// evaluator.js

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
  // prefix operators like ~y
  if (paramNode.position === 'prefix' || paramNode.position === 'postfix') return extractParamName(paramNode.operand);
  return paramNode.name || null;
}

/**
 * ASTの変数を環境(env)に登録された値に置換します（本体の遅延評価のための準備）
 */
function substituteVariables(node, env, visited = new Set()) {
  if (!node) return node;
  if (typeof node === 'string') {
    if (env && env.has(node)) {
      if (!visited.has(node)) {
        const nextVisited = new Set(visited);
        nextVisited.add(node);
        const definedObj = env.get(node);
        if (definedObj && definedObj.ast) {
           // Do not recursively substitute inside the bound argument's AST,
           // because the argument is from a different scope and might have variable name collisions (e.g., 'x').
           return definedObj.ast;
        }
      }
    }
    return node;
  }
  if (node.type === 'Unit') return node;
  if (node.type === 'block') {
    return { ...node, content: substituteVariables(node.content, env, visited) };
  }
  if (node.type === 'coproduct_block') {
    return { ...node, statements: node.statements.map(s => substituteVariables(s, env, visited)) };
  }
  if (node.type === 'operation') {
    if (node.operator === '?') {
      // ラムダの本体を置換する場合、引数名がシャドウイングしないかチェックが必要ですが、簡易的に内部も置換します
      return { ...node, left: node.left, right: substituteVariables(node.right, env, visited) };
    }
    return {
      ...node,
      left: substituteVariables(node.left, env, visited),
      right: substituteVariables(node.right, env, visited),
      operand: substituteVariables(node.operand, env, visited)
    };
  }
  return node;
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
 * 配列からASTのブロックを再構築します
 */
function packArray(elements) {
  if (elements.length === 0) return { type: 'block', kind: 'bracket', content: { type: 'Unit' } };
  if (elements.length === 1) return { type: 'block', kind: 'bracket', content: elements[0] };
  const content = elements.reduce((acc, curr) => ({ type: 'operation', operator: ' ', name: 'concat', left: acc, right: curr }));
  return { type: 'block', kind: 'bracket', content: content };
}

/**
 * 配列ブロックを遅延評価的にHeadとTailに分解します
 */
function lazyUnpack(argVal) {
  if (argVal && argVal.type === 'expanded_array') {
    return lazyUnpack(argVal.array);
  }
  // Support unpacking lazy concat operations
  if (argVal && argVal.type === 'operation' && (argVal.name === 'concat' || argVal.operator === ' ')) {
    return { head: argVal.left, tail: argVal.right };
  }
  if (argVal && argVal.type === 'block' && argVal.kind === 'bracket') {
    const content = argVal.content;
    if (content && content.name === 'range') {
       const rangeOp = content;
       if (rangeOp.left && rangeOp.left.name === 'range_arithmetic') {
          const head = rangeOp.left.left;
          const step = rangeOp.left.right;
          const headNum = Number(head);
          const stepNum = Number(step);
          const maxNum = Number(rangeOp.right);
          
          if (!isNaN(maxNum) && headNum > maxNum) {
             return null; // Range completed
          }
          
          const nextHead = String(headNum + stepNum);
          
          const tail = {
             type: 'block', kind: 'bracket', content: {
                type: 'operation', operator: '~', name: 'range',
                left: { type: 'operation', operator: '~+', name: 'range_arithmetic', left: nextHead, right: step },
                right: rangeOp.right
             }
          };
          return { type: 'Cons', head: head, tail: tail };
       }
    }
    if (content && content.name === 'concat') {
       const elements = flattenConcat(content);
       if (elements.length > 0) {
         return { type: 'Cons', head: elements[0], tail: packArray(elements.slice(1)) };
       }
    }
    if (content && content.type !== 'Unit') {
       return { type: 'Cons', head: content, tail: packArray([]) };
    }
  }
  return null;
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

  // MVP Browser integration: stub module loading
  // In the future, we will use fetch() or a virtual file system
  console.warn(`[Warning] importModule (@) is not supported in the browser MVP. Skipping import of: ${moduleName}`);
  
  const moduleResult = {
    type: 'block',
    kind: 'brace',
    content: {}
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
          const evaled = evaluate(resolvedAst, env, nextVisited);
          if (evaled && typeof evaled === 'object' && !evaled.__sourceIdent) {
            evaled.__sourceIdent = node;
          }
          return evaled;
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
      // Convert '?' to Lambda type
      let params = node.left;
      while (params && params.type === 'block') params = params.content;
      const paramsList = flattenConcat(params);
      
      return {
        type: 'Lambda',
        params: paramsList,
        body: node.right,
        env: env
      };
    } else {
      evalLeft = node.left !== undefined ? evaluate(node.left, env, visited) : undefined;
    }

    let evalRight = undefined;
    if (node.operator === '?') {
      // ラムダの本体は適用時まで評価しない (遅延評価)
      evalRight = node.right;
    } else if (node.name === 'concat' && node.operator === ' ') {
      // To support infinite streams, delay evaluation of the right side of concat
      evalRight = node.right;
    } else {
      evalRight = node.right !== undefined ? evaluate(node.right, env, visited) : undefined;
    }
    let evalOperand = undefined;
    if (node.operator === '$' && node.position === 'prefix') {
      // $ (address) のオペランドは評価せず、識別子のまま保持する
      evalOperand = node.operand;
    } else {
      evalOperand = node.operand !== undefined ? evaluate(node.operand, env, visited) : undefined;
    }

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
      if (evalLeft && evalLeft.type === 'Lambda') {
        const newEnv = evalLeft.env ? new Map(evalLeft.env) : new Map(env);
        let params = evalLeft.params;
        let body = evalLeft.body;
        
        let currentArg = evalRight;
        
        // __hole__ (_) による部分適用の場合、引数を1つ消費してカリー化状態を維持する
        if (currentArg === '_') {
            const pNode = params[0];
            const remainingParams = params.slice(1);
            return {
                type: 'Lambda',
                params: remainingParams,
                body: body,
                env: newEnv
            };
        }

        let remainingParams = [];
        for (let i = 0; i < params.length; i++) {
          const pNode = params[i];
          const pName = extractParamName(pNode);
          
          if (pNode.position === 'prefix' && pNode.operator === '~') {
            // Capture rest of the array or argument
            if (pName) {
                newEnv.set(pName, { ast: currentArg, category: getInitialCategory(currentArg, env) });
            }
            remainingParams = params.slice(i + 1);
            break;
          } else {
            // Normal parameter
            let unpacked = null;
            if (params.length - i > 1 || (currentArg && currentArg.type === 'expanded_array')) {
               unpacked = lazyUnpack(currentArg);
            }
            
            let argToBind = unpacked ? unpacked.head : currentArg;
            
            // Unit fallback for default args
            const isUnit = argToBind === undefined || argToBind === '_' || argToBind.type === 'Unit' || 
                           (argToBind && argToBind.type === 'block' && argToBind.kind === 'bracket' && argToBind.content && argToBind.content.type === 'Unit');
            
            if (isUnit) {
              const defValAst = extractDefaultValue(pNode);
              if (defValAst !== undefined) {
                argToBind = evaluate(defValAst, newEnv, visited);
              }
            }

            if (pName) newEnv.set(pName, { ast: argToBind, category: getInitialCategory(argToBind, env) });
            
            if (unpacked) {
              currentArg = unpacked.tail;
            } else {
              currentArg = { type: 'Unit' };
            }
          }
          
          if (i === params.length - 1) {
              remainingParams = [];
          }
        }
        
        if (remainingParams.length > 0) {
          // Curry: Still have parameters left
          const lambdaResult = {
            type: 'Lambda',
            params: remainingParams,
            body: body,
            env: newEnv
          };
          if (evalLeft.__sourceIdent) {
            lambdaResult.__sourceIdent = evalLeft.__sourceIdent;
          }
          return lambdaResult;
        } else {
          // Fully applied
          const bodyVisited = new Set(visited);
          if (evalLeft.__sourceIdent) {
            bodyVisited.add(evalLeft.__sourceIdent);
          }
          return evaluate(body, newEnv, bodyVisited);
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
      // f => g
      if (evalLeft && evalLeft.type === 'Lambda' && evalRight && evalRight.type === 'Lambda') {
        // ... (We will fix compose later if needed, just simplify for now)
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
      if (evalLeft && evalLeft.type === 'Lambda') {
        const applyNode = { ...node, name: 'apply' };
        return evaluate(applyNode, env, visited);
      }
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
        return {
          type: 'expanded_dict',
          dict: evalOperand
        };
      }
      
      // 配列の展開
      if (evalOperand && evalOperand.type === 'block' && evalOperand.kind === 'bracket') {
        return {
          type: 'expanded_array',
          array: evalOperand
        };
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
