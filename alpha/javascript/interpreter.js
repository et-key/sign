/**
 * 最小インタプリタ（評価器）。Pass2/Pass1bが構築した二分木ASTを実際に評価して値を出す。
 *
 * 【スコープ】今回の最初の実装は以下に限定する（既知の制限）：
 * - `$`/`@`/`#`（アドレス取得・デリファレンス・ストア）は未対応。メモリモデルが必要な
 *   ため別途の設計課題とする。
 * - block（List/Struct/Dict）の評価はシンプルなJS配列/オブジェクトへのマッピングに留める。
 * - TCO・末尾呼び出し最適化は行わない（JSの通常の再帰呼び出しに委ねる）。
 *
 * 【実装した中核の意味論】
 * - 完全性公理（type_system.md §3.4）：`f __ = __`。引数のいずれかがUnit（デフォルト値も
 *   rest~のフォールバックも無い場合）なら、本体を評価せず即座にUnitを返す。
 * - デフォルト引数へのUnitフォールバック（§3.4）：デフォルトを持つ仮引数にUnitが渡されたら
 *   デフォルト式（let*的に、直前までの束縛を使って）を評価する。
 * - restパラメータへのUnitフォールバック（§3.3）：restの実引数が無い、またはUnit単体なら
 *   空リストにフォールバックする（完全性公理による崩壊は起きない）。
 * - 算術演算子の非対称Unit伝播則（§3.3）：左辺Unit=吸収元、右辺Unit=単位元（素通し）。
 * - 比較演算子の吸収則（§3.3）：両辺とも吸収元。`!=`のみ例外で右辺Unitは単位元。
 * - `&`/`|`/`;`の短絡評価（AGENTS.md）：`&`は左辺がUnitなら右辺を評価せず即座にUnit、
 *   `|`は左辺がUnitでなければ右辺を評価せず左辺を返す。
 * - 多引数関数（`params[]`）の一括適用：pass2.jsのapplyChainInfoと対称に、apply連鎖を
 *   遡って引数を全部集めてから一度だけ本体を評価する（カリー化された中間クロージャは
 *   生成しない、今日合意した「単一`?`＝一括束縛・タダ」という設計に対応）。
 */

// Unit（__）の実行時における一意な番人（sentinel）。Symbolなので他のどんな値とも衝突しない。
const UNIT = Symbol("Sign.Unit");

function isUnit(v) {
  return v === UNIT || v === undefined;
}

// ---- 実行時環境（Pass1の静的envとは別物、実際の値を保持する） ----
function newRuntimeEnv(parent) {
  return { bindings: new Map(), parent: parent || null };
}
function envDefine(env, name, value) {
  env.bindings.set(name, value);
}
function envGet(env, name) {
  let e = env;
  while (e) {
    if (e.bindings.has(name)) return e.bindings.get(name);
    e = e.parent;
  }
  return UNIT; // 未定義識別子はUnitへ収束（AGENTS.md）
}

// ---- リテラルの評価 ----
function evalLiteral(node) {
  switch (node.kind) {
    case "number":
      return node.value.includes(".") ? parseFloat(node.value) : parseInt(node.value, 10);
    case "string":
      return node.value.slice(1, -1); // バッククォートを剥がす
    case "char":
      return node.value.slice(1); // "\a" -> "a"
    case "address":
      return parseInt(node.value.slice(2), 16);
    case "unicode":
      return parseInt(node.value.slice(2), 16);
    case "register":
      return node.value.startsWith("0b") ? parseInt(node.value.slice(2), 2) : parseInt(node.value.slice(2), 16);
    case "unit":
      return UNIT;
    default:
      return UNIT;
  }
}

// ---- apply連鎖の収集（pass2.jsのapplyChainInfoと対称） ----
// apply[apply[apply[f, a1], a2], a3] を辿って、呼び出し先ノードと引数ノード列（左から順）を集める。
function collectApplyChain(node) {
  const argNodes = [];
  let n = node;
  while (n && n.type === "operation" && n.name === "apply") {
    argNodes.unshift(n.right);
    n = n.left;
  }
  return { calleeNode: n, argNodes };
}

function paramEntriesOf(paramsNode) {
  if (!paramsNode) return [];
  if (paramsNode.type === "atom" && paramsNode.kind === "identifier") {
    return [{ name: paramsNode.value, rest: false, default: null }];
  }
  if (paramsNode.type === "params") return paramsNode.entries;
  return [];
}

