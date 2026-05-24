import fs from 'fs';
import path from 'path';

/**
 * evaluator.js
 * 
 * 抽象構文木（AST）を評価（Reduction / 型推論）するモジュール。
 * 型推論と値の実行を同一の操作（圏論的な射の適用）として扱います。
 * 解決できない射の適用や比較は `Unit` へフォールバックし、
 * 比較演算子等は真理値ではなく対象そのものを返す（構成的論理）仕様です。
 */

// コンパイラパイプラインのインポート（importModule用）
import { preprocess } from '../lexisize/lexer.js';
import * as parser from '../parse/minimal.js';
import { buildAST } from './shunting_yard.js';
import { buildEnvironment, getInitialCategory } from './builder.js';
import { resolveCoproducts } from './coproduct_resolver.js';

// キャッシュ: 一度読んだモジュールを保存する
const moduleCache = new Map();

/**
 * ファイルをモジュールとして読み込み、評価してエクスポート辞書を返します。
 */
function importModule(moduleName) {
  // キャッシュにあればそれを返す
  if (moduleCache.has(moduleName)) {
    return moduleCache.get(moduleName);
  }

  // とりあえず _test_ などの基本ディレクトリから探索する簡略版
  // 実際には現在のファイルのパスなどから相対解決する必要があります
  const possiblePaths = [
    path.join(process.cwd(), `${moduleName}.sn`),
    path.join(process.cwd(), '_test_', `${moduleName}.sn`),
    path.join(process.cwd(), '_test_', 'module_system', `${moduleName}.sn`)
  ];

  let filePath = null;
  let code = null;
  for (const p of possiblePaths) {
    if (fs.existsSync(p)) {
      filePath = p;
      code = fs.readFileSync(p, 'utf-8');
      break;
    }
  }

  if (!code) {
    // 見つからない場合は Unit
    return { type: 'Unit' };
  }

  // ファイルをパースして評価
  const preprocessed = preprocess(code);
  const astProgram = parser.parse(preprocessed);
  const astLines = astProgram.filter(line => line !== null && line !== undefined);

  let fileEnv = new Map();
  const evaluatedAsts = [];

  for (const astLine of astLines) {
    let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
    fileEnv = buildEnvironment(astTree, fileEnv);
    astTree = resolveCoproducts(astTree, fileEnv);
    astTree = evaluate(astTree, fileEnv);
    evaluatedAsts.push(astTree);
  }

  // fileEnv の中から exported: true のものを集めて辞書（brace block）を作る
  const exportsDict = {};
  for (const [key, value] of fileEnv.entries()) {
    if (value.exported) {
      exportsDict[key] = evaluate(value.ast, fileEnv); // 再帰的評価
    }
  }

  const moduleResult = {
    type: 'block',
    kind: 'brace',
    content: exportsDict
  };

  moduleCache.set(moduleName, moduleResult);
  return moduleResult;
}

/**
 * ASTを再帰的に評価します。
 * @param {Object|string|number} node - 評価対象のノード
 * @param {Map} env - 識別子の構造を保持する環境
 * @param {Set} visited - 無限ループ防止用の訪問済み識別子セット
 * @returns {Object|string|number} 評価結果（または Unit）
 */
