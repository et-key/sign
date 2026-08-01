/**
 * Pass2: coproduct_resolver.md のアルゴリズム実装。
 * Pass1相当(peggyパーサー)が返すフラットなTerm列を、二分木ASTへ縮約する。
 *
 * getCategory は第2引数に env（pass1.js の buildEnv が返す識別子→カテゴリのMap）を
 * 受け取れる。env未指定、またはenvに無い識別子は Atom にフォールバックする
 * （組み込み `<print>` のみ例外的に Lambda）。
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
 * 【既知の制限】ブロック内部の行（[...]や{...}の中身）はenvを引き継いで解決されるが、
 * pass1.js の buildEnv 自体はトップレベルの行しか見ていないため、ブロック内で定義された
 * 識別子はenvに登録されない。
 */

import { OPERATOR_DICT } from "./operator_table.js";

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

function toNode(x) {
  // すでにoperation/blockノードならそのまま、そうでなければAtomリーフとして包む
  if (x && typeof x === "object" && !Array.isArray(x)) return x;
  if (Array.isArray(x)) return resolveBlock(x);
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
function resolveDensity(items) {
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
    let core = toNode(items[i]);
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
      node = { type: "operation", op, name: lookup(op, "postfix")?.name, position: "postfix", operand: node };
    }
    for (let k = preOps.length - 1; k >= 0; k--) {
      const op = preOps[k];
      node = { type: "operation", op, name: lookup(op, "prefix")?.name, position: "prefix", operand: node };
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

// ---- getCategory (coproduct_resolver.md §2) ----
// env: Pass1が構築した識別子→カテゴリのMap（未指定ならすべてAtom扱いにフォールバック）
function getCategory(node, env) {
  if (!node || typeof node !== "object") return "Atom";
  if (node.type === "operation") {
    if (node.op === "?") return "Lambda"; // 関数定義
    if (node.name === "compose") return "Lambda";
    if (node.partial) return "Lambda"; // オペランド不足の部分適用
    if (node.position === "prefix" && node.op === "@") return "Lambda"; // 前置@（Input）
    // 通常の演算ノード（算術・concat等）はAtom
    return "Atom";
  }
  if (node.type === "atom") {
    if (node.kind === "identifier") {
      if (env && env.has(node.value)) return env.get(node.value);
      // envに無い場合、組み込み関数名のみLambda扱い
      if (["<print>"].includes(node.value)) return "Lambda";
      return "Atom";
    }
    return "Atom";
  }
  if (node.type === "block") return "Atom";
  return "Atom";
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
  if (catA === "Lambda" && catB === "Atom") return mk("apply", a, b);
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
function reduceOnce(items, tier, env) {
  for (let i = 0; i < items.length - 1; i++) {
    const a = items[i];
    const b = items[i + 1];
    if (isBareOperatorToken(b)) {
      const entry = lookup(b, "infix");
      if (entry && entry.precedence === tier && i + 2 < items.length && !isBareOperatorToken(items[i + 2])) {
        const left = toNode(a);
        const right = toNode(items[i + 2]);
        const node = { type: "operation", op: b, name: entry.name, position: "infix", left, right };
        items.splice(i, 3, node);
        return true;
      }
      continue;
    }
    if (tier === 10 && !isBareOperatorToken(a) && !isBareOperatorToken(b)) {
      const left = toNode(a);
      const right = toNode(b);
      const node = coproductReduce(left, right, env);
      if (node) {
        items.splice(i, 2, node);
        return true;
      }
    }
  }
  return false;
}

function reduceAll(rawItems, env) {
  // 演算子トークン（裸の記号文字列）は reduceOnce の走査で判定する必要があるため、
  // ここでは atom/block のみを変換し、演算子文字列はそのまま残す。
  let items = resolveDensity(rawItems).map((x) => (isBareOperatorToken(x) ? x : toNode(x)));
  // tier 26(escape) から 1(export) まで、高い方から低い方へ処理
  for (let tier = 26; tier >= 1; tier--) {
    let guard = 0;
    while (reduceOnce(items, tier, env)) {
      if (++guard > 10000) throw new Error("reduceAll: possible infinite loop at tier " + tier);
    }
  }
  if (items.length !== 1) {
    // 未縮約の要素が残っている（未対応の演算子等）。診断のためそのまま返す。
    return { type: "unresolved", items };
  }
  return items[0];
}

// ---- ブロック（[...] {...} (...) インデント／絶対値）の解決 ----
function resolveBlock(exprsArray, env) {
  // grammarのBlockは配列を返す。INDENT/ABSは特殊マーカー文字列が先頭・末尾に入る。
  let kind = "paren"; // 【既知の制限】paren/brace/bracketはgrammar.pegjs側で区別されないため固定値
  let arr = exprsArray;
  if (arr[0] === '"INDENT_"' && arr[arr.length - 1] === '"_DEDENT"') {
    kind = "indent";
    arr = arr.slice(1, -1);
  } else if (arr[0] === '"ABS_"') {
    kind = "abs";
    arr = arr.slice(1);
  }
  const lines = arr.map((line) => (Array.isArray(line) ? reduceAll(line, env) : toNode(line)));
  return { type: "block", kind, lines };
}

export { reduceAll, getCategory, resolveDensity };
