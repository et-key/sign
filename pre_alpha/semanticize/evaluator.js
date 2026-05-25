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

const moduleCache = new Map();

/**
 * パラメータノードから引数名（識別子）を抽出します
 */
function extractParamName(paramNode) {
  if (!paramNode) return null;
  if (typeof paramNode === 'string') return paramNode;
  if (paramNode.type === 'block') return extractParamName(paramNode.content);
  if (paramNode.operator === ':') return extractParamName(paramNode.left);
  return paramNode.name || null;
}

/**
 * concat の木をフラットな配列に展開します
 */
function flattenConcat(node) {
  if (!node) return [];
  if (node.name === 'concat' && node.operator === ' ') {
    return [...flattenConcat(node.left), ...flattenConcat(node.right)];
  }
  return [node];
}

/**
 * パラメータノードからデフォルト値のASTを抽出します
 */
function extractDefaultValue(paramNode) {
  if (!paramNode) return undefined;
  if (paramNode.type === 'block') return extractDefaultValue(paramNode.content);
  if (paramNode.operator === ':') return paramNode.right;
  return undefined;
}

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
    
    if (node.operator === ':' || node.operator === '#') {
      evalLeft = node.left;
    } else if (node.operator === '?') {
      // ラムダの引数部分は評価しない（または変数名として保持）
      evalLeft = node.left;
    } else {
      evalLeft = node.left !== undefined ? evaluate(node.left, env, visited) : undefined;
    }

    let evalRight = undefined;
    if (node.operator === '?') {
      // ラムダの本体は適用時まで評価しない (遅延評価)
      evalRight = node.right;
    } else {
      evalRight = node.right !== undefined ? evaluate(node.right, env, visited) : undefined;
    }
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
      // 未解決の変数の場合は 型 (Left | Unit) へ還元する
      let typeOfLeft = evalLeft !== undefined ? evalLeft : node.left;
      if (typeof typeOfLeft === 'string' && !isNaN(typeOfLeft)) {
        typeOfLeft = "Number";
      }
      return { type: 'operation', operator: '|', left: typeOfLeft, right: { type: 'Unit' } };
    }

    // 四則演算
    if (['+', '-', '*', '/'].includes(node.operator)) {
      // 数値に評価せず、型へ還元する (２項演算は基本的に左辺の型を返す)
      let typeOfLeft = evalLeft !== undefined ? evalLeft : node.left;
      if (typeof typeOfLeft === 'string' && !isNaN(typeOfLeft)) {
        typeOfLeft = "Number";
      }
      return typeOfLeft;
    }

    // apply (適用・評価: 射に対して対象を適用する)
    if (node.name === 'apply' && node.operator === ' ') {
      if (evalLeft && evalLeft.operator === '?') {
        const newEnv = evalLeft.env ? new Map(evalLeft.env) : new Map(env);
        
        // カリー化・部分適用の処理
        let params = evalLeft.left;
        while (params && params.type === 'block') {
          params = params.content;
        }

        if (params && params.name === 'concat') {
          const paramArray = flattenConcat(params);
          const argArray = flattenConcat(evalRight);
          
          let i = 0;
          for (; i < argArray.length && i < paramArray.length; i++) {
            const pName = extractParamName(paramArray[i]);
            let argVal = argArray[i];

            // Unit 判定
            const isUnit = argVal === undefined || argVal === '_' || argVal.type === 'Unit' || 
                           (argVal.type === 'block' && argVal.kind === 'bracket' && argVal.content && argVal.content.type === 'Unit');
            
            if (isUnit) {
              const defValAst = extractDefaultValue(paramArray[i]);
              if (defValAst !== undefined) {
                argVal = evaluate(defValAst, newEnv, visited);
              }
            }

            if (pName) {
              newEnv.set(pName, { ast: argVal, category: getInitialCategory(argVal, env) });
            }
          }

          if (i < paramArray.length) {
            // カリー化: 残りのパラメータで新しい Lambda を返す
            const remainingParams = paramArray.slice(i);
            let newParams = remainingParams[0];
            for (let j = 1; j < remainingParams.length; j++) {
              newParams = { type: 'operation', operator: ' ', name: 'concat', left: newParams, right: remainingParams[j] };
            }
            return {
              type: 'operation',
              operator: '?',
              left: newParams,
              right: evalLeft.right,
              env: newEnv
            };
          } else {
            // すべての引数が供給された場合
            return evaluate(evalLeft.right, newEnv, visited);
          }
        } else {
          // 単一引数の場合、束縛して本体を評価
          const argName = extractParamName(params);
          let argVal = evalRight;

          const isUnit = argVal === undefined || argVal === '_' || argVal.type === 'Unit' || 
                         (argVal.type === 'block' && argVal.kind === 'bracket' && argVal.content && argVal.content.type === 'Unit');

          if (isUnit) {
            const defValAst = extractDefaultValue(params);
            if (defValAst !== undefined) {
              argVal = evaluate(defValAst, newEnv, visited);
            }
          }

          if (argName) {
            newEnv.set(argName, { ast: argVal, category: getInitialCategory(argVal, env) });
          }
          return evaluate(evalLeft.right, newEnv, visited);
        }
      }
      return {
        ...node,
        left: evalLeft,
        right: evalRight
      };
    }

    // compose (関数合成)
    if (node.name === 'compose' && node.operator === ' ') {
      // f g -> x ? g(f(x))
      // evalLeft: f, evalRight: g
      if (evalLeft && evalLeft.operator === '?' && evalRight && evalRight.operator === '?') {
        return {
          type: 'operation',
          operator: '?',
          left: evalLeft.left,
          right: {
            type: 'operation',
            operator: ' ',
            name: 'apply',
            left: evalRight,
            right: {
              type: 'operation',
              operator: ' ',
              name: 'apply',
              left: evalLeft,
              right: evalLeft.left
            }
          },
          env: env
        };
      }
      return {
        ...node,
        left: evalLeft,
        right: evalRight
      };
    }

    // concat (連接)
    if (node.name === 'concat' && node.operator === ' ') {
      // 動的解決: 左辺がLambdaだった場合、誤ってconcatと判定されたものをapplyとして処理する
      if (evalLeft && evalLeft.operator === '?') {
        const applyNode = { ...node, name: 'apply' };
        return evaluate(applyNode, env, visited);
      }
      
      // リスト/アトムの結合
      // とりあえずそのままAST構造（Coproduct）を残すが、実行時には展開されるべき
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