export function evaluate(node, env, visited = new Set()) {
  if (node === undefined || node === null) return { type: 'Unit' };

  // 値や文字列（識別子）の評価
  if (typeof node === 'string') {
    // 数値リテラルや文字列リテラルはそのまま
    if (!isNaN(node) || node.startsWith('0x') ||
      (node.startsWith('`') && node.endsWith('`'))) {
      // parseFloat して数値を返すことも可能だが、AST構造としては文字列のままで運用しているならそのまま返す
      return node;
    }

    // 環境（デフォルト引数やローカル変数、関数定義など）に登録されていれば、その AST構造（前提）を展開する
    if (env && env.has(node)) {
      if (!visited.has(node)) {
        const definedObj = env.get(node);
        if (definedObj && definedObj.ast) {
          // 無限ループ防止のため、訪問済みとしてマークしてから展開
          const nextVisited = new Set(visited);
          nextVisited.add(node);
          // 未解決の coproduct_block を含んでいる可能性があるので、解決してから評価する
          const resolvedAst = resolveCoproducts(definedObj.ast, env);
          return evaluate(resolvedAst, env, nextVisited);
        }
      }
    }

    // 未解決の識別子はそのまま返す（型推論における自由変数として扱う）
    return node;
  }

  // Unit はそのまま
  if (node.type === 'Unit') return node;

  // ブロックの評価
  if (node.type === 'block') {
    // 透過的ブロック（paren, group, indent 等）は中身を評価して返す
    if (node.kind === 'paren' || node.kind === 'group' || node.kind === 'indent') {
      return evaluate(node.content, env, visited);
    }

    // bracket(配列), brace(辞書) 等はコンテナとして中身を評価
    return {
      ...node,
      content: evaluate(node.content, env, visited)
    };
  }

  // coproduct_block（文の連続）の評価
  if (node.type === 'coproduct_block') {
    if (Array.isArray(node.statements)) {
      const evaledStatements = node.statements.map(s => evaluate(s, env, visited));
      // ブロックが1要素しか持たない場合はそれを直接返す（還元）
      if (evaledStatements.length === 1) return evaledStatements[0];
      return {
        ...node,
        statements: evaledStatements
      };
    }
    return node;
  }

  // 演算子（Operation）の評価
  if (node.type === 'operation') {
    let evalLeft = undefined;
    
    // 定義演算子(:) や エクスポート(#) の場合は、左辺（名前）を展開しない
    if (node.operator === ':' || node.operator === '#') {
      evalLeft = node.left;
    } else {
      evalLeft = node.left !== undefined ? evaluate(node.left, env, visited) : undefined;
    }

    const evalRight = node.right !== undefined ? evaluate(node.right, env, visited) : undefined;
    const evalOperand = node.operand !== undefined ? evaluate(node.operand, env, visited) : undefined;

    // 比較演算子 (=, !=, >, <, >=, <=)
    // 構成的論理: 対象が存在する（マッチする）場合は対象を返し、ダメなら Unit
    if (['=', '!=', '>', '<', '>=', '<='].includes(node.operator)) {
      if (evalLeft !== undefined && evalRight !== undefined) {
        // 数値の比較
        const leftNum = Number(evalLeft);
        const rightNum = Number(evalRight);
        if (!isNaN(leftNum) && !isNaN(rightNum)) {
          let ok = false;
          if (node.operator === '=') ok = (leftNum === rightNum);
          else if (node.operator === '!=') ok = (leftNum !== rightNum);
          else if (node.operator === '>') ok = (leftNum > rightNum);
          else if (node.operator === '<') ok = (leftNum < rightNum);
          else if (node.operator === '>=') ok = (leftNum >= rightNum);
          else if (node.operator === '<=') ok = (leftNum <= rightNum);

          return ok ? evalLeft : { type: 'Unit' };
        }

        // 構造比較（簡易的に JSON 文字列化で比較）
        if (node.operator === '=') {
          if (JSON.stringify(evalLeft) === JSON.stringify(evalRight)) {
            return evalLeft;
          }
        }
      }
      // 未解決の変数や未評価の射を含む比較は、一旦 Unit (解なし) へ還元
      return { type: 'Unit' };
    }

    // 四則演算
    if (['+', '-', '*', '/'].includes(node.operator)) {
      if (evalLeft !== undefined && evalRight !== undefined) {
        const leftNum = Number(evalLeft);
        const rightNum = Number(evalRight);
        if (!isNaN(leftNum) && !isNaN(rightNum)) {
          if (node.operator === '+') return String(leftNum + rightNum);
          if (node.operator === '-') return String(leftNum - rightNum);
          if (node.operator === '*') return String(leftNum * rightNum);
          if (node.operator === '/') return String(leftNum / rightNum);
        }
      }
      // 数値に評価できない場合は未解決状態としてASTを残す
      // (将来的な型変数を含む単一化などをここで行う)
      return {
        ...node,
        left: evalLeft !== undefined ? evalLeft : node.left,
        right: evalRight !== undefined ? evalRight : node.right
      };
    }

    // apply (適用・評価: 射に対して対象を適用する)
    if (node.name === 'apply' && node.operator === ' ') {
      // もし evalLeft が Lambda(関数構造)であれば展開・適用する処理を書く。
      // 現段階では具体的なラムダ抽象の実体化まで踏み込まないため、
      // 簡単な具体化（関数の実行）ができなければASTとして残す

      // ... 実装が複雑な場合は AST として残す
      return {
        ...node,
        left: evalLeft,
        right: evalRight
      };
    }

    // concat (積)
    if (node.name === 'concat' && node.operator === ' ') {
      return {
        ...node,
        left: evalLeft,
        right: evalRight
      };
    }

    // @ (import: 後置演算子)
    if (node.operator === '@' && node.position === 'postfix') {
      let moduleName = typeof node.operand === 'string' ? node.operand : (node.operand.name || String(node.operand));
      if (moduleName.startsWith('<') && moduleName.endsWith('>')) {
        moduleName = moduleName.slice(1, -1);
      }
      return importModule(moduleName);
    }

    // ~ (展開: 後置演算子)
    if (node.operator === '~' && node.position === 'postfix') {
      // 辞書の中身を現在の環境 (env) に直接マージする
      if (evalOperand && evalOperand.type === 'block' && evalOperand.kind === 'brace' && evalOperand.content) {
        for (const [key, val] of Object.entries(evalOperand.content)) {
          // 展開された値のカテゴリを推測する
          const cat = getInitialCategory(val, env);
          env.set(key, { category: cat, ast: val });
        }
      }
      return {
        type: 'expanded_dict',
        dict: evalOperand
      };
    }

    // export (# 前置演算子)
    // エクスポートは評価時には特に値を変更しない（builderで処理済み）
    if (node.operator === '#' && node.position === 'prefix') {
      return evalOperand;
    }

    // その他の演算子はそのまま評価済み要素を割り当てて再構築
    return {
      ...node,
      left: evalLeft !== undefined ? evalLeft : node.left,
      right: evalRight !== undefined ? evalRight : node.right,
      operand: evalOperand !== undefined ? evalOperand : node.operand
    };
  }

  return node;
}
