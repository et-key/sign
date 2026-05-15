import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/parser.js';
import { buildAST } from './semanticize/shunting_yard.js';
import util from 'util';

const testCases = [
  "1+2*3",                    // 単純な中置
  "(1+2)*3",                  // グルーピング (ネストされた配列のテスト)
  "|a| + 1",                  // 絶対値ブロック
  "a|-b",                     // 多義的演算子の連続
  "func:\n\ta = 1\n\tb = 2"   // インデントブロック
];

for (const tc of testCases) {
  console.log(`\n=== Input: ${tc} ===`);

  // 1. Lexer (前処理)
  const preprocessed = preprocess(tc);
  // 見やすくするために制御文字を可視化
  const visible = preprocessed.replace(/\x02/g, '<INDENT>').replace(/\x03/g, '<DEDENT>');
  console.log(`[Lexer output]: ${visible.replace(/\n/g, '\\n')}`);

  try {
    // 2. PEG Parser (構文解析 -> フラット/ネスト配列)
    const astProgram = parser.parse(preprocessed);
    // Programは Line の配列で、末尾や空行が undefined/null になることがある
    const astLines = astProgram.filter(line => line !== null && line !== undefined);
    console.log(`[PEG output]  :`, util.inspect(astLines, { depth: null, colors: true, breakLength: Infinity }));

    // 最初の行の式(配列)を取り出してテスト
    const astFlat = astLines.length > 0 ? astLines[0] : [];

    // 3. Shunting Yard (優先順位解決 -> AST)
    // astFlat は入れ子になっている可能性があるため、一番内側の配列を渡す
    // `Line` は `expr` を返す。`expr` は配列。
    const astTree = buildAST(Array.isArray(astFlat) && astFlat.length === 1 && Array.isArray(astFlat[0]) ? astFlat[0] : astFlat);
    console.log(`[ShuntingYard]:`, util.inspect(astTree, { depth: null, colors: true }));
  } catch (e) {
    console.error(`[Parse Error]`, e.message);
  }
}
