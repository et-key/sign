/**
 * Pass2: coproduct_resolver.md のアルゴリズム実装。
 * Pass1相当(peggyパーサー)が返すフラットなTerm列を、二分木ASTへ縮約する。
 *
 * getCategory は第2引数に env（pass1.js の childEnv/buildEnv が返す、ブロック階層に
 * 沿ってネストしたスコープ連鎖）を受け取る。env未指定、またはenv連鎖のどこにも無い
 * 識別子は Atom にフォールバックする（組み込み `<print>` のみ例外的に Lambda）。
 * ブロック（[...] {...} (...) やインデントブロック）を再帰的に解決する際、
 * resolveBlock がそのブロック内の行だけを対象にした子スコープ（親=呼び出し時のenv）を
 * 自動生成するため、外側スコープの識別子は内側のブロックから常に参照できる。
 *
 * 実装にあたって仕様書(coproduct_resolver.md)に明記がなく、以下の点は仮定を置いた（要レビュー）:
 * 1. 複数の前置/後置演算子が連続する場合（例: `!$x`）の結合順序。
 *    coreに近い方から先に結合する（`!$x` = `!($x)`）という一般的な慣習を採用。
 * 2. 優先度10.1（Unshift/push）の具体的な演算子名。仕様は「Atom|List~ の組み合わせ」としか
 *    書いておらず、方向性の区別が明記されていない。ここでは List~ 側が右なら push、
 *    左なら unshift とした。
 * 3. Block（[...] {...} (...)）の種別（paren/brace/bracket）は grammar.pegjs が
 *    区別を保持しないため、AST上でも区別できていない（kindは "paren" 固定、または
 *    indent/absのみ判別）。
 *
 * 【grammar.pegjs 根本修正済み】以前は Expression の `.flat()` が密着演算子グループと
 * Blockを区別できず、Blockが他の項と混在すると中身が漏れる問題があった（Pass2側の
 * repairLeakedBlocks()という回避策で当座を凌いでいた）。grammar.pegjs 側で以下の3点を
 * 修正したことで根本的に解消し、Pass2側の回避策は不要になった:
 *   - Term: coreが配列（Block）の場合、1階層ラップして返す
 *   - Expression: soloかどうかに関わらず常にflat()する
 *   - Block: indent/abs系もexprsを展開せず1要素として保持する（bracket系と対称に）
 */

import { OPERATOR_DICT } from './operator_table.js';
import { childEnv, envLookup, bindEnv, EXPORT_MARKERS } from './pass1.js';

// ---- ユーティリティ ----

