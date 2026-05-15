import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { annotateContextualOperators } from './semanticize/analyzer.js';
import util from 'util';

const testCases = [
  "my_dict :\n\tkey1: 10\n\tkey2: 20",
  "func_match: x y ?\n\tpattern1: result1\n\tpattern2: result2",
  "func_args:\n\t\targ1: type1 = default1\n\t?\n\t\tbody_statement"
];

for (const tc of testCases) {
  console.log(`\n=== Input: ${tc} ===`);
  try {
    // 1. Lexer (前処理)
    const preprocessed = preprocess(tc);
    const visible = preprocessed.replace(/\x02/g, '<INDENT>').replace(/\x03/g, '<DEDENT>');
    console.log(`[Lexer output]: ${visible.replace(/\n/g, '\\n')}`);

    // 2. PEG Parser (構文解析)
    const astProgram = parser.parse(preprocessed);
    // Programは Line の配列で、末尾や空行が undefined/null になることがある
    const astLines = astProgram.filter(line => line !== null && line !== undefined);
    
    // 改行で分割された行（配列の配列）を1次元に結合し、連続したストリームとしてShunting Yardに渡す
    // これにより、複数行にまたがる ? 演算子などが前後のブロックと正しく結合される
    const astFlat = astLines.flat(2);
    
    // 3. Shunting Yard (優先順位解決 -> AST)
    // `Line` は `expr` を返す。`expr` は配列。
    let astTree = buildAST(Array.isArray(astFlat) && astFlat.length === 1 && Array.isArray(astFlat[0]) ? astFlat[0] : astFlat);
    
    // 4. Semantic Analyzer (意味解析: `:` のタグ付け)
    astTree = annotateContextualOperators(astTree);
    
    console.log(`[ShuntingYard & Semantic Analyzer]:`, util.inspect(astTree, { depth: null, colors: true }));
  } catch (err) {
    if (err.location) {
      console.error(`[Parse Error] Expected ${err.expected.map(e=>e.text?`"${e.text}"`:`[${e.parts.join('')}]`).join(', ')} but "${err.found}" found.`);
    } else {
      console.error(`[Parse Error]`, err.message);
    }
  }
}