// 仮引数を実引数に束縛した新しい実行時envを返す。完全性公理により崩壊する場合は null を返す。
function bindParams(paramsNode, argValues, closureEnv) {
  const entries = paramEntriesOf(paramsNode);
  const env = newRuntimeEnv(closureEnv);
  let argIdx = 0;

  for (const entry of entries) {
    if (entry.rest) {
      let restArgs = argValues.slice(argIdx);
      argIdx = argValues.length;
      // §3.3: restにUnitが渡された（または実引数が尽きた）場合は空リストへフォールバック
      if (restArgs.length === 0 || (restArgs.length === 1 && isUnit(restArgs[0]))) {
        restArgs = [];
      }
      envDefine(env, entry.name, restArgs);
      continue;
    }

    let value = argIdx < argValues.length ? argValues[argIdx] : UNIT;
    argIdx++;

    if (isUnit(value)) {
      if (entry.default) {
        // let*的に、ここまでに束縛済みのenvでデフォルト式を評価する
        value = evaluate(entry.default, env);
      } else {
        return null; // 完全性公理：デフォルト無しのパラメータにUnit → 呼び出し全体が崩壊
      }
    }
    envDefine(env, entry.name, value);
  }

  return env;
}

function makeClosure(paramsNode, bodyNode, env) {
  return { __lambda__: true, params: paramsNode, body: bodyNode, env };
}

// 関数合成（coproduct_resolver.md §3: Lambda Lambda → compose）。
// 【重要】数学的合成記法(f∘g)(x)=f(g(x))とは逆で、Signの `f g` は左→右のパイプライン順。
// documents/ja-jp/guide/example.sn: `[+ 1] [* 2] 5 = [* 2]([+ 1] 5) = 12`
// （左の[+1]が先に5へ適用され6、その結果に右の[*2]が適用され12。"関数合成は左単位元"）。
// つまり (f g)(x) = g(f(x)) ——fを先に、その結果にgを適用する。
function makeComposed(f, g) {
  return { __lambda__: true, __compose__: [f, g] };
}

function applyClosure(closure, argValues) {
  if (typeof closure === "function") return closure(...argValues); // 組み込み関数
  if (!closure || !closure.__lambda__) {
    throw new TypeError("Lambdaではない値を関数として適用しようとしました");
  }
  if (closure.__compose__) {
    const [f, g] = closure.__compose__;
    // 完全性公理はチェーン全体に効く：fの結果がUnitならgを呼ばず即座にUnit。
    // 左(f)を先に適用し、その結果に右(g)を適用する（左→右パイプライン順、上記参照）。
    const mid = applyClosure(f, argValues);
    if (isUnit(mid)) return UNIT;
    return applyClosure(g, [mid]);
  }
  const callEnv = bindParams(closure.params, argValues, closure.env);
  if (callEnv === null) return UNIT;
  return evaluate(closure.body, callEnv);
}

// ---- 算術・比較演算子のUnit伝播ルール（type_system.md §3.3） ----
const ARITH_OPS = {
  add: (l, r) => l + r,
  sub: (l, r) => l - r,
  mul: (l, r) => l * r,
  div: (l, r) => l / r,
  mod: (l, r) => l % r,
  pow: (l, r) => Math.pow(l, r),
};
const COMPARE_OPS = {
  less: (l, r) => l < r,
  less_equal: (l, r) => l <= r,
  assign_equal: (l, r) => l === r,
  more_equal: (l, r) => l >= r,
  more: (l, r) => l > r,
};

function evalArith(name, leftNode, rightNode, env) {
  const l = evaluate(leftNode, env);
  if (isUnit(l)) return UNIT; // 左辺Unit = 吸収元
  // §3.2: String（Listと同型）の左辺に算術演算子は効かない → 型エラーで__に収束。
  // 注: list_model.md §4.4の文面は「+でコードポイントが露出する」としているが、
  // 自身の例(`123` 123 = `123123`)はスペース連結でありこの主張を実証していない。
  // type_system.md §3.2の明示的な表（String+算術演算子→型エラー(__消去)）を正とする。
  if (typeof l === "string") return UNIT;
  const r = evaluate(rightNode, env);
  if (isUnit(r)) return l; // 右辺Unit = 単位元（id射、素通し）
  return ARITH_OPS[name](l, r);
}

function evalCompare(name, op, leftNode, rightNode, env) {
  const l = evaluate(leftNode, env);
  const r = evaluate(rightNode, env);
  if (op === "!=") {
    // 例外: x != __ = x（単位元）、__ != x = __（吸収元）
    if (isUnit(l)) return UNIT;
    if (isUnit(r)) return l;
    return l !== r ? l : UNIT; // 比較演算子は真の場合、値(左辺 or 右辺)を返す（§4）
  }
  if (isUnit(l) || isUnit(r)) return UNIT; // 両辺とも吸収元
  const truthy = COMPARE_OPS[name](l, r);
  return truthy ? (l === 0 || l === 1 ? r : l) : UNIT; // §4: 左辺が算術単位元(0/1)なら右辺、それ以外は左辺を返す
}

// ---- construct/concat/product（List/Struct構築） ----
function asList(v) {
  return Array.isArray(v) ? v : [v];
}
function stringifyForConcat(v) {
  if (typeof v === "string") return v;
  if (isUnit(v)) return "";
  return String(v);
}