const OPERATOR_SYMBOL_RE = /^[!"#$%&'\-=^~|@;+:*,<>/?]+$/;

function isMarkedPrefix(x) {
  // 例: "@_", "!!_"  (末尾が "_"、かつ本体が単なる "_"/"__"ではない)
  return typeof x === "string" && x !== "_" && x !== "__" && x.endsWith("_") && !x.startsWith("_");
}
function isMarkedPostfix(x) {
  // 例: "_@", "_~"
  return typeof x === "string" && x !== "_" && x !== "__" && x.startsWith("_") && !x.endsWith("_");
}
function isBareOperatorToken(x) {
  return typeof x === "string" && OPERATOR_SYMBOL_RE.test(x) && !isMarkedPrefix(x) && !isMarkedPostfix(x);
}

function toNode(x, env) {
  // すでにoperation/blockノードならそのまま、そうでなければAtomリーフとして包む
  if (x && typeof x === "object" && !Array.isArray(x)) return x;
  if (Array.isArray(x)) return resolveBlock(x, env);
  return { type: "atom", kind: classifyAtom(x), value: x };
}

function classifyAtom(s) {
  if (s === "__" || s === "\x00") return "unit";
  if (s === "_") return "hole";
  if (typeof s === "string" && s.startsWith("<") && s.endsWith(">")) return "identifier";
  if (typeof s === "string" && s.startsWith("`")) return "string";
  if (typeof s === "string" && s.startsWith("\\")) return "char";
  if (typeof s === "string" && /^0x[0-9a-fA-F]+$/.test(s)) return "address";
  if (typeof s === "string" && /^(0r[0-9a-fA-F]+|0b[01]+)$/.test(s)) return "register";
  if (typeof s === "string" && /^0u[0-9a-fA-F]+$/.test(s)) return "unicode";
  if (typeof s === "string" && /^-?[0-9]+\.?[0-9]*$/.test(s)) return "number";
  return "unknown";
}

// ---- Step1: 密着した前置/後置演算子の解決 ----
// pre:Prefixes core:Core post:Postfixes は既に隣接した1つのTermとして
// 平坦化されているため、"X_"が連続する塊 → core → "_X"が連続する塊、という
// 隣接パターンを左から右へ貪欲に見つけて畳み込む。
function resolveDensity(rawItems, env) {
  const items = rawItems;
  const out = [];
  let i = 0;
  while (i < items.length) {
    // 前置マーカーを伴わない裸の演算子トークンは、密着グループの外側にあるので素通しする
    if (isBareOperatorToken(items[i])) {
      out.push(items[i]);
      i++;
      continue;
    }
    const preOps = [];
    while (i < items.length && isMarkedPrefix(items[i])) {
      preOps.push(items[i].slice(0, -1)); // "@_" -> "@"
      i++;
    }
    if (i >= items.length) {
      // 前置演算子だけでcoreが無い＝部分適用（Lambdaカテゴリの断片として残す）
      for (const op of preOps) out.push({ type: "operation", op, name: lookup(op, "prefix")?.name, position: "prefix", partial: true });
      break;
    }
    let core = toNode(items[i], env);
    i++;
    const postOps = [];
    while (i < items.length && isMarkedPostfix(items[i])) {
      postOps.push(items[i].slice(1)); // "_@" -> "@"
      i++;
    }
    // coreに近い方から先に結合（前置は右から、後置は左から）
    let node = core;
    for (let k = postOps.length - 1; k >= 0; k--) {
      const op = postOps[k];
      const operand = node;
      node = { type: "operation", op, name: lookup(op, "postfix")?.name, position: "postfix", operand };
      // ポイントフリー記述の前置/後置版（function_guide.md「前置演算子は`[<op>_]`
      // 後置演算子は`[_<op>]`」）: operandが直接hole（`_`）なら、この演算子は
      // まだ値を待っている部分適用とみなす（getCategoryの既存のpartial判定に乗る）。
      if (operand.type === "atom" && operand.kind === "hole") node.partial = true;
    }
    for (let k = preOps.length - 1; k >= 0; k--) {
      const op = preOps[k];
      const operand = node;
      node = { type: "operation", op, name: lookup(op, "prefix")?.name, position: "prefix", operand };
      if (operand.type === "atom" && operand.kind === "hole") node.partial = true;
    }
    out.push(node);
  }
  return out;
}

function lookup(symbol, position) {
  const defs = OPERATOR_DICT[symbol];
  if (!defs) return null;
  return defs.find((d) => d.position === position) || null;
}

// apply[apply[apply[f, a1], a2], a3] のような左結合のapplyチェーンを遡り、
// 消費済みの引数の数（depth）と、根本の呼び出し先ノード（base、通常は識別子）を返す。
function applyChainInfo(node) {
  let depth = 0;
  let n = node;
  while (n && n.type === "operation" && n.name === "apply") {
    depth++;
    n = n.left;
  }
  return { depth, base: n };
}

// bracket系ブロック（indent/absを除く）が1行だけを保持している場合、その1行を再帰的に
// 覗く（`[+]`のような、演算子1個だけを囲んだブロックの中身を取り出す）。
// `[1 2 3]`のような複数トークンの行は`lines.length===1`のまま（1行の中で構築済みの
// construct連鎖になっているだけ）なので、中身の種類で自然に区別される。
function unwrapSoloBlock(node) {
  while (node && node.type === "block" && node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
    node = node.lines[0];
  }
  return node;
}

// ---- getCategory (coproduct_resolver.md §2) ----
// env: pass1.js が構築した識別子環境の連鎖（{bindings, parent}）。
// 未指定ならすべてAtom扱いにフォールバック。
function getCategory(node, env) {
  if (!node || typeof node !== "object") return "Atom";
  if (node.type === "operation") {
    if (node.op === "?") return "Lambda"; // 関数定義
    if (node.name === "compose") return "Lambda";
    if (node.partial) return "Lambda"; // オペランド不足の部分適用
    if (node.position === "prefix" && node.op === "@") return "Lambda"; // 前置@（Input）
    if (node.name === "apply") {
      // 多引数関数（params[]が複数エントリ、pass1.jsのarity）は、1回のapplyでは
      // 飽和しない場合がある。左に伸びるapplyチェーンの深さ（=消費済みの引数の数）が
      // 呼び出し先のarityにまだ届いていなければ、まだ引数を受け取れるLambdaのまま
      // 扱う（次のAtomとの結合が construct ではなく apply になるように）。
      // アリティが不明（単一パラメータ・rest・ブラケット等）な場合は、従来通り
      // 1回の適用で即座にAtom（飽和済み）として扱う。
      const { depth, base } = applyChainInfo(node);
      if (base && base.type === "atom" && base.kind === "identifier" && env) {
        const binding = envLookup(env, base.value);
        if (binding && typeof binding.arity === "number" && depth < binding.arity) {
          return "Lambda";
        }
      }
      // 【注意】ポイントフリー記述の完全に裸な中置演算子（`[+]`）が複数引数を貪欲に
      // 取り込む挙動は、ここ（getCategory）ではなくreduceOnceのPhase2（apply）専用の
      // 特例として実装している（isBarePointfreeChainBase参照）。ここで「常にLambda」に
      // してしまうと、Phase2で使い切った後のPhase3（apply_reverse）でも依然Lambdaと
      // 誤判定され、既に確定した計算結果（`[+](3)(4)`のような値）がまた関数として
      // 呼ばれようとしてしまう（`1 2 [+] 3 4`で実際に踏んだ）。apply連鎖は、名前付き
      // 識別子と同様に既知のarityが無い限り、1回の適用で即座にAtom（飽和済み）として
      // 扱うのが正しい——ポイントフリーの多引数消費はPhase2内で完結させる。
    }
    // 通常の演算ノード（算術・concat等）はAtom
    return "Atom";
  }
  if (node.type === "atom") {
    if (node.kind === "identifier") {
      if (env) {
        const found = envLookup(env, node.value);
        if (found !== undefined) return found.category;
      }
      // envに無い場合、組み込み関数名のみLambda扱い
      if (["<print>"].includes(node.value)) return "Lambda";
      return "Atom";
    }
    return "Atom";
  }
  if (node.type === "block") {
    // ポイントフリー記述（function_guide.md「任意のカッコで演算子を囲むことで関数として
    // 扱う」）: `[+]`はbracketブロック{lines:[partialノード1個]}という形になるため、
    // 中身を見ずに常にAtomを返すと外側の余積解決でLambdaとして扱われない。1行だけの
    // bracket系ブロック（indent/absを除く）は、中身のカテゴリをそのまま継承する
    // （`[1 2 3]`のような通常のListは中身がconstructでAtomのままなので影響なし）。
    if (node.kind !== "indent" && node.kind !== "abs" && node.lines.length === 1) {
      return getCategory(node.lines[0], env);
    }
    return "Atom";
  }
  return "Atom";
}

// identifierノードのenv上のBinding（{category, restParam}）を取得する。
// getCategoryと違い、Lambdaのrestパラメータ形状（coproduct_resolver.md §5.4）を
// 見るために生のBindingそのものが必要な箇所（coproductReduceのapply分岐）で使う。
function identifierBinding(node, env) {
  if (!env || !node || node.type !== "atom" || node.kind !== "identifier") return undefined;
  return envLookup(env, node.value);
}

// bの「List性」を判定する。素のブロック（[1 2 3]等）か、後置~でマークされたブロックかを見て、
// { isList, tilde } を返す（tilde=trueなら意図的な展開渡し、falseなら素の塊渡し）。
function listShape(node) {
  if (isListLike(node)) return { isList: true, tilde: false };
  if (hasPostfixTilde(node) && isListLike(node.operand)) return { isList: true, tilde: true };
  return { isList: false, tilde: false };
}

function isListLike(node) {
  return node && node.type === "block" && (node.kind === "bracket" || node.kind === "brace" || node.kind === "paren");
}
function hasPostfixTilde(node) {
  return node && node.type === "operation" && node.op === "~" && node.position === "postfix";
}

function mk(name, left, right) {
  return { type: "operation", op: " ", name, position: "infix", left, right };
}

// coproduct_resolver.md §3の優先度表（10.5〜10.0）
function coproductReduce(a, b, env) {
  const catA = getCategory(a, env), catB = getCategory(b, env);
  if (catA === "Lambda" && catB === "Lambda") return mk("compose", a, b);
  if (catA === "Lambda" && catB === "Atom") {
    // coproduct_resolver.md §5.4: 裸のrestパラメータ（`x ~xs ? ...`）を持つLambdaに
    // 後置~なしでListを渡すのは、意図（各要素を位置引数に分配）と乖離した挙動
    // （list全体が単一のxに束縛されxsが空になる）になるため、TypeErrorで拒否する。
    // ブラケット形式（`[x ~xs] ? ...`）はrestParam==='bracket'であり対象外。
    const binding = identifierBinding(a, env);
    if (binding && binding.restParam === "bare") {
      const shape = listShape(b);
      if (shape.isList && !shape.tilde) {
        throw new TypeError(
          `coproduct_resolver.md §5.4違反: 裸のrestパラメータ ('${a.value} ~xs' 形式) を持つ関数に、List を後置 ~ なしで渡すことはできません（意図: 各要素を位置引数に分配するなら 後置~ を付けてください）`
        );
      }
    }
    return mk("apply", a, b);
  }
  if (catA === "Atom" && catB === "Lambda") return mk("apply_reverse", a, b);
  if (catA === "Atom" && catB === "Atom") {
    const listA = isListLike(a) || (hasPostfixTilde(a) && isListLike(a.operand));
    const listB = isListLike(b) || (hasPostfixTilde(b) && isListLike(b.operand));
    if (listA && listB) {
      const tA = hasPostfixTilde(a), tB = hasPostfixTilde(b);
      if (tA && tB) return mk("concat", a, b); // §5.2-1: 双方~ → concat
      return null; // §5.2-2: ~なし → マージしない、独立したAtomのまま
    }
    if ((listA && !listB) || (!listA && listB)) {
      // 10.1: Atom|List~ の組み合わせ → Unshift/push（仕様に方向の明記なし、上記コメント参照）
      return listB ? mk("push", a, b) : mk("unshift", a, b);
    }
    return mk("construct", a, b); // 10.0: Atom Atom → 直和/双積
  }
  return null;
}

// ---- Step2: 優先順位に基づく総当たり縮約（coproduct_resolver.md §4） ----
//
// coproduct_resolver.md §4は「10.5(compose)→10.4(apply)→10.3(apply_reverse)→10.2〜10.0
// (concat/push/unshift/construct)の順に、各優先度をリスト全体に対して使い尽くしてから
// 次へ進む」という段階的マルチパスを規定している。以前はtier===10をひとまとめにし、
// 隣接ペアを左から見て最初にマッチしたものを即座に縮約する単一グリーディスキャンに
// なっていたため、この優先順位が守られていなかった（例: `5 inc 3` で本来10.4(apply)が
// 先に `inc 3` を縮約すべきところ、実際は左端の `5 inc` が10.3(apply_reverse)として
// 先に縮約されてしまっていた）。COPRODUCT_PHASESで4段階に明示的に分割し、各段階を
// 使い尽くしてから次へ進むことで仕様通りの優先順位を保証する。
//
// これにより、apply_reverse（UFCS的な `receiver method` 記法、`f : [foo bar ~this] ? ...`
// のようなオブジェクト指向的呼び出しを意図）は「そのLambdaが右側に通常適用できるAtomを
// 持たない場合のみ」発動するフォールバックになる——両隣にAtomがあるLambdaは常にapply
// （右のAtomへの通常適用）が先に確定するため、apply_reverseが途中のAtomを横取りすることはない。
// concat/push/unshift/constructの3つ（10.2〜10.0）はcoproductReduce内部でリスト形状のみから
// 相互排他的に決まり、tier間の競合が無いため、引き続き1フェーズにまとめている。
// ポイントフリー記述の完全に裸な中置演算子（`[+]`、left/right両方null）のapply連鎖の
// 根本（base）かどうかを判定する。`[+]`のようにbracketブロックでラップされたまま
// 渡ってくる場合はunwrapSoloBlockで中身を覗く。Phase2（apply）専用の特例判定にのみ
// 使う——getCategory本体には反映しない（下記COPRODUCT_PHASESのコメント参照）。
function isBarePointfreeChainBase(node) {
  const { base } = applyChainInfo(node);
  const unwrapped = unwrapSoloBlock(base);
  return !!(unwrapped && unwrapped.type === "operation" && unwrapped.partial && unwrapped.left === null && unwrapped.right === null);
}

// ポイントフリー記述由来のLambda（`[+]`のような裸の演算子、`[+ 1]`のような部分適用、
// およびそのapply連鎖）かどうかを判定する。演算子の種類（算術・比較・前置・後置いずれも
// ポイントフリー記述できる、function_guide.md）を問わず一律で判定する。
function isPointfreeLambda(node) {
  const unwrapped = unwrapSoloBlock(node);
  if (!unwrapped || unwrapped.type !== "operation") return false;
  if (unwrapped.partial) return true;
  if (unwrapped.name === "apply") {
    const { base } = applyChainInfo(unwrapped);
    const unwrappedBase = unwrapSoloBlock(base);
    return !!(unwrappedBase && unwrappedBase.type === "operation" && unwrappedBase.partial);
  }
  return false;
}

const COPRODUCT_PHASES = [
  { match: (catA, catB) => catA === "Lambda" && catB === "Lambda" }, // 10.5: compose
  {
    match: (catA, catB) => catA === "Lambda" && catB === "Atom",
    // ポイントフリー記述の完全に裸な中置演算子（`[+]`）は「複数の引数を貪欲に演算する」
    // （function_guide.md）——getCategoryでは通常のarity判定と同様1回の適用で即座に
    // Atom（飽和済み）として扱うが、Phase2（apply）だけはこの特例で「まだ右にAtomが
    // あれば貪欲に食う」を許可する。これをgetCategory本体に持ち込むと、Phase2で使い
    // 切った後のPhase3（apply_reverse）でも依然Lambdaと誤判定され、既に確定した計算
    // 結果（`[+](3)(4)`）がまた関数として呼ばれようとしてしまう（`1 2 [+] 3 4`で実際に
    // 踏んだバグ）。Phase2内だけで完結させることで、Phase2が尽きた時点（＝これ以上
    // 右にAtomが無い時点）で自然にAtomへ確定する。
    extendPointfree: true,
  }, // 10.4: apply
  {
    // 10.3: apply_reverse。ポイントフリー由来のLambda（`[+]`/`[+ 1]`等、演算子の種類を
    // 問わない）はapply_reverseの対象から除外する（8/5の設計合意）。ポイントフリーは
    // 常に前置適用（`[+ 1] 5`）という一つの呼び出し方だけを持ち、UFCS的なreceiver記法
    // （`x f`）という別経路を重ねない——「一つのことを表現する方法は一つ」の方針、かつ
    // `5 [+]`のような曖昧な読み（5をどちら側の被演算子とみなすか不定）を防ぐ。
    match: (catA, catB, a, b) => catA === "Atom" && catB === "Lambda" && !isPointfreeLambda(b),
  },
  { match: (catA, catB) => catA === "Atom" && catB === "Atom" }, // 10.2〜10.0: concat/push/unshift/construct
];

function reduceOnce(items, tier, env, phase) {
  for (let i = 0; i < items.length - 1; i++) {
    const a = items[i];
    const b = items[i + 1];
    if (isBareOperatorToken(b)) {
      const entry = lookup(b, "infix");
      if (entry && entry.precedence === tier && i + 2 < items.length && !isBareOperatorToken(items[i + 2])) {
        const left = toNode(a, env);
        const right = toNode(items[i + 2], env);
        const node = { type: "operation", op: b, name: entry.name, position: "infix", left, right };
        items.splice(i, 3, node);
        return true;
      }
      continue;
    }
    if (tier === 10 && !isBareOperatorToken(a) && !isBareOperatorToken(b)) {
      const left = toNode(a, env);
      const right = toNode(b, env);
      const catA = getCategory(left, env), catB = getCategory(right, env);
      if (phase && phase.extendPointfree && catB === "Atom" && isBarePointfreeChainBase(left)) {
        items.splice(i, 2, mk("apply", left, right));
        return true;
      }
      if (phase && !phase.match(catA, catB, left, right)) continue;
      const node = coproductReduce(left, right, env);
      if (node) {
        items.splice(i, 2, node);
        return true;
      }
    }
  }
  return false;
}

// ---- Lambda定義行（トップレベルに `?` を持つ行）の専用処理 ----
//
// `:`(define, precedence=1)と`?`(lambda, precedence=2)は演算子テーブル上もっとも低い
// 優先度で、reduceAllは26→1の順で処理するため、この2つは総当たり縮約の最後の最後に
// しか処理されない。一方スペース(余積)はtier=10で固定的に先に処理される。
// そのため、仮引数部をそのまま総当たり縮約に素通しすると、`?`が実際に処理される
// 「前」に、仮引数部の中身が既存の汎用ルールで誤って確定してしまう
// （例: `g x` → construct[g,x]、`y : x + 1` → define[y, add[x,1]]、
//   どちらも「仮引数の宣言」であって「値の式」ではないのに、区別なく解決されてしまう）。
// これを避けるため、行の中にトップレベルの `?` があれば、総当たり縮約に渡す前に
// 仮引数部を切り出し、buildParameterList で専用に処理する。

function isIdentifierToken(x) {
  return typeof x === "string" && x.startsWith("<") && x.endsWith(">");
}

// ブラケット／インデントブロックの仮引数部の「1行」を解析する。1行が常に1エントリとは
// 限らない——`[x ~xs]`のように、デフォルトを持たない複数の裸パラメータが1行に同居する
// ケースがあるため、配列（複数エントリ）を返す。
//   ["<y>", ":", "<x>", "+", "1"] → [{ name: "<y>", rest: false, defaultTokens: ["<x>","+","1"] }]
//   ["<x>"]                       → [{ name: "<x>", rest: false, defaultTokens: null }]
//   ["<x>", "~_", "<xs>"]         → [{name:"<x>",...}, { name: "<xs>", rest: true, defaultTokens: null }]
function parseParamLine(tokens) {
  const colonIdx = tokens.indexOf(":");
  if (colonIdx !== -1) {
    // "name : defaultExpr..." という1エントリ（rest付きデフォルトは現行仕様に例が無く未対応）
    return [{ name: tokens[0], rest: false, defaultTokens: tokens.slice(colonIdx + 1) }];
  }
  // ":" が無ければ、裸の複数パラメータが1行に並んでいる可能性がある（例: "x ~xs"）
  return splitBareParamTokens(tokens);
}

// ブラケット（[x ~xs]等）／インデントブロック（デフォルト引数）の仮引数部から、
// 「1行=1エントリ」の行配列を取り出す。resolveBlockのkind判定と対称。
function extractParamLines(token) {
  if (Array.isArray(token) && token[0] === '"INDENT_"') return token[1];
  if (Array.isArray(token) && token[0] === '"ABS_"') return token[1];
  return token; // bracket系: tokenそのものがexprs（行の配列）
}

function isTaggedBlock(x) {
  return Array.isArray(x) && (x[0] === '"INDENT_"' || x[0] === '"ABS_"');
}
function isFlatTokenLine(x) {
  return Array.isArray(x) && x.every((t) => typeof t === "string");
}

// extractParamLinesが返す「文の並び」を、1文=1識別子宣言の生トークン列（flat token line）の
// 配列へ正規化する。grammarのTerm規則（配列coreを持つ単独の項は1階層ラップされる）により、
// 仮引数部がインデントブロックの中に単独のブラケット（例: function_guide.mdのfunc_mixed、
// `[`を定義行より深くインデントして書く形式）を1文として含む場合、その1文はさらに
// 「本来のブラケットのExpressions（複数の実パラメータ行）」を1階層ラップした形で現れる。
// 再帰的にラップを剥がして、最終的に全ての要素がflat token lineになるまで平坦化する。
function flattenParamStatements(node) {
  if (isFlatTokenLine(node)) return [node];
  return node.flatMap((stmt) => {
    if (isFlatTokenLine(stmt)) return [stmt];
    if (isTaggedBlock(stmt)) return flattenParamStatements(stmt[1]);
    // 文字列以外の要素を含む配列 = さらに複数文（またはラップされた1文）としてネストしている
    return flattenParamStatements(stmt);
  });
}

// 裸の（ブラケット／インデントで囲まれていない）仮引数トークン列を、1識別子=1エントリに分割する。
// デフォルト式は裸形式では現行仕様に例が無いため未対応（bracket/indent形式のみ対応）。
function splitBareParamTokens(tokens) {
  const entries = [];
  let i = 0;
  while (i < tokens.length) {
    if (tokens[i] === "~_") {
      entries.push({ name: tokens[i + 1], rest: true, defaultTokens: null });
      i += 2;
    } else {
      entries.push({ name: tokens[i], rest: false, defaultTokens: null });
      i += 1;
    }
  }
  return entries;
}

// paramTokens[0]（`[x ~xs]`のような単一要素）が、真の意味でのブラケット仮引数リスト
// （list_model.md §2.4のEagerパターン、実引数を分割代入で受け取る）か、単に複数行に
// またがって書かれた裸のデフォルト引数形式（`g:\n x\n y:x+1\n?...`）かを判定する。
// どちらも生トークンの形はINDENT_タグの有無だけでは区別しきれない——func_mixed
// （function_guide.md）のようにブラケットが定義行より深くインデントされて単独の1文として
// 書かれると、grammarのTerm規則で1階層余分にラップされ、外側だけ見るとINDENT_タグ付きに
// 見えてしまうため（README「Lambda仮引数部の専用処理」参照）。
// 判定方法: INDENT_/ABS_タグが無ければ直接ブラケット。タグ付きなら、その中身が
// 「唯一の要素で、かつさらに入れ子になった（flat token lineでもタグ付きでもない）配列」で
// ある限り再帰的に剥がしていき（flattenParamStatementsと同じTerm-wrap剥がしロジック）、
// 実際に1回でも剥がせて、かつ最終的に「複数のflat token line（＝ブラケットの各行）」に
// 行き着いた場合のみブラケットとみなす。単に「1個の裸パラメータだけがインデントブロックに
// 単独で書かれている」ケース（それ自体がflat token line）や、「複数の裸パラメータ行が
// 直接並んでいる」通常のデフォルト引数形式は、どちらもfalseになる。
function isBracketParamList(token) {
  if (!Array.isArray(token)) return false;
  if (!isTaggedBlock(token)) return true;
  let inner = token[1];
  let peeled = false;
  while (Array.isArray(inner) && inner.length === 1 && Array.isArray(inner[0]) && !isFlatTokenLine(inner[0]) && !isTaggedBlock(inner[0])) {
    inner = inner[0];
    peeled = true;
  }
  return peeled && Array.isArray(inner) && inner.length >= 1 && inner.every((line) => isFlatTokenLine(line) || isTaggedBlock(line));
}

// 仮引数部の生トークン列を解析し、{ node, scope } を返す。
// scope は let* 的な逐次束縛（自分より前のパラメータ + 外側スコープのみ参照可能）を
// 反映した子スコープで、後続のデフォルト式・関数本体の両方から使われる。
function buildParameterList(paramTokens, env) {
  // 単一の裸パラメータ（デフォルト・rest無し）は既存挙動をそのまま保つ
  // （identifierノード1つを返す。9/9テスト等、既存の出力形状との後方互換のため）。
  if (paramTokens.length === 1 && isIdentifierToken(paramTokens[0])) {
    const name = paramTokens[0];
    const scope = bindEnv([name], env);
    return { node: toNode(name, scope), scope };
  }
  if (paramTokens.length === 0) {
    return { node: null, scope: env };
  }

  let rawEntries;
  let isBracket = false;
  if (paramTokens.length === 1 && Array.isArray(paramTokens[0])) {
    // ブラケット([x ~xs])形式、またはインデントブロック（デフォルト引数）形式
    isBracket = isBracketParamList(paramTokens[0]);
    rawEntries = flattenParamStatements(extractParamLines(paramTokens[0])).flatMap(parseParamLine);
  } else {
    // 裸の空白区切り形式（例: g x, x ~xs）
    rawEntries = splitBareParamTokens(paramTokens);
  }

  const allNames = new Set(rawEntries.map((e) => e.name));
  const boundSoFar = new Set();
  let scope = env;
  const entries = [];
  for (const raw of rawEntries) {
    if (raw.defaultTokens) {
      // let*的な逐次スコープの強制: デフォルト式は自分より前に束縛済みのパラメータのみ
      // 参照できる。同一パラメータリスト内の「まだ束縛されていない」識別子
      // （自分自身、または後ろのパラメータ）への参照は前方参照としてエラーにする
      // （7月30日の設計スレッドが意図した「通常の未定義識別子エラーとしてPass1で弾ける」）。
      checkNoForwardReference(raw.defaultTokens, raw.name, allNames, boundSoFar);
    }
    // デフォルト式は「自分より前に束縛済みのパラメータ」+外側スコープのみ参照できる（let*）。
    const defaultNode = raw.defaultTokens ? reduceAll(raw.defaultTokens, scope) : null;
    entries.push({ name: raw.name, rest: raw.rest, default: defaultNode });
    scope = bindEnv([raw.name], scope); // このパラメータ自身を、次のパラメータ以降から見えるようにする
    boundSoFar.add(raw.name);
  }
  // デフォルトを持つ仮引数は、実際の評価（未実装）ではアリティ計算から除外される
  // （function_guide.md「関数適用時」節）。値の評価をしなくても構造だけから機械的に
  // 求まる部分として、実質アリティ（デフォルト・rest以外の仮引数の数）だけ先に持たせておく。
  const requiredArity = entries.filter((e) => !e.rest && e.default === null).length;
  // bracket: true の場合、interpreter.js の bindParams は「呼び出し側が渡した単一の
  // List/Dict実引数を、この仮引数リストへ分割代入する」という別経路（Eagerパターン、
  // list_model.md §2.4）を通る。裸の複数行デフォルト引数形式（isBracketParamList参照）
  // ではfalseのままで、既存の位置引数ストリーム的な束縛（stream/pull型）を維持する。
  return { node: { type: "params", entries, requiredArity, bracket: isBracket }, scope };
}

// 同一パラメータリスト内で、まだ束縛されていない識別子（自分自身 or 後ろのパラメータ）への
// 前方参照を検出する。tokens は defaultTokens の生トークン列（ネストした配列も再帰的に見る）。
function checkNoForwardReference(tokens, paramName, allNames, boundSoFar) {
  for (const t of tokens) {
    if (Array.isArray(t)) {
      checkNoForwardReference(t, paramName, allNames, boundSoFar);
      continue;
    }
    if (isIdentifierToken(t) && allNames.has(t) && !boundSoFar.has(t)) {
      throw new ReferenceError(
        `パラメータ '${paramName}' のデフォルト式が、まだ束縛されていない識別子 '${t}' を参照しています（let*的な逐次スコープでは、自分より前に宣言されたパラメータのみ参照できます）`
      );
    }
  }
}

function resolveLambdaLine(rawItems, qIdx, env) {
  // 先頭が前置export記号（#/##/###）なら、その分だけ識別子の位置をずらす
  // （pass1.jsのbuildEnvScopeと対称。例: `##f : x ? x + 1` → ["##_","<f>",":",...]）。
  let idx = 0;
  let exported = null;
  if (typeof rawItems[0] === "string" && EXPORT_MARKERS[rawItems[0]]) {
    exported = EXPORT_MARKERS[rawItems[0]];
    idx = 1;
  }

  let nameToken = null;
  let paramsStart = idx;
  if (isIdentifierToken(rawItems[idx]) && rawItems[idx + 1] === ":") {
    nameToken = rawItems[idx];
    paramsStart = idx + 2;
  }
  const paramTokens = rawItems.slice(paramsStart, qIdx);
  const bodyTokens = rawItems.slice(qIdx + 1);

  const { node: paramNode, scope } = buildParameterList(paramTokens, env);
  const bodyNode = reduceAll(bodyTokens, scope);
  const lambdaNode = { type: "operation", op: "?", name: "lambda", position: "infix", left: paramNode, right: bodyNode };

  if (nameToken) {
    return { type: "operation", op: ":", name: "define", position: "infix", left: toNode(nameToken, env), right: lambdaNode, exported };
  }
  return lambdaNode;
}

function reduceAll(rawItems, env) {
  // ラムダ定義行（トップレベルに `?` を持つ行）は、仮引数部が総当たり縮約に誤って
  // 素通しされないよう、先に専用ロジックへ分岐する（上記コメント参照）。
  const qIdx = rawItems.indexOf("?");
  if (qIdx !== -1) {
    return resolveLambdaLine(rawItems, qIdx, env);
  }

  // 【意図的に対応しない】カンマと`:`を1行に混在させる形（例: `foo : 1, bar : 2`）は、
  // `:`(precedence=1)が`,`(precedence=8)より優先度が低いことに起因して総当たり縮約が
  // 誤って隣接トークンを結合してしまう。一時期トップレベルの","を先に分割する回避策を
  // 入れたが、この書き方自体がlist_model.md/pattern_guide.mdの辞書リテラル例（すべて
  // 改行区切り）のどこにも登場しない、こちらで作った未定義入力への対症療法だったため
  // 撤去した。「一つのことを表現する方法は一つ」という方針により、辞書は改行区切りの
  // 形だけをサポートする（`pass3.js`のinferAtomTypeも改行区切りの形のみ判定）。

  // 演算子トークン（裸の記号文字列）は reduceOnce の走査で判定する必要があるため、
  // ここでは atom/block のみを変換し、演算子文字列はそのまま残す。
  let items = resolveDensity(rawItems, env).map((x) => (isBareOperatorToken(x) ? x : toNode(x, env)));
  // tier 26(escape) から 1(export) まで、高い方から低い方へ処理
  for (let tier = 26; tier >= 1; tier--) {
    let guard = 0;
    if (tier === 10) {
      // coproduct_resolver.md §4: compose→apply→apply_reverse→concat/push/constructの
      // 4段階を、それぞれ使い尽くしてから次へ進む（COPRODUCT_PHASES参照）。
      for (const phase of COPRODUCT_PHASES) {
        while (reduceOnce(items, tier, env, phase)) {
          if (++guard > 10000) throw new Error("reduceAll: possible infinite loop at tier " + tier);
        }
      }
      continue;
    }
    while (reduceOnce(items, tier, env)) {
      if (++guard > 10000) throw new Error("reduceAll: possible infinite loop at tier " + tier);
    }
  }
  // ポイントフリー記述（function_guide.md「ポイントフリー記述」）: 総当たり縮約後も
  // 縮約しきれず残った「裸の中置演算子トークン単体」（例: `[+]`）、または「裸の中置演算子
  // トークン＋右オペランド1個・左オペランド無し」（例: `[+ 1]`）は、部分適用の
  // Lambdaとして扱う。reduceOnceの汎用中置演算子マッチは「オペランド 演算子 オペランド」
  // の並び（items[i]=左辺, items[i+1]=演算子, items[i+2]=右辺）しか見ないため、演算子が
  // 列の先頭に来るこの形は総当たり縮約の対象外のまま残る——ここで拾ってpartialノードに
  // 変換する。getCategoryの既存ルール（`if (node.partial) return "Lambda"`）でLambdaに
  // 分類される。
  if (items.length === 1 && typeof items[0] === "string" && isBareOperatorToken(items[0])) {
    const entry = lookup(items[0], "infix");
    if (entry) return { type: "operation", op: items[0], name: entry.name, position: "infix", partial: true, left: null, right: null };
  }
  if (items.length === 2 && typeof items[0] === "string" && isBareOperatorToken(items[0])) {
    const entry = lookup(items[0], "infix");
    if (entry) return { type: "operation", op: items[0], name: entry.name, position: "infix", partial: true, left: null, right: items[1] };
  }

  if (items.length !== 1) {
    // 未縮約の要素が残っている（未対応の演算子等）。診断のためそのまま返す。
    return { type: "unresolved", items };
  }
  return items[0];
}

// ---- ブロック（[...] {...} (...) インデント／絶対値）の解決 ----
// grammar.pegjs修正後: bracket系(`[` `{` `(`)は exprs をそのまま返し、
// indent/abs系は [MARKER, exprs, MARKER?] という「exprsを1要素として保持した」
// 配列を返す（以前は ...exprs と展開しており、bracket系と保護膜の厚みが
// 非対称でExpressionのflat()で漏れる原因になっていたが、修正済み）。
function resolveBlock(term, env) {
  let kind = "paren"; // 【既知の制限】paren/brace/bracketはgrammar.pegjs側で区別されないため固定値
  let exprsArray;
  if (Array.isArray(term) && term[0] === '"INDENT_"') {
    kind = "indent";
    exprsArray = term[1];
  } else if (Array.isArray(term) && term[0] === '"ABS_"') {
    kind = "abs";
    exprsArray = term[1];
  } else {
    exprsArray = term; // bracket系: term がそのまま exprs
  }
  // このブロック内の行だけを対象にした子スコープを作る（ネストしたスコープ連鎖）
  const inner = childEnv(exprsArray.filter(Array.isArray), env);
  const lines = exprsArray.map((line) => (Array.isArray(line) ? reduceAll(line, inner) : toNode(line, inner)));
  return { type: "block", kind, lines };
}

export { reduceAll, getCategory, resolveDensity };
