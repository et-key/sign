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
import { childEnv, envLookup, bindEnv } from './pass1.js';

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
// env: pass1.js が構築した識別子環境の連鎖（{bindings, parent}）。
// 未指定ならすべてAtom扱いにフォールバック。
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
  if (node.type === "block") return "Atom";
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
function reduceOnce(items, tier, env) {
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
  if (paramTokens.length === 1 && Array.isArray(paramTokens[0])) {
    // ブラケット([x ~xs])形式、またはインデントブロック（デフォルト引数）形式
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
  return { node: { type: "params", entries, requiredArity }, scope };
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
  let nameToken = null;
  let paramsStart = 0;
  if (isIdentifierToken(rawItems[0]) && rawItems[1] === ":") {
    nameToken = rawItems[0];
    paramsStart = 2;
  }
  const paramTokens = rawItems.slice(paramsStart, qIdx);
  const bodyTokens = rawItems.slice(qIdx + 1);

  const { node: paramNode, scope } = buildParameterList(paramTokens, env);
  const bodyNode = reduceAll(bodyTokens, scope);
  const lambdaNode = { type: "operation", op: "?", name: "lambda", position: "infix", left: paramNode, right: bodyNode };

  if (nameToken) {
    return { type: "operation", op: ":", name: "define", position: "infix", left: toNode(nameToken, env), right: lambdaNode };
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
  // 演算子トークン（裸の記号文字列）は reduceOnce の走査で判定する必要があるため、
  // ここでは atom/block のみを変換し、演算子文字列はそのまま残す。
  let items = resolveDensity(rawItems, env).map((x) => (isBareOperatorToken(x) ? x : toNode(x, env)));
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