function evaluate(node, env) {
  if (!node || typeof node !== "object") return UNIT;

  if (node.type === "atom") {
    if (node.kind === "identifier") return envGet(env, node.value);
    return evalLiteral(node);
  }

  if (node.type === "block") {
    // ブロックの値＝最後の文の値（順に評価、同じenvのまま逐次実行）
    let result = UNIT;
    for (const line of node.lines) result = evaluate(line, env);
    return result;
  }

  if (node.type === "operation") {
    switch (node.name) {
      case "define": {
        const value = node.right.name === "lambda" ? makeClosure(node.right.left, node.right.right, env) : evaluate(node.right, env);
        envDefine(env, node.left.value, value);
        return value;
      }
      case "lambda":
        return makeClosure(node.left, node.right, env);
      case "apply": {
        const { calleeNode, argNodes } = collectApplyChain(node);
        const callee = evaluate(calleeNode, env);
        // 後置~（expand）で渡された引数は、1個のList値としてではなく複数の位置引数へ
        // 展開する（pattern_guide.md「関数にListを渡すときは必ず後置~を使う」「後置~を
        // 使ったときに、それぞれの引数リストに分配して渡される」）。これが無いと
        // 裸のrestパラメータでの再帰（xs~の展開）が終端せず無限再帰する。
        const argValues = [];
        for (const a of argNodes) {
          if (a.type === "operation" && a.position === "postfix" && a.name === "expand") {
            const v = evaluate(a.operand, env);
            argValues.push(...(Array.isArray(v) ? v : [v]));
          } else {
            argValues.push(evaluate(a, env));
          }
        }
        return applyClosure(callee, argValues);
      }
      case "compose": {
        const f = evaluate(node.left, env);
        const g = evaluate(node.right, env);
        return makeComposed(f, g);
      }
      case "and": {
        // §3.3・AGENTS.md: 短絡評価。左辺がUnitなら右辺を評価せず即座にUnit。
        const l = evaluate(node.left, env);
        if (isUnit(l)) return UNIT;
        return evaluate(node.right, env);
      }
      case "or": {
        // 短絡評価: 左辺がUnitでなければ右辺を評価せず左辺を返す。
        const l = evaluate(node.left, env);
        if (!isUnit(l)) return l;
        return evaluate(node.right, env);
      }
      case "xor": {
        const l = evaluate(node.left, env);
        const r = evaluate(node.right, env);
        if (isUnit(l)) return r;
        if (isUnit(r)) return l;
        return UNIT;
      }
      case "construct":
      case "concat": {
        const l = evaluate(node.left, env);
        const r = evaluate(node.right, env);
        // §3.2 左辺優先規則: 左辺が文字列（Stringは`\a \b \c`のような文字の並びとも同型）
        // なら、右辺を文字列化してテキストとして連結する（`123` 123 = `123123`、
        // list_model.md §2.1/§4.4）。それ以外は通常のList構築。
        if (typeof l === "string") return l + stringifyForConcat(r);
        return [...asList(l), ...asList(r)];
      }
      case "product": {
        const l = evaluate(node.left, env);
        const r = evaluate(node.right, env);
        return [...asList(l), r];
      }
    }

    if (ARITH_OPS[node.name]) return evalArith(node.name, node.left, node.right, env);
    if (COMPARE_OPS[node.name]) return evalCompare(node.name, node.op, node.left, node.right, env);

    if (node.position === "prefix" || node.position === "postfix") {
      switch (node.name) {
        case "negate": {
          const v = evaluate(node.operand, env);
          return isUnit(v) ? UNIT : -v;
        }
        case "not": {
          const v = evaluate(node.operand, env);
          return isUnit(v) ? true : UNIT; // §4: !__ = id射（真）、!非Unit = __（偽）
        }
        case "expand": {
          // 後置~：1段階展開。今回の簡易値表現ではリストはそのままJS配列のため、
          // 展開はconstruct/concat側（配列のspread）に委ねてそのまま値を通す。
          return evaluate(node.operand, env);
        }
        case "continuous":
          // 前置~（rest記法用の密着マーカー）。値としてはオペランドをそのまま返す。
          return evaluate(node.operand, env);
        case "factorial": {
          const v = evaluate(node.operand, env);
          if (isUnit(v)) return UNIT;
          let r = 1;
          for (let i = 2; i <= v; i++) r *= i;
          return r;
        }
        case "export_internal":
        case "export_external":
        case "export_pin":
          return evaluate(node.operand, env);
      }
      throw new Error(`interpreter: 未対応の前置/後置演算 '${node.name}'（$/@/#はアドレス操作のため未対応）`);
    }

    // 未対応の演算（$/@/#等）
    throw new Error(`interpreter: 未対応の演算 '${node.name}'`);
  }

  return UNIT;
}

export { evaluate, newRuntimeEnv, envDefine, envGet, UNIT, isUnit };
