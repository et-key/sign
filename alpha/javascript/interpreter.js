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
 * - 未定義識別子のUnit収束（unit.md §0.1）：どのスコープにも見つからない識別子は例外を
 *   投げず`__`へフォールバックする。この収束は非ブロッキングな"information"診断として
 *   `env.diagnostics`（ルート env から共有される配列）に記録する。仮想キーワードとしての
 *   意図的な利用（`@lazy tick`等）を委縮させないため、warning/cautionへは格上げしない
 *   （末尾位置の警告はtco.md §3の領域でありTCO解析が無い本インタプリタでは対象外）。
 */

// Unit（__）の実行時における一意な番人（sentinel）。Symbolなので他のどんな値とも衝突しない。
const UNIT = Symbol("Sign.Unit");

function isUnit(v) {
  return v === UNIT || v === undefined;
}

// pass3.jsのisDefineNodeと同じ判定（循環import回避のためここで別途最小実装）。
function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}
function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

// ---- 実行時環境（Pass1の静的envとは別物、実際の値を保持する） ----
// diagnosticsは子envにも同じ配列参照を引き継ぐ（ルートenvに一元的に蓄積される）。
function newRuntimeEnv(parent) {
  return { bindings: new Map(), parent: parent || null, diagnostics: parent ? parent.diagnostics : [] };
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
  // 未定義識別子はUnitへ収束（unit.md §0.1）。診断はinformationレベルに留め、実行は止めない。
  env.diagnostics.push({ level: "information", message: `未定義識別子 '${name}' は Unit(__) に収束しました`, identifier: name });
  return UNIT;
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

// 実引数ノード1個を評価して値配列にする。後置~（expand）付きなら複数の位置引数へ展開する
// （apply/apply_reverse共通、pattern_guide.md「関数にListを渡すときは必ず後置~を使う」）。
function evalArgValues(argNode, env) {
  if (argNode.type === "operation" && argNode.position === "postfix" && argNode.name === "expand") {
    const v = evaluate(argNode.operand, env);
    return Array.isArray(v) ? v : [v];
  }
  return [evaluate(argNode, env)];
}

function paramEntriesOf(paramsNode) {
  if (!paramsNode) return [];
  if (paramsNode.type === "atom" && paramsNode.kind === "identifier") {
    return [{ name: paramsNode.value, rest: false, default: null }];
  }
  if (paramsNode.type === "params") return paramsNode.entries;
  return [];
}

// ブラケット仮引数リスト（`[x ~xs]`等、list_model.md §2.4のEagerパターン）へ、呼び出し側が
// 渡した単一のList/Dict実引数を分割代入できる値かどうか判定する。Lambda（クロージャ）は
// 除外する——`f`をそのまま1個の不透明な値として渡すケースを構造体扱いしないため。
function isDestructurable(v) {
  return Array.isArray(v) || (v !== null && typeof v === "object" && !v.__lambda__);
}

// ブラケット仮引数リストへ、単一のList/Dict実引数を分割代入する（8/5の設計合意）。
// List: list_model.md §2.5「rest記法の位置一般化」——`~name`はブラケット内のどの位置にも
// 置ける。`~name`より前の非restエントリは先頭から、`~name`より後の非restエントリは
// **末尾から**順に対応し、`~name`自身はその間に残った要素全部を受け取る
// （`[x ~xs]`＝従来通り先頭分割、`[~head tail]`＝末尾からのpop、`[first ~mid last]`＝
// 両端からの分割代入、いずれも同じロジックで自然に表現される）。
// Dict: エントリ名とキー名の一致で（順序に関わらず）値を引く（構造体メンバーの一致による
// 自動バインディング、function_guide.md）。restエントリがあれば、名前が一致しなかった
// 残りのキーをまとめた新しいオブジェクトを渡す（pattern_guide.mdのStore「~objは...渡した
// 構造体以下の構造体を保持したい場合に使う」）。
// 【.st/.istへの含み】ここで「どのフィールド名にアクセスしたか」がentriesの名前列挙に
// 集約されているため、将来.st生成（type_system.md §6.2「関数仮引数のフィールド要求」）を
// 実装する際、このentries列挙をそのまま構造的フィールド要求集合として再利用できる想定。
function bindBracketParams(entries, value, env) {
  if (Array.isArray(value)) {
    const restIdx = entries.findIndex((e) => e.rest);
    const before = restIdx === -1 ? entries : entries.slice(0, restIdx);
    const after = restIdx === -1 ? [] : entries.slice(restIdx + 1);

    let idx = 0;
    for (const entry of before) {
      let v = idx < value.length ? value[idx] : UNIT;
      idx++;
      if (isUnit(v)) {
        if (entry.default) v = evaluate(entry.default, env);
        else return null; // 完全性公理
      }
      envDefine(env, entry.name, v);
    }

    if (restIdx !== -1) {
      // afterの分だけ末尾を確保してから、間に残った部分をrestへ渡す。
      const restEnd = Math.max(idx, value.length - after.length);
      envDefine(env, entries[restIdx].name, value.slice(idx, restEnd));
      for (let i = 0; i < after.length; i++) {
        const entry = after[i];
        const pos = restEnd + i;
        let v = pos < value.length ? value[pos] : UNIT;
        if (isUnit(v)) {
          if (entry.default) v = evaluate(entry.default, env);
          else return null; // 完全性公理
        }
        envDefine(env, entry.name, v);
      }
    }
    return env;
  }
  // Dict（構造体）: entry名とキー名の一致で分割代入
  const claimedKeys = new Set();
  for (const entry of entries) {
    if (entry.rest) continue; // restは全エントリ処理後にまとめて扱う
    const key = entry.name.slice(1, -1); // "<foo>" -> "foo"
    claimedKeys.add(key);
    let v = Object.prototype.hasOwnProperty.call(value, key) ? value[key] : UNIT;
    if (isUnit(v)) {
      if (entry.default) v = evaluate(entry.default, env);
      else return null; // 完全性公理
    }
    envDefine(env, entry.name, v);
  }
  const restEntry = entries.find((e) => e.rest);
  if (restEntry) {
    const rest = {};
    for (const k of Object.keys(value)) if (!claimedKeys.has(k)) rest[k] = value[k];
    envDefine(env, restEntry.name, rest);
  }
  return env;
}

// 仮引数を実引数に束縛した新しい実行時envを返す。完全性公理により崩壊する場合は null を返す。
function bindParams(paramsNode, argValues, closureEnv) {
  const entries = paramEntriesOf(paramsNode);
  const env = newRuntimeEnv(closureEnv);

  if (paramsNode && paramsNode.type === "params" && paramsNode.bracket && argValues.length === 1 && isDestructurable(argValues[0])) {
    return bindBracketParams(entries, argValues[0], env);
  }

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

// ポイントフリー記述（function_guide.md）: `[+]`（左右とも欠落）・`[+ 1]`（右辺だけ束縛）
// のような、演算子を直接値として扱うLambda。nodeはpass2.jsが作るpartialな中置演算
// ノード（{op, name, partial:true, left, right}）で、left/rightのうち欠けている側が
// 呼び出し引数で埋まる。
function makePointfreeClosure(node, env) {
  return { __lambda__: true, __pointfree__: node, env };
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
  if (closure.__pointfree__) return applyPointfree(closure.__pointfree__, closure.env, argValues);
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

// list_cheat_sheet.md「重複した要素の作成/リフト/分割」: `*`（repeat）・`^`（lift）・
// `/`（split）はList左辺に対して固有の意味を持つ。それ以外の算術演算子（+ - %）は
// Stringの場合（下記）と同様、Listに対しては未定義のため型エラーとしてUnitへ収束する。
function listRepeat(l, r) {
  // [0 1] * 3 → [0 1 0 1 0 1]（lをr回連結）
  const out = [];
  for (let i = 0; i < r; i++) out.push(...l);
  return out;
}
function listLift(l, r) {
  // [0 1] ^ 3 → [[0 1] [0 1] [0 1]]（lのコピーをr個、要素として持ち上げる）
  const out = [];
  for (let i = 0; i < r; i++) out.push([...l]);
  return out;
}
function listSplit(l, r) {
  // [1 2 3 4] / 2 → [[1 2] [3 4]]（lをr個のグループへ均等分割）
  const out = [];
  const size = Math.ceil(l.length / r);
  for (let i = 0; i < l.length; i += size) out.push(l.slice(i, i + size));
  return out;
}

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
  if (Array.isArray(l)) {
    if (name === "mul") return listRepeat(l, r);
    if (name === "pow") return listLift(l, r);
    if (name === "div") return listSplit(l, r);
    return UNIT; // list_cheat_sheet.mdに無い組み合わせ（+ - %）はStringと同様に型エラー
  }
  return ARITH_OPS[name](l, r);
}

// list_model.md §2.3の派生演算子（`~+`/`~-`/`~*`/`~/`/`~^`）に対応するstep関数を返す。
function rangeStepFn(op, step) {
  switch (op) {
    case "~-":
      return (v) => v - step;
    case "~*":
      return (v) => v * step;
    case "~/":
      return (v) => v / step;
    case "~^":
      return (v) => Math.pow(v, step);
    default:
      return (v) => v + step; // "~+" またはstep省略の単純形式
  }
}

// start から end まで（終端を含む）、stepFnを繰り返し適用して配列へ実体化する。
// 昇順・降順どちらもstart/endの大小関係だけから判定する（呼び出し元でstepの符号を揃える）。
function buildRange(start, end, stepFn) {
  const out = [];
  let v = start;
  let guard = 0;
  const ascending = start <= end;
  while (ascending ? v <= end : v >= end) {
    out.push(v);
    v = stepFn(v);
    if (++guard > 1000000) throw new Error("interpreter: range: 要素数が多すぎます（stepが0または終端に向かっていない可能性）");
  }
  return out;
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

// 前置/後置の単項演算（すでに評価済みの値vに対して行う）。通常のevaluate()経路
// （node.operandを評価してここへ渡す）と、ポイントフリーのhole適用（下記applyPointfree、
// 呼び出し引数を直接vとして渡す）の両方から共有する。
function evalUnaryOp(name, v) {
  switch (name) {
    case "negate":
      return isUnit(v) ? UNIT : -v;
    case "not":
      return isUnit(v) ? true : UNIT; // §4: !__ = id射（真）、!非Unit = __（偽）
    case "expand":
      // 後置~：1段階展開。今回の簡易値表現ではリストはそのままJS配列のため、
      // 展開はconstruct/concat側（配列のspread）に委ねてそのまま値を通す。
      return v;
    case "continuous":
      // 前置~（rest記法用の密着マーカー）。値としてはオペランドをそのまま返す。
      return v;
    case "factorial": {
      if (isUnit(v)) return UNIT;
      let r = 1;
      for (let i = 2; i <= v; i++) r *= i;
      return r;
    }
    case "export_internal":
    case "export_external":
    case "export_pin":
      return v;
  }
  throw new Error(`interpreter: 未対応の前置/後置演算 '${name}'（$/@/#はアドレス操作のため未対応）`);
}

// ポイントフリー演算子（`[+]`/`[+ 1]`/`[!_]`/`[_!]`等）を呼び出し引数へ適用する。
// 中置（op/left/right）と前置/後置（op/operand=hole）の両方に対応する
// （function_guide.md「全ての演算子を関数として扱う」、演算子の種類を問わない）。
// - 前置/後置（`[!_]`/`[_!]`）: holeの位置に呼び出し引数をそのまま充てる（arity=1固定）。
// - 中置・完全に裸（left/right両方null）: 貪欲に複数引数を畳み込む（function_guide.md
//   「ポイントフリー記述の二項演算子は、複数の引数を貪欲に演算する」、[+] 1 2 3 4 5 → 15）。
//   後置~による展開（evalArgValues）と組み合わせれば、[+] [1 2 3 4]~ のような畳み込み
//   関数（list_cheat_sheet.md）としても機能する。
// - 中置・右辺だけ束縛（left=null, right=非null）: 呼び出し引数が欠けている左辺を埋める
//   （[+ 1] 5 = 5 + 1、documents/ja-jp/guide/example.snの合成連鎖の例）。
function applyPointfree(node, closureEnv, argValues) {
  if (node.position === "prefix" || node.position === "postfix") {
    const x = argValues.length > 0 ? argValues[0] : UNIT;
    return evalUnaryOp(node.name, x);
  }

  const combine = (a, b) => {
    if (ARITH_OPS[node.name]) return ARITH_OPS[node.name](a, b);
    if (COMPARE_OPS[node.name]) {
      // ポイントフリーはList側のfold/map/filterが前提（8/5の設計合意）のため、単位元の
      // 見方も算術側（0/1）ではなくList側に移る——真なら常に要素そのもの(a)を残す。
      // evalCompare（通常の中置比較）の§4規則「左辺が算術単位元(0/1)なら右辺、それ以外は
      // 左辺」は、算術チェーンの中で「次に運ぶ値」を選ぶための規則であり、fold/map/filter
      // で「元の要素を残す/捨てる」ことが目的のポイントフリー文脈にはそぐわない
      // （`[< 3,] [1 2 3]~`が要素の1,2ではなく評価結果の3,2になってしまう）。
      if (isUnit(a) || isUnit(b)) return UNIT;
      const truthy = COMPARE_OPS[node.name](a, b);
      return truthy ? a : UNIT;
    }
    throw new Error(`interpreter: pointfree: 未対応の演算子 '${node.name}'`);
  };

  const rightBound = node.right !== null && node.right !== undefined;
  const leftBound = node.left !== null && node.left !== undefined;

  if (node.pointfreeMap) {
    // 末尾カンマの写像糖衣構文（`[* 2,]`、function_guide.md「そのすべてに適用される」）。
    // 複数の位置引数（`[* 2,] 1 2 3 4 5`、Phase2の貪欲消費でここへ集約済み）・後置~で
    // 展開されたList（`[* 2,] [1 2 3]~`、evalArgValuesが既に展開済み）のどちらでも、
    // argValuesは「写像対象の値がフラットに並んだ配列」として届く。各要素へ演算を適用し、
    // 結果からUnitを取り除く——比較演算子（`[< 3,]`）は真の場合のみ値を返す（§4）ため、
    // このUnit除去だけで「選択写像」（select、偽だった要素の除外）が自然に得られる
    // （list_cheat_sheet.md「選択写像」、余積のUnit除去則、type_system.mdの輸入失敗例と同型）。
    const bound = rightBound ? evaluate(node.right, closureEnv) : undefined;
    const results = argValues.map((v) => (isUnit(v) ? UNIT : combine(v, bound)));
    return results.filter((r) => !isUnit(r));
  }

  if (!leftBound && !rightBound) {
    if (argValues.length === 0) return UNIT;
    return argValues.reduce((acc, v) => (isUnit(acc) ? UNIT : combine(acc, v)));
  }
  if (rightBound && !leftBound) {
    const bound = evaluate(node.right, closureEnv);
    const x = argValues.length > 0 ? argValues[0] : UNIT;
    if (isUnit(x)) return UNIT;
    return combine(x, bound);
  }
  // left束縛・right欠落（例が仕様に無いため未対応）。
  throw new Error("interpreter: pointfree: この形の部分適用（左辺束縛・右辺欠落）は未対応です");
}

// ---- construct/concat/product（List/Struct構築） ----
// unit.md 91-92行目: 空白/カンマ等の余積演算における __ は単位元（`__ op x = x`）であり、
// 103行目「`__ = []`（空リストと等価）」の通り、値として並べず消去（フィルタ）する。
function asList(v) {
  if (isUnit(v)) return [];
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
    // |list|（abs）: list_cheat_sheet.md「要素数の取得」。ブロックとしては通常通り解決される
    // （中身を逐次評価、最後の文の値）が、kind==='abs'の場合だけ絶対値/要素数へ変換する
    // ——List/StringならJSの.length、数値ならMath.abs（"absolute"の名の通り、リストの
    // 要素数と数値の絶対値を同じ記号で表す設計、list_cheat_sheet.mdの命名）。
    if (node.kind === "abs") {
      let inner = UNIT;
      for (const line of node.lines) inner = evaluate(line, env);
      if (Array.isArray(inner) || typeof inner === "string") return inner.length;
      if (isUnit(inner)) return UNIT;
      return Math.abs(inner);
    }
    // Dict判定はpass3.jsのinferAtomTypeと同じ基準（全行がdefineかつ左辺が識別子）。
    // 左辺が識別子でないdefine行（下記match_case）と区別するため、identifierNode
    // 判定も併せて要求する——さもないと「フォールバック行の無いmatch_case連鎖」
    // （全行がcond:result）がDict扱いされてしまう。辞書は独立したスコープで評価し、
    // キーが呼び出し元のenvへ漏れないようにする（let*的に、後のキーのデフォルト式的な
    // 参照は前のキーを見られる）。
    if (node.lines.length >= 1 && node.lines.every((l) => isDefineNode(l) && isIdentifierNode(l.left))) {
      const dictEnv = newRuntimeEnv(env);
      const dict = {};
      for (const line of node.lines) {
        const value = evaluate(line, dictEnv); // define評価：dictEnvに束縛しつつ値を返す
        dict[line.left.value.slice(1, -1)] = value; // "<foo>" -> "foo"
      }
      return dict;
    }
    // 通常のブロックの逐次評価。match_case（function_guide.md「?の右辺を改行・インデント
    // ブロックを挟むことで、本体内の:演算子はmatch_caseとなる」）：defineノードで左辺が
    // 識別子でない（＝実質的には条件式）行は、「条件:結果」の短絡評価テストとして扱う。
    // 条件を評価し非Unit（真）なら即座にその行の右辺（結果）を返してブロック全体を
    // 打ち切る。Unit（偽）なら束縛は一切行わず次の行へ進む。左辺が識別子の行は今まで
    // 通りevaluate（defineとしてenvDefineし、その値をブロックの現在の結果とする）。
    let result = UNIT;
    for (const line of node.lines) {
      if (isDefineNode(line) && !isIdentifierNode(line.left)) {
        const cond = evaluate(line.left, env);
        if (!isUnit(cond)) return evaluate(line.right, env);
        continue;
      }
      result = evaluate(line, env);
    }
    return result;
  }

  if (node.type === "operation") {
    // ポイントフリー記述（`[+]`/`[+ 1]`等、pass2.jsが作るpartialな中置演算ノード）は
    // 値として評価される場面では即座に演算しようとせず、クロージャ値として返す
    // （下のARITH_OPS/COMPARE_OPS分岐に落ちるとnode.left===nullをUnit扱いして
    // 誤った結果になるため、switch/算術分岐より前でここで捕捉する）。
    if (node.partial) return makePointfreeClosure(node, env);
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
          argValues.push(...evalArgValues(a, env));
        }
        return applyClosure(callee, argValues);
      }
      case "apply_reverse": {
        // `x f`（UFCS的なreceiver記法、coproduct_resolver.md §3の10.3）。左のxは常に
        // ちょうど1個のreceiver値としてのみ渡す（8/5の設計合意：複数引数は取れない）。
        // applyと違い後置~による複数位置引数への展開は行わない——xが`~`付きList等でも
        // 展開せず「1個の値」としてそのまま渡す（evaluate側のexpandケースは非spread時
        // 単なる素通しなので、ここでevalArgValuesを使わず直接evaluateするだけで済む）。
        // それ以外はapplyと全く同じ経路（bindParams・完全性公理）を通す——
        // `f : [foo bar ~this] ? ...`のような構造体destructuringも通常呼び出しと同じ
        // 仕組みで解決される。
        const callee = evaluate(node.right, env);
        return applyClosure(callee, [evaluate(node.left, env)]);
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
      // list_cheat_sheet.md「先頭/末尾に要素追加」（10.1、pass2.jsのcoproductReduce参照）。
      // pass2.js側の命名はJS配列メソッドのpush/unshiftとは意味が逆——push(a,b)はb側が
      // List（右がList~）で「aを先頭へ」、unshift(a,b)はa側がList（左がList~）で
      // 「bを末尾へ」（pass2.js冒頭コメント「優先度10.1の具体的な演算子名」参照、
      // 仕様は方向性を明記していないため実装時に決めた仮定）。
      case "push": {
        // 0 [1 2 3] → [0 1 2 3]（aを先頭に追加）。aがUnit（単位元）なら素通しでbのみ返す。
        const a = evaluate(node.left, env);
        const b = evaluate(node.right, env);
        return isUnit(a) ? asList(b) : [a, ...asList(b)];
      }
      case "unshift": {
        // [1 2 3] 4 → [1 2 3 4]（bを末尾に追加）。bがUnit（単位元）なら素通しでaのみ返す。
        const a = evaluate(node.left, env);
        const b = evaluate(node.right, env);
        return isUnit(b) ? asList(a) : [...asList(a), b];
      }
      // list_model.md §2.3「派生演算子による範囲リストの構築」。仕様上レンジ式の実体は
      // 常にイテレータ（{start,step,end}の固定サイズ構造体、終端の無い2項指定はPull型の
      // 無限ストリームにもなれる）だが、本インタプリタは全ての値をJS配列へ実体化する
      // 単純な評価器のため、ここでは常に即座に配列へ展開する（3項セット「即座に全消費」
      // の挙動のみ再現、2項指定の遅延・無限ストリームは未対応——下記参照）。
      case "range": {
        // 3項形式 [start ~+ step ~ end]（node.leftがrange_arithmeticノード）と、
        // 単純形式 [start ~ end]（step省略、昇順なら+1・降順なら-1）の両方を扱う。
        if (node.left && node.left.type === "operation" && node.left.name === "range_arithmetic") {
          const start = evaluate(node.left.left, env);
          const step = evaluate(node.left.right, env);
          const end = evaluate(node.right, env);
          return buildRange(start, end, rangeStepFn(node.left.op, step));
        }
        const start = evaluate(node.left, env);
        const end = evaluate(node.right, env);
        const step = start <= end ? 1 : -1;
        return buildRange(start, end, (v) => v + step);
      }
      case "range_arithmetic": {
        // 2項形式 [start ~+ step]（終端なし）は仕様上、終端を持たない無限のPull型
        // ストリーム（list_model.md §2.3「2項指定」）。本インタプリタは実体化された
        // 値しか扱えないため、無限生成を試みず明示的に未対応として拒否する。
        throw new Error(
          "interpreter: 終端の無い範囲式（2項指定の~+等）は無限のPull型ストリームのため、値を全て実体化する本インタプリタでは未対応です（list_model.md §2.3）"
        );
      }
      case "product": {
        // list_model.md §2.1: `1,2,3,4,5`（スカラーのカンマ連鎖）は`1 2 3 4 5`と等価な
        // フラットリストだが、§(n次元配列の構築)の`1 2 3 , 4 5 6`は[[1,2,3],[4,5,6]]という
        // 入れ子。`,`は左結合（product[product[1,2],3]の形）で連鎖するため、左辺自身が
        // 同じproductノード（＝連鎖の続き）の場合だけ展開して連結し、そうでない場合
        // （スペースで構築された塊やリテラル単体が左辺の場合）は互いに対等な要素として
        // 2要素のリストにする。
        const l = evaluate(node.left, env);
        const r = evaluate(node.right, env);
        const isChain = node.left && node.left.type === "operation" && node.left.name === "product";
        return isChain ? [...asList(l), r] : [l, r];
      }
      case "get_prop": {
        // `d ' foo`: 右辺が識別子の場合、変数として評価せず「キー名そのもの」として扱う
        // （Dict/Structのフィールドアクセス）。数値等なら通常通り評価してListのインデックスに使う。
        const l = evaluate(node.left, env);
        if (isUnit(l)) return UNIT;
        if (node.right.type === "atom" && node.right.kind === "identifier") {
          const key = node.right.value.slice(1, -1); // "<foo>" -> "foo"
          if (l && typeof l === "object" && !Array.isArray(l)) {
            return Object.prototype.hasOwnProperty.call(l, key) ? l[key] : UNIT;
          }
          return UNIT;
        }
        const r = evaluate(node.right, env);
        if (Array.isArray(l) && typeof r === "number") {
          return r >= 0 && r < l.length ? l[r] : UNIT;
        }
        // list_cheat_sheet.md「範囲で要素取得」: `[1 2 3 4] ' [1 ~ 3]` → `[2 3 4]`。
        // rangeが実体化したインデックス列（配列）で、該当位置の値をまとめて取り出す。
        if (Array.isArray(l) && Array.isArray(r)) {
          return r.map((i) => (typeof i === "number" && i >= 0 && i < l.length ? l[i] : UNIT));
        }
        return UNIT;
      }
    }

    if (ARITH_OPS[node.name]) return evalArith(node.name, node.left, node.right, env);
    // `!=`（tier12、name="not_equal"）はCOMPARE_OPSにキーを持たない——8/6にoperator_table.js
    // 側のtier8`!==`をname="xnot_equal"へ改名して名前衝突自体は解消したが、COMPARE_OPS
    // （evalCompareの汎用フォールバックが呼ぶテーブル）には依然not_equalを追加していない。
    // evalCompareは既にop==="!="専用の分岐（§4の例外規則）を持っているため、ここで
    // node.opを見て個別に通す。`!==`（構造比較、xnot_equal）はここではまだ未対応のまま
    // ——別途、構造的な深い等価性比較の実装が必要（==/===とセットで、要検討）。
    if (COMPARE_OPS[node.name] || node.op === "!=") return evalCompare(node.name, node.op, node.left, node.right, env);

    if (node.position === "prefix" || node.position === "postfix") {
      return evalUnaryOp(node.name, evaluate(node.operand, env));
    }

    // 未対応の演算（$/@/#等）
    throw new Error(`interpreter: 未対応の演算 '${node.name}'`);
  }

  return UNIT;
}

export { evaluate, newRuntimeEnv, envDefine, envGet, UNIT, isUnit };
