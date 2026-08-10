/**
 * 最小インタプリタ（評価器）。Pass2/Pass1bが構築した二分木ASTを実際に評価して値を出す。
 *
 * 【スコープ】今回の最初の実装は以下に限定する（既知の制限）：
 * - `$`/`@`/`#`（アドレス取得・デリファレンス・ストア）は未対応。メモリモデルが必要な
 *   ため別途の設計課題とする。
 * - block（List/Struct/Struct）の評価はシンプルなJS配列/オブジェクトへのマッピングに留める。
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

// unit.md 103行目「`__ = []`（空リストと等価）」: 空配列はUnitと同型として扱う。
// これが無いと、`[h ~t]`型の再帰でリストを完全に消費し尽くした終端（restが正しく[]に
// なった状態）が`!placed`/`placed & ...`のようなUnit判定で検出できず、範囲外アクセスが
// 静かにUNITへ吸収されたまま再帰が終端しないまま数値の偶然の一致に頼って停止する、
// といった見た目上は動くが誤った挙動を招く（8-Queens監査で発見、2026-08-08）。
// string_and_comment.md §1「空文字列は`__`（Unit）と同型」: 同じ理屈をStringドメインにも
// 適用する——空文字列は文字列連結の単位元（`"" + s = s`）であり、空リストが余積の単位元
// であるのと同じ位置づけ。
function isUnit(v) {
  return v === UNIT || v === undefined || (Array.isArray(v) && v.length === 0) || v === "";
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
// 渡した単一のList/Struct実引数を分割代入できる値かどうか判定する。Lambda（クロージャ）は
// 除外する——`f`をそのまま1個の不透明な値として渡すケースを構造体扱いしないため。
function isDestructurable(v) {
  return Array.isArray(v) || (v !== null && typeof v === "object" && !v.__lambda__);
}

// ブラケット仮引数リストへ、単一のList/Struct実引数を分割代入する（8/5の設計合意）。
// List: list_model.md §2.5「rest記法の位置一般化」——`~name`はブラケット内のどの位置にも
// 置ける。`~name`より前の非restエントリは先頭から、`~name`より後の非restエントリは
// **末尾から**順に対応し、`~name`自身はその間に残った要素全部を受け取る
// （`[x ~xs]`＝従来通り先頭分割、`[~head tail]`＝末尾からのpop、`[first ~mid last]`＝
// 両端からの分割代入、いずれも同じロジックで自然に表現される）。
// Struct: エントリ名とキー名の一致で（順序に関わらず）値を引く（構造体メンバーの一致による
// 自動バインディング、function_guide.md）。restエントリがあれば、名前が一致しなかった
// 残りのキーをまとめた新しいオブジェクトを渡す（pattern_guide.mdのStore「~objは...渡した
// 構造体以下の構造体を保持したい場合に使う」）。
// 【.st/.istへの含み】ここで「どのフィールド名にアクセスしたか」がentriesの名前列挙に
// 集約されているため、将来.st生成（type_system.md §6.2「関数仮引数のフィールド要求」）を
// 実装する際、このentries列挙をそのまま構造的フィールド要求集合として再利用できる想定。
function bindBracketParams(entries, value, env) {
  // スカラー ≅ 1要素リスト（asList/get_propと同じ同型性）。Struct（プレーンオブジェクト）
  // ではない非Array値は、長さ1のリストとして分割代入できる。
  if (!isDestructurable(value)) value = [value];
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
  // Struct（構造体）: entry名とキー名の一致で分割代入
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

    if (entry.pattern) {
      // 混在パラメータ内のブラケット分割代入エントリ（pass2.jsのparseParamStatements/
      // splitBareParamTokens参照、例: `f : a [h ~t] ? ...`）。対応する1個の実引数を
      // そのままこのenvへ分割代入する（ネストした完全性公理の崩壊は呼び出し全体へ伝播）。
      if (bindBracketParams(entry.pattern, value, env) === null) return null;
      continue;
    }
    envDefine(env, entry.name, value);
  }

  return env;
}

function makeClosure(paramsNode, bodyNode, env) {
  return { __lambda__: true, params: paramsNode, body: bodyNode, env };
}

// `!__` が返す Id射（categorical_truth.md §6、guide/operator_table.md 141行目）。
// SKIのKコンビネータ（λx.λy.x、引数をそのまま返す恒等射）がSignにおける「真」であり、
// `__`（K*、引数を吸収する void 関数）が「偽」である。
// 【重要】ここで `1` や `true` のような具体的な値を返してはいけない——それは Boolean 型を
// 暗黙に再導入することであり、「Signに真偽値型は存在しない」という設計原則と矛盾する
// （categorical_truth.md の IMPORTANT ブロックが明示的に禁じている）。返すのは
// 「Unitでない何か」＝副作用を持たないことが静的に確定している恒等射そのもの。
// 未評価のラムダはUnitと同型（副作用の可能性があり評価予定が確定しない）だが、この
// Id射だけはその例外——純粋な恒等関数なので評価予定が静的に確定し、非Unitとして扱える。
const IDENTITY = { __lambda__: true, __identity__: true };

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

// 自動カリー化（project memory: project-sign-currying-design、pass2.jsのmarkUndersaturatedApplies
// が"partial_apply"と静的に判定した呼び出し）を、部分適用クロージャへ変換する。
// 既に渡された分の実引数を新しいenvへ束縛し（完全性公理はここでも健在——供給された値が
// 明示的にUnitなら、デフォルトが無い限りやはり崩壊する。これは「値がUnit」の話であり、
// pass2が判定した「引数の個数が足りない」とは別軸——ここへ来る時点で個数の判断は
// 既に済んでいる）、残りの仮引数だけを持つ新しいLambdaを返す。
function makePartialClosure(closure, suppliedArgs) {
  const entries = paramEntriesOf(closure.params);
  const bound = entries.slice(0, suppliedArgs.length);
  const remaining = entries.slice(suppliedArgs.length);
  const capturedEnv = newRuntimeEnv(closure.env);
  for (let i = 0; i < bound.length; i++) {
    const entry = bound[i];
    let value = suppliedArgs[i];
    if (isUnit(value)) {
      if (entry.default) value = evaluate(entry.default, capturedEnv);
      else return UNIT; // 完全性公理：デフォルト無しのパラメータに明示的なUnitが来た場合は崩壊
    }
    envDefine(capturedEnv, entry.name, value);
  }
  const remainingParams = {
    type: "params",
    entries: remaining,
    requiredArity: remaining.filter((e) => !e.rest && e.default === null).length,
    bracket: false,
  };
  return { __lambda__: true, params: remainingParams, body: closure.body, env: capturedEnv };
}

// ---- 末尾呼び出し最適化（TCO） ----
// Signはif/while/forを持たず反復を再帰でのみ表現する設計（0_design_principles.md）だが、
// このインタプリタは素朴に木を歩くだけで、JS自身もES6仕様のProper Tail Callsを実装して
// いない（V8は結局実装しなかった）ため、深い再帰がJSの呼び出しスタック上限に直撃する
// （8-Queens監査後の相互再帰テストでn=2000程度からMaximum call stack size exceeded）。
// トランポリン方式で対処する: 末尾位置での関数呼び出しをTailCallという「まだ実行して
// いない呼び出しの予約」として返し、applyClosure側のwhileループがそれを検出したら
// 新しいJSスタックフレームを積まずに同じフレーム内でループを継続する。

// TailCallマーカー: 末尾位置で見つかったLambda呼び出し（未実行）を表す。
class TailCall {
  constructor(closure, argValues) {
    this.closure = closure;
    this.argValues = argValues;
  }
}

// インデントブロック（match_case含む）の逐次評価。tailEvalは「ブロックの最終結果と
// なる式」をどう評価するかのコールバック——通常のevaluate()からはevaluate自身を渡す
// （常に値を完全に確定させる、従来通りの挙動）。末尾呼び出し検出用のevaluateTailからは
// evaluateTail自身を渡すことで、末尾位置の判定ロジックをこの1箇所だけに保つ。
function evalIndentBlock(node, env, tailEval) {
  const lines = node.lines;
  let result = UNIT;
  for (let i = 0; i < lines.length; i++) {
    const line = lines[i];
    if (isDefineNode(line) && !isIdentifierNode(line.left)) {
      const cond = evaluate(line.left, env);
      if (!isUnit(cond)) return tailEval(line.right, env);
      continue;
    }
    if (i === lines.length - 1) return tailEval(line, env);
    result = evaluate(line, env);
  }
  return result;
}

// nodeを「末尾位置」として評価する。末尾位置とは、この式の値がそのまま関数呼び出し
// 全体の返値になる位置——ブロックの最終行・発火したmatch_case分岐の右辺・`|`/`&`の
// 右辺（短絡評価で右へ進んだ場合、その結果に対して何も後処理をしないため）。
// これらの位置を再帰的に辿った先が既知のLambdaへの素朴なapply呼び出しであれば、
// その場でapplyClosureを再帰呼び出しする代わりにTailCallマーカーを返す——
// JSのスタックフレームを消費しない。それ以外の形（compose・pointfree・組み込み関数・
// 算術式など）は通常のevaluate()にそのまま委譲する（正しく動くが最適化はされない）。
function evaluateTail(node, env) {
  if (!node || typeof node !== "object") return evaluate(node, env);
  if (
    node.type === "block" &&
    node.kind === "indent" &&
    !(node.lines.length >= 1 && node.lines.every((l) => isDefineNode(l) && isIdentifierNode(l.left)))
  ) {
    // Struct型（全行define+識別子キー）はここでは対象外——evaluate()のStruct分岐へ委譲。
    return evalIndentBlock(node, env, evaluateTail);
  }
  if (node.type === "operation") {
    if (node.name === "or") {
      const l = evaluate(node.left, env);
      if (!isUnit(l)) return l;
      return evaluateTail(node.right, env);
    }
    if (node.name === "and") {
      const l = evaluate(node.left, env);
      if (isUnit(l)) return UNIT;
      return evaluateTail(node.right, env);
    }
    if (node.name === "apply") {
      const { calleeNode, argNodes } = collectApplyChain(node);
      const callee = evaluate(calleeNode, env);
      const argValues = [];
      for (const a of argNodes) argValues.push(...evalArgValues(a, env));
      // compose/pointfree/組み込み関数（JS function）は素朴なLambda呼び出しではないため
      // トランポリンの対象外——安全側に倒して通常のapplyClosureへ委譲する。
      if (callee && callee.__lambda__ && !callee.__compose__ && !callee.__pointfree__) {
        return new TailCall(callee, argValues);
      }
      return applyClosure(callee, argValues);
    }
  }
  return evaluate(node, env);
}

// 「複数の実引数を貪欲に消費する」ポイントフリークロージャかどうか（実行時版）。
// pass2.js の isGreedyPointfree と同じ判定を、縮約後のクロージャに対して行う
// ——合成の中間をストリームとして展開すべきかどうかの判断に使う。
function isGreedyPointfreeClosure(closure) {
  const node = closure && closure.__pointfree__;
  if (!node || !node.partial) return false;
  return node.pointfreeMap === true || (node.left === null && node.right === null);
}

function applyClosure(closure, argValues) {
  // eslint-disable-next-line no-constant-condition
  while (true) {
    if (typeof closure === "function") return closure(...argValues); // 組み込み関数
    // 関数の位置に来たUnitは余積の初対象（単位元）として引数を素通しする
    // （type_system.md §6.1の表「関数の位置 (`__ x`) → 引数を素通しにする」、
    // 同§のimport失敗例が示す通りクラッシュさせない）。Pass2が静的にLambdaと判定した
    // 呼び出し先が、実行時にはまだ束縛されていない・未定義でUnitに収束していた、という
    // 場合にここへ来る——unit.md §0.1の「未定義識別子はUnitへ収束、実行は止めない」に
    // 揃える。Id射（`!__`）への適用と同じ結果になるのは偶然ではなく、
    // guide/operator_table.md 147行目の `__ 5 == !__ 5` が言っていることそのもの。
    if (isUnit(closure)) return argValues.length === 1 ? argValues[0] : argValues;
    if (!closure || !closure.__lambda__) {
      throw new TypeError("Lambdaではない値を関数として適用しようとしました");
    }
    if (closure.__compose__) {
      const [f, g] = closure.__compose__;
      // 完全性公理はチェーン全体に効く：fの結果がUnitならgを呼ばず即座にUnit。
      // 左(f)を先に適用し、その結果に右(g)を適用する（左→右パイプライン順、上記参照）。
      const mid = applyClosure(f, argValues);
      if (isUnit(mid)) return UNIT;
      // list_model.md §2.4③: ポイントフリー合成の中間は「1個の実体化されたList値」
      // ではなく次段へ流れるストリーム（①②の Eager/Lazy 境界と同じ原則）。
      // 次段が貪欲なポイントフリー（`[+]`/`[* 2,]`）なら展開して渡す——
      // `[* 2,] [+] 1 2 3 4 5` は「2倍の写像 → 畳み込み」で30になる。
      // 括弧で括った場合（`([* 2,] 1 2 3 4 5)`）はそこで値（List）に実体化されるため、
      // 畳み込むには後置`~`での再展開が要る、という区別がそのまま効く。
      if (Array.isArray(mid) && isGreedyPointfreeClosure(g)) return applyClosure(g, mid);
      return applyClosure(g, [mid]);
    }
    // Id射（`!__`）への適用は引数をそのまま返す。引数がUnitなら完全性公理がそのまま
    // 効いてUnitになる（categorical_truth.md「`!__ __` は理論的に正しく `__` を返す」）。
    if (closure.__identity__) return argValues.length > 0 ? argValues[0] : UNIT;
    if (closure.__pointfree__) return applyPointfree(closure.__pointfree__, closure.env, argValues);
    const callEnv = bindParams(closure.params, argValues, closure.env);
    if (callEnv === null) return UNIT;
    const result = evaluateTail(closure.body, callEnv);
    if (result instanceof TailCall) {
      // 末尾呼び出し: 新しいJSフレームを積まず、同じループの中で継続する。
      closure = result.closure;
      argValues = result.argValues;
      continue;
    }
    return result;
  }
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

// type_system.md §3.2/§4.1 の丸め規則: 四捨五入（最近接、タイは0から遠ざける）。
// AArch64の`fcvtas`/`fcvtau`が1命令で行う丸めと同じ方向。JSの`Math.round`は
// タイを+∞方向へ倒す（`Math.round(-2.5)`が`-2`になる）ため、負側は符号を外して
// 丸めてから戻す必要がある。
function roundHalfAwayFromZero(x) {
  return x < 0 ? -Math.round(-x) : Math.round(x);
}

// 算術族の型規則を**値に対して**適用する（type_system.md §3.2）。
// 通常の中置（evalArith）とポイントフリー（applyPointfree の combine）の両方から呼ぶ——
// 以前は後者が ARITH_OPS を直に叩いており型ガードを丸ごと迂回していたため、
// `[+ 1] [1 2 3]` が `"1,2,31"`（JSの配列→文字列強制）、`[* 2,] \`abc\`` が NaN を
// 静かに返していた。算術が何を意味するかを決める場所は1つでなければならない。
function arithOnValues(name, l, r) {
  if (isUnit(l)) return UNIT; // 左辺Unit = 吸収元
  // §3.2: String（Listと同型）の左辺に算術演算子は効かない → 型エラーで__に収束。
  // 注: list_model.md §4.4の文面は「+でコードポイントが露出する」としているが、
  // 自身の例(`123` 123 = `123123`)はスペース連結でありこの主張を実証していない。
  // type_system.md §3.2の明示的な表（String+算術演算子→型エラー(__消去)）を正とする。
  if (typeof l === "string") return UNIT;
  if (isUnit(r)) return l; // 右辺Unit = 単位元（id射、素通し）
  if (Array.isArray(l)) {
    // §3.2の算術族テーブル: List左辺の `*`/`^`/`/` は右辺を「回数・個数」として使うため
    // Address（数値）でなければならない。それ以外は型エラーで__へ収束する。
    if (typeof r !== "number") return UNIT;
    if (name === "mul") return listRepeat(l, r);
    if (name === "pow") return listLift(l, r);
    if (name === "div") return listSplit(l, r);
    return UNIT; // list_cheat_sheet.mdに無い組み合わせ（+ - %）はStringと同様に型エラー
  }
  // §3.2 数値の昇格格子: 算術族に数値以外が混ざったら型エラーとして__へ収束する（両方向）。
  // 左辺Stringは上で弾いているが、右辺が String/List/Lambda のケースはここまで落ちてくる。
  // この判定が無いとJSの型強制がそのまま漏れ、「もっともらしく見える間違った値」が
  // 静かに出てくる——`1 + \`abc\`` → "1abc"、`1 + [2 3]` → "12,3"、
  // `x : !__` の `x + 1` → "[object Object]1" は全てこの経路だった。
  if (typeof l !== "number" || typeof r !== "number") return UNIT;
  return ARITH_OPS[name](l, r);
}

function evalArith(node, env) {
  const name = node.name;
  const l = evaluate(node.left, env);
  // 左辺がUnit/Stringの時点で右辺を評価せずに済ませる（短絡、既存の挙動を保つ）
  if (isUnit(l) || typeof l === "string") return arithOnValues(name, l, undefined);
  const r = evaluate(node.right, env);
  const value = arithOnValues(name, l, r);
  if (typeof value !== "number") return value;
  // §3.2「除算だけは Address 同士でも丸めが起きる」: 結果型が Address（＝両辺とも
  // Address）なのに非整数が出たら四捨五入する。丸めるべきかどうかは**値**からは
  // 決められない——JSのNumberでは `5` と `5.0` が同一なので、`5 / 2`（→3）と
  // `5.0 / 2`（→2.5）を値だけで区別できない。pass3 がノードへ載せた Layer 2 型
  // （compile.js のパイプライン）を読んで初めて判定できる。
  if (node.atomType === "Address" && !Number.isInteger(value)) {
    const rounded = roundHalfAwayFromZero(value);
    // 精度が失われたことを information として記録する（unit.md §7.3 と同じ非ブロッキング
    // 診断のレベル）。昇格格子のおかげで Float が絡む算術は精度を落とさないため、
    // 黙って丸めが起きるのは Address 同士の除算だけ——ここだけに診断を置けば足りる。
    if (env && env.diagnostics) {
      env.diagnostics.push({
        level: "information",
        message: `整数除算 ${l} / ${r} の結果を四捨五入して ${rounded} にしました。精度が必要なら左辺を ${l}.0 と書いてください`,
      });
    }
    return rounded;
  }
  return value;
}

// list_model.md §2.3の派生演算子5種（`~+`/`~-`/`~*`/`~/`/`~^`）が、pass2.js/operator_table.js
// でそれぞれ別名のASTノードになったもの（`~+`のみrange_arithmetic、他4種はrange_arithmetic_rev/
// range_geometric/range_geometric_rev/range_power）。rangeStepFn自体は5種全てのstep関数を
// 既に持っているが、evaluate側の"range"ケースが"range_arithmetic"の1つしか認識しておらず、
// 残り4種は3項形式（終端あり）ですら「未対応の演算」として弾かれていた（8-Queens監査で発見）。
const RANGE_ARITHMETIC_NAMES = new Set([
  "range_arithmetic",
  "range_arithmetic_rev",
  "range_geometric",
  "range_geometric_rev",
  "range_power",
]);

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

// type_system.md §6.2「`==` は常に純粋な構造比較（Hom集合の一致）であり、コンストラクタ名を
// 一切参照しない」: 値の「形」（Scalar/String/List/Struct）と中身だけを再帰的に比較する。
// どのコンストラクタ関数経由で作られたかは一切問わない（それを問うのは`===`/`' !__`の役目——
// Pass1レベルでの構造体の生成元追跡が必要になる別機能で、今回は対象外）。
// Unit同型の値（__・空配列・空文字列、いずれもisUnit）は互いに構造的に等しいとみなす
// （零対象は1つしかない、というunit.mdの立場と一貫させる）。
function structuralEqual(l, r) {
  if (isUnit(l) && isUnit(r)) return true;
  if (isUnit(l) || isUnit(r)) return false;
  if (Array.isArray(l) && Array.isArray(r)) {
    return l.length === r.length && l.every((v, i) => structuralEqual(v, r[i]));
  }
  if (Array.isArray(l) || Array.isArray(r)) return false;
  const lIsPlainObject = l !== null && typeof l === "object" && !l.__lambda__;
  const rIsPlainObject = r !== null && typeof r === "object" && !r.__lambda__;
  if (lIsPlainObject && rIsPlainObject) {
    const lKeys = Object.keys(l);
    const rKeys = Object.keys(r);
    return (
      lKeys.length === rKeys.length &&
      lKeys.every((k) => Object.prototype.hasOwnProperty.call(r, k) && structuralEqual(l[k], r[k]))
    );
  }
  if (typeof l === "object" || typeof r === "object") return l === r; // Lambda等は参照同一性のみ
  return l === r; // Scalar/String
}

// comparison.md §2.1: 真のとき左辺と右辺のどちらを返すかは「左辺の値が**算術単位元**か」で
// 決まる。対象は Layer 2 型が数値（Address/Float/Vector）であるものに限る——
// リストや文字列は数値的に 0 に見えても算術ドメインではないため対象外。
//
// Float も対象に含む（ℝ は体であり 0 が加法単位元・1 が乗算単位元として ℤ と同格に
// 存在する。2026-08-09 に comparison.md の Float 除外を撤回した）。値だけでは
// リスト・文字列との区別がつかない場面があるため、pass3 がノードへ載せた Layer 2 型
// （compile.js のパイプライン）を読む。
function isArithmeticUnitElement(value, leftNode) {
  if (value !== 0 && value !== 1) return false;
  const type = leftNode && leftNode.atomType;
  // 型注釈が無い（pass3を通していない経路）の場合は、値が0/1である時点で数値とみなす
  if (type === undefined || type === null) return true;
  return type === "Address" || type === "Float" || type === "Vector";
}

function evalCompare(node, env) {
  const name = node.name;
  const op = node.op;
  const leftNode = node.left;
  const rightNode = node.right;
  const l = evaluate(leftNode, env);
  const r = evaluate(rightNode, env);
  if (op === "!=") {
    // 例外: x != __ = x（単位元）、__ != x = __（吸収元）
    if (isUnit(l)) return UNIT;
    if (isUnit(r)) return l;
    // 真の場合の返値選択は他の比較演算子と同じ §2.1 の規則に従う（comparison.md §1が
    // `!=` を対象の比較演算子として列挙しており、§2.1の適用外とされているのは
    // 構造比較の `==`/`!==` だけ）。ここだけ左辺固定になっていた。
    return l !== r ? (isArithmeticUnitElement(l, leftNode) ? r : l) : UNIT;
  }
  if (op === "==") {
    // type_system.md §6.2: 型シグネチャ (L -> R) -> (L | __)。真なら左辺、偽ならUnit
    // （他の比較演算子・§4の慣習と同じ「返値が情報を運ぶ」規約）。
    return structuralEqual(l, r) ? l : UNIT;
  }
  if (op === "!==") {
    // `!==`は`==`の否定——ただしUnit規則は`!=`とは別物（operator_table.md 56行目）:
    // 左辺Unit→右辺値を返す、右辺Unit→左辺値を返す（どちらも素通し。`!=`の「左辺Unitは
    // 吸収元」のような非対称な吸収は無い）。両辺ともUnitなら構造的に等しい（__ == __）
    // ので「等しくない」は偽＝Unitを返す。
    if (isUnit(l) && isUnit(r)) return UNIT;
    if (isUnit(l)) return r;
    if (isUnit(r)) return l;
    return structuralEqual(l, r) ? UNIT : l;
  }
  if (isUnit(l) || isUnit(r)) return UNIT; // 両辺とも吸収元
  const truthy = COMPARE_OPS[name](l, r);
  // §2.1: 左辺が算術単位元(0/1、Intドメインに限る)なら右辺、それ以外は左辺を返す
  return truthy ? (isArithmeticUnitElement(l, leftNode) ? r : l) : UNIT;
}

// 前置/後置の単項演算（すでに評価済みの値vに対して行う）。通常のevaluate()経路
// （node.operandを評価してここへ渡す）と、ポイントフリーのhole適用（下記applyPointfree、
// 呼び出し引数を直接vとして渡す）の両方から共有する。
function evalUnaryOp(name, v) {
  switch (name) {
    case "negate":
      return isUnit(v) ? UNIT : -v;
    case "not":
      return isUnit(v) ? IDENTITY : UNIT; // §4: !__ = Id射（真）、!非Unit = __（偽）
    case "input":
      // 前置@（参照外し）。$で作った参照セルはget()で読み取る。それ以外の値
      // （$を経由せず直接Lambda等が束縛された識別子）はそのまま素通しする——
      // `@f 1`が「fを参照外ししてから呼ぶ」と「fを直接呼ぶ」の両方で同じ記法になるように
      // （手動カリー化`@(f 1) 2`の継続呼び出しと、通常のLambda呼び出しを区別しない）。
      // unit.md §0.4: @__ = __（Unitもそのまま吸収元として素通し）。
      return v && v.__address__ ? v.get() : v;
    case "expand": {
      // 後置~：1段階展開（list_cheat_sheet.md「リストのフラット」、`[1 2,3 4]~ → [1 2 3 4]`）。
      // 呼び出し引数位置での展開（複数の位置引数へのspread）はevalArgValues側が
      // 独自に処理する別経路なので、ここは「値としての」1段階フラット化のみを担う。
      // ネストした要素（配列）だけをspreadし、非配列の要素はそのまま残す。
      if (!Array.isArray(v)) return v;
      return v.flatMap((x) => (Array.isArray(x) ? x : [x]));
    }
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
  throw new Error(`interpreter: 未対応の前置/後置演算 '${name}'`);
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
    // 算術は通常の中置と同じ型規則を通す（arithOnValues）。以前はARITH_OPSを直に
    // 叩いており、`[+ 1] [1 2 3]` → "1,2,31"（JSの配列→文字列強制）や
    // `[* 2,] \`abc\`` → NaN といった silent-wrong-value が漏れていた。
    if (ARITH_OPS[node.name]) return arithOnValues(node.name, a, b);
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

// ---- $/@/#（アドレス操作） ----
// unit.md §0.4「$__、@__の挙動：UnitはすべてのUnitを吸収する」。
// アドレス値は { __address__:true, get, set } という参照セル（getter/setter）として表現する。
// get()で参照先を読み、set(v)で書き込む（`#`＝output、pattern_guide.mdの`$[array ' 0] # 3`）。
// 識別子・配列要素（get_prop）は実体（env/配列）への本物の参照（書き込みが反映される）、
// それ以外の式は評価結果のスナップショットを読み取り専用で包むだけ
// （新規に作った値自体はどこにも「格納」されていないため、書き込む先が無い）。
function makeAddress(getFn, setFn) {
  return { __address__: true, get: getFn, set: setFn || (() => {}) };
}

// pass2.jsのunwrapSoloBlockと同じロジック（循環import回避のためここで別途最小実装）。
// `$[expr]`のようにブラケット/括弧で1個の式を囲んだだけの中身を覗く。
function unwrapParenNode(node) {
  while (node && node.type === "block" && node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
    node = node.lines[0];
  }
  return node;
}

// `$operand`（前置address）を、operandの構文形に応じた参照セルへ解決する。
function evalAddress(operandNode, env) {
  const inner = unwrapParenNode(operandNode);
  if (inner.type === "atom" && inner.kind === "identifier") {
    // $x: xが束縛されているスコープを辿り、そのバインディングへの本物の参照を作る
    // （代入すればxそのものが書き変わる）。未束縛ならUnit（アドレスの取りようが無い）。
    const name = inner.value;
    let e = env;
    while (e && !e.bindings.has(name)) e = e.parent;
    if (!e) return UNIT;
    return makeAddress(() => e.bindings.get(name), (v) => e.bindings.set(name, v));
  }
  if (inner.type === "operation" && inner.name === "get_prop") {
    // $[list ' idx]: リスト要素への本物の参照（list_cheat_sheet.mdのget_prop対象）。
    const l = evaluate(inner.left, env);
    const idx = evaluate(inner.right, env);
    if (!Array.isArray(l) || typeof idx !== "number" || idx < 0 || idx >= l.length) return UNIT;
    return makeAddress(() => l[idx], (v) => { l[idx] = v; });
  }
  // それ以外（リテラル・ラムダ式など、その場で作った値）: 書き込み先を持たない
  // スナップショット参照。カリー化の手動形`f : x ? $[y ? ...]`はここを通る——
  // 継続クロージャそのものをアドレス化するだけで、書き込みは意味を持たない。
  const snapshot = evaluate(inner, env);
  return makeAddress(() => snapshot);
}

function evaluate(node, env) {
  if (!node || typeof node !== "object") return UNIT;

  if (node.type === "atom") {
    if (node.kind === "identifier") return envGet(env, node.value);
    return evalLiteral(node);
  }

  if (node.type === "block") {
    // 空ブロック（`[]`/`{}`/`()`）は空リスト。unit.md「`__ = []`（空リストと等価）」の
    // 通りUnitと同型（isUnit([])が真）なので、Unit判定を要求する箇所ではそのまま
    // Unitとして振る舞いつつ、`|[]|`が0になる等の「リストとしての」性質も保てる。
    if (node.kind !== "abs" && node.lines.length === 0) return [];
    // |list|（abs）: list_cheat_sheet.md「要素数の取得」。ブロックとしては通常通り解決される
    // （中身を逐次評価、最後の文の値）が、kind==='abs'の場合だけ絶対値/要素数へ変換する
    // ——List/StringならJSの.length、数値ならMath.abs（"absolute"の名の通り、リストの
    // 要素数と数値の絶対値を同じ記号で表す設計、list_cheat_sheet.mdの命名）。
    if (node.kind === "abs") {
      let inner = UNIT;
      for (const line of node.lines) inner = evaluate(line, env);
      // Unitのときだけ値では決まらない——`__ = []`（unit.md）の同一視により「空リスト
      // ＝要素数0」とも「値の不在」とも読めるため、pass3が記録したオペランド型で決める。
      // List/Stringの位置なら空コレクションなので0、それ以外（不在・型不明）は吸収元。
      // 型が付かない側を0に倒さないのは、不在がもっともらしい値に化けるのを防ぐため
      // ——「不在」と「うっかり使える値」を混ぜないという一点が、null参照の失敗の核心
      // だったので、Signは常に吸収元側へ倒す（narrowingは呼び出し側が明示的に行う）。
      if (isUnit(inner)) {
        const operand = node.operandType;
        return operand === "List" || operand === "String" ? 0 : UNIT;
      }
      if (Array.isArray(inner) || typeof inner === "string") return inner.length;
      // Lambda（Id射・クロージャ等）や構造体には要素数/絶対値が定義されていない——
      // Math.absへ渡すとNaNが静かに出るため、型エラーとして__へ収束させる。
      if (inner !== null && typeof inner === "object") return UNIT;
      return Math.abs(inner);
    }
    // 構造体判定はpass3.jsのinferAtomTypeと同じ基準（全行がdefineかつ左辺が識別子）。
    // 左辺が識別子でないdefine行（下記match_case）と区別するため、identifierNode
    // 判定も併せて要求する——さもないと「フォールバック行の無いmatch_case連鎖」
    // （全行がcond:result）がStruct扱いされてしまう。構造体は独立したスコープで評価し、
    // キーが呼び出し元のenvへ漏れないようにする（let*的に、後のキーのデフォルト式的な
    // 参照は前のキーを見られる）。
    if (node.lines.length >= 1 && node.lines.every((l) => isDefineNode(l) && isIdentifierNode(l.left))) {
      const structEnv = newRuntimeEnv(env);
      const dict = {};
      for (const line of node.lines) {
        const value = evaluate(line, structEnv); // define評価：structEnvに束縛しつつ値を返す
        dict[line.left.value.slice(1, -1)] = value; // "<foo>" -> "foo"
      }
      return dict;
    }
    // 通常のブロックの逐次評価（match_case含む）。evalIndentBlock参照——末尾呼び出し
    // 検出（evaluateTail）と評価ロジックを共有するため、ここではevaluateを
    // 「ブロックの最終結果をどう評価するか」のコールバックとして渡す（通常のevaluate()
    // から呼ぶ限りは以前と全く同じ挙動）。
    return evalIndentBlock(node, env, evaluate);
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
      case "partial_apply": {
        // 自動カリー化。pass2.jsが「既知のアリティに対して引数の個数が足りない」と
        // 静的に判定済みのapplyチェーン——ここでは完全性公理による崩壊(bindParams経由の
        // 通常のapplyClosure)を一切通さず、無条件に部分適用クロージャを構築する。
        // collectApplyChainは"apply"という名前だけを見てチェーンを遡るため使えない
        // （pass2は連鎖の最も外側だけを"partial_apply"へリネームする——自分自身をそのまま
        // 渡すと無限再帰する）。最初の1段（自分自身）だけ別扱いし、以降は通常の"apply"
        // チェーンとして遡る。
        const argNodes = [node.right];
        let n = node.left;
        while (n && n.type === "operation" && n.name === "apply") {
          argNodes.unshift(n.right);
          n = n.left;
        }
        const calleeNode = n;
        const callee = evaluate(calleeNode, env);
        const argValues = [];
        for (const a of argNodes) {
          argValues.push(...evalArgValues(a, env));
        }
        if (!callee || !callee.__lambda__ || callee.__compose__ || callee.__pointfree__) {
          // pass2の静的判定は素のLambda識別子のみを対象にしているため通常来ないはずだが、
          // 想定外の形なら安全側の通常apply経路へフォールバックする。
          return applyClosure(callee, argValues);
        }
        return makePartialClosure(callee, argValues);
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
        // 余積の単位元則（type_system.md §6.1「関数の位置の `__` は余積の初対象＝単位元、
        // 引数を素通しにする」）。Unit側を消した結果が1項だけになったら、それを
        // 1要素リストで包み直さずそのまま返す——`[5]`（1行ブロック）が5そのものに
        // 評価されるのと同じで、この言語では1要素リストとスカラーは同型。
        // これが無いと `__ 5` が `[5]` になり、guide/operator_table.md 147行目の
        // `__ 5 == !__ 5`（両方5）が成立しない。2項以上（`__ 1 2` → `[1 2]`、§6.1の
        // 輸入失敗例）は左結合で `(__ 1) 2` → `1 2` と畳まれるため従来通り。
        if (isUnit(l)) return r;
        if (isUnit(r)) return l;
        // tier 10.4（`Lambda` 中置 `Atom` → apply）は演算子表の上では**型による分岐**であり、
        // pass2 は静的に解けた場合だけ apply ノードを作る。ところが「適用の結果が Lambda に
        // なる式」（`[!_] __` → Id射）は、静的には arity 1 が飽和した Atom にしか見えないため
        // construct へ落ちてしまい、`([!_] __) 5` が `[Id射, 5]` になっていた。
        // 生の `(!__) 5` は getCategory が前置`!`+unit を直接 Lambda と判定するので 5 を返す。
        // 同じ Id射が、作られ方によって射になったり値として並んだりするのは誤り。
        // 実行時には左辺の実際の値が分かるので、ここで表どおりの分岐へ戻す。
        // 右辺も Lambda の場合は tier 10.5（compose）であってここでの apply ではないため除く。
        if (l !== null && typeof l === "object" && l.__lambda__ &&
            !(r !== null && typeof r === "object" && r.__lambda__)) {
          return applyClosure(l, [r]);
        }
        // §3.2 余積族: どちらかが文字列ならテキストとして連結する
        // （`123` 123 = `123123`、list_model.md §2.1/§4.4）。
        // Stringは余積の**吸収元**——あらゆる値がテキスト表現を持つため、Stringとの
        // 結合は常に成立する。左辺だけを見ていると `` `ab` 1 `` → "ab1" なのに
        // `1 `ab`` は [1, "ab"] という別物になり、同じ演算子が引数の順序で挙動を
        // 変えてしまっていた。それ以外は通常のList構築。
        if (typeof l === "string" || typeof r === "string") {
          return stringifyForConcat(l) + stringifyForConcat(r);
        }
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
        // 3項形式 [start ~op step ~ end]（node.leftが5種の派生演算子いずれかのノード。
        // list_model.md §2.3: ~+/~-/~*/~/~^、rangeStepFnが全種のstep関数を持つ）と、
        // 単純形式 [start ~ end]（step省略、昇順なら+1・降順なら-1）の両方を扱う。
        if (node.left && node.left.type === "operation" && RANGE_ARITHMETIC_NAMES.has(node.left.name)) {
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
      case "range_arithmetic":
      case "range_arithmetic_rev":
      case "range_geometric":
      case "range_geometric_rev":
      case "range_power": {
        // 2項形式 [start ~op step]（終端なし、5種いずれも）は仕様上、終端を持たない
        // 無限のPull型ストリーム（list_model.md §2.3「2項指定」）。本インタプリタは
        // 実体化された値しか扱えないため、無限生成を試みず明示的に未対応として拒否する。
        // （3項形式 [start ~op step ~ end] は上の"range"ケースが処理する——このケースに
        // 来るのは、外側に終端"~ end"が付いていない生の2項ノードのみ。）
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
        // （Struct/Structのフィールドアクセス）。数値等なら通常通り評価してListのインデックスに使う。
        const l = evaluate(node.left, env);
        if (isUnit(l)) return UNIT;
        if (node.right.type === "atom" && node.right.kind === "identifier") {
          const key = node.right.value.slice(1, -1); // "<foo>" -> "foo"
          if (l && typeof l === "object" && !Array.isArray(l)) {
            return Object.prototype.hasOwnProperty.call(l, key) ? l[key] : UNIT;
          }
          return UNIT;
        }
        // スカラー ≅ 1要素リスト（asListと同じ同型性）。非Array値も長さ1のリストとして
        // インデックスアクセスできる（`5 ' 0` = 5、`5 ' 1` = __）。
        // string_and_comment.md §6「文字列は0uリテラルのシーケンスとして扱える」:
        // Stringは文字のListと同型（list_model.md）なので、文字ごとに分解してインデックス
        // アクセスする（`hello ' 0` = `h`）。get-rest・複数インデックス取得の結果は
        // 文字の配列のままではなく文字列へ戻す（isString、Stringとして返す方が同型性に
        // 合う——List側の`[1 2 3 4] ' [1~3] → [2 3 4]`と対称）。
        const isString = typeof l === "string";
        const asIndexable = Array.isArray(l) ? l : isString ? l.split("") : [l];
        // get-rest: `list ' N~`（数値インデックスへ後置~）は、Nから末尾までの部分リストを
        // 返す（既存のList/Scalar同型性・負インデックス変換をそのまま流用できる。
        // Array.prototype.sliceの負start解釈がSignの「末尾から数える」規約と一致するため
        // 追加変換は不要）。呼び出し引数位置での展開（複数の位置引数へのspread）を担う
        // evalArgValuesとは別経路——ここはget_propの右辺としての`~`のみを扱う。
        if (node.right.type === "operation" && node.right.position === "postfix" && node.right.name === "expand") {
          const n = evaluate(node.right.operand, env);
          if (typeof n !== "number") return UNIT;
          const sliced = asIndexable.slice(n);
          return isString ? sliced.join("") : sliced;
        }
        const r = evaluate(node.right, env);
        // 負のインデックスは末尾から数える（`-1`=最後の要素、length+indexへ写像）。
        // 正側は0始まり、負側は-1始まり（-0が無いため対称にはならない）。
        // type_system.md §4.1: `'` は Address（位置）を構造的に要求するため、Float が
        // 来たら四捨五入する（AArch64の`fcvtas`＝最近接・タイは0から遠ざける、1命令）。
        // 位置は整数でしか存在しないので、`list ' 1.5` は補間ではなく `list ' 2` になる。
        // 既に整数ならroundHalfAwayFromZeroは恒等なので、この丸めに静的な型情報は要らない
        // （除算の丸めは Address同士かFloat混在かで挙動が変わるため pass3 が必要、という
        // 点で対照的）。
        const resolveIndex = (i) => {
          const n = roundHalfAwayFromZero(i);
          return n < 0 ? asIndexable.length + n : n;
        };
        if (typeof r === "number") {
          const idx = resolveIndex(r);
          return idx >= 0 && idx < asIndexable.length ? asIndexable[idx] : UNIT;
        }
        // list_cheat_sheet.md「範囲で要素取得」: `[1 2 3 4] ' [1 ~ 3]` → `[2 3 4]`。
        // rangeが実体化したインデックス列（配列）で、該当位置の値をまとめて取り出す。
        if (Array.isArray(r)) {
          const mapped = r.map((i) => {
            if (typeof i !== "number") return UNIT;
            const idx = resolveIndex(i);
            return idx >= 0 && idx < asIndexable.length ? asIndexable[idx] : UNIT;
          });
          return isString ? mapped.map((v) => (isUnit(v) ? "" : v)).join("") : mapped;
        }
        return UNIT;
      }
      case "address":
        // 前置$。node.operandはまだ評価せず、その構文形（識別子/get_prop/その他）に
        // 応じてevalAddressが参照セルを組み立てる（evalUnaryOpの「先に評価済みの値を
        // 受け取る」経路には乗せられない——参照先の束縛そのものが必要なため）。
        return evalAddress(node.operand, env);
      case "output": {
        // `addr # value`（後置#、pattern_guide.mdの`$[array ' 0] # 3`）。
        // 左辺は$で作った参照セルである必要がある——それ以外（Unitや普通の値）は
        // 書き込み先を持たないため吸収し、右辺の値をそのまま返す（unit.mdのUnit吸収則に倣う）。
        const addr = evaluate(node.left, env);
        const value = evaluate(node.right, env);
        if (addr && addr.__address__) addr.set(value);
        return value;
      }
    }

    // 三項連鎖比較（comparison.md §4、pass2.jsが単一ノードへまとめたもの）。
    // 隣接ペアが全て真なら「無条件で中央の項」を返し、ひとつでも偽なら即座にUnit。
    // 二項比較の§2.1「左辺が算術単位元(0/1)なら右辺」は連鎖には適用しない——
    // §4はまさにその規則に依存せず中央を取り出すための仕組みとして定義されている。
    if (node.name === "chain_compare") {
      const l = evaluate(node.left, env);
      const c = evaluate(node.middle, env);
      const r = evaluate(node.right, env);
      if (isUnit(l) || isUnit(c) || isUnit(r)) return UNIT; // 比較演算子の吸収則（§3.3）
      if (node.op === "!=") return l !== c && c !== r ? c : UNIT;
      return COMPARE_OPS[node.compareName](l, c) && COMPARE_OPS[node.compareName](c, r) ? c : UNIT;
    }

    if (ARITH_OPS[node.name]) return evalArith(node, env);
    // `!=`（tier12、name="not_equal"）・`==`（name="equal"）・`!==`（tier8、name="xnot_equal"、
    // ==の構造比較を否定したもの）はCOMPARE_OPSにキーを持たない——8/6にoperator_table.js側の
    // tier8`!==`をname="xnot_equal"へ改名して名前衝突自体は解消したが、COMPARE_OPS
    // （evalCompareの汎用フォールバックが呼ぶテーブル）には元々not_equal/equal/xnot_equalを
    // 追加していない。evalCompareは既にop==="!="/"=="/"!=="それぞれの専用分岐を持っている
    // ため、ここでnode.opを見て個別に通す。`===`（same、同一性）はコンストラクタ由来の
    // 追跡（type_system.md §6.2の`' !__`）が必要な別機能のため、まだ未対応のまま。
    if (COMPARE_OPS[node.name] || node.op === "!=" || node.op === "==" || node.op === "!==")
      return evalCompare(node, env);

    if (node.position === "prefix" || node.position === "postfix") {
      return evalUnaryOp(node.name, evaluate(node.operand, env));
    }

    // 未対応の演算（$/@/#等）
    throw new Error(`interpreter: 未対応の演算 '${node.name}'`);
  }

  return UNIT;
}

export { evaluate, newRuntimeEnv, envDefine, envGet, UNIT, isUnit };
