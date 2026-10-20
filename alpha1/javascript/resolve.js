/**
 * 余積（空白）の解決（alpha1 の意味解析の最初の段）。
 *
 * 仕様は alpha1/docs/coproduct_spec.md（設計 workflow の最終版）。ここに書くのは、確信度 91% 以上の規則
 * （§4 の R1〜R26、§1.2 の P1〜P3、§2 の表の「する」の行）だけである。90% 以下の所は §6.2 の門（G1〜G12、
 * P2 の門）で名指しで断る。決まっていない形を黙ってどれかの読みに倒すと、後で利用者の答えが出たときに、
 * その形が黙った誤答として残るからである。断った形は、答えが出たら試験の「断られる」側から「通る」側へ移す。
 *
 * 入り口は `resolve(source)` の1つで、`{ trees, diagnostics }` を返す。trees は1行に1つの木、diagnostics は
 * 止めない診断（information の undefined-name）。門に当たったら OperationError を投げる（reason は §6.2 の名前、
 * spec は `…§6.2 G2(b)` のように門の番号まで、`gate` に門の番号）。
 *
 * **木の書き方（`show`）**。§1.3・§6.3 の S 式に合わせ、無い所はここで決めた。
 * - 節：`(construct a b …)`・`(compose f g …)`・`(apply h x)`・`(apply h x ·rev)`・`(? [$p0 …] (apply h …))`。
 * - 葉は項そのもの。名前は `<>` を外した綴り、字面は書いたまま、印は核に付けて書く（`$inc`・`xs~`・`-x!`・`!_`）。
 * - 中置の項は綴りを頭にした `(+ 1 2)`。欠けた被演算子は `·`。
 * - 括りは書いたとおりに、いつも `[…]` で書く。前段は `[…]`・`(…)`・`{…}` を1つの印にまとめて種類を残さない
 *   （利用者 2026-08-05「カッコの意味って統一されているから種類を問うていない」）ので、綴りを1つにするしかない。
 *   それに S 式の `(…)` は節の印なので、括りを `(…)` で書くと節と見分けが付かない。§6.3 の `(f3 1)` は `[f3 1]` になる。
 *   括りの中の行は ` ⏎ ` でつなぎ、行末の `,`（貪欲の印）は前の語に付ける（`[* 2,]`）。括りの中は書いたとおりで、
 *   解いた木は葉の `view.inner` に持つ。絶対値は `|…|`、ノルムは `||…||`。
 * - 字下げのブロックは、解いた行を並べて `(block 行 行 …)`。書いたとおりに書く所（括りの中・`?` の左）では `{行 ⏎ 行}`。
 * - 段1〜9 の中置は `(== 左 右)`・`(, 左 右)`（`,` は右結合のまま入れ子にする）。
 * - `:` は `(: 左 右)`。左が1項なら解かない（P3）ので、その項をそのまま書く。
 * - `?` は `(? [仮引数を書いたとおり] 本体)`。`?` の左は解かない（P3）。
 * - 括りの関数（R24）は、その `?` を通って呼ばれた実体を形の綴りの順に並べて `(? [仮引数] (inst 形 本体) …)`。
 *   一度も呼ばれなければ、本体を書いたまま `(? [仮引数] (defer {本体}))`（R25。字下げの本体は行を ` ⏎ ` でつなぐ）。
 *   どの `?` を通って呼ばれたかは書いた `?` ごとに数える。同じ綴りの別の関数（`a : [say] ? say 21` と
 *   `b : [say] ? say 21`）は本体の答えを共有するが、呼ばれていない方は defer のまま（R25「一度も呼ばれない」）。
 *
 * **形の綴り**（`inst` の形。R24 の「渡された物の生まれ」を書く）。
 * - 中身の見えない A は `A`、関数は `L`、未知は `U`。
 * - 数（数・文字の字面と、それに値の印や値の演算子を当てた物。長さ1の List と同型）は `N`。数の List は `[N…]`。
 *   番地の字面（`0x…`・`NxHHHH`）は数に入れず、中身の見えない A（SCALAR の注）。
 * - 構造体とも List とも読めないが中身の見える器（行の混ざった括り・同じ名前の欄が2つある構造体など）で、中身に
 *   関数か未知が見える物は `A(U)`。名前で受ければ未知、`~rest` で受ければ中身の見えたまま（撒けば §3.3 の手順1 の
 *   G7）なので、`A` とは別の実体にする。
 * - 構造体は欄を書いた順に `{say:L other:A}`。List は要素の形に `…` を付けて `[A…]`（長さは書かない。形は長さに
 *   依らないので、長さの違う同じ要素の List は同じ実体になる）。入れ子は `{greet:{hello:L} world:[A…]}`・`[[A…]…]`。
 * - 仮引数が2つ以上なら、仮引数ごとの形を空白で並べる（`A [A…]`）。裸の仮引数はいつも A なので `A`。
 * - 関数の欄は、どの関数でも `L` と書く。実体の鍵には関数の出どころ（書いた本体と、定義した所の範囲）まで入れて
 *   いるので、本体の根の違う関数が同じ実体になることはない。同じ綴りの実体が2つ並んだら、関数が違う。
 * - 綴りが SHAPE_TEXT_MAX 字を超えたら、そこで切って `⋯` を付ける（同じ物を欄どうしで共有する形は、木として書くと
 *   深さごとに倍になる）。切っても実体の鍵は切らない（鍵は canonKey の注）。
 *
 * **種類**は A（値）・L（関数）・U（未知）の3つ。§0.4 の1のとおり、隣り合う2項の種類の対は4つしかないので、
 * 対ごとに構築（零対象のある圏での標準の射 A ⊔ B → A × B）・合成・適用（評価射）・逆適用（評価射の前に対称の
 * 同型を置いたもの）が1つずつ決まる。U はどの対にもならないので、2項以上の並びでは門で断る（根なら通す）。
 */
import peggy from "peggy";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { preprocess } from "./lexer.js";
import { OPERATOR_DICT } from "./operator_table.js";
import { OperationError } from "./errors.js";

const SPEC = "alpha1/docs/coproduct_spec.md";

// ---------------------------------------------------------------------------
// 前段
// ---------------------------------------------------------------------------

// 文法は1回だけ組み立てる。試験は何十も resolve を呼ぶので、呼ぶたびに peggy.generate すると遅い。
let parser = null;
function frontEnd(source) {
  if (!parser) {
    const dir = path.dirname(fileURLToPath(import.meta.url));
    parser = peggy.generate(fs.readFileSync(path.join(dir, "sign.pegjs"), "utf8"));
  }
  return parser.parse(preprocess(source));
}

// ---------------------------------------------------------------------------
// 門と名前の断り
// ---------------------------------------------------------------------------

const GATE_REASON = {
  G1: "coproduct-reverse-of-many",
  G2: "coproduct-partial-neighbor",
  G3: "coproduct-beside-product",
  G4: "coproduct-prefix-tilde",
  G5: "coproduct-unit-position",
  G6: "coproduct-input-position",
  G7: "coproduct-unknown-kind",
  G8: "coproduct-reverse-arity",
  G9: "coproduct-reverse-spread",
  G10: "coproduct-reverse-pointfree",
  G11: "coproduct-no-reading",
  G12: "coproduct-excess-neighbor",
};

// 門の番号（`G2(b)` のように枝まで）から断りを作る。reason は門ごとの名前で、枝は spec と gate で見分ける。
function gate(id, message) {
  const base = id.replace(/\(.\)$/, "");
  const e = new OperationError(message, { spec: `${SPEC} §6.2 ${id}`, reason: GATE_REASON[base] });
  e.gate = id;
  return e;
}

// 余積の門か。本体の根の種類を仮に解くとき（下の bodyRootOf）は、門に当たっても止めずに「未知」にする。
// 名前の門（P2）は仮に解いても答えが変わらないので止める。
// 実体の守りの断り（guardRefusal）も門に数える。根の種類を解く所では未知にし、覚えた断りを resolve の最後に投げる。
function isGate(e) {
  return e instanceof OperationError && typeof e.reason === "string" && (e.reason.startsWith("coproduct-") || !!e.guard);
}

function nameError(reason, message) {
  const e = new OperationError(message, { spec: `${SPEC} §1.2 P2`, reason });
  e.gate = "P2";
  return e;
}

// 前段は通るが、木にできない形。余積の規則ではないので門には数えない。
function shapeError(reason, message, where = "§1.2 P1") {
  return new OperationError(message, { spec: `${SPEC} ${where}`, reason });
}

// 字下げのブロックは並びの項にならない（§2、92）。仕様は「前段が中置の右にだけ置く」ことを前提にしているが、
// 前段はブロックを閉じた後の行頭の空白の行（前の行の続き）をつなぐので、ブロックが並びの項や中置の左に来る形も
// 通す（`v :` ⏎ `→inc` ⏎ ` 5`）。前提が崩れた所でブロックを項として読むと、本体の種類（全部の行が A のときだけ A）を
// 素通りして構造体の A になり、黙って木が変わる。だから中置の右でない所のブロックは断る。
function isBareIndent(term) {
  return !!term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === "indent";
}
function refuseIndentBlock(where) {
  return shapeError(
    "indent-block-position",
    `字下げのブロックが${where}にあります。ブロックは中置の右にだけ置けます（前の行の続きを書くなら、ブロックの中に書きます）。`,
    "§2"
  );
}

// ---------------------------------------------------------------------------
// P1：語を項に寄せ、中置を畳む
// ---------------------------------------------------------------------------

// 前段の語の見分け方（§1.1）。前置の印は記号の並び＋末尾 `_`、後置の印は `_`＋記号1つ。
const PREFIX_MARK = /^(###|##|#|-|~|!!|!|\$|@)_$/;
const POSTFIX_MARK = /^_[!~@]$/;
const OPERATOR_WORD = /^[!"#$%&'\-=^~|@;+:*,<>/?]+$/;
const isNameWord = (w) => typeof w === "string" && w.length > 2 && w[0] === "<" && w[w.length - 1] === ">";
const isInfixWord = (w) => typeof w === "string" && OPERATOR_WORD.test(w);

const BLOCK_TAG = { '"BRACKET_"': "bracket", '"ABS_"': "abs", '"NORM_"': "norm", '"INDENT_"': "indent" };

// 値の演算子の印（§2「A の核に前置 `-` `!` `!!`・後置 `!`」）。
const VALUE_PREFIX = new Set(["-", "!", "!!"]);

function makeCore(w) {
  if (Array.isArray(w)) {
    const c = BLOCK_TAG[w[0]];
    if (!c) throw shapeError("front-end-shape", `前段の囲みの印を読めません: ${JSON.stringify(w[0])}`);
    // 欠けた被演算子を許すのは括りの行だけ（P1「括りの1行が中置で始まるか終わる形」）。
    const rows = w[1].map((row) => parseRow(row, { inBracket: c === "bracket" }));
    return { c, rows, raw: w };
  }
  if (w === "_") return { c: "unit" };
  if (isNameWord(w)) return { c: "name", name: w.slice(1, -1) };
  return { c: "lit", text: w };
}

// 1行の語を、項（前置の印・核・後置の印をまとめた物）と中置の演算子の並びにする（R2：印は隣の核1つに付く）。
function tokenize(words) {
  const toks = [];
  let i = 0;
  while (i < words.length) {
    const w = words[i];
    if (isInfixWord(w)) {
      const def = (OPERATOR_DICT[w] || []).find((d) => d.position === "infix");
      if (!def) throw shapeError("operator-unknown", `\`${w}\` は中置の演算子として表にありません。`);
      if (def.removed) throw shapeError("operator-removed", `\`${w}\` は廃止されました（${def.removed}）。`);
      toks.push({ t: "op", sym: w, stage: def.precedence, assoc: def.assoc || "left" });
      i++;
      continue;
    }
    const pre = [];
    while (typeof words[i] === "string" && PREFIX_MARK.test(words[i])) pre.push(words[i++].slice(0, -1));
    if (i >= words.length) throw shapeError("front-end-shape", "前置の印の後ろに核がありません。");
    const core = makeCore(words[i++]);
    const post = [];
    while (typeof words[i] === "string" && POSTFIX_MARK.test(words[i])) post.push(words[i++].slice(1));
    toks.push({ t: "atom", term: { type: "atom", pre, core, post } });
  }
  return toks;
}

// 1行を木にする。段1〜9 は並びを切り（R1・R20）、段12〜22 は項の中へ先に畳む（P1）。段10 の前置 `~` と
// 段23〜25 の印は、前段が核に密着させて返すので、項の印として tokenize が持つ。
//
// 木：{type:'op', sym, stage, left, right}（段1〜9）か {type:'seq', terms}（余積の並び）。
// 項：{type:'atom', pre, core, post} か {type:'infix', sym, stage, left, right}。
function parseRow(words, { inBracket = false } = {}) {
  const toks = tokenize(words);
  let pos = 0;
  const peek = () => toks[pos];
  const isLow = (t) => t && t.t === "op" && t.stage <= 9;
  const isHigh = (t) => t && t.t === "op" && t.stage >= 12;

  function parseLow(minStage) {
    let left = parseSegment();
    while (isLow(peek()) && peek().stage >= minStage) {
      const op = toks[pos++];
      const right = parseLow(op.assoc === "right" ? op.stage : op.stage + 1);
      left = { type: "op", sym: op.sym, stage: op.stage, left, right };
    }
    return left;
  }
  function parseSegment() {
    const terms = [];
    while (pos < toks.length && !isLow(peek())) terms.push(parseHigh(12));
    return terms.length ? { type: "seq", terms } : null;
  }
  function parseHigh(minStage) {
    let left = null;
    if (peek() && peek().t === "atom") left = toks[pos++].term;
    while (isHigh(peek()) && peek().stage >= minStage) {
      const op = toks[pos++];
      const next = op.assoc === "right" ? op.stage : op.stage + 1;
      const right = peek() && (peek().t === "atom" || isHigh(peek())) ? parseHigh(next) : null;
      left = { type: "infix", sym: op.sym, stage: op.stage, left, right };
    }
    return left;
  }

  const tree = parseLow(1);
  const allowMissing = inBracket && words.length > 0 && (isInfixWord(words[0]) || isInfixWord(words[words.length - 1]));
  if (!allowMissing && hasMissing(tree)) {
    throw shapeError("infix-missing-operand", `中置の演算子の被演算子が欠けています（点なしは括りの中でだけ書けます）: \`${writeRow(words)}\``);
  }
  refuseMixedAssoc(tree);
  return tree;
}

function hasMissing(tree) {
  if (tree === null) return true;
  if (tree.type === "seq") return tree.terms.some(hasMissingTerm);
  return hasMissing(tree.left) || hasMissing(tree.right);
}
function hasMissingTerm(term) {
  if (term === null) return true;
  if (term.type === "infix") return hasMissingTerm(term.left) || hasMissingTerm(term.right);
  return false;
}

// 同じ段に結合の向きの違う中置が続く形（段18 の `'` は左、`@` は右）は、表の段と向きだけでは畳み方が決まらない
// （P1 は「表の段と結合の向きのとおり」としか言わない）。どちらかに倒すと黙って割れるので断る。
function refuseMixedAssoc(tree) {
  const visitTerm = (term) => {
    if (!term || term.type !== "infix") return;
    for (const child of [term.left, term.right]) {
      if (child && child.type === "infix" && child.stage === term.stage && assocOf(child.sym) !== assocOf(term.sym)) {
        throw shapeError("infix-mixed-assoc", `同じ段で結合の向きが違う中置（\`${child.sym}\` と \`${term.sym}\`）が続いています。括りで分けて書きます。`);
      }
      visitTerm(child);
    }
  };
  const visit = (t) => {
    if (!t) return;
    if (t.type === "seq") t.terms.forEach(visitTerm);
    else {
      visit(t.left);
      visit(t.right);
    }
  };
  visit(tree);
}
function assocOf(sym) {
  const def = (OPERATOR_DICT[sym] || []).find((d) => d.position === "infix");
  return (def && def.assoc) || "left";
}

// ---------------------------------------------------------------------------
// 書いたとおりの綴り（括りの葉・`?` の左）
// ---------------------------------------------------------------------------

function writeRow(words) {
  const parts = [];
  let pending = "";
  for (const w of words) {
    if (Array.isArray(w)) {
      parts.push(pending + writeBlock(w));
      pending = "";
    } else if (PREFIX_MARK.test(w)) {
      pending += w.slice(0, -1);
    } else if (POSTFIX_MARK.test(w) && parts.length) {
      parts[parts.length - 1] += w.slice(1);
    } else {
      parts.push(pending + (isNameWord(w) ? w.slice(1, -1) : w));
      pending = "";
    }
  }
  // 行末の `,` は貪欲の印なので前の語に付ける（§6.3 の `[* 2,]`・`[< 3,]`）。
  if (parts.length >= 2 && parts[parts.length - 1] === ",") {
    parts.pop();
    parts[parts.length - 1] += ",";
  }
  return parts.join(" ");
}

function writeBlock(b) {
  const inner = b[1].map(writeRow).join(" ⏎ ");
  switch (BLOCK_TAG[b[0]]) {
    case "bracket":
      return `[${inner}]`;
    case "abs":
      return `|${inner}|`;
    case "norm":
      return `||${inner}||`;
    default:
      return `{${inner}}`;
  }
}

function writeCore(core) {
  if (core.c === "name") return core.name;
  if (core.c === "lit") return core.text;
  if (core.c === "unit") return "_";
  return writeBlock(core.raw);
}

function writeTerm(term) {
  if (!term) return "";
  if (term.type === "infix") return [writeTerm(term.left), term.sym, writeTerm(term.right)].filter((s) => s !== "").join(" ");
  return term.pre.join("") + writeCore(term.core) + term.post.join("");
}

function writeTree(tree) {
  if (!tree) return "";
  if (tree.type === "seq") return tree.terms.map(writeTerm).join(" ");
  return [writeTree(tree.left), tree.sym, writeTree(tree.right)].filter((s) => s !== "").join(" ");
}

// 解かない項（`:` の左の1項）の S 式。中置は畳んであるので S 式で書く（P1 は解かない所にも当たる）。
function rawView(term) {
  if (!term) return null;
  if (term.type === "infix") return { v: "infix", sym: term.sym, left: rawView(term.left), right: rawView(term.right) };
  return { v: "atom", text: writeTerm(term) };
}

// ---------------------------------------------------------------------------
// 木の歩き方（P2 の名前集め・局所の定義・取り込みの範囲）
// ---------------------------------------------------------------------------

function bareName(term) {
  return term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === "name" ? term.core.name : null;
}
function singleBareName(tree) {
  return tree && tree.type === "seq" && tree.terms.length === 1 ? bareName(tree.terms[0]) : null;
}
function isBareBlock(term, c) {
  return term && term.type === "atom" && term.pre.length === 0 && term.post.length === 0 && term.core.c === c;
}

// 仮引数の並びの中の名前（P2）。括りの仮引数の中で `:` の右に書いた物は既定値で、仮引数ではないので数えない。
// 既定値の右の名前まで数えると、`[z : inc]` の `inc` を仮引数と読み、ファイルの定義を隠すと誤って断る。
function forEachParamNameInTree(tree, cb) {
  if (!tree) return;
  if (tree.type === "seq") return tree.terms.forEach((t) => forEachParamNameInTerm(t, cb));
  forEachParamNameInTree(tree.left, cb);
  if (tree.sym !== ":") forEachParamNameInTree(tree.right, cb);
}
function forEachParamNameInTerm(term, cb) {
  if (!term) return;
  if (term.type === "infix") {
    forEachParamNameInTerm(term.left, cb);
    forEachParamNameInTerm(term.right, cb);
  } else if (term.core.c === "name") cb(term.core.name);
  else if (term.core.rows) term.core.rows.forEach((r) => forEachParamNameInTree(r, cb));
}

function forEachNameInTree(tree, cb) {
  if (!tree) return;
  if (tree.type === "seq") tree.terms.forEach((t) => forEachNameInTerm(t, cb));
  else {
    forEachNameInTree(tree.left, cb);
    forEachNameInTree(tree.right, cb);
  }
}
function forEachNameInTerm(term, cb) {
  if (!term) return;
  if (term.type === "infix") {
    forEachNameInTerm(term.left, cb);
    forEachNameInTerm(term.right, cb);
  } else if (term.core.c === "name") cb(term.core.name);
  else if (term.core.rows) term.core.rows.forEach((r) => forEachNameInTree(r, cb));
}

// 木の中の項を全部訪ねる。`?` の右（入れ子の関数の本体）は、skipLambda なら入らない。
function forEachTerm(tree, cb, { skipLambda = false } = {}) {
  const visitTree = (t) => {
    if (!t) return;
    if (t.type === "seq") t.terms.forEach(visitTerm);
    else if (t.sym === "?" && skipLambda) return;
    else {
      visitTree(t.left);
      visitTree(t.right);
    }
  };
  const visitTerm = (term) => {
    if (!term) return;
    cb(term);
    if (term.type === "infix") {
      visitTerm(term.left);
      visitTerm(term.right);
    } else if (term.core.rows) term.core.rows.forEach(visitTree);
  };
  visitTree(tree);
}

// 取り込み（後置 `@`）のある範囲か（P2）。範囲は関数の本体か、ファイルのいちばん外。
function hasImportIn(tree) {
  let found = false;
  forEachTerm(tree, (term) => {
    if (term.type === "atom" && term.post.includes("@")) found = true;
  }, { skipLambda: true });
  return found;
}

// 仮引数の並び（`?` の左）を読む。素の関数（§3.4）は、仮引数が全部裸の名前（既定値なし・前置 `~` なし・
// 括りなし）の関数である。字下げの仮引数のブロック（前段は `?` の左に1つのブロックとして返す）は1行に1つ。
function parseParams(left) {
  const names = [];
  let plain = true;
  const other = (n) => names.push({ name: n, cls: "other" });
  if (!left) return { plain: false, names };
  if (left.type !== "seq") {
    forEachParamNameInTree(left, other);
    return { plain: false, names };
  }
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) {
    for (const row of left.terms[0].core.rows) {
      const n = singleBareName(row);
      if (n) names.push({ name: n, cls: "bare" });
      else if (row && row.type === "op" && row.sym === ":" && singleBareName(row.left)) {
        other(singleBareName(row.left)); // 既定値のある仮引数。既定値の右は `?` の左なので解かない（P3）
        plain = false;
      } else {
        forEachParamNameInTree(row, other);
        plain = false;
      }
    }
    return { plain: plain && names.length > 0, names };
  }
  for (const t of left.terms) {
    const n = bareName(t);
    if (n) names.push({ name: n, cls: "bare" });
    else {
      // 括りの中の名前・前置 `~` の名前は、ここでは未知。括りの関数（R24：仮引数が裸の名前と括りだけで既定値が無い）
      // なら、実体の範囲では lookup が先に仮引数の desc（渡された物の生まれ）を見て、実体の外では本体を読まない（R25）。
      // 既定値のある関数（`[x : 1] ? …`）・括りの外の前置 `~` の関数（`a ~y ? …`）は括りの関数ではないので、今までどおり
      // 定義の行で本体を読み、ここで未知にした名前は並びで G7 になる。
      forEachParamNameInTerm(t, other);
      plain = false;
    }
  }
  return { plain: plain && names.length > 0, names };
}

// 括りの関数（R24 の言葉）の仮引数の並び。括りの関数でなければ null。
// 括りの関数は、仮引数が裸の名前と括りだけで（括りが1つ以上）、既定値が無い（括りの中にも `:` が無い）関数である。
// 括りの外の前置 `~`（2026-10-04 に廃止した裸の `~xs`）や印の付いた仮引数は、R24 の言葉に入らないので今までどおり
// アリティの分からない関数（other）にする。字下げの仮引数のブロックも、行が裸の名前か既定値なので今までどおり。
//
// 返す物：[{kind:'bare', name} | {kind:'bracket', simple, names, rest, all}]。アリティは並びの長さ（括りは1つで1）。
// simple は R24 の表で読める括り（1行で、裸の名前が並び、末尾にだけ `~rest` が1つ）。それ以外の括り（入れ子の括り
// `[[a b] c]`・2行の括り・`~rest` が途中にある括り）の中の名前は、どの言葉も読み方を決めていないので、決めずに
// 未知にする（all がその名前）。未知にした名前は、並びで使えば G7 で断られるので、黙ってどれかの読みにはならない。
function patternParamsOf(left) {
  if (!left || left.type !== "seq") return null;
  if (left.terms.length === 1 && isBareBlock(left.terms[0], "indent")) return null;
  const params = [];
  let hasBracket = false;
  for (const t of left.terms) {
    const n = bareName(t);
    if (n) {
      params.push({ kind: "bare", name: n });
      continue;
    }
    if (!isBareBlock(t, "bracket") || t.core.rows.some(treeHasColon)) return null;
    hasBracket = true;
    params.push(bracketParamOf(t));
  }
  return hasBracket ? params : null;
}
function treeHasColon(tree) {
  if (!tree) return false;
  if (tree.type === "seq") return tree.terms.some(termHasColon);
  return tree.sym === ":" || treeHasColon(tree.left) || treeHasColon(tree.right);
}
function termHasColon(term) {
  if (!term) return false;
  if (term.type === "infix") return termHasColon(term.left) || termHasColon(term.right);
  return !!term.core.rows && term.core.rows.some(treeHasColon);
}
function bracketParamOf(term) {
  const all = [];
  forEachParamNameInTerm(term, (n) => all.push(n));
  const rows = term.core.rows;
  const notSimple = { kind: "bracket", simple: false, all };
  if (rows.length === 0) return { kind: "bracket", simple: true, names: [], rest: null, all };
  if (rows.length !== 1 || !rows[0] || rows[0].type !== "seq") return notSimple;
  const names = [];
  let rest = null;
  const terms = rows[0].terms;
  for (let i = 0; i < terms.length; i++) {
    const t = terms[i];
    const n = bareName(t);
    if (n) names.push(n);
    else if (i === terms.length - 1 && t.type === "atom" && t.pre.length === 1 && t.pre[0] === "~" && !t.post.length && t.core.c === "name") rest = t.core.name;
    else return notSimple;
  }
  return { kind: "bracket", simple: true, names, rest, all };
}

// 定義の右辺から `?` を取り出す。1行の括りや字下げのブロックで包んだ `?`（`f : [x ? x]`、字下げの仮引数の
// ブロックの `f :` ⏎ … ⏎ `? …`）も関数の定義に数える。包みを開かないと、名前の種類を決めるのに本体を解く
// ことになり、本体が自分の名前を呼ぶだけで輪（name-cycle）に見えてしまう。
// 片側の欠けた `?`（`[z ?]`・`[? z]`）は関数の定義ではなく `[?]` の点なしで、種類は未知（§2、Q19）。括りの外では
// 前段の後の畳み込み（P1）が欠けた被演算子を断るので、ここに来るのは括りの中の形だけである。名前を通したときだけ
// 関数と読むと、`[z ?] 5` は断るのに `ff : [z ?]` の `ff 5` は通る、という食い違いになる。
function isSection(op) {
  return !op.left || !op.right;
}
function unwrapLambda(rhs) {
  let t = rhs;
  while (t && t.type === "seq" && t.terms.length === 1) {
    const term = t.terms[0];
    if (!(isBareBlock(term, "bracket") || isBareBlock(term, "indent")) || term.core.rows.length !== 1) break;
    t = term.core.rows[0];
  }
  return t && t.type === "op" && t.sym === "?" && !isSection(t) ? t : null;
}

function asDefinition(line) {
  if (!line || line.type !== "op" || line.sym !== ":" || !line.left || line.left.type !== "seq" || line.left.terms.length !== 1) return null;
  const t = line.left.terms[0];
  // `#` は公開の印で、名前空間の話（余積の外）。定義する名前は核の名前である。
  if (t.type !== "atom" || t.core.c !== "name" || t.post.length || t.pre.length > 1 || (t.pre.length === 1 && !/^#+$/.test(t.pre[0]))) return null;
  const lambda = unwrapLambda(line.right);
  const def = { name: t.core.name, rhs: line.right, lambda };
  if (lambda) {
    const p = parseParams(lambda.left);
    def.plain = p.plain;
    def.n = p.names.length;
    def.pattern = patternParamsOf(lambda.left);
  }
  return def;
}

// P2：同じ範囲の同じ名前と、隠し（仮引数と、ファイルの定義や外の仮引数が同じ名前）を、解く前に全部見る。
function checkParamNames(lines, F) {
  const visitTree = (t, outer) => {
    if (!t) return;
    if (t.type === "seq") return t.terms.forEach((term) => visitTerm(term, outer));
    if (t.sym === "?") {
      const { names } = parseParams(t.left);
      const seen = new Set();
      for (const { name } of names) {
        if (seen.has(name)) throw nameError("name-duplicate", `仮引数 \`${name}\` が同じ関数に2つあります。`);
        seen.add(name);
        if (F.defs.has(name)) throw nameError("name-shadow", `仮引数 \`${name}\` がファイルの定義 \`${name}\` を隠します。`);
        if (outer.has(name)) throw nameError("name-shadow", `仮引数 \`${name}\` が外の関数の仮引数 \`${name}\` を隠します。`);
      }
      return visitTree(t.right, new Set([...outer, ...seen]));
    }
    visitTree(t.left, outer);
    visitTree(t.right, outer);
  };
  const visitTerm = (term, outer) => {
    if (!term) return;
    if (term.type === "infix") {
      visitTerm(term.left, outer);
      visitTerm(term.right, outer);
    } else if (term.core.rows) term.core.rows.forEach((r) => visitTree(r, outer));
  };
  for (const line of lines) visitTree(line, new Set());
}

// 関数の本体の中で `:` の左に1語で置かれた名前は、局所の定義か枝の条件か決まっていない（P2）。仮引数でも
// ファイルの定義でもなければ「種類が未知」にする。入れ子の関数の本体は、その関数の範囲で数える。
function scanLocals(tree, scope, F) {
  if (!tree) return;
  if (tree.type === "seq") return tree.terms.forEach((t) => scanLocalsTerm(t, scope, F));
  if (tree.sym === "?") return;
  if (tree.sym === ":") {
    const n = singleBareName(tree.left);
    if (n) {
      if (!paramInChain(scope, n) && !F.defs.has(n)) scope.locals.add(n);
    } else scanLocals(tree.left, scope, F);
    return scanLocals(tree.right, scope, F);
  }
  scanLocals(tree.left, scope, F);
  scanLocals(tree.right, scope, F);
}
function scanLocalsTerm(term, scope, F) {
  if (!term) return;
  if (term.type === "infix") {
    scanLocalsTerm(term.left, scope, F);
    scanLocalsTerm(term.right, scope, F);
  } else if (term.core.rows) term.core.rows.forEach((r) => scanLocals(r, scope, F));
}
function paramInChain(scope, name) {
  for (let s = scope; s; s = s.parent) if (s.params && s.params.has(name)) return true;
  return false;
}

// ---------------------------------------------------------------------------
// 種類
// ---------------------------------------------------------------------------
//
// desc：{k:'A'|'L'|'U', fn?, spread?, elements?, shape?}
//   fn（L のとき）：
//     {type:'plain', origin:'plain'|'partial'|'hole', n, getBodyRoot, idKey}  素の関数・部分適用・穴（§3.4）。穴の部分適用は
//       'hole' のまま（plainApply）
//     {type:'pattern', n, idKey, label, op, scopeKey, lastBracket, bareAt, instantiate}  括りの関数（R24）。n は仮引数の数
//       （括りは1つで1）。lastBracket は最後の仮引数が括りの関数（k > n なら残りの並び全体を最後の括りが1つの List として
//       受ける、applyKind）。bareAt は仮引数ごとに裸か。op と scopeKey は書いた `?` と、それを解いた範囲（定義の行の木に、
//       その `?` を通って呼ばれた実体だけを描くため）
//     {type:'pattern', n, label, lastBracket, base, bound, instantiate}  括りの関数の部分適用（patternPartial）。n は残りの
//       仮引数の数、base は元の括りの関数、bound は当てた物の desc（前から）。instantiate は bound を前に足して base の
//       実体を作る。鍵は idKey ではなく base の出どころと当てた物の形（internPartial）
//     {type:'pfUnary'|'pfGreedyUnary'|'pfGreedyBinary'|'pfUnknownArity', pointfree:true}  点なし（§2、pointfreeOf の注）
//     {type:'pfPick', pointfree:true, sym, key}  段18 の点なし。key は `[' 0]`・`[' say]` の鍵（R26）、ほかは null
//     {type:'compose', fns, partial}  合成
//     {type:'input'}  頭の前置 `@`
//     {type:'other'}  アリティの分からない関数（既定値のある関数など）
//   idKey：関数の出どころ（書いた `?` の綴りと、定義した所の範囲の鍵）。実体の鍵（fnKey）に使う。
//   envDepth：定義した所の範囲の、いちばん内の実体の深さ（無ければ 0）。鍵の深さ（fnDepth、実体の深さの守り）に使う。
//   spread：後置 `~` で撒く項。elements：中身の見える器の要素の種類（§2「中身が見える器」）。
//   shape（A のとき）：中身の形（R24）。{s:'struct', fields:[{name, desc}]}・{s:'list', elem}・{s:'scalar'}（数）。無ければ
//     中身の見えない A。
//     shape のある desc は、いつも elements も持つ。elements は撒く項の門（§3.3 の手順1）が見る「中身に L か未知が
//     見えるか」で、shape から読める答えと食い違わないようにする（elementsOfShape・deepKind）。

const A = () => ({ k: "A" });
const U = () => ({ k: "U" });

// ---- 形（R24・R26） ----
//
// 形は「渡された物の生まれ」を書く。構造体は、全部の行が `名前 : 値` の括りか字下げのブロック（rowsShape）。List は、
// 構築の並び・`,` の並び・2行以上の値の括りか字下げのブロック（1行が1要素、rowsShape）・文字列の字面。数（SCALAR）は
// 長さ1の List と同型。それ以外は中身の見えない A（shape なし）。
// List の要素の desc は長さに依らない（mergeElems）。長さを形に入れると、再帰で長さごとに実体ができ、`f [1 2 3]` と
// `f [1 2]` が別の実体になる（R24「同じ形なら同じ実体」に反する）。

// 器の1つの要素の、深く見た種類（elementKind と同じ答え）。A でも、中身に L か未知が見えれば U。
function deepKind(d) {
  if (!d || d.k !== "A") return d ? d.k : "U";
  if (d.elements) return d.elements.some((k) => k !== "A") ? "U" : "A";
  if (d.shape) return elementsOfShape(d.shape).some((k) => k !== "A") ? "U" : "A";
  return "A";
}
function elementsOfShape(shape) {
  if (shape.s === "scalar") return ["A"];
  if (shape.s === "struct") return shape.fields.map((f) => deepKind(f.desc));
  return shape.elem ? [deepKind(shape.elem)] : [];
}
function withShape(shape) {
  return { k: "A", shape, elements: elementsOfShape(shape) };
}

// 数（R24）：数・文字の字面と、それに値の印（`-`・`!!`・後置 `!`）や値の演算子（段13〜16・19〜22）を当てた物。前置 `!` は
// 入れない（`!_` は恒等射なので、`!x` は `_` か関数で、数にならない。classify の値の印の枝）。
// `[x]≅x` なので長さ1の List と同型で、括りで受ければ名前はその数、`~rest` は同じ要素の List（利用者 2026-10-19
// 「数や `[3]` を `[x ~xs]` に渡したら、長さ1の List（x は 3、xs は空）として分解していい？」に「それでいいはずだよ」）。
// 中身の見えない A（裸の仮引数・適用の結果・`$` の番地）は数と決まっていないので、ここに入れない：器かもしれず、
// 器なら要素に関数が見えるかもしれない。段12（`~` の範囲）は List を作るので数にしない。
// 番地の字面（`0x…`・`NxHHHH`）も入れない。R24 の数は「数・文字の字面」で、§2 の字面の行は番地を数と別に挙げ、
// 型でも番地の字面は `$` が返す値と同じ Address（type_system.md §2 の Atom 内部型）なので、指す先が器かもしれない
// のは `$` の番地と同じである。数と決めると、番地を受けた名前を黙って値と読む（数の確かめ 2026-10-19 の F1）。
// `0r`・`0b` は符号なしの数（UInt）、`0u` は文字（Char）なので数に入れる。
const SCALAR = { s: "scalar" };
const scalarDesc = () => ({ k: "A", shape: SCALAR, elements: ["A"] });
const isScalar = (d) => !!d && d.k === "A" && !d.spread && !!d.shape && d.shape.s === "scalar";
const SCALAR_INFIX_STAGES = new Set([13, 14, 15, 16, 19, 20, 21, 22]);
// 番地の字面（sign.pegjs の address と同じ形）。
const ADDRESS_LIT = /^[0-9]+x[0-9a-fA-F]+$/;

// List の要素の desc。要素の形が全部同じならそれ、全部 A だが形が違えば中身の見えない A、中身に L か未知が見え
// れば U（R24「要素に L が見えたら、名前は未知」。既存の elements が深く見て U にするので、それと揃える）。
function mergeElems(descs) {
  if (!descs.length) return null;
  if (descs.some((d) => deepKind(d) !== "A")) return U();
  const k0 = internDesc(descs[0]);
  return descs.every((d) => internDesc(d) === k0) ? descs[0] : A();
}

function isSpreadNode(t) {
  return !!t && t.t === "leaf" && !!t.desc.spread;
}
function listShapeOf(items) {
  // 撒く項を含む並び（`[vs~ 4]`）の要素は、撒いた器の要素と並べた項が混ざり、要素の位置が数えられない。決めずに
  // 中身の見えない A にする（名前は未知、`~rest` は A）。
  if (items.some(isSpreadNode)) return null;
  return { s: "list", elem: mergeElems(items.map(descOfTree)) };
}
function commaItems(tree) {
  const out = [];
  let t = tree;
  while (t && t.t === "op" && t.sym === ",") {
    out.push(t.left);
    t = t.right;
  }
  out.push(t);
  return out;
}

// 解いた木の中身の形。見えなければ null。
function shapeOfTree(tree) {
  if (!tree || tree.kind.k !== "A") return null;
  if (tree.t === "construct") return listShapeOf(tree.items);
  if (tree.t === "op" && tree.sym === ",") return listShapeOf(commaItems(tree));
  if ((tree.t === "leaf" && tree.cat === "plain" && !tree.desc.spread) || tree.t === "apply") return tree.kind.shape || null;
  return null;
}

// 解いた木を、値として渡したときの desc（構築と `,` の並びは、ここで形と要素を付ける）。
function descOfTree(tree) {
  if (!tree) return U();
  if (tree.t === "construct" || (tree.t === "op" && tree.sym === ",")) {
    const d = { k: "A" };
    const sh = shapeOfTree(tree);
    if (sh) d.shape = sh;
    const el = visibleElements(tree);
    if (el) d.elements = el;
    return d;
  }
  return tree.kind;
}

// 括りか字下げのブロックを解いた行から、中身の形。構造体は、全部の行が「1語の名前 : 値」で、名前が重ならないもの
// （重なれば、どの行の欄か決まらないので中身の見えない A）。欄の desc は右辺の生まれ（R24）。欄と値の混ざった行や
// 枝の行は、構造体とも List とも言えないので中身の見えない A にする。欄の右辺が撒く項（`k : vs~`）なら、欄で受けた
// 名前が撒く項として並びに入ることになり、それはどの言葉にも無いので、構造体ごと中身の見えない A にする（listShapeOf
// の撒く項と同じ）。
// 字下げのブロックも括りと同じに読む：2行以上の値の行は List で、1行が1要素（利用者 2026-10-19「値の行を並べた字下げの
// ブロックを、括りと同じ List（1行が1要素）として受けていい？」に「それでいいよ」）。
function rowsShape(trees) {
  const isField = (t) => !!t && t.t === "op" && t.sym === ":" && !!t.fieldName;
  if (trees.every(isField)) {
    const names = trees.map((t) => t.fieldName);
    if (new Set(names).size !== names.length || trees.some((t) => isSpreadNode(t.right))) return null;
    return { s: "struct", fields: trees.map((t) => ({ name: t.fieldName, desc: descOfTree(t.right) })) };
  }
  if (trees.length === 1) return shapeOfTree(trees[0]);
  if (trees.some((t) => !t || (t.t === "op" && t.sym === ":"))) return null;
  return listShapeOf(trees);
}

// R26：`x ' k` の鍵。字面の整数か裸の名前だけ。裸の名前の鍵は、いつも欄の名前（R26「裸の名前の鍵は、いつも欄の名前
// である」）なので、名前として引かない（引くと、欄の名前に「定義されていません」と出る）。
function pickKeyOf(term) {
  if (!term || term.type !== "atom" || term.pre.length || term.post.length) return null;
  if (term.core.c === "name") return { name: term.core.name };
  if (term.core.c === "lit" && /^[0-9]+$/.test(term.core.text)) return { int: Number(term.core.text) };
  return null;
}
// 引いた物の desc（R26）。構造体＋裸の名前は同じ名前の欄（無ければ未知）、List＋字面の整数は要素。ほかは未知。
function pickDesc(desc, key) {
  if (!desc || desc.k !== "A" || desc.spread || !desc.shape || !key) return U();
  const sh = desc.shape;
  if (sh.s === "struct" && key.name !== undefined) {
    const f = sh.fields.find((x) => x.name === key.name);
    return f ? f.desc : U();
  }
  if (sh.s === "list" && key.int !== undefined) return sh.elem && sh.elem.k === "A" ? sh.elem : U();
  // 数（`5 ' 0`・`[' 0] 3`）からは引かない。R26 の文面は x の形を「R24 の構造体か List」と書き、R24 は数をそのどちらとも
  // 別の行に置く（数を長さ1の List として読むのは、括りで受けるときの文面）。`[x]≅x` から引けると読むかは決めていない
  // ので、未知にする（断る側、数の確かめ 2026-10-19 の F2）。数を `~rest` で受けた物は R24 の List なので、そこからは引ける。
  return U();
}

// ---- 実体の鍵と形の綴り（R24） ----
//
// 実体の鍵は「関数の出どころ・渡された物の desc」の正規の文字列。L の desc は関数の出どころ（書いた `?` の綴りと、
// 定義した所の範囲の鍵）まで入れる——本体の根が違う関数を同じ実体にすると、片方の本体の読みでもう片方を読むことに
// なる。出どころを物の同一性（何番目に見たか）ではなく綴りで持つのは、呼ぶ行と定義の行の順を入れ替えても鍵と
// 並び順が変わらないようにするため（R25：順序に依らない）。同じ綴りで同じ範囲の関数は、本体を解いた答えも同じである。

const writtenCache = new WeakMap();
function lambdaKey(op, scopeKey) {
  let s = writtenCache.get(op);
  if (s === undefined) {
    s = writeTree(op);
    writtenCache.set(op, s);
  }
  return `λ{${s}}@${scopeKey}`;
}

function fnKey(fn) {
  if (!fn) return "?";
  switch (fn.type) {
    case "plain":
      return `plain:${fn.origin}:${fn.n}:${fn.idKey || ""}`;
    case "pattern":
      return fn.bound ? canonKey(internPartial(fn)) : `pattern:${fn.idKey}`;
    case "compose":
      return canonKey(internCompose(fn));
    case "pfPick":
      return `pfPick:${fn.sym}:${fn.key ? JSON.stringify(fn.key) : ""}`;
    default:
      return fn.idKey ? `${fn.type}:${fn.idKey}` : fn.type;
  }
}

// 形は欄どうしで同じ物を指すことがある（`m1 : [p : m0 ⏎ q : m0]`、再帰の `f [p : r ⏎ q : r]`）。鍵を木として綴ると、
// 入れ子の深さ d で 2^d 個の葉を辿り、文字列も 2^d の長さになる（深さ 20 で秒、25 で文字列の長さの上限を超える）。
// だから形は2段で鍵にする。
// 1. internDesc：中身で番号に寄せる（子は番号で書くので、1つの形につき1回だけ見る）。番号が同じ ⇔ 中身が同じ。
//    ハッシュは使わない（違う形が同じ鍵になると、黙って別の実体の答えを返す）。
// 2. canonKey：番号の DAG を深さ優先で綴り、2回目に出た形は `^n`（n 番目に綴った形）で指す。綴りは中身だけで決まる
//    （番号の振り方＝形を見た順に依らない）ので、行の順を入れ替えても鍵と、鍵で決める並び順は変わらない。長さは形の
//    中の違う物の数に比例する。
// 括りの関数の部分適用の L も同じ2段で鍵にする（internPartial）。当てた物に前の部分適用が入ると（`q1 : pp [f : q0]
// [f : q0]`）、当てた物を葉の文字列に綴れば段ごとに倍になり、22 段で文字列の長さの上限を超えた（部分適用の確かめ
// 2026-10-19 の F1）。
// 合成の L も同じ（internCompose）。子の鍵を文字列でつなぐと、同じ部分適用を2つ並べた合成（`c1 : q1 q1`）を当てた
// 部分適用の鎖で段ごとに倍になり、24 段で文字列の長さの上限を超えた（反証 2026-10-19 の続き）。
// 表は resolve を呼ぶたびに作り直す（resetIntern）。
// 番号には、鍵の入れ子の深さ（depth）も持たせる（実体の深さの守り、INSTANCE_DEPTH_LIMIT の注の1）。深さは綴りだけで決まる。
let internTable = new Map(); // 中身の綴り（子は番号）→ 番号
// 番号 → {leaf} | {s:'struct', fields:[[名前, 番号]]} | {s:'list', elem:番号|null} | {s:'partial', base, bound:[番号]}
//   | {s:'compose', fns:[番号], partial}。どれも depth を持つ。
let internNodes = [];
let internByDesc = new WeakMap();
let internByShape = new WeakMap();
let internByFn = new WeakMap();
let canonMemo = new Map();
function resetIntern() {
  internTable = new Map();
  internNodes = [];
  internByDesc = new WeakMap();
  internByShape = new WeakMap();
  internByFn = new WeakMap();
  canonMemo = new Map();
  identTable = new Map([["·", NO_IDENT]]);
  identByDesc = new WeakMap();
  identByShape = new WeakMap();
  identByFn = new WeakMap();
  opSerial = new WeakMap();
  opCount = 0;
}
function internText(text, node) {
  let id = internTable.get(text);
  if (id === undefined) {
    id = internNodes.length;
    internNodes.push(node);
    internTable.set(text, id);
  }
  return id;
}
// 葉の深さは 1。関数の葉は、書いた所の範囲が実体の中なら、その実体の深さに 1 を足す（fnDepth）。綴りに範囲の鍵（＝実体の
// 鍵）が入っているので、同じ綴りの葉は同じ深さになる。
const internLeaf = (text, depth = 1) => internText(text, { leaf: text, depth });
const depthOf = (id) => internNodes[id].depth;
const maxDepth = (ids) => ids.reduce((m, c) => Math.max(m, depthOf(c)), 0);
function internDesc(d) {
  if (!d) return internLeaf("U");
  const memo = internByDesc.get(d);
  if (memo !== undefined) return memo;
  let id;
  if (d.k === "L") id = internFn(d.fn);
  else if (d.k !== "A") id = internLeaf("U");
  else if (d.spread) id = internLeaf("A~");
  // 中身の見えない A。中身に関数か未知が見える器（`A(U)`、頭の注）は、`~rest` の読みが違うので別の鍵にする。
  else if (!d.shape) id = internLeaf(deepKind(d) === "A" ? "A" : "A(U)");
  else id = internShape(d.shape);
  internByDesc.set(d, id);
  return id;
}
function internShape(sh) {
  const memo = internByShape.get(sh);
  if (memo !== undefined) return memo;
  let id;
  if (sh.s === "scalar") id = internLeaf("N");
  else if (sh.s === "struct") {
    const fields = sh.fields.map((f) => [f.name, internDesc(f.desc)]);
    const depth = 1 + maxDepth(fields.map(([, c]) => c));
    id = internText(`{${fields.map(([n, c]) => `${n}:#${c}`).join(" ")}}`, { s: "struct", fields, depth });
  } else {
    const elem = sh.elem ? internDesc(sh.elem) : null;
    id = internText(elem === null ? "[]" : `[#${elem}…]`, { s: "list", elem, depth: elem === null ? 1 : 1 + depthOf(elem) });
  }
  internByShape.set(sh, id);
  return id;
}
// 括りの関数の部分適用の鍵：元の関数の出どころと、当てた物の形。裸の仮引数の位置は A にする——実体の鍵（bindParams）が
// 裸の位置の形を見ないので、そこに何を当てても同じ関数である（R24「裸の仮引数の位置は、形に数えない」。素の関数の部分
// 適用の鍵が当てた物を見ないのと同じ）。数えると、同じ実体が2つ描かれ、再帰では同じ形の実体が入れ子になって G7 に
// なった（部分適用の確かめ 2026-10-19 の F2）。綴りは番号で書く（子と同じ。`(` の中は番号だけなので、後ろの出どころと
// 混ざらない）。
function internPartial(fn) {
  const memo = internByFn.get(fn);
  if (memo !== undefined) return memo;
  const bound = fn.bound.map((d, i) => (fn.base.bareAt[i] ? internLeaf("A") : internDesc(d)));
  const depth = 1 + Math.max(fnDepth(fn.base), maxDepth(bound));
  const id = internText(`P(${bound.map((c) => `#${c}`).join(" ")})${fn.base.idKey}`, { s: "partial", base: fn.base.idKey, bound, depth });
  internByFn.set(fn, id);
  return id;
}
// 合成の鍵：中の関数の鍵を、書いた順に番号で並べる（部分適用と同じく、子は番号）。
function internCompose(fn) {
  const memo = internByFn.get(fn);
  if (memo !== undefined) return memo;
  const fns = fn.fns.map(internFn);
  const id = internText(`C(${fns.map((c) => `#${c}`).join(" ")})${fn.partial ? ":partial" : ""}`, { s: "compose", fns, partial: !!fn.partial, depth: 1 + maxDepth(fns) });
  internByFn.set(fn, id);
  return id;
}
// L の desc の関数の番号。部分適用と合成は中身で番号に寄せ、ほかは fnKey の綴りの葉（短い綴りで決まる）。
function internFn(fn) {
  if (fn && fn.type === "pattern" && fn.bound) return internPartial(fn);
  if (fn && fn.type === "compose") return internCompose(fn);
  return internLeaf(`L<${fnKey(fn)}>`, fnDepth(fn));
}
// 関数の葉の深さ：書いた所の範囲の深さ（envDepth。閉包の鍵は書いた所の範囲の鍵を持つので、その段と同じ）。ファイルの範囲の
// 関数と、範囲を鍵に持たない関数（点なし・頭の前置 `@`・アリティの分からない関数・素の関数の部分適用と穴は元の関数のまま）は 1。
function fnDepth(fn) {
  return Math.max(1, (fn && fn.envDepth) || 0);
}
// 範囲の中の、いちばん内の実体の範囲の深さ（実体の範囲は depth を持つ、instScope）。実体の中でなければ 0。
function envDepth(scope) {
  for (let s = scope; s; s = s.parent) if (s.depth !== undefined) return s.depth;
  return 0;
}
function canonKey(id) {
  const memo = canonMemo.get(id);
  if (memo !== undefined) return memo;
  const seen = new Map();
  const walk = (i) => {
    const node = internNodes[i];
    if (node.leaf !== undefined) return node.leaf;
    if (seen.has(i)) return `^${seen.get(i)}`;
    seen.set(i, seen.size);
    if (node.s === "struct") return `{${node.fields.map(([n, c]) => `${n}:${walk(c)}`).join(" ")}}`;
    if (node.s === "partial") return `L<pattern:${node.base}<${node.bound.map(walk).join(" ")}>>`;
    if (node.s === "compose") return `L<compose(${node.fns.map(walk).join(" ")})${node.partial ? ":partial" : ""}>`;
    return node.elem === null ? "[]" : `[${walk(node.elem)}…]`; // `[]` は要素の無い List（空の文字列の字面）
  };
  const s = walk(id);
  canonMemo.set(id, s);
  return s;
}
function descKey(d) {
  return canonKey(internDesc(d));
}

// 形の綴り（頭の注）。人が読む物なので、max 字を超えたら切って `⋯` を付ける。切った所から先は辿らないので、共有の
// 多い形でも max に比例する手間で済む。
const SHAPE_TEXT_MAX = 400;
function descText(d, max = SHAPE_TEXT_MAX) {
  let out = "";
  let cut = false;
  const put = (s) => {
    if (cut) return;
    if (out.length + s.length > max) {
      out += `${s.slice(0, Math.max(0, max - out.length))}⋯`;
      cut = true;
    } else out += s;
  };
  const walk = (x) => {
    if (cut) return;
    if (!x || x.k === "U") return put("U");
    if (x.k === "L") return put("L");
    if (x.spread) return put("A~");
    if (!x.shape) return put(deepKind(x) === "A" ? "A" : "A(U)");
    const sh = x.shape;
    if (sh.s === "scalar") return put("N");
    if (sh.s === "struct") {
      put("{");
      sh.fields.forEach((f, i) => {
        if (i) put(" ");
        put(`${f.name}:`);
        walk(f.desc);
      });
      put("}");
    } else if (!sh.elem) put("[]");
    else {
      put("[");
      walk(sh.elem);
      put("…]");
    }
  };
  walk(d);
  return out;
}

// 名前を引く（P2・R21）。仮引数・局所の定義・ファイルの定義の順に探し、無ければ未定義。実体の範囲では、仮引数の
// desc（R24 で当てた物）をそのまま返す。
function lookup(name, ctx) {
  let imported = false;
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.descs && s.descs.has(name)) return s.descs.get(name);
    if (s.params && s.params.has(name)) return s.params.get(name) === "bare" ? A() : U();
    if (s.locals && s.locals.has(name)) return U();
    if (s.hasImport) imported = true;
  }
  const def = ctx.F.defs.get(name);
  if (def) return nameKindOf(ctx.F, def);
  if (imported) return U();
  reportUndefined(name, ctx);
  return A();
}

// 名前が `?` の定義（`f : x ? …`・`f : [x ? …]`）を直に指すか。逆適用の右（R12「名前か `?` の括り」）と穴の頭
// （R16）に置けるのは、§3.4 の素の関数（「名前の定義と `?` の括りがあたる」）だけである。別名（`p : inc`・
// `q : [inc]`）を素の関数に数えるかは仕様に書かれていない。数えると、`5 [inc]` は断るのに `q : [inc]` の `5 q` は
// 通る、という食い違いになるので、断る側に揃えた。別名の適用の種類（§3.4 の表）は今のまま、生まれた関数で決める。
function isLambdaName(name, ctx) {
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  const def = ctx.F.defs.get(name);
  return !!(def && def.lambda);
}

// 種類は要らないが、名前を書いた所（`$x`・`@x` など）。未定義なら information だけ出す。
function touchName(name, ctx) {
  let imported = false;
  for (let s = ctx.scope; s; s = s.parent) {
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return;
    if (s.hasImport) imported = true;
  }
  if (!ctx.F.defs.has(name) && !imported) reportUndefined(name, ctx);
}

function reportUndefined(name, ctx) {
  if (!ctx.diag || ctx.F.reported.has(name)) return;
  ctx.F.reported.add(name);
  ctx.diag.push({
    severity: "information",
    reason: "undefined-name",
    name,
    message: `\`${name}\` は定義されていません。値として読み、値は値の段で決めます（§4 R21）。`,
  });
}

// ---- 仮置きの記録（§3.4「再帰は、A と仮置きして一巡し、食い違えばその関数を未知にし、外れた仮置きに頼った答えは確定した値で解き直す」） ----
//
// 種類（素の関数の本体の根・値の定義の種類・括りの関数の実体の本体の根・無名の素の関数の本体の根）は、定義どうしの依りの
// 上の不動点である。本体の根を解いている途中の関数をもう一度引いたら、A と仮置きして返す。その関数の本体の根が A でなければ、
// 仮置きが外れたので、その関数は未知（§3.4）。仮置きを使って出した答え（途中の関数より上で解いた本体の根や、値の定義の
// 種類）は、仮置きが当たったと分かるまで「仮の答え」として覚える。外れたら、その答えに古い（stale）と印を付け、次に読まれた
// ときに、確定した値で解き直す（freshMemo・collectedRoot）。そうしないと、外れた仮置きの上に立った答えが黙って残る。
//
// 前は、外れた仮置きに頼った答えを全部未知に替えていた。依り（deps）は、解いている途中の関数を引いた所より上の枠の全部に
// 付く（根に使ったかは見ない）ので、根に使っていない本体（`g : y ? (f 1 y) , 1`。根は積）まで未知になり、f と g のどちらを
// 先に解くかで g の根が割れた（§5 Q28。f が先なら `g 5 inc` は G2(a)、g が先なら A）。解き直すなら、依りが広くても、
// 増えるのは解き直しの手間だけで、答えは変わらない（利用者 2026-10-20「コンパイルの時間を早めたければ、定義の順序を
// 見直せとも言えるね！」）。依りを根に使った物だけに狭める（Q28 の案(1)）必要は無い。
//
// 印を付けるのは3つの所である。どれが欠けても、外れた仮置きの上に立った答えが残り、定義の順で答えが割れる。
// 1. 外れた枠の名簿（tentatives）にある答え（finishFrame）。
// 2. 当たった枠の名簿にある答えは、その枠が頼った仮置き（枠の deps）を引き継ぐ（finishFrame）。枠が当たったと言えるのは、
//    その枠が頼った下の仮置きも当たったときだけだからである。前は引き継がず、O・M・N の順に枠が積まれ、N が M の仮置きを、
//    M が O の仮置きを使い、M が A で閉じた後で O が外れると、N の答えが古いまま残った（確かめ 2026-10-20 の F1：
//    `h : x ? ⏎ ⇥f x ⏎ ⇥inc`・`f : x ? ⏎ ⇥g x ⏎ ⇥h x`・`g : x ? f x` は、h を f・g より先に置くと `g 5 inc` が A、ほかの並べ方は
//    G2(a)。A の側は黙った誤答。HEAD からある）。
// 3. 例外（門ではない例外。名前の輪など）で抜けた枠の名簿にある答え（abortFrame）。仮置きが当たったか確かめられないから
//    である。前は付けず、namesPattern が輪を握りつぶす道で、仮置きの上で A と出した関数の答えが残った（確かめ 2026-10-20 の
//    Q28V-3：`k : x ? h x` の h が未知なのに、w を v より先に置くと `k 5 inc` が A。HEAD からある）。輪の依りを持つ記録は、
//    根の答えが未知でも印を付ける（「値を含む輪」の注の、例外で抜けた枠）。
//
// 根の答えが未知なら、印を付けず、依りも持たせない（entryOf）。未知はいちばん下で、下の「単調」により、確定した値で解き
// 直しても未知のままだからである。前は未知の答えにも印を付けていたので、解き直しの中で外の枠がまた仮置きされて外れ直し、
// 同じ記録の解き直しが関数の数の指数で増えた（確かめ 2026-10-20 の Q28V-1・F3：f1〜f5 が後ろの f と g を呼び、g が積で
// f1〜f5 を呼ぶ形で、g の解き直しが 31 回。関数 16 個で 65535 回）。値の定義の種類は A・L・U と中身の形を持つので、根と
// 同じ「いちばん下」は言わず、いつも解き直す（値の定義は仮置きされないので、解き直しても外れは増えない）。値を含む輪を
// 断るようにした（§5 Q30、「値を含む輪」の注）後は、値の定義が仮置きを読めば断るので、値の定義の記録は仮置きに頼らず、
// 古くならない（この道は守りとして残す）。
//
// 答えが定義の順に依らない理由（P2「順序には依らない」）：根の種類で答えに効くのは「A か、A でないか」だけ（plainApply・
// instantiate）で、§3.4 の表の行は、引いた根が A のときだけ A を返し、A でなければ未知か門（門に当たった本体の根は未知）に
// する。だから引いた根が A から A でないへ下がっても、どの本体の根も上がらない（単調）。仮置きは A（上）から始め、外れたら
// 確定した値（A でない）で解き直すので、各関数の値は A から一度だけ下がる。下げるのは、上の仮置き（どれも本当の値より
// 下がっていない）のもとでも A にならないと分かった時だけなので、確定した値は、いちばん大きい不動点の値より下がらない。
// 外れた仮置きに頼った答えは、上の3つの印で全部解き直すので、着いた所は不動点である。だから、どの順に解いても、いちばん
// 大きい不動点に着く。解き直しの手間だけが順に依る。
// この理屈は、門が本体と前提の値だけで決まることを使っている。実体の深さの守りは、作る実体の鍵（渡された形）だけで決まる
// 普通の門なので、この理屈の中にある。実体の総数の守りは、確定した実体（最後の木の実体）だけを数えるので、断るかは
// 最後の木だけで決まる。理屈の外に残るのは、止まるための上限（作った実体の全部）だけである（INSTANCE_DEPTH_LIMIT の注、
// §5 Q25）。
//
// 解き直しの手間：外れた記録は未知に下がり、二度と枠を積まないので、各記録の仮置きが外れるのは一度だけである。印は外れか
// 例外のたびにしか付かないので、同じ記録の解き直しは、それまでの外れと例外の数を超えない（外れは記録の数まで）。上の
// Q28V-1 の形は、g の解き直しが関数の数（5 回）で済む。単調でない所（未知を受けると A になる所）があっても、未知の根は
// 解き直さないので、根が上がって振動することは無い（確かめ 2026-10-20 では、単調でない所は見つかっていない）。

// 同じ記録の解き直しの守り（実装の守り。値は言語の規則ではない）。上の「解き直しの手間」により、同じ記録の解き直しは、
// 外れの数（枠を積んだ鍵の数 F.frameKeys まで）と例外の数の和を超えない。例外は名前の輪のような止まる誤りで、続くのは
// namesPattern が握りつぶす所だけなので、鍵の数を超えて解き直すのは、例外が繰り返したか、上の理屈が破れたときである。
// そのときは読みを決めずに、名指しして断る（未知に固定して黙って進めると、断る側でも言い分が別の門になり、理由が見えない）。
// 前は 16 回で未知に固定していたが、未知の答えにも印を付けて解き直しが指数で増えたので、関数5つの普通のプログラムが上限を
// 踏み、定義の順で割れた（確かめ 2026-10-20 の Q28V-1・F2）。
function guardAgain(F, count, label) {
  if (count <= F.frameKeys.size) return;
  const e = new OperationError(
    `${label} の種類を、仮置きが外れたので ${count} 回解き直しました（枠を積んだ記録の数 ${F.frameKeys.size} を超えました）。解き直しが終わるかを決めないので、読みを決めません（§3.4）。`,
    { spec: `${SPEC} §3.4`, reason: "resolve-again-limit" }
  );
  F.againRefused = F.againRefused || e; // namesPattern が握りつぶしても、resolve の最後に断る
  throw e;
}
function recordLabel(F, key) {
  if (key.isInst) return `括りの関数 \`${key.label}\` の実体（形 ${key.shapeText}）`;
  const fn = F.namedLambdas.get(key);
  if (fn) return `関数 \`${fn.name}\``;
  return F.defs.get(key.name) === key ? `定義 \`${key.name}\`` : "名前の無い関数";
}

// 枠：deps は仮置きの依り、cyc は輪の依り（「値を含む輪」の注。読んだ途中の枠から、そこまでの道筋への表）、tentatives・
// cycEntries はそれぞれを持つ記録の名簿。
function pushFrame(F, key) {
  const frame = { key, deps: new Set(), cyc: new Map(), cycEntries: [], consulted: false, failed: false, tentatives: [] };
  F.stack.push(frame);
  F.inProgress.set(key, frame);
  F.frameKeys.add(key);
  return frame;
}
function popFrame(F, frame) {
  const i = F.stack.lastIndexOf(frame);
  if (i >= 0) F.stack.splice(i, 1);
  F.inProgress.delete(frame.key);
}
// 例外で抜けた枠（「仮置きの記録」の注の3）。この枠を輪の依りに持つ記録は、未知でも古いと印を付ける（「値を含む輪」の注の、
// 例外で抜けた枠）。
function abortFrame(F, frame) {
  popFrame(F, frame);
  for (const t of frame.cycEntries) {
    if (!t.cyc.has(frame)) continue;
    t.cyc.delete(frame);
    t.stale = true;
  }
  for (const t of frame.tentatives) {
    t.deps.delete(frame);
    if (t.value !== "U") t.stale = true;
  }
  // この枠に頼って作った実体は、外れたのと同じに扱う（INSTANCE_DEPTH_LIMIT の注の3）。
  if (frame.pendingCalls) settlePending(F, frame, true, []);
}
// 解いている途中の枠 target の仮置きを読む。via は、記録を通して読んだときの、その記録から target までの道筋（一歩の
// 綴りの配列を返す関数。言い分を作るときだけ呼ぶ）。
// target より上に値の定義の枠があれば、仮置きで閉じずに断る（「値を含む輪」の注）。
function consult(F, target, via) {
  const i = F.stack.indexOf(target);
  if (i >= 0) for (let j = i + 1; j < F.stack.length; j++) if (F.stack[j].isValue) throw cycleError(F, i, via);
  target.consulted = true;
  if (i < 0) return;
  addCycle(F, i, target, via, true);
}
// 記録の輪の依りにある、解いている途中の枠 target を通る（「値を含む輪」の注の輪の依り）。consult と同じく、target より上に
// 値の定義の枠があれば断るが、仮置きの依りには入れない（解き直しは今までどおり）。
function passThrough(F, target, via) {
  const i = F.stack.indexOf(target);
  if (i < 0) return;
  for (let j = i + 1; j < F.stack.length; j++) if (F.stack[j].isValue) throw cycleError(F, i, via);
  addCycle(F, i, target, via, false);
}
// target（枠の並びの i）より上の枠と無名の関数の本体に、target への依りを足す。輪の依りには、そこから target までの道筋
// （上の一歩と via）も覚える（言い分の道筋。記録を通して見つけた輪でも、記録の中の段を抜かさない）。
function addCycle(F, i, target, via, tentative) {
  const chain = chainFrom(F, i);
  for (let at = 1; at < chain.length; at++) {
    const s = chain[at];
    if (tentative) s.deps.add(target);
    if (!s.cyc.has(target)) s.cyc.set(target, () => [...chain.slice(at + 1).map((u) => stepText(F, u)), ...(via ? via() : [])]);
  }
}
// 枠の並びの i から上の一歩：枠と、その間で解いている無名の素の関数の本体（beginCollect。枠を積まない）を、呼んだ順に。
function chainFrom(F, i) {
  const inner = F.collectors.filter((c) => c.start > i);
  const chain = [];
  for (let j = i; j < F.stack.length; j++) {
    chain.push(F.stack[j]);
    for (const c of inner) if (c.start === j + 1) chain.push(c);
  }
  return chain;
}

// ---- 値を含む輪（§5 Q30） ----
//
// 値の定義の種類を解いている途中に、その外側（枠の並びで下）で解いている途中の枠を仮置きで読んだら（consult）、輪に値の
// 定義が入っている。外側の枠の計算から値の定義へ入ったのだから外側はこの値に頼り、この値は外側を読んだのだから外側に
// 頼るからである。だから仮置きで閉じずに、名前の輪（name-cycle）で断る。値の定義から入った輪（nameKindOf の「解いている
// 途中」）と同じ断りで、どこから入っても同じ答えになる。
// 前は、値の定義から入れば断り、関数から入れば仮置きで閉じていた。`a : f 1`・`v : f 1`・`f : x ? v` は、v が先なら
// name-cycle、a が先なら f の仮置きで輪が閉じて、v が自分に頼っているのが見えず、黙って通った（§5 Q30）。v = f 1 = v で、
// 値はいつまでもできない（主の Claude「本当の欠陥は a が先だと通ってしまうほう」、利用者 2026-10-20「明らかにそうだと思う」）。
// 解決器の役目は、意味を決めることではなく、書いた人が見落とした輪（長い輪）を、入口に依らずに必ず見つけて、輪の道筋を
// 名指しすることである（利用者 2026-10-20「エンジニアかAIなら、書いていて気付くと思うし、それに気づきやすい言語だと
// 思ってるんだ」）。だから言い分に、輪に入っている枠を並べて書く（cycleError）。
// 輪に値の定義が無い物（関数どうしの再帰・括りの関数の実体の輪）は、今までどおり A と仮置きして閉じる（§3.4）。`$` で
// 遅らせた名前（`f : x ? x , $v`）は種類を引かない（touchName。前置 `@`・前置 `~` の名前も同じ）ので、輪に数えない（今の
// まま。この片では扱わない）。
// 名前が括りの関数かを覗く所（namesPattern。既定値と1項の `:` の左は解かない（P3）ので、G7 を探すためだけに名前の種類を
// 引く）のうち、既定値を覗いた所を通る輪は輪に数えない（値はできる。namesPattern の注）。
// 値の定義の記録は、これで仮置きに頼らない（仮置きを読めば断るので、記録の依りは空のまま）。だから値の定義の記録が古く
// なることも無い（freshMemo の値の定義の道は、守りとして残す）。
//
// 輪の依り（cyc）。仮置きの依り（deps）は解き直しのための物で、根の答えが未知の記録には持たせない（entryOf。未知は解き
// 直さない）。だが輪を見つけるには、未知の記録も、計算の途中で読んだ解いている途中の枠を覚えていなければならない。覚えないと、
// 輪を値の定義の無い所で先に閉じ、閉じた関数の答えが未知だったとき、後で値の定義がその記録を読んでも、解いている途中の外の
// 枠を通ったことが見えない（`a : g 1`・`g : x ? ⏎ ⇥k x ⏎ ⇥vk`・`k : x ? ⏎ ⇥g x ⏎ ⇥k x ⏎ ⇥inc`・`vk : k 1` は、vk が先なら
// name-cycle、a が先なら k が未知で閉じて黙って通った。上の規則だけでは直らず、HEAD からある。2026-10-20 の確かめで、生成器の
// 4 万本のうち 9 本が、上の規則だけでは入口で割れた。1本は通る並べ方があった）。
// だから記録は、仮置きの依りとは別に、輪の依り（計算の途中で読んだ、解いている途中の枠。仮置きの依りを含む）を持ち、読む
// ときに通る（passThrough）。輪の依りは、値の定義の枠より下の枠を通れば断るためだけに使い、仮置きの依りには入れない。古い
// という印（stale）に使うのは、下の「例外で抜けた枠」だけで、そこでも未知を未知に解き直すだけである。だから断らないプログラム
// の答えは、輪の依りを足す前と同じである。閉じた枠の輪の依りは、その枠を
// 読んだ記録が引き継ぐ（finishFrame。「仮置きの記録」の注の2と同じ理由：記録 → 閉じた枠 → その枠が読んだ途中の枠）。
// 輪の依りは、途中の枠までの道筋も覚える（addCycle・finishFrame）。記録を通して見つけた輪の言い分に、記録の中の段（記録が
// 閉じる前に通った枠と、引き継いだ枠）を書くためである。前は記録の持ち主の1歩しか書かず、入口で言い分が替わり、無い辺を
// 名指しした（確かめ 2026-10-20 の Q30-V2：`a : g 1`・`g : x ? ⏎ ⇥m x ⏎ ⇥vk`・`m : x ? k x`・`k : x ? g x`・`vk : m 1` は、
// a が先なら「`vk` → `m` の本体 → `g` の本体」で、m の本体は g を引かない）。
//
// 例外で抜けた枠（abortFrame）。例外で抜けた枠は閉じないので、その枠を輪の依りに持つ記録へ、その枠が読んだ途中の枠を
// 引き継がない。未知の記録は古いと印を付けない（「仮置きの記録」の注）ので、そのままだと、輪の依りの欠けた記録が残る。
// 今それが起きるのは、namesPattern が例外（既定値を覗いた所を通る名前の輪と、名前の輪でない止まる誤り）を握りつぶすとき
// だけである（覗いた定義から上の枠が抜ける）。
// `a : g 1`・`g : x ? [[y : v 2] ? 5] x`・`v : h 1`・`h : x ? ⏎ ⇥k x ⏎ ⇥g x ⏎ ⇥vk ⏎ ⇥inc`・`k : x ? ⏎ ⇥h x ⏎ ⇥inc`・`vk : k 1` は、
// a が先なら、覗いた v の中で k が h を読んで未知で閉じ、h の行 `g x` が覗いた所を通る輪で抜ける。後で vk が k の記録を読んでも
// h を通ったことが見えず、vk → k → h → vk の輪が黙って抜けた（7 文の並べ方 5040 のうち 1680）。だから、例外で抜けた枠を
// 輪の依りに持つ記録には、未知でも古いと印を付け、次に読まれたときに解き直す。未知の記録を解き直しても、「仮置きの記録」の
// 注の「単調」により未知のままなので、答えは変わらない（変わるのは、輪を見つけるかだけ）。
//
// 残る割れ（§5 Q30 の未決、HEAD から）：輪を閉じる道が、仮置きの上でだけ通る形。`pb : [y ~ys] ? y + 1`・`g : x ? ⏎ ⇥pb [k x]
// ⏎ ⇥ek`・`k : x ? pb [g x]`・`ek : k 1`・`pf : g 1` は、ek が先なら k の仮置き（A）の上で g の本体が行 `ek` まで進んで
// name-cycle、pf が先なら確定した k（未知）で g の本体が1行目の G7 に当たり、行 `ek` を読まないので輪が無い。どちらも断る
// （黙った誤答ではない）が、言い分が入口で割れる。確定した値の上では輪が無いので、輪を見つけた道が仮置きに頼ったかまで見て
// 断りを遅らせるか、書いた名前だけで輪を見るか（`$` の無い名前。呼ばれない関数の値を欄に入れた `v : [s : p]` まで断る）は、
// 決めていない。

// 輪の言い分。輪は枠の並びの i から上の全部（i の計算が上の枠を順に呼び、いちばん上が i を読んだ）で、via があれば
// その記録（記録の持ち主と、記録が覚えた道筋）を通して i へ戻る。無名の素の関数の本体（枠を積まずに解く、collectedRoot）も、その間に挟む。書き始めは、輪の
// 中の値の定義のうち、ファイルに先に書いた物にする（同じ輪なら、どこから入っても言い分が替わらない）。
// 言い分を作ったら覚え（F.cycleRefused）、握りつぶされても resolve の最後に断る（guardAgain の againRefused と同じ作り）。
function cycleError(F, i, via) {
  const steps = chainFrom(F, i).map((s) => ({ text: stepText(F, s), def: s.isValue ? s.key : null }));
  if (via) for (const text of via()) steps.push({ text, def: null });
  let at = steps.findIndex((s) => s.def);
  for (const d of F.defs.values()) {
    const k = steps.findIndex((s) => s.def === d);
    if (k >= 0) {
      at = k;
      break;
    }
  }
  const ring = [...steps.slice(at), ...steps.slice(0, at)];
  const path = [...ring, ring[0]].map((s) => s.text).join(" → ");
  const e = nameError(
    "name-cycle",
    `定義 \`${ring[0].def.name}\` の種類が、並びを通して自分の種類に依っています（輪：${path}）。輪に値の定義があるので、その値はいつまでもできません（§5 Q30）。`
  );
  e.cycle = ring.map((s) => s.text);
  e.cycleFrom = i; // 輪のいちばん下の枠（namesPattern が、覗いた所を通る輪かを見る）
  F.cycleRefused = F.cycleRefused || e;
  return e;
}
// 輪の道筋の一歩（枠の持ち主か、枠を積まない無名の素の関数の本体）。
function stepText(F, frame) {
  if (!frame.key) return frame.label || "名前の無い関数の本体";
  const k = frame.key;
  if (frame.isValue) return `\`${k.name}\``;
  if (k.isInst) return `\`${frame.label || k.label}\` を形 ${cutShape(k.shapeText)} で呼んだ実体の本体`;
  const fn = F.namedLambdas.get(k);
  if (fn) return `\`${fn.name}\` の本体`;
  return k.label || "名前の無い関数の本体";
}
function cutShape(text) {
  return text.length > 60 ? `${text.slice(0, 60)}…` : text;
}

// 無名の素の関数（`[w ? f [1 2]]`）の本体の根。名前の無い関数は自分を引けないので枠（pushFrame）は積まないが、本体を
// 解いている間に引いた仮置き（解いている途中の外の関数）は覚える（collector）。根は閉包で関数の desc に乗り、欄として
// 別の括りの関数の実体へ渡る。仮置きを覚えずに `() => root` で持つと、仮置きが外れても根が古いまま残り、それを読んだ
// 実体の答え（instMemo）も古いまま残る。行の順で、同じ関数が通ったり G7 になったりした（確かめ 2026-10-19 の A-F1）。
// 覚えた仮置きは名前つきの関数の根（bodyRootOf）と同じく記録に載せ、読むたびに consult する（readMemo）。
// 名前が無いので記録の地図（bodyMemo）には載らない。だから記録は閉包が持ち、本体を同じ範囲で解き直す手段（again）も持つ。
// 仮置きが外れて古くなったら、読まれたときに枠を積んで解き直す（bodyRootOf と同じく根だけ。枠を積むので F.stack は空に
// ならず、実体の木（materialize）も呼んだ記録（recordCall）も作らない。門に当たれば未知）。解き直している途中に、ほかの
// 関数の本体（欄で受けた実体など）を通ってまた読まれたら、bodyRootOf と同じく A と仮置きする（§3.4。枠を積み直すと、
// 同じ鍵の枠が2つ積まれ、内の枠を閉じたときに外の枠が解いている途中の印から消える）。
// label は輪の道筋に書く一歩（cycleError。無名の関数は書いた所で名指しする）。
function beginCollect(F, label) {
  const c = { start: F.stack.length, deps: new Set(), cyc: new Map(), label };
  F.collectors.push(c);
  return c;
}
function endCollect(F, c) {
  const i = F.collectors.lastIndexOf(c);
  if (i >= 0) F.collectors.splice(i, 1);
}
function collectedRoot(F, c, value, again) {
  const live = (d) => F.stack.includes(d);
  const cell = { entry: entryOf(value, [...c.deps].filter(live), [...c.cyc].filter(([d]) => live(d))), count: 0, label: c.label };
  for (const d of cell.entry.deps) d.tentatives.push(cell.entry);
  for (const d of cell.entry.cyc.keys()) d.cycEntries.push(cell.entry);
  const memo = { set: (_, entry) => (cell.entry = entry) };
  // 解き直しで本体が門に当たったら、読んだ側の枠の後ろは最後の木の道に無い（木では、書いた所で本体が門に当たる。
  // INSTANCE_DEPTH_LIMIT の注の2。instantiate の、門に当たる実体を呼んだ所と同じ）。
  const gate = (root) => {
    if (cell.gated && F.stack.length) F.stack[F.stack.length - 1].gated = true;
    return root;
  };
  return () => {
    const running = F.inProgress.get(cell);
    if (running) {
      consult(F, running);
      return "A";
    }
    if (!cell.entry.stale) return gate(readMemo(F, cell.entry, () => cell.label));
    guardAgain(F, ++cell.count, "名前の無い関数");
    const frame = pushFrame(F, cell);
    let root;
    let gated = false;
    try {
      root = again();
    } catch (e) {
      if (!isGate(e)) {
        abortFrame(F, frame);
        throw e;
      }
      root = "U";
      gated = true;
    }
    cell.gated = gated || !!frame.gated;
    finishFrame(F, frame, memo, root);
    return gate(root);
  };
}
// owner は記録の持ち主（輪の道筋に書く一歩を返す関数）。記録から途中の枠までの道筋は、持ち主の一歩と、記録が覚えた道筋。
function readMemo(F, entry, owner) {
  const via = (d) => () => [owner(), ...(entry.cyc.has(d) ? entry.cyc.get(d)() : [])];
  for (const d of entry.deps) consult(F, d, via(d));
  for (const d of entry.cyc.keys()) if (!entry.deps.has(d)) passThrough(F, d, via(d));
  return entry.value;
}
// 記録を引く。古ければ記録を消して null を返し、呼んだ側が解き直す（そのときには、外れた仮置きの関数の記録は確定して
// いる）。解き直しの回数は guardAgain が見る。
function freshMemo(F, memo, key) {
  const entry = memo.get(key);
  if (!entry || !entry.stale) return entry || null;
  memo.delete(key);
  const n = (F.againCounts.get(key) || 0) + 1;
  F.againCounts.set(key, n);
  guardAgain(F, n, recordLabel(F, key));
  return null;
}
// 記録。根の答えが未知なら依りを持たせない（「仮置きの記録」の注：未知は解き直さない。読んだ側にも依りを渡さない）。
// 輪の依り（cyc、「値を含む輪」の注）は、未知でも持たせる。
// cyc は [途中の枠, そこまでの道筋] の並び。
function entryOf(value, deps, cyc) {
  return { value, deps: new Set(value === "U" ? [] : deps), cyc: new Map(cyc) };
}
// 枠を閉じて記録に載せる（「仮置きの記録」の注の1・2）。この枠の仮置きが外れたら（failed）、それに頼った答えに古いと印を
// 付ける（解き直しは読まれた時）。当たったら、それに頼った答えは、この枠が頼った仮置きを引き継ぐ。
function finishFrame(F, frame, memo, value) {
  popFrame(F, frame);
  const entry = entryOf(
    value,
    [...frame.deps].filter((d) => d !== frame),
    [...frame.cyc].filter(([d]) => d !== frame)
  );
  memo.set(frame.key, entry);
  for (const d of entry.deps) d.tentatives.push(entry);
  for (const d of entry.cyc.keys()) d.cycEntries.push(entry);
  // 輪の依りは、当たっても外れても引き継ぐ（記録はこの枠の答えを読んだので、この枠が読んだ途中の枠も通っている）。道筋は、
  // 記録からこの枠まで、この枠の一歩、この枠からその途中の枠まで。
  for (const t of frame.cycEntries) {
    const toFrame = t.cyc.get(frame);
    if (!toFrame) continue;
    t.cyc.delete(frame);
    for (const [d, toD] of entry.cyc) {
      if (t.cyc.has(d)) continue;
      t.cyc.set(d, () => [...toFrame(), stepText(F, frame), ...toD()]);
      d.cycEntries.push(t);
    }
  }
  for (const t of frame.tentatives) {
    t.deps.delete(frame);
    if (t.stale || t.value === "U") continue;
    if (frame.failed) {
      t.stale = true;
      continue;
    }
    for (const d of entry.deps) {
      if (t.deps.has(d)) continue;
      t.deps.add(d);
      d.tentatives.push(t);
    }
  }
  // この枠に頼って作った実体（INSTANCE_DEPTH_LIMIT の注の2・3）。外れたら作った実体の数から外し、当たったら、この枠が頼った
  // 仮置きに頼り直す。外れたかは仮置きの記録と同じ（読まれて A でない）。最後に置く（総数の門に当たっても、記録は済んでいる）。
  if (frame.pendingCalls) settlePending(F, frame, frame.failed || (frame.consulted && value !== "A"), entry.deps);
}

// 名前の種類（§2「ファイルの定義の名前」）。`?` なら L、それ以外は右辺を解いた根の種類。値なら中身の形も持つ（R24：
// 名前を通して渡しても、生まれは右辺のもの）。
function nameKindOf(F, def) {
  if (def.lambda) {
    if (def.pattern) return { k: "L", fn: patternFn(F, def.lambda, def.pattern, F.fileScope, def.name) };
    if (!def.plain) return { k: "L", fn: { type: "other" } };
    return {
      k: "L",
      fn: { type: "plain", origin: "plain", n: def.n, getBodyRoot: () => bodyRootOf(F, def.lambda), idKey: lambdaKey(def.lambda, F.fileScope.key) },
    };
  }
  const memo = freshMemo(F, F.valueMemo, def);
  if (memo) return readMemo(F, memo, () => `\`${def.name}\``);
  // 解いている途中の値の定義をもう一度引いた：値を含む輪（「値を含む輪」の注）。輪はその枠から上の全部。
  const running = F.inProgress.get(def);
  if (running) throw cycleError(F, F.stack.indexOf(running));
  const frame = pushFrame(F, def);
  frame.isValue = true; // 値の定義の枠（consult が、この枠より下の仮置きを読ませない）
  let value;
  try {
    const root = resolveTree(def.rhs, { F, scope: F.fileScope, diag: null });
    value = { k: root.kind.k, fn: root.kind.fn };
    const el = visibleElements(root);
    if (el) value.elements = el;
    const sh = shapeOfTree(root);
    if (sh) value.shape = sh;
  } catch (e) {
    abortFrame(F, frame);
    throw e;
  }
  finishFrame(F, frame, F.valueMemo, value);
  return value;
}

// 素の名前つき関数の、本体の根の種類（§3.4）。
function bodyRootOf(F, lambdaOp) {
  const memo = freshMemo(F, F.bodyMemo, lambdaOp);
  if (memo) return readMemo(F, memo, () => `\`${F.namedLambdas.get(lambdaOp).name}\` の本体`);
  const running = F.inProgress.get(lambdaOp);
  if (running) {
    consult(F, running);
    return "A";
  }
  const frame = pushFrame(F, lambdaOp);
  let value;
  try {
    const ctx = { F, scope: F.fileScope, diag: null };
    const lam = makeLambda(lambdaOp, ctx);
    value = resolveBody(lambdaOp.right, { ...ctx, scope: lam.scope }).rootKind;
  } catch (e) {
    if (!isGate(e)) {
      abortFrame(F, frame);
      throw e;
    }
    value = "U"; // 本体が門に当たる。根は決まらない（行を解くときに同じ門で断る）
  }
  if (frame.consulted && value !== "A") {
    value = "U";
    frame.failed = true;
  }
  finishFrame(F, frame, F.bodyMemo, value);
  return value;
}

// ---------------------------------------------------------------------------
// 括りの関数の実体（R24・R25）
// ---------------------------------------------------------------------------
//
// 括りの関数の本体の読み（適用か構築か）は、渡された物の生まれで決まる（R24）。だから本体は、呼ばれて形が決まった
// ときにだけ、形ごとに解く（実体）。定義の所では解かない（R25）。呼ばれる前に読みを1つに決めるのは、関係より先に
// 対象を定めることで、`__` の短絡と同じ誤りになる。一度も呼ばれない関数は `_` と同型で、矛盾ではないので断らない。
//
// 実体は2段で解く。素の関数の本体（bodyRootOf と、定義の行を解くとき）と同じ分け方である。
// 1. 根の種類（instRootOf）：再帰は A と仮置きして一巡し、食い違えば未知（§3.4・R24）。門に当たれば未知にして
//    止めない。仮置きの上で解いた木は、仮置きが外れると黙って違う木になるので、ここでは木を残さない。
// 2. 木（materialize）：解いている途中の種類が無い（F.stack が空）ときに、仮置きの済んだ答えで本体をもう一度解き、
//    木か門を残す。門に当たった実体は、呼んだ行で断る（R25）。呼んだ所が別の実体の本体の中なら、その実体も同じ門で
//    失敗し、いちばん外の呼んだ行で1回だけ、関数の名前と形を足して投げ直す。
//    分け合った実体を、まだ歩いていない物（callIdent）で呼んだら、本体をその物で歩き直して記録だけを足す（walkCalls）。
//
// 定義の行の木（`(inst 形 本体)` の並び）は、ファイルの全部の行を解き終えてから埋める（resolve の最後）。だから
// 呼ぶ行が定義の前でも後でも、定義の行の木は同じになる。行を前もって全部解いて実体を集める段は要らない。
//
// 実体（の答え）は鍵（書いた `?` の綴り・範囲・渡された物の形）で共有するが、定義の行に描くのは、その `?` を
// 通って呼ばれた実体だけにする（F.calls、recordCall）。同じ綴りの別の関数の呼び出しで描くと、呼ばれていない関数の
// 行に inst が出て、R25 の「一度も呼ばれない括りの関数は defer」が破れる。逆に、分け合った実体の本体の中の呼び出しを
// 作った側の物でしか記録しないと、呼ばれた方の行が defer のまま残る（呼んだ物の同一性、callIdent の注）。門の名指しも、
// 呼んだ行で使った関数の名前にする（instanceError）。実体を最初に作った関数の名前にすると、ほかの行の有無で名指しが変わる。

// 形を変えながら自分（か、自分を呼ぶ関数の輪）を呼び続ける再帰（`f : [x ~xs] ? f [xs xs]`）は、実体が有限に収まら
// ない。名指しせずに未知や仮置きのまま止めると黙って違う木になるので、守りに当たったら読みを決めずに断る。守りは4つある。
// 1と2は実体の鍵（渡された形）と確定した答えだけで決め、枠の積み方や作った実体の履歴では決めない。だから当たるかは、
// ほかの門と同じく本体と前提の値だけで決まり、「仮置きの記録」の理屈（どの順に解いても同じ不動点に着く）の中にある。
// 3と4は止まるための資源の守りで、計算の道で決まる（理屈の外。別の reason で断る）。
// どの守りも、当たったら門として投げる（根の種類を解く所では未知になり、そこから先は浅く止まる）。1 は普通の門で、呼んだ行
// で名指しする。2〜4 は覚えて（guardRefusal）、resolve の最後に、ほかの門より先に断る（値を含む輪と解き直しの守りの後）。
//
// 1. 深さ（INSTANCE_DEPTH_LIMIT）：作る実体の鍵の入れ子の深さ（instanceDepth）がこの数を超えたら、その実体を作らずに
//    G7 で断る。根の種類を解く所（instRootOf）では未知になり、木を残す段（materialize）が同じ鍵にまた当たって、呼んだ行で
//    名指しする（R25）。深さは鍵の綴りだけで決まる（番号に持たせる、depthOf）ので、どの定義・行から先に解いても、記録を
//    引いても同じになる。
//    数え方：中身の見えない A・未知・数の葉は 1、構造体と List は中身のいちばん深い物に 1 を足す。関数の葉は、書いた所の
//    範囲の深さ（実体の中で書いた閉包の鍵は、書いた所の範囲の鍵＝実体の鍵を持つ。fnDepth）で、ファイルの範囲なら 1。括りの
//    関数の部分適用と合成は、元の関数と当てた物（裸の仮引数の位置は A）・中の関数のいちばん深い物に 1 を足す。素の関数の
//    部分適用と穴は、元の関数と同じ（鍵に当てた物が入らない）。門で見る実体の深さは、括りの仮引数に当てた物のいちばん深い物
//    （裸の仮引数は A なので 1）。関数を書いた所の深さは入れない（書いた所の実体は、その実体の門で見てある）。実体の範囲の
//    深さ（中で書く閉包の深さ）は、当てた物の深さと、書いた所の範囲の深さの大きい方。
//    `f : [x ~xs] ? f [xs xs]` は形が1段ずつ深くなり、`f : [s] ? f [s : [y ? s y]]` は閉包が前の実体の中で書かれるので鍵が
//    1段ずつ深くなって断る。減っていく形の再帰（入れ子の字面を1段ずつ剥がす）は、初めの形の深さで決まる：32 段の入れ子の
//    字面（深さ 33）は最初の呼び出しで断り、31 段（深さ 32）は通る。再帰でなくても、渡した物の鍵が上限より深ければ断る
//    （鍵だけで決めるので、通る形と区別しない。閉包を欄に入れて次の関数へ渡す鎖も、閉包が前の実体の鍵を持つので深くなる）。
//    値だけを渡す別々の関数の鎖（`p1` が `p2` を、`p2` が `p3` を…呼ぶ）や、素の関数を挟む鎖（`f0 : x ? hb [s : f1]`…）、
//    形の深くならない輪（欄の入れ替え）は当たらない。
//    前は同じ `?` の実体の入れ子を数え、どの順に解いても同じ段になるよう数え直していた（枠の並びの数え方・記録の下の
//    入れ子・輪の頭の段・当たった記録を resolve の最後に断る作り。2026-10-20 の自己点検の SC-1・SC-2）。それでも輪の中は
//    近似で、上限のちょうど上では入口で割れえたうえ、当たるかが枠の積み方で決まるので、理屈の外に置いていた。
//    穴（前から、§5 Q25 の未決）：合成の子の合成は開く（R8）ので、同じ合成を2つ並べて渡す再帰（`f : [g] ? f [g : g g]`）は、
//    合成の中の関数の数が倍々になっても深さが増えない。総数の上限に届く前に鍵の長さが溢れ、内部の例外になる。
// 2. 総数（INSTANCE_TOTAL_LIMIT）：深さに上限があっても、形が枝ごとに増えると実体は 2^深さ になり、解決が止まらない。同じ
//    `?`（書いた所。どの範囲で書いた物も1つ）を通って呼んだ、確定した実体の数がこの数を超えたら G7 で断る。同じ綴りの関数は
//    実体を分け合うが、呼んだ `?` のそれぞれで数える（綴りで数えると、別々に書いた2つの関数が上限を分け合った。確かめ
//    2026-10-20）。確定した実体とは、最後の木の道にあると言える呼び出しの実体である（noteCall）：呼んだときに、解いている途中の
//    どの枠も仮置きに頼っておらず（pendingNow）、門に当たる実体を呼んだ後でもない（gated）物、頼っていた枠が全部当たって閉じた
//    物（settlePending）、枠が空のとき（木を残す段）に呼んだ物。確定した値だけを読んで辿った道は木を残す段がもう一度辿るので、
//    どれも最後の木の実体である。門に当たる実体を呼んだ後ろは、木を残す段がそこで呼んだ行ごと断るので、最後の木に無い（根の
//    種類を解く所は、門を未知にして先へ進む）。外れた仮置きの上でだけ作った実体も、確定した値の上では作られないので数えない。
//    だから断るのは「最後の木の実体の数が上限を超える」ときで、どの順に解いても同じになる。前は作った実体の全部を数えたので、
//    上限の前後で断るかが定義の順で割れた（`g : x ? ⏎ ⇥f x ⏎ ⇥inc` と `f : x ? p [s : (g x)]` に、p の実体を 511 個作る行を
//    足すと、g が先なら仮置きの上の p|{s:A} も数えて G7、f が先なら通る。§5 Q25 の SC-3）。門に当たる実体の後ろの実体も数えて
//    いたので、`t : x ? (bad [y : 1]) , (p [m : 1])` と p の実体を 512 個作る行は、行の順で G5 と総数の G7 に割れた（前の版も）。
//    枝ごとに形が増える再帰（`g : [x ~xs] ? (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])`）は、最初の枝を深さ優先で降りて
//    深さの門に当たるので、最後の木はそこで断る形で、残りの枝は最後の木に無い。だから 3 で断る。
// 3. 作った実体の数（INSTANCE_WORK_LIMIT）：2 で数えない実体（仮置きに頼った物と、門に当たる実体の後ろの物）は、増え続けても
//    2 では止まらない（`g : [x ~xs] ? (g xs) , (g [[a : xs] [a : xs]]) , (g [[b : xs] [b : xs]])` は、同じ形で自分を引いた後なので、
//    後ろの実体はどれも g の仮置きに頼る）。だから同じ `?` で作って外れていない実体（確定した物と、まだ仮置きに頼っている物と、
//    門の後ろの物）にも 2 の 2 倍の上限を置く（instance-work-limit）。頼っていた枠の仮置きが外れたら、その実体は数から外す
//    （discard）。外さないと、外れた仮置きの世界ごとに実体が積み増し、上限の前後で定義の順で割れた（f が g と h の仮置きの上で
//    同じ p の実体を 342 個ずつ作り、g → h → f の順に解く並べ方だけ 1026 個で断る。確かめ 2026-10-20）。外した後に残る割れは、
//    まだ外れると分かっていない仮置きの上の実体と門の後ろの実体が、同時に 2 との差（512 個）を埋めるときである（§5 Q25 の未決）。
// 4. 入れ子の数（INSTANCE_NEST_LIMIT）：形が深くならないまま、解いている途中の実体が長く入れ子になる再帰（欄 7 つの並べ替え。
//    形は 5040 通り）や、それを関数を跨いで呼び合う再帰は、JS のスタックを溢れさせ、解き直しと輪の記録（仮置きの依り・輪の依り）
//    の手間も入れ子の長さの2乗ほどで増えた（前の深さの守り「同じ `?` の実体の入れ子 32」を外した後。確かめ 2026-10-20）。だから、
//    根の種類を解いている実体と木を解いている実体の入れ子の数に上限を置く（instance-nest-limit。1段が 1.3KB ほどで、node の
//    既定のスタックでも収まる）。入れ子の長さは、先に作った実体の記録を引くかで変わるので、上限の前後では定義の順で割れうる
//    （§5 Q25 の未決。値だけを渡す別々の関数でも 257 段の鎖は断る。前の版は数千段まで通し、並べ方によってスタックが溢れた）。
//    実体1段の本体が重い（括弧の深い入れ子）と、上限の内でもスタックが溢れる。そのときは内部の例外にせず、資源の守りとして断る
//    （resolve-stack-limit、stackRefusal。どこで溢れるかは、同じプロセスで前に何を解いたかでも変わる）。
// どの値も言語の規則ではなく実装の守りで、値は決めていない。
const INSTANCE_DEPTH_LIMIT = 32;
const INSTANCE_TOTAL_LIMIT = 512;
const INSTANCE_WORK_LIMIT = 2 * INSTANCE_TOTAL_LIMIT;
const INSTANCE_NEST_LIMIT = 256;

// 作る実体の門で見る鍵の深さ（注の1）：括りの仮引数に当てた物のいちばん深い物（裸の仮引数は A なので数えない）。関数を
// 書いた所の深さは入れない（書いた所の実体は、その実体の門で見てある。入れると、深い実体の中で書いた `[[b] ? b] [1]` まで
// 断る）。params と argDescs は bindParams と同じ。
function instanceDepth(params, argDescs) {
  let depth = 1;
  params.forEach((p, i) => {
    if (p.kind !== "bare") depth = Math.max(depth, depthOf(internDesc(argDescs[i])));
  });
  return depth;
}
function depthGate(label, shapeText, depth) {
  const e = gate(
    "G7",
    `括りの関数 \`${label}\` を形 ${cutShape(shapeText)} で呼ぶと、渡した物の鍵の入れ子（形と、欄の関数を書いた所の実体の鍵）が ${INSTANCE_DEPTH_LIMIT} 段を超えます（${depth} 段）。形を変えながら自分か、自分を呼ぶ関数の輪を呼び続けると、実体が有限に収まるかを決めないので、本体の読みを決めません（R24）。`
  );
  e.instance = { fn: label, shape: shapeText };
  e.instances = [e.instance];
  return e;
}

// いまの呼び出しが最後の木の道にあると言えるか（注の2）。言えないのは、解いている途中の枠が仮置きに頼っているとき
// （pendingNow。仮置きを読まれた枠 consulted と、枠と無名の関数の本体が頼っている枠 deps）と、枠の計算が門に当たった実体を
// 呼んだ後のとき（gated）。根の種類を解く所は、実体の本体が門に当たっても未知にして先へ進むが、木を残す段はそこで呼んだ行
// ごと断るので、その後ろで作る実体は最後の木に入らない（門に当たる `bad [y : 1]` の後ろの `p [m : 1]`。確かめ 2026-10-20）。
function pendingNow(F) {
  const s = new Set();
  for (const f of F.stack) {
    if (f.consulted) s.add(f);
    for (const d of f.deps) s.add(d);
  }
  for (const c of F.collectors) for (const d of c.deps) s.add(d);
  return s;
}
const gatedNow = (F) => F.stack.some((f) => f.gated);
// 括りの関数 fn（書いた `?` は op）を通って実体 inst を呼んだ（注の2・3）。made なら、この呼び出しが実体を作った（か、外した
// 実体を作り直した）。最後の木の道にあると言えれば、op の確定した実体に数える。仮置きに頼っていれば、頼っている枠に覚えさせ、
// 枠が閉じたときに決める（settlePending）。門に当たった実体を呼んだ後なら数えない（木を残す段で、呼んだ所が数える）。
function noteCall(F, inst, op, label, made) {
  const set = F.instanceTotals.get(op);
  if (set && set.has(inst)) return;
  const pend = pendingNow(F);
  const onPath = !gatedNow(F);
  if (!pend.size) {
    if (onPath) countSettled(F, inst, op, label);
    return;
  }
  const entry = { inst, op, label, made, onPath, pendingOn: pend };
  for (const f of pend) (f.pendingCalls || (f.pendingCalls = [])).push(entry);
}
// 作って外れていない実体の数（注の3）。作った `?`（か、外した実体を作り直した `?`）で数える。
function makeLive(F, inst, op, label) {
  const made = (F.instancesMade.get(op) || 0) + 1;
  if (made > INSTANCE_WORK_LIMIT) throw guardRefusal(F, "work", label);
  F.instancesMade.set(op, made);
  inst.liveOp = op;
}
// 外れた仮置きの上でだけ作った実体を、作った実体の数から外す（注の3）。鍵の記録（F.instances）には残し、また呼ばれたら
// 作り直したと数える（instantiate）。確定した実体は外さない。
function discard(F, inst) {
  if (!inst.liveOp || inst.final) return;
  F.instancesMade.set(inst.liveOp, F.instancesMade.get(inst.liveOp) - 1);
  inst.liveOp = null;
}
// 解いている途中の枠 frame が閉じた（failed なら仮置きが外れた）ときの、frame に頼った呼び出し。外れたら、その呼び出しが作った
// 実体を作った実体の数から外し、当たったら frame が頼っていた枠（deps）に頼り直す。どの枠にも頼らなくなったら確定した実体
// （総数に数える）。数えるのは最後にまとめて（総数の門に当たっても、frame の後片付けを終えてから投げる）。
function settlePending(F, frame, failed, deps) {
  const now = [];
  for (const entry of frame.pendingCalls || []) {
    if (!entry.pendingOn || !entry.pendingOn.has(frame)) continue;
    entry.pendingOn.delete(frame);
    if (failed) {
      entry.pendingOn = null;
      if (entry.made) discard(F, entry.inst);
      continue;
    }
    for (const d of deps) {
      if (entry.pendingOn.has(d)) continue;
      entry.pendingOn.add(d);
      (d.pendingCalls || (d.pendingCalls = [])).push(entry);
    }
    if (entry.pendingOn.size) continue;
    entry.pendingOn = null;
    if (entry.onPath) now.push(entry);
  }
  frame.pendingCalls = null;
  for (const e of now) countSettled(F, e.inst, e.op, e.label);
}
// 確定した実体を、呼んだ `?` ごとに数える（注の2）。同じ綴りの関数が分け合う実体は、呼んだ `?` のそれぞれで1つ。上限を
// 超えたら断る。確定した実体は、作った実体の数でも外さない。
function countSettled(F, inst, op, label) {
  let set = F.instanceTotals.get(op);
  if (!set) F.instanceTotals.set(op, (set = new Set()));
  if (set.has(inst)) return;
  if (set.size + 1 > INSTANCE_TOTAL_LIMIT) throw guardRefusal(F, "total", label);
  set.add(inst);
  if (!inst.liveOp) makeLive(F, inst, op, label);
  inst.final = true;
}
// 守りの断り（注の2〜4）。当たった実体と行は解く順に依るので、書いた `?` の名前（名前の定義なら名前、括りなら綴り）だけを
// 言う。ほかの門と同じく投げ（根の種類を解く所では未知になり、そこから先は浅く止まる）、覚えて resolve の最後に断る。覚えた物が
// 2つ以上なら、名前のいちばん小さい物。総数は G7（断るかは最後の木だけで決まる）、作った実体の数と入れ子の数は資源の守り
// なので、別の reason にする。
const GUARD = {
  total: { reason: GATE_REASON.G7, gate: "G7", what: () => `確定した実体が ${INSTANCE_TOTAL_LIMIT} 個を超えました` },
  work: { reason: "instance-work-limit", gate: "", what: () => `作った実体（仮置きの上で作った物も数える）が ${INSTANCE_WORK_LIMIT} 個を超えました` },
  nest: { reason: "instance-nest-limit", gate: "", what: () => `実体を解いている途中の入れ子が ${INSTANCE_NEST_LIMIT} 段を超えました` },
};
function guardRefusal(F, kind, label) {
  const g = GUARD[kind];
  const e = new OperationError(
    `括りの関数 \`${label}\` の${g.what()}（形を変えながら増え続けています）。実体が有限に収まるかを決めないので、本体の読みを決めません（§5 Q25）。`,
    { spec: `${SPEC} §4 R24`, reason: g.reason }
  );
  e.gate = g.gate;
  e.guard = kind; // isGate に数える（ほかの門と同じく、根の種類を解く所では未知）
  e.label = label;
  const old = F.guards[kind];
  if (!old || label < old.label) F.guards[kind] = e;
  F.guardStop = F.guardStop || e; // 新しい実体を作らない（instantiate）
  return e;
}
// 覚えた守りの断り（resolve の最後）。総数・作った実体の数・入れ子の数の順。
function guardRefused(F) {
  return F.guards.total || F.guards.work || F.guards.nest || null;
}
// 解いている途中の実体（根の種類を解いている物と、木を解いている物）の入れ子に入る（注の4）。出るのは呼んだ側（instRootOf・
// materialize）。
function enterNest(F, inst) {
  if (F.instNest >= INSTANCE_NEST_LIMIT) throw guardRefusal(F, "nest", inst.label);
  F.instNest++;
}
// JS のスタックが溢れた（注の4）：入れ子の数の守りの内でも、実体1段の本体が重い（括弧の深い入れ子）と溢れる。内部の例外の
// まま出さず、資源の守りとして断る（どこで溢れるかは、同じプロセスで前に何を解いたかでも変わる）。
function stackRefusal(e) {
  if (!(e instanceof RangeError) || !/call stack/i.test(e.message)) return null;
  return new OperationError("解決の途中で JS のスタックが溢れました（実体の入れ子か、本体の入れ子が深すぎます）。読みを決めません（§5 Q25）。", {
    spec: `${SPEC} §4 R24`,
    reason: "resolve-stack-limit",
  });
}

function patternFn(F, op, params, defScope, label) {
  const fn = { type: "pattern", n: params.length, idKey: lambdaKey(op, defScope.key), label, op, scopeKey: defScope.key };
  fn.lastBracket = params[params.length - 1].kind !== "bare"; // 残りの並びを最後の括りが受ける形（applyKind）
  fn.bareAt = params.map((p) => p.kind === "bare"); // 裸の仮引数の位置（部分適用の鍵で A にする、internPartial）
  fn.env = scopeIdent(defScope); // 書いた範囲の同一性（callIdent）
  fn.envDepth = envDepth(defScope); // 鍵の深さ（fnDepth）
  fn.instantiate = (argDescs) => instantiate(F, fn, op, params, defScope, argDescs);
  return fn;
}

// 括りの関数の部分適用（applyKind の k < n）。残りの仮引数は後ろの n − k 個なので、最後の仮引数が括りかは元の関数の
// まま。当てた物（bound）は元の関数（base）の前から並べて覚え、残りが来たら合わせて元の関数の実体を作る。部分適用の
// 部分適用（`(t3 1) 2`）も、元の関数に当てた物を足していく。
// 鍵は当てた物の形を入れ、木のまま持つ（internPartial）——当てた物の違う部分適用を同じ関数として扱わない（欄に入れて
// 括りの関数に渡したときの実体の鍵）。
function patternPartial(fn, args) {
  const base = fn.base || fn;
  const bound = [...(fn.bound || []), ...args];
  return {
    type: "pattern",
    n: base.n - bound.length,
    label: base.label,
    lastBracket: base.lastBracket,
    base,
    bound,
    instantiate: (argDescs) => base.instantiate([...bound, ...argDescs]),
  };
}

// その `?` を通って、木まで解く実体を呼んだ（定義の行の木に描く物。resolve の最後）。
function recordCall(F, fn, inst) {
  let byScope = F.calls.get(fn.op);
  if (!byScope) F.calls.set(fn.op, (byScope = new Map()));
  let set = byScope.get(fn.scopeKey);
  if (!set) byScope.set(fn.scopeKey, (set = new Set()));
  set.add(inst);
}

// ---- 呼んだ物の同一性（R25 の描き方） ----
//
// 実体の答えは綴りの鍵で分け合うが、記録（recordCall）は「その `?` を通って呼ばれたか」なので、どの `?` かという物の
// 同一性で取る。分け合った実体の本体の中で呼ぶ関数（欄に入れて渡した関数・実体の中の括った `?`）は、実体を作った側の
// 物ではなく、いま呼んだ側の物である。直す前は、使い回したときに本体の中の呼び出しを記録しなかったので、
// `h [f : pair]` と `h [f : pair2]`（pair と pair2 は同じ綴り）で、どちらの定義の行に inst が出るかが行の順で入れ替わった。
// 値の定義が先に作った実体を別の行が木にすると、門の名指しも作った側の名前になった（反証 2026-10-19 の続き）。
// だから呼び出しごとに、呼んだ物の同一性を番号に寄せ（callIdent）、実体ごとに、まだ歩いていない番号で呼ばれたら、本体を
// その物で歩いて記録を足す（materialize・walkCalls）。答えは綴りで決まるので、歩き直しても木・種類・門は変わらない。
// 同一性は、実引数の中と、関数を書いた範囲（実体の範囲なら、その実体を呼んだ物）の中の括りの関数の `?` で決まる。
// 素の関数と点なしは数えない（NO_IDENT）：素の関数の本体は定義の行で解き、呼んでも本体を歩かない。合成は中の関数を数える。
// 番号は歩きを重ねないためだけに使い、鍵にも並び順にも入れない。番号の振り方は見た順に依るが、記録される `?` と実体の
// 組は依らない。比べるのは同じ実体（同じ鍵）を呼んだ物どうしだけで、鍵が各位置の関数の綴りと範囲の鍵を決めているので、
// 番号には書いた `?` と、書いた範囲の同一性だけを入れる。
const NO_IDENT = 0; // 括りの関数が見えない物
let identTable = new Map([["·", NO_IDENT]]); // 綴り（子は番号）→ 番号
let identByDesc = new WeakMap();
let identByShape = new WeakMap();
let identByFn = new WeakMap();
let opSerial = new WeakMap(); // 書いた `?` → 番号（物の同一性）
let opCount = 0;
function identText(text) {
  let id = identTable.get(text);
  if (id === undefined) identTable.set(text, (id = identTable.size));
  return id;
}
function identDesc(d) {
  if (!d) return NO_IDENT;
  const memo = identByDesc.get(d);
  if (memo !== undefined) return memo;
  const id = d.k === "L" ? identFn(d.fn) : d.k === "A" && d.shape ? identShape(d.shape) : NO_IDENT;
  identByDesc.set(d, id);
  return id;
}
function identShape(sh) {
  const memo = identByShape.get(sh);
  if (memo !== undefined) return memo;
  let id = NO_IDENT;
  if (sh.s === "struct") {
    const fields = sh.fields.map((f) => [f.name, identDesc(f.desc)]);
    if (fields.some(([, c]) => c !== NO_IDENT)) id = identText(`{${fields.map(([n, c]) => `${n}:#${c}`).join(" ")}}`);
  } else if (sh.s === "list" && sh.elem) {
    const c = identDesc(sh.elem);
    if (c !== NO_IDENT) id = identText(`[#${c}…]`);
  }
  identByShape.set(sh, id);
  return id;
}
function identFn(fn) {
  if (!fn) return NO_IDENT;
  const memo = identByFn.get(fn);
  if (memo !== undefined) return memo;
  let id = NO_IDENT;
  if (fn.type === "pattern" && fn.bound) {
    // 部分適用：元の関数と当てた物。裸の仮引数の位置は、実体の中で A なので呼べない（internPartial と同じ）。
    const bound = fn.bound.map((d, i) => (fn.base.bareAt[i] ? NO_IDENT : identDesc(d)));
    id = identText(`P#${identFn(fn.base)}(${bound.map((c) => `#${c}`).join(" ")})`);
  } else if (fn.type === "pattern") {
    let n = opSerial.get(fn.op);
    if (n === undefined) opSerial.set(fn.op, (n = opCount++));
    id = identText(`F${n}#${fn.env}`);
  } else if (fn.type === "compose") {
    const fns = fn.fns.map(identFn);
    if (fns.some((c) => c !== NO_IDENT)) id = identText(`C(${fns.map((c) => `#${c}`).join(" ")})`);
  }
  identByFn.set(fn, id);
  return id;
}
// 呼んだ物の同一性：関数を書いた範囲の同一性と、括りの仮引数に当てた物の同一性（裸の仮引数の位置は A なので数えない）。
function callIdent(fn, params, argDescs) {
  const args = params.map((p, i) => (p.kind === "bare" ? NO_IDENT : identDesc(argDescs[i])));
  return identText(`${fn.env}(${args.map((c) => `#${c}`).join(" ")})`);
}
// 範囲の同一性。実体の範囲は、その実体を呼んだ物の同一性を持つ（instScope）。ほかの範囲は外の範囲のもの。
function scopeIdent(scope) {
  for (let s = scope; s; s = s.parent) if (s.ident !== undefined) return s.ident;
  return NO_IDENT;
}
// 実体の範囲：仮引数に当てた desc（R24）と、呼んだ物の同一性と、鍵の深さ（中で書いた関数の深さ、fnDepth）を持つ。
function instScope(F, op, defScope, b, key, ident) {
  const lam = makeLambda(op, { F, scope: defScope });
  lam.scope.descs = b.descs;
  lam.scope.key = key;
  lam.scope.ident = ident;
  lam.scope.depth = b.depth;
  return lam.scope;
}

// 仮引数に渡された物を当てる（R24 の表）。返す物は {descs（名前 → desc）, key, text}。
function bindParams(params, argDescs) {
  const descs = new Map();
  const keys = [];
  const texts = [];
  params.forEach((p, i) => {
    const d = argDescs[i];
    if (p.kind === "bare") {
      // 裸の仮引数は、今までどおり A（R24）。渡された物の形を見ないので、鍵も A にする。
      descs.set(p.name, A());
      keys.push("A");
      texts.push("A");
      return;
    }
    keys.push(descKey(d));
    texts.push(descText(d));
    if (!p.simple) {
      for (const n of p.all) descs.set(n, U()); // 入れ子の分解など、読み方が決まっていない括り（patternParamsOf の注）
      return;
    }
    bindBracket(p, d, descs);
  });
  return { descs, key: keys.join(" "), text: texts.join(" ") };
}
function bindBracket(p, d, descs) {
  const setNames = (f) => p.names.forEach((n) => descs.set(n, f(n)));
  if (!d || d.k !== "A" || d.spread) {
    // L か未知：どの名前も未知。
    setNames(() => U());
    if (p.rest) descs.set(p.rest, U());
    return;
  }
  const sh = d.shape;
  if (!sh) {
    // 中身の見えない A：裸の名前は未知、`~rest` は A。
    // 形では構造体とも List とも読めないが §2 では中身の見える器（行の混ざった括り・同じ名前の欄が2つある構造体・欄の
    // 右辺が撒く項の構造体・撒く項を含む並び）は、`~rest` に中身（elements）を持ち
    // 越す。R24 の表の「中身の見えない A」は裸の仮引数・`$` の番地と番地の字面・範囲・適用の結果のように中身が本当に
    // 見えない物の行で（数の字面は 2026-10-19 に R24 の数の行へ移した）、ここで A() にすると、関数の見える中身を
    // `r~` で撒いても門（§3.3 の手順1）を素通りした（確かめ 2026-10-19 の F2）。
    // 何が残りに入るかは決まらないので、元の器の中身を全部持ち越す（断る側）。
    setNames(() => U());
    if (p.rest) descs.set(p.rest, d.elements ? { k: "A", elements: d.elements } : A());
    return;
  }
  if (sh.s === "scalar") {
    // 数：長さ1の List として受ける（SCALAR の注）。名前はその数、`~rest` は同じ要素の List（形は長さに依らない）。
    setNames(() => scalarDesc());
    if (p.rest) descs.set(p.rest, withShape({ s: "list", elem: scalarDesc() }));
    return;
  }
  if (sh.s === "struct") {
    // 構造体：裸の名前は同じ名前の欄の生まれ。無ければ未知（名前で当たらなかった名前を前から当てるかは、どの言葉にも
    // 無い）。`~rest` は受けなかった欄の構造体。
    setNames((n) => {
      const f = sh.fields.find((x) => x.name === n);
      return f ? f.desc : U();
    });
    if (p.rest) descs.set(p.rest, withShape({ s: "struct", fields: sh.fields.filter((f) => !p.names.includes(f.name)) }));
    return;
  }
  // List：裸の名前は要素の生まれ（要素に L か未知が見えれば未知。mergeElems）、`~rest` は同じ要素の List。
  setNames(() => (sh.elem && sh.elem.k === "A" ? sh.elem : U()));
  if (p.rest) descs.set(p.rest, d);
}

// 括りの関数の適用（§3.4 の括りの関数の行）。k = n のとき（前から順に当てる）と、最後の仮引数が括りで k > n の
// とき（残りの並び全体を最後の括りが1つの List として受ける、R24）と、最後の仮引数が裸で k > n のとき（前から n 個
// だけを当てる。余りは鍵に入れない）に実体を作る（呼ぶのは applyKind）。部分適用は、残りが来たときに当てた物と
// 合わせて、元の関数のこの3つのどれかで作る（patternPartial）。
function instantiate(F, fn, op, params, defScope, argDescs) {
  const b = bindParams(params, argDescs);
  const key = `${fnKey(fn)}|${b.key}`;
  const ident = callIdent(fn, params, argDescs);
  let inst = F.instances.get(key);
  if (!inst) {
    // 実体の守り（INSTANCE_DEPTH_LIMIT の注）。深さは鍵だけで決まる普通の門で、超える実体は作らない。守りの断りを覚えた後は、
    // 新しい実体を作らない（resolve はその断りで終わるので、残りの計算は値を含む輪と解き直しの守りを見るためだけにある。作り
    // 続けると、当たった後の枝を全部解いて遅かった）。
    if (F.guardStop) throw F.guardStop;
    const depth = instanceDepth(params, argDescs);
    if (depth > INSTANCE_DEPTH_LIMIT) throw depthGate(fn.label, b.text, depth);
    // 範囲の深さ（中で書いた閉包の深さ、fnDepth）は、当てた物の深さと書いた所の範囲の深さの大きい方。
    b.depth = Math.max(depth, envDepth(defScope));
    // scope は作った側の物の範囲（根の種類を出す、instRootOf）。walked は本体を歩いて記録した物の同一性（callIdent の注）。
    const scope = instScope(F, op, defScope, b, key, ident);
    inst = { isInst: true, key, label: fn.label, shapeText: b.text, depth: b.depth, lambda: op, scope, walked: new Set(), cycleDeps: new Set(), liveOp: null };
    makeLive(F, inst, op, fn.label);
    F.instances.set(key, inst);
    noteCall(F, inst, op, fn.label, true);
  } else if (!inst.liveOp) {
    // 外れた仮置きの上でだけ作った実体を、また呼んだ：作り直したと数える（注の3）。
    makeLive(F, inst, op, fn.label);
    noteCall(F, inst, op, fn.label, true);
  } else noteCall(F, inst, op, fn.label, false);
  b.depth = inst.depth; // 呼んだ側の物の範囲も、同じ深さを持つ（scopeOf）
  const root = instRootOf(F, inst, fn.label);
  // 本体が門に当たる実体を呼んだ：木を残す段はここで呼んだ行ごと断るので、この枠の計算の後ろは最後の木の道に無い（注の2）。
  if (inst.gated && F.stack.length) F.stack[F.stack.length - 1].gated = true;
  if (F.stack.length === 0) {
    recordCall(F, fn, inst);
    // 木と、本体の中の呼び出しの記録は、いま呼んだ側の物の範囲で歩く。実体を作ったのが木を残さない所（値の定義の種類を
    // 出す所など）でも、門は呼んだ行で渡した物の名前で名指しする。
    const scopeOf = () => (ident === inst.scope.ident ? inst.scope : instScope(F, op, defScope, b, key, ident));
    materialize(F, inst, scopeOf);
    if (inst.error) {
      if (!F.matStack.length) throw instanceError(inst, fn.label);
      // 別の実体の本体の中から呼んだ：その実体も同じ門で失敗する。どの実体を、どの名前で呼んで門に当たったかを
      // 覚えておき、いちばん外の呼んだ行で、呼んだ順に名指しする（instanceError）。
      F.matStack[F.matStack.length - 1].via = { inst, label: fn.label };
      throw inst.error;
    }
    // 分け合った実体を、まだ歩いていない物で呼んだ：その物で本体を歩き、呼んだ `?` を記録する（R25）。
    if (!inst.walked.has(ident)) walkCalls(F, inst, scopeOf());
  }
  // 実体の本体の根が A なら A、ほかは未知（§3.4 の素の関数の k = n と同じ）。結果は中身の見えない A。
  return { kind: root === "A" ? A() : U() };
}

// 実体の本体の根の種類（bodyRootOf と同じ仕組み）。label は呼んだ名前（輪の道筋の一歩、stepText）。
function instRootOf(F, inst, label) {
  const memo = freshMemo(F, F.instMemo, inst);
  if (memo) return readMemo(F, memo, () => `\`${label || inst.label}\` を形 ${cutShape(inst.shapeText)} で呼んだ実体の本体`);
  const running = F.inProgress.get(inst);
  if (running) {
    consult(F, running); // 同じ形で自分を呼んだ：同じ実体の仮置き（R24）
    return "A";
  }
  enterNest(F, inst);
  const frame = pushFrame(F, inst);
  frame.label = label;
  let value;
  let gated = false;
  try {
    value = resolveBody(inst.lambda.right, { F, scope: inst.scope, diag: null }).rootKind;
  } catch (e) {
    if (!isGate(e)) {
      F.instNest--;
      abortFrame(F, frame);
      throw e;
    }
    // 本体が門に当たる。木を残す段（materialize）で同じ門に当たり、呼んだ行で断る（深さの守りも、鍵だけで決まる門なので
    // 同じ。INSTANCE_DEPTH_LIMIT の注の1）。
    value = "U";
    gated = true;
  }
  F.instNest--;
  // 本体が門に当たるか、門に当たる実体を呼んだ実体は、木を残す段で断る（呼んだ側の枠の後ろは最後の木に無い、instantiate）。
  inst.gated = gated || !!frame.gated;
  if (frame.consulted && value !== "A") {
    value = "U";
    frame.failed = true;
  }
  finishFrame(F, frame, F.instMemo, value);
  return value;
}

// 実体の木（R25）。解いている途中の種類が無いときにだけ呼ぶ。本体の中の未定義の名前は、ここで1回だけ information を
// 出す（F.reported）。定義の所では本体を解かないので、呼ばれない本体の中の名前は出さない（読まないので）。
// 範囲（scopeOf）は、はじめて木にした呼び出しの物のもの。その物の分の記録も、この歩きで取る（walked）。
// 木まで解く実体は最後の木の実体で、呼んだ所（instantiate の noteCall。枠が空なので確定した呼び出し）で確定した実体に数えて
// ある（INSTANCE_DEPTH_LIMIT の注の2）。
function materialize(F, inst, scopeOf) {
  if (inst.materializing) {
    // 木を解いている途中の実体を、本体の中からもう一度呼んだ（再帰）。根の種類は仮置きの済んだ答えを使い、木は
    // 外側の1回で作る。外側が門に当たったら、間にある実体（どれも外側を呼んでいる）も同じ門で失敗にする。
    const i = F.matStack.indexOf(inst);
    for (let j = i + 1; j < F.matStack.length; j++) inst.cycleDeps.add(F.matStack[j]);
    return;
  }
  if (inst.done) return;
  enterNest(F, inst);
  const scope = scopeOf();
  inst.walked.add(scope.ident);
  inst.materializing = true;
  F.matStack.push(inst);
  try {
    inst.tree = resolveBody(inst.lambda.right, { F, scope, diag: F.diag }).tree;
  } catch (e) {
    if (!isGate(e)) throw e;
    inst.error = e;
  } finally {
    F.instNest--;
    F.matStack.pop();
    inst.materializing = false;
    inst.done = true;
  }
  if (inst.error) failDependents(inst);
}
// 分け合った実体の本体を、いま呼んだ側の物（scope）で歩き直し、本体の中の呼び出しだけを記録する（callIdent の注）。
// 木と information は残さない：答えは綴りで決まるので、木は materialize の1回と同じになり、未定義の名前も同じである。
// 歩く前に印を付けるので、同じ物で自分を呼ぶ再帰は1回で止まる。本体の中の実体は、同じ綴りの鍵で materialize の
// 歩きがもう作っている。
function walkCalls(F, inst, scope) {
  inst.walked.add(scope.ident);
  resolveBody(inst.lambda.right, { F, scope, diag: null });
}
// 守り：実体が門に当たると、その門は呼んだ行まで投げ上がり、resolve 全体が断る（materialize は F.stack が空のときにだけ
// 走り、そこから上で門を捕まえる所は無い）。だから輪の途中の実体に付けた失敗は、今は誰にも読まれない（確かめ
// 2026-10-19 で観測できなかった）。門を捕まえて続ける所を足したとき、輪の途中の実体を成功のまま残さないために置く。
// 名指しの名前は、実体を最初に作った関数のもの（その実体を呼んだ名前は、ここでは分からない）。
function failDependents(inst) {
  for (const d of inst.cycleDeps) {
    if (d.error) continue;
    d.error = inst.error;
    d.via = { inst, label: inst.label };
    failDependents(d);
  }
}

// 呼んだ行で断る（R25）。門の番号と reason は本体で当たった門のまま、言い分に関数の名前と形を足す。label は呼んだ行で
// 使った関数の名前（実体は同じ綴りの関数で共有するので、実体を作った関数の名前ではない）。実体の本体の中で別の括りの
// 関数を呼んで門に当たったなら、通った実体を呼んだ順に並べる（e.instance はいちばん外、e.instances は全部）。
function instanceError(inst, label) {
  const e0 = inst.error;
  const chain = [{ fn: label, shape: inst.shapeText }];
  const seen = new Set([inst]);
  for (let v = inst.via; v && !seen.has(v.inst); v = v.inst.via) {
    seen.add(v.inst);
    chain.push({ fn: v.label, shape: v.inst.shapeText });
  }
  const cut = (s) => (s.length > 60 ? `${s.slice(0, 60)}…` : s);
  const seg = (c) => `\`${c.fn}\` を形 ${cut(c.shape)} で`;
  const J = "呼んだ実体の本体で、";
  const named =
    chain.length > 4
      ? `${chain.slice(0, 3).map(seg).join(J)}${J}…（ほか ${chain.length - 4} 段）…、${seg(chain[chain.length - 1])}`
      : chain.map(seg).join(J);
  const e = new OperationError(`括りの関数 ${named}呼んだ実体の本体が、門に当たりました（R25：呼んだ行で断る）。${e0.message}`, {
    spec: e0.spec,
    reason: e0.reason,
  });
  e.gate = e0.gate;
  e.instance = chain[0];
  e.instances = chain;
  return e;
}

// 中身の見える器（字面の括り・`,` の並び・構築の並び）の要素の種類。見えなければ null。
function visibleElements(tree) {
  if (!tree) return null;
  if (tree.t === "construct") return tree.items.map(elementKind);
  if (tree.t === "op" && tree.sym === ",") {
    const out = [];
    let t = tree;
    while (t && t.t === "op" && t.sym === ",") {
      out.push(elementKind(t.left));
      t = t.right;
    }
    out.push(elementKind(t));
    return out;
  }
  if (tree.t === "leaf" && tree.cat === "plain" && tree.desc.elements && tree.term && tree.term.type === "atom" && !tree.term.pre.length && !tree.term.post.length) {
    return tree.desc.elements;
  }
  // `'` で引いた物（R26）と `[' 0] xs` の適用は、形が見えれば要素も持つ。ここで見ないと、中身に関数の見える欄を
  // 引いて撒く形（`[m ' greet]~`）が、形では関数が見えるのに撒く項の門を素通りする。
  if ((tree.t === "leaf" && tree.cat === "plain" && tree.term && tree.term.type === "infix") || tree.t === "apply") {
    return tree.kind.k === "A" && tree.kind.elements ? tree.kind.elements : null;
  }
  return null;
}

// 器の1つの要素の種類。要素が A でも、それ自体が中身の見える器なら中身まで見て、L か未知があれば未知に数える。
// 構築の値を平らにするか（§5 Q12）が決まっていないので、`[fs 1]~` は平らにすれば `fs` の中の関数を撒く。
// 1段だけ見ると、ここを素通しする（§3.3 の手順1「中身に L か未知が見えるもの → G7」）。欄（`k : inc`）は、
// 行の種類は A でも中身は右辺なので、右辺を見る。
function elementKind(node) {
  if (!node) return "U";
  if (node.t === "op" && node.sym === ":") return elementKind(node.right);
  if (node.kind.k !== "A") return node.kind.k;
  const inner = visibleElements(node);
  return inner && inner.some((k) => k !== "A") ? "U" : "A";
}

// ---------------------------------------------------------------------------
// 項の種類（§2、手順の 0）
// ---------------------------------------------------------------------------
//
// 返す物：{cat, desc, view, isLambdaName?, isQBracket?}
//   cat：'plain'（ふつうの葉）・'unit'（字面の `_`）・'idNeg'（括らない `!_`）・'input'（前置 `@`）・'ptilde'（前置 `~`）

function classify(term, ctx) {
  if (term.type === "infix") return classifyInfix(term, ctx);
  const { pre, core, post } = term;
  const view = { v: "atom", text: writeTerm(term) };
  const plain = (desc, extra = {}) => ({ cat: "plain", desc, view, ...extra });

  if (pre.length === 0 && post.length === 0) {
    switch (core.c) {
      case "lit":
        // 文字列の字面は List（R24。String ≅ List(Char)）。要素は文字で、文字は Int と同じ扱いの数（README の法則 B）。
        if (core.text.length >= 2 && core.text[0] === "`" && core.text[core.text.length - 1] === "`") {
          return plain(withShape({ s: "list", elem: core.text.length > 2 ? scalarDesc() : null }));
        }
        // 番地の字面は数でない（SCALAR の注）ので中身の見えない A。ほかは数・文字の字面。
        return plain(ADDRESS_LIT.test(core.text) ? A() : scalarDesc());
      case "unit":
        return { cat: "unit", desc: U(), view };
      case "name":
        return plain(lookup(core.name, ctx), { isLambdaName: isLambdaName(core.name, ctx) });
      case "bracket": {
        const b = bracketInfo(core, ctx);
        return { cat: "plain", desc: b.desc, view: { ...view, inner: b.trees }, isQBracket: b.isQ };
      }
      case "abs":
      case "norm": {
        const a = enclosureInfo(core, ctx);
        return { cat: "plain", desc: a.desc, view: { ...view, inner: a.trees } };
      }
      case "indent": {
        const b = blockInfo(core, ctx);
        return { cat: "plain", desc: b.desc, view: { v: "block", rows: b.trees } };
      }
    }
  }
  // `$` が前に付いた項（名前・括り・`!_`）は値（§2、96）。
  if (post.length === 0 && pre.length === 1 && pre[0] === "$" && (core.c === "name" || core.c === "bracket")) {
    touchCore(core, ctx);
    return plain(A());
  }
  if (post.length === 0 && pre.length === 2 && pre[0] === "$" && pre[1] === "!" && core.c === "unit") return plain(A());
  // 前置 `@`：種類は並びの位置で決まる（§2、G6）。
  if (post.length === 0 && pre.length === 1 && pre[0] === "@" && (core.c === "name" || core.c === "bracket")) {
    touchCore(core, ctx);
    return { cat: "input", desc: { k: "L", fn: { type: "input" } }, view };
  }
  // 後置 `~`（撒く項）。
  if (pre.length === 0 && post.length === 1 && post[0] === "~") return classifySpread(term, view, ctx);
  // 前置 `~`：1項の並びなら項として残し、2項以上なら G4。
  if (post.length === 0 && pre.length === 1 && pre[0] === "~") {
    touchCore(core, ctx);
    return { cat: "ptilde", desc: U(), view };
  }
  // 括らない `!_`（R18）。
  if (post.length === 0 && pre.length === 1 && pre[0] === "!" && core.c === "unit") return { cat: "idNeg", desc: U(), view };
  // 値の演算子の印：A の核なら A、L・未知・`_` の核なら未知（§2、Q22）。
  if (pre.every((p) => VALUE_PREFIX.has(p)) && post.every((p) => p === "!")) {
    if (core.c === "unit") return plain(U());
    const inner = classify({ type: "atom", pre: [], core, post: [] }, ctx);
    if (!(inner.cat === "plain" && inner.desc.k === "A" && !inner.desc.spread)) return plain(U());
    // 数に値の印を当てても数（SCALAR の注）。ただし前置 `!` は外す：`!_` は恒等射（R18）で、`_` でない物に当てると
    // `_` になる。だから `!x` は数にならず、x が `_` になる物（`1 < 0`・`/ 0`）なら関数になる。数と読むと、
    // `f !(1 < 0)` の実体で `h 5` を黙って構築と読む。
    return plain(isScalar(inner.desc) && !pre.includes("!") ? scalarDesc() : A());
  }
  // 後置 `@`（取り込み）・前置 `#`・表に無い印の組み合わせ（`@f~`・`$x@` など）は未知（§2、G7）。
  touchCore(core, ctx);
  return plain(U());
}

function touchCore(core, ctx) {
  if (core.c === "name") touchName(core.name, ctx);
  else if (core.c === "bracket") bracketInfo(core, ctx);
  else if (core.c === "abs" || core.c === "norm") enclosureInfo(core, ctx);
  else if (core.rows) core.rows.forEach((r) => resolveTree(r, ctx));
}

// `|…|`・`||…||`（§2、92）。囲みは値の演算子（絶対値・ノルム）なので、中の行の根が全部値のときだけ A にする。
// 中に関数か未知が来た形（`|inc|`）は、値の演算子に関数が来た項（§5 Q22）と同じく読みが決まらないので未知にする。
// §2 の表は囲みを A とだけ書いているが、それは中が値である前提の行で、中が関数のときまで A と読むと、`|inc| 5` が
// 黙って構築になる。字面の `_` だけの行（`||_||`）は値の単位として A のままにする（§2 の行の文面どおり）。
// 撒く項だけの行（`|vs~|`）は、中置の被演算子の撒く項（classifyInfix の注）と同じ理由で未知にする。
function enclosureInfo(core, ctx) {
  const trees = core.rows.map((r) => resolveTree(r, ctx));
  const isValue = (t) =>
    !!t && ((t.kind.k === "A" && !(t.t === "leaf" && t.desc.spread)) || (t.t === "leaf" && t.cat === "unit"));
  return { desc: trees.length && trees.every(isValue) ? A() : U(), trees };
}

// 括らない `!_` を、並びの中で R18 が取り除ける位置の外で見つけたとき（§2「それ以外の位置」、Q15）。
function refuseIdNeg(where) {
  return gate("G7", `括らない \`!_\` が${where}にあります。取り除けるのは、並びの中ですぐ左が関数ですぐ右が値のときだけです。それ以外の位置の読みは決まっていません（R18、§5 Q15）。`);
}

// 段12〜22 の中置の項（§2）。値の演算子（段12〜16・19〜22）は被演算子が全部 A のときだけ A。字面の `_` が
// 被演算子にあれば G5、関数や未知があれば未知。段18 の `x ' k` は、x の形が見えて k が字面の整数か裸の名前なら、
// 引いた物の生まれ（R26、pickDesc）。引いた物が関数なら L で、名前の欄と同じく呼べる。ほかの鍵（`k~`・範囲・式）と
// `x @ k` は、何を引いたか決まらないので未知（§2）。`x ' a ' b` の鎖は、左の `x ' a` の desc からもう一度引く。
// 撒く項（`vs~ + 1`）も未知にする。§2 は撒く項を「A（撒く印つき）」とするが、撒いた中身を2項の演算子にどう渡すか
// （要素ごとか、並びとして渡すか）は仕様に無い。結果が撒かれた並びのままなら、適用の実引数の数 k が数えられず
// 逆適用の左にも置けない（R12・G9）が、1つの値なら数えられて置ける。読みで木が変わるので、値の段には回せない。
function classifyInfix(term, ctx) {
  if (isBareIndent(term.left)) throw refuseIndentBlock(`中置 \`${term.sym}\` の左`);
  const l = term.left ? classify(term.left, ctx) : null;
  const key = term.sym === "'" && term.left ? pickKeyOf(term.right) : null;
  if (key) {
    // 鍵は名前として引かない（pickKeyOf の注）。書いたとおりの葉にする。
    if (l.cat === "idNeg") throw refuseIdNeg(`中置 \`${term.sym}\` の被演算子`);
    const desc = l.cat === "plain" ? pickDesc(l.desc, key) : U();
    return { cat: "plain", desc, view: { v: "infix", sym: term.sym, left: l.view, right: rawView(term.right) } };
  }
  const r = term.right ? classify(term.right, ctx) : null;
  if ((l && l.cat === "idNeg") || (r && r.cat === "idNeg")) throw refuseIdNeg(`中置 \`${term.sym}\` の被演算子`);
  const view = { v: "infix", sym: term.sym, left: l ? l.view : null, right: r ? r.view : null };
  if (term.stage === 18) return { cat: "plain", desc: U(), view };
  if ((l && l.cat === "unit") || (r && r.cat === "unit")) {
    throw gate("G5", `値の演算子 \`${term.sym}\` の被演算子に字面の \`_\` があります（\`${writeTerm(term)}\`）。\`_ + 1\` の読みは決まっていません（§5 Q7）。`);
  }
  const isA = (x) => x && x.cat === "plain" && x.desc.k === "A" && !x.desc.spread;
  if (!(isA(l) && isA(r))) return { cat: "plain", desc: U(), view };
  // 数どうしの値の演算子の結果は数（SCALAR の注）。段12（範囲）は List を作るので入れない。
  const scalar = SCALAR_INFIX_STAGES.has(term.stage) && isScalar(l.desc) && isScalar(r.desc);
  return { cat: "plain", desc: scalar ? scalarDesc() : A(), view };
}

// 後置 `~` の項（§2）。核が「中身が見えて要素が全部 A の器」か「裸の仮引数」か「中身の見えない物」なら撒く印つき
// の A。中身に関数か未知が見えれば、項の数に依らず G7（§5 Q20：中身の関数をその場で解くか値の段で解くか未決）。
//
// 名前の種類が未知のとき（`q : use $inc 5` の `q~`）は、撒く印つきの A にせず未知の葉にする（2項以上の並びで G7）。
// §2 は適用の結果を「中身の見えない物」に数えるが、種類が未知の物は L かもしれず、L の核を撒く形は G7（Q20）で
// ある。どちらの行に当たるか決まらないので、断る側に倒した。中身が見える名前は、種類を見る前に中身を見る
// （`q : [use $inc 5]` の `q~` は、括りの `[use $inc 5]~` と同じく位置に依らず G7）。
function classifySpread(term, view, ctx) {
  const { core } = term;
  const spreadA = { cat: "plain", desc: { k: "A", spread: true }, view };
  const refuse = () => gate("G7", `\`${writeTerm(term)}\` は中身に関数か種類の未知な物が見える器を撒いています。撒いた中身をどの段で解くかは決まっていません（§5 Q20）。`);
  if (core.c === "lit") return spreadA;
  if (core.c === "abs" || core.c === "norm") {
    const a = enclosureInfo(core, ctx);
    return a.desc.k === "A" ? spreadA : { cat: "plain", desc: U(), view };
  }
  if (core.c === "name") {
    const d = lookup(core.name, ctx);
    if (d.k === "L") throw refuse();
    if (d.elements && d.elements.some((k) => k !== "A")) throw refuse();
    if (d.k === "U") return { cat: "plain", desc: U(), view };
    return spreadA;
  }
  if (core.c === "bracket") {
    const b = bracketInfo(core, ctx);
    if (b.desc.k !== "A" || (b.desc.elements && b.desc.elements.some((k) => k !== "A"))) throw refuse();
    return { ...spreadA, view: { ...view, inner: b.trees } };
  }
  return { cat: "plain", desc: U(), view };
}

// 括りの種類（§2）。点なしを先に見る（点なしの行は被演算子が欠けているので、並びとしては解けない）。
function bracketInfo(core, ctx) {
  if (core.rows.length === 0) return { desc: { k: "A", elements: [] }, trees: [], isQ: false };
  if (core.rows.length === 1) {
    const pf = pointfreeOf(core.rows[0], ctx);
    if (pf) return { desc: pf, trees: [], isQ: false };
  }
  return rowsInfo(core.rows, ctx);
}

// 字下げのブロック（`?` の本体でない所。構造体や中置の右）。点なしは括りでだけ書けるので見ない。
function blockInfo(core, ctx) {
  return rowsInfo(core.rows, ctx);
}

function rowsInfo(rows, ctx) {
  const scope = blockScope(rows, ctx);
  const inner = scope ? { ...ctx, scope } : ctx;
  const trees = rows.map((r) => resolveTree(r, inner));
  if (trees.length >= 2) {
    const desc = { k: "A", elements: trees.map(elementKind) };
    const sh = rowsShape(trees);
    if (sh) desc.shape = sh;
    return { desc, trees, isQ: false };
  }
  const root = trees[0];
  // 1行なら、中の行を解いた根の種類（頂が `?` なら L、`:`・`,` なら A、段4〜8 なら被演算子が全部 A のとき A）。
  // `excess` は葉に持ち込まない：括りの中の根でなら通る（G12）。形は、1行の `名前 : 値` なら欄1つの構造体、ほかは
  // 中の行の形（長さ1のリストはスカラと同型なので、`[m]` は m の形、`[1 2 3]` は構築の並びの形）。
  const desc = { k: root.kind.k };
  if (root.kind.fn) desc.fn = root.kind.fn;
  desc.elements = visibleElements(root) || [elementKind(root)];
  if (desc.k === "A") {
    const sh = rowsShape(trees);
    if (sh) desc.shape = sh;
  }
  return { desc, trees, isQ: root.t === "lambda" && root.kind.k === "L" };
}

// 括りと字下げのブロックの中で `:` の左に1語で置いた名前（P2）。関数の本体の中では局所の定義か枝の条件か決まって
// いないので未知にする（scanLocals）。関数の本体の外の括り（`[sq : z ? z * z ⏎ sq 5]`）でも、局所の定義か欄か
// 決まっていない（§5 Q10）のは同じである。ここを未定義の名前（A）と読むと、同じ字面が置き場所で別の木になり、
// 定義した行の隣で「定義されていません」と出る。だから仮引数でもファイルの定義でもなければ、その括りの中で未知に
// する。範囲を括りの中に限るのは、括りの外では欄の名前を裸で読まない（欄は分解して受ける関数で読む）からである。
function blockScope(rows, ctx) {
  const scope = { parent: ctx.scope, params: null, locals: new Set(), hasImport: false };
  for (const r of rows) scanLocals(r, scope, ctx.F);
  if (!scope.locals.size) return null;
  // 範囲の鍵（実体の鍵に入る関数の出どころ。lambdaKey の注）。中身は書いた行と外の範囲で決まる。
  scope.key = `${ctx.scope.key}/b{${rows.map(writeTree).join(" ⏎ ")}}`;
  return scope;
}

// 点なしの括り（§2）。返す物は desc、点なしでなければ null。
//
// 種類（§3.4 の行）：
// - pfUnary（`[+ 1]` など）・pfGreedyUnary（`[* 2,]` など）・pfGreedyBinary（`[+]` だけ）。
// - pfUnknownArity：アリティの分からない点なし。`[|]`・`[&]`・`[,]` と、`[+]` 以外の両側の欠けた点なし（`[*]`・
//   `[-]`・`[<]`・`[']` など）。§3.4 の貪欲な2項の行は `[+]` だけを挙げ（出どころの U 08-27 03:28 も `[+]` の話）、
//   表の頭は「挙げた形だけを決め、ほかは「未知」にする」なので、`[*] 2 3` の種類は未知にする。点なしなので G10 は当たる。
// - pfPick：段18（`'`・`@`）の片側の欠けた点なし（`[' 0]`・`[@ 0]`）。`[' k]` で k が字面の整数か裸の名前なら、`x ' k` と
//   同じ射なので、`[' k] x` の適用は `x ' k` と同じ desc にする（R26、§3.4 の段18 の行）。そのために鍵を fn に持たせる。
//   ほかの形（`[@ 0]`・`[x ']`・鍵が式）は、§2 の `x @ k` と同じく何を引いたか決まらないので未知。A と読むと、
//   `[' 0] fs` が `inc`（L）を引くのに `[' 0] fs inc` が黙って `inc` に関数を渡す。点なしなので G10 は当たる。
function pointfreeOf(row, ctx) {
  const L = (type) => ({ k: "L", fn: { type, pointfree: true } });
  const unaryInfix = (t) => {
    if (!t || t.type !== "seq" || t.terms.length !== 1) return null;
    const term = t.terms[0];
    return term.type === "infix" && term.stage >= 12 && term.stage <= 22 && (term.left === null) !== (term.right === null) ? term : null;
  };
  // 点なしの被演算子は1項に限り、A でなければ（関数や未知なら）点なしとしても未知にする。
  const withOperand = (term, type) => {
    const c = classify(term.left || term.right, ctx);
    if (c.cat === "unit") throw gate("G5", `点なし \`[${writeTerm(term)}]\` の被演算子に字面の \`_\` があります（§5 Q7）。`);
    if (c.cat === "idNeg") throw refuseIdNeg(`点なし \`[${writeTerm(term)}]\` の被演算子`);
    if (!(c.cat === "plain" && c.desc.k === "A" && !c.desc.spread)) return U();
    if (term.stage === 18) return { k: "L", fn: { type: "pfPick", pointfree: true, sym: term.sym, key: null } };
    return L(type);
  };
  if (row.type === "op") {
    // 貪欲な単項：`[* 2,]`・`[< 3,]`
    if (row.sym === "," && row.right === null) {
      const u = unaryInfix(row.left);
      if (u) return withOperand(u, "pfGreedyUnary");
    }
    if (row.left === null || row.right === null) {
      // `[|]`・`[&]`・`[,]` は L（アリティは未知、91）。段1〜9 のほかの点なし（`[:]`・`[?]`・`[==]` など）は未知（Q19）。
      if (row.left === null && row.right === null && (row.sym === "|" || row.sym === "&" || row.sym === ",")) return L("pfUnknownArity");
      return U();
    }
    return null;
  }
  if (row.terms.length !== 1) return null;
  const t = row.terms[0];
  if (t.type === "infix" && t.stage >= 12 && t.stage <= 22) {
    if (t.left === null && t.right === null) {
      return L(t.sym === "+" ? "pfGreedyBinary" : "pfUnknownArity"); // `[+]` だけが貪欲な2項（`[']`・`[@]` も未知）
    }
    if (t.left === null || t.right === null) {
      // `[' 0]`・`[' say]`：鍵は名前として引かない（pickKeyOf の注）ので、被演算子を解かない。
      const key = t.sym === "'" && t.left === null ? pickKeyOf(t.right) : null;
      if (key) return { k: "L", fn: { type: "pfPick", pointfree: true, sym: t.sym, key } };
      return withOperand(t, "pfUnary"); // `[+ 1]`・`[2 *]`・`[@ 0]`（pfPick、鍵なし）
    }
    return null;
  }
  if (t.type === "atom" && t.core.c === "unit" && t.pre.length + t.post.length === 1) {
    // 前置・後置の点なし。値の演算子（`[-_]`・`[!_]`・`[!!_]`・`[_!]`）だけを L にし、`[~_]` などは未知（Q19）。
    const valueMark = (t.pre.length === 1 && VALUE_PREFIX.has(t.pre[0])) || (t.post.length === 1 && t.post[0] === "!");
    return valueMark ? L("pfUnary") : U();
  }
  return null;
}

// ---------------------------------------------------------------------------
// 行を解く（P3）
// ---------------------------------------------------------------------------

function resolveTree(tree, ctx) {
  if (tree === null) return null;
  if (tree.type === "seq") return resolveSeq(tree.terms, ctx);
  switch (tree.sym) {
    case "?":
      return resolveLambda(tree, ctx);
    case ":":
      return resolveDefine(tree, ctx);
    case ",":
      return resolveProduct(tree, ctx);
    default: {
      // 段4〜8：被演算子が全部 A なら A、そうでなければ未知（§2）。
      if (isBlockSeq(tree.left)) throw refuseIndentBlock(`\`${tree.sym}\` の左`);
      const l = resolveTree(tree.left, ctx);
      const r = resolveTree(tree.right, ctx);
      return { t: "op", sym: tree.sym, left: l, right: r, kind: l && r && l.kind.k === "A" && r.kind.k === "A" ? A() : U() };
    }
  }
}

// `:`（R3、P3）。左は、1項なら解かない（定義・欄・既定値の左はいつも1項）。2項以上なら枝の条件として解く。
// fieldName は左が1語の裸の名前のときの名前で、括りやブロックの行なら構造体の欄の名前になる（rowsShape、R24）。
function resolveDefine(tree, ctx) {
  let left = null;
  let isLocalDef = false;
  let fieldName = null;
  if (tree.left && tree.left.type === "seq" && tree.left.terms.length === 1) {
    const term = tree.left.terms[0];
    if (!isNameTarget(term)) {
      const label = patternCallIn(term, ctx);
      if (label) {
        throw gate(
          "G7",
          `\`:\` の左の1項 \`${writeTerm(term)}\` の中で括りの関数 \`${label}\` を呼んでいます。1項の \`:\` の左は解かない（P3）ので、ここで呼んでも実体が作れず、本体の読みが決まりません（R25）。条件を2項以上で書くか、条件の外で呼びます。`
        );
      }
    }
    left = { t: "raw", view: rawView(term) };
    const n = bareName(term);
    if (n && ctx.scope.locals && ctx.scope.locals.has(n)) isLocalDef = true;
    fieldName = n;
  } else left = resolveTree(tree.left, ctx);
  const right = resolveTree(tree.right, ctx);
  return { t: "op", sym: ":", left, right, kind: A(), isLocalDef, fieldName };
}

// 1項の `:` の左が名前（定義・欄・局所の定義の左。公開の `#` 付きも）か。名前でない1項（`(t [1 2]) : 1`）は枝の
// 条件だが、P3 は2項以上のときだけ枝の条件として解くので、読まない。
function isNameTarget(term) {
  return term.type === "atom" && term.core.c === "name" && !term.post.length && (term.pre.length === 0 || (term.pre.length === 1 && /^#+$/.test(term.pre[0])));
}

// 読まない1項の `:` の左の中で、括りの関数（名前か、括った `?`）を呼んでいれば、その名前。
// R25 の「一度も呼ばれない括りの関数は defer で断らない」は、本体を読まないのが呼ばれていないからである。読まない所
// から呼ぶと、書いた呼び出しがあるのに実体が作れず、関数は defer になって本体の門が黙って消える（確かめ 2026-10-19 の
// F3。n_queens.sn の `(conflict col 1 board) : …` がそうだった）。1項の左を条件として解くかは P3 の話で、仕様が決めて
// いないので、ここでは読まずに名指しで断る（断る側）。
// 「呼んでいる」は、解かずに字面で見る：括りの関数が2項以上の並びの項にある（適用・合成・逆適用のどれかになる）。
// 1項だけ（`[z : inc]` の inc、`(t)`）は関数を値として書いただけで、`$` で渡すのと同じく実体を作らない（R25 の公開と
// 同じ扱い）ので断らない。素の関数は定義の行で本体を読むので、ここには関わらない（前からの P3 のまま）。
function patternCallIn(term, ctx) {
  return patternCallWalk(ctx, (visitTree, visitTerm) => visitTerm(term), false);
}
// 既定値（`?` の左の `:` の右）も、`?` の左は解かない（P3）ので読まない。そこで括りの関数を呼ぶ形も、1項の `:` の
// 左と同じ理由（R25 の「一度も呼ばれない」に当たらないのに、実体が作れない）で断る。
function patternCallInDefaults(left, ctx) {
  let found = null;
  const visit = (t) => {
    if (found || !t) return;
    if (t.type === "seq") {
      for (const term of t.terms) visitParamTerm(term);
      return;
    }
    if (t.sym === ":") {
      found = patternCallWalk(ctx, (visitTree) => visitTree(t.right), true); // 既定値（右）は全部を見る
      return;
    }
    visit(t.left);
    visit(t.right);
  };
  const visitParamTerm = (term) => {
    if (found || !term) return;
    if (term.type === "infix") {
      visitParamTerm(term.left);
      visitParamTerm(term.right);
    } else if (term.core.rows) term.core.rows.forEach(visit);
  };
  visit(left);
  return found;
}
// inDefault は既定値の中を見ているか（namesPattern）。
function patternCallWalk(ctx, start, inDefault) {
  let found = null;
  // 2項以上の並びの項のうち、括りの関数を指す物（裸の名前か、括った `?`）。
  const calledIn = (terms) => {
    for (const x of terms) {
      const n = bareName(x);
      if (n && namesPattern(n, ctx, inDefault)) return n;
      const op = x && x.type === "atom" && !x.pre.length && !x.post.length ? unwrapLambda({ type: "seq", terms: [x] }) : null;
      if (op && patternParamsOf(op.left)) return `[${writeTree(op)}]`;
    }
    return null;
  };
  const visitTree = (t) => {
    if (found || !t) return;
    if (t.type === "seq") {
      if (t.terms.length >= 2) found = calledIn(t.terms);
      return t.terms.forEach(visitTerm);
    }
    if (t.sym === "?") return visitTree(t.right); // 入れ子の関数の本体も読まない所にある。左（仮引数）は名前だけ
    visitTree(t.left);
    visitTree(t.right);
  };
  const visitTerm = (x) => {
    if (found || !x) return;
    if (x.type === "infix") {
      visitTerm(x.left);
      visitTerm(x.right);
    } else if (x.core.rows) x.core.rows.forEach(visitTree);
  };
  start(visitTree, visitTerm);
  return found;
}
// 名前が括りの関数を指すか（lookup と同じ順に探す。未定義の information は出さない）。inDefault は、既定値の中を覗いて
// いるか（patternCallInDefaults）。
function namesPattern(name, ctx, inDefault) {
  const isPattern = (d) => !!d && d.k === "L" && !!d.fn && d.fn.type === "pattern";
  for (let s = ctx.scope; s; s = s.parent) {
    if (s.descs && s.descs.has(name)) return isPattern(s.descs.get(name));
    if ((s.params && s.params.has(name)) || (s.locals && s.locals.has(name))) return false;
  }
  const F = ctx.F;
  const def = F.defs.get(name);
  if (!def) return false;
  if (def.lambda) return !!def.pattern;
  const start = F.stack.length;
  const before = F.cycleRefused;
  try {
    return isPattern(nameKindOf(F, def)); // 別名（`p : t`）
  } catch (e) {
    if (!(e instanceof OperationError)) throw e;
    if (e.reason !== "name-cycle") return false; // 門は、その定義の行を解くときに出る
    // 名前の輪（§5 Q30）。既定値の中を覗いた所を通る輪（輪のいちばん下の枠が、覗く前から解いている途中）は、種類の輪では
    // ない。既定値は解かず（P3）、値の無で呼ばれたときにだけ評価する（§3.7）ので、値はできる（`v : g 1`・`g : x ? [[y : v 2]
    // ? 5] x` は v = 5）。覗くのは G7（R25）を探すためだけで、行を解く段（枠が空）で、確定した種類でもう一度覗く。だから
    // 握りつぶして「括りの関数ではない」と読み、作った言い分（F.cycleRefused）も覗く前に戻す。前（2026-10-20 の作り直し）は
    // 投げ直していて、HEAD がどの並べ方でも通していた、値のできるプログラムを name-cycle で断った（確かめ 2026-10-20 の
    // Q30-V1・ADV-1）。
    // 覗いた定義の計算の中だけで閉じる輪（輪のいちばん下の枠が、覗いてから積んだ物）は、覗いた所を通らない本物の輪なので、
    // 投げ直す（`a : g 1`・`g : x ? [[y : v 2] ? 5] x`・`v : h 1`・`h : x ? ⏎ ⇥k x ⏎ ⇥vk ⏎ ⇥inc`・`k : x ? ⏎ ⇥h x ⏎ ⇥inc`・
    // `vk : k 1` の vk → k → h → vk）。前の作り（例外で抜けた枠を輪の依りに持つ記録に印を付けない）で全部を握りつぶすと、a が先
    // なら黙って通った（5040 のうち 1680）。今は、握りつぶしても後の計算が印から同じ輪をもう一度見つける（確かめ 2026-10-20、
    // 生成器 1 万本で、全部を握りつぶす写しと答え・輪の道筋が同じ）が、見つけた本物の輪を捨てる理由が無いので、断る側に置く。
    // 1項の `:` の左（枝の条件）を覗いた所を通る輪は、投げ直す（断る側。§5 Q30 の未決）。枝の条件も解かない（P3）が、本体を
    // 実行すれば評価するので、値は本当にできない（`v : (g 1) , 1`・`g : x ? ⏎ ⇥(v 2) : 1`）。ただ、覗くのは値の定義の名前だけ
    // なので、関数を1つ挟む（`(f 2) : 1`・`f : x ? v`）と HEAD のまま通る。
    if (inDefault && e.cycleFrom < start) {
      F.cycleRefused = before;
      return false;
    }
    throw e;
  }
}

// `,`（R19・G3）。値だけの並びはそのまま `,` の内に置く。関数か未知を含む2項以上の並びが括らずに直の被演算子に
// なると、`(f x) , …` と `f (x , …)` のどちらかが決まらない（§5 Q3）ので断る。
//
// 2項以上の辺は、項の種類を1回だけ付けて G3 を見、付けた項のまま縮める。種類を付けると括りの中まで解けるので、
// G3 を見るためだけに付けて捨て、縮めるときにもう一度付けると、各段に `,` のある括りの入れ子で1段ごとに倍の時間が
// かかる（深さ 20 で数秒）。前置 `@`（L）と括らない `!_`（未知）は、種類が A でないのでここで断られる。
function resolveProduct(tree, ctx) {
  if (isBlockSeq(tree.left)) throw refuseIndentBlock("`,` の左");
  const sides = [tree.left, tree.right].map((side) => {
    if (!side || side.type !== "seq" || side.terms.length < 2) return null;
    const items = classifyItems(side.terms, ctx);
    if (items.some((c) => c.cat !== "unit" && c.desc.k !== "A")) {
      throw gate("G3", `\`,\` の被演算子 \`${writeTree(side)}\` は関数か種類の未知な物を含む余積の並びです。括って書きます（§5 Q3）。`);
    }
    return items;
  });
  const left = sides[0] ? reduceItems(sides[0], ctx) : resolveTree(tree.left, ctx);
  const right = sides[1] ? reduceItems(sides[1], ctx) : resolveTree(tree.right, ctx);
  return { t: "op", sym: ",", left, right, kind: A() };
}

function isBlockSeq(tree) {
  return !!tree && tree.type === "seq" && tree.terms.length === 1 && isBareIndent(tree.terms[0]);
}

// 関数の範囲。鍵は外の範囲と書いた `?` で決まる（仮引数は書いた綴りで決まり、局所の名前も本体の綴りで決まる）。
// 実体の範囲は、この鍵を実体の鍵で置き換え、仮引数に当てた desc を持つ（instantiate）。
function makeLambda(op, ctx) {
  const params = parseParams(op.left);
  const scope = {
    parent: ctx.scope,
    params: new Map(params.names.map((p) => [p.name, p.cls])),
    locals: new Set(),
    hasImport: hasImportIn(op.right),
    key: `${ctx.scope.key}/${lambdaKey(op, "")}`,
  };
  scanLocals(op.right, scope, ctx.F);
  return { params, scope };
}

// `?`（P3：左は解かず、右を関数の範囲で解く）。片側の欠けた `?` は点なし（unwrapLambda の注）なので、種類は未知。
// 括りの関数は、ここでは本体を解かない（R25）。木は resolve の最後に、集めた実体で埋める（patternNode）。
function resolveLambda(op, ctx) {
  if (isSection(op)) {
    return { t: "lambda", paramsText: op.left ? writeTree(op.left) : "", body: op.right ? resolveTree(op.right, ctx) : null, kind: U() };
  }
  const pattern = patternParamsOf(op.left);
  if (pattern) return patternNode(op, pattern, ctx);
  const inDefault = patternCallInDefaults(op.left, ctx);
  if (inDefault) {
    throw gate(
      "G7",
      `仮引数の既定値の中で括りの関数 \`${inDefault}\` を呼んでいます。\`?\` の左は解かない（P3）ので、ここで呼んでも実体が作れず、本体の読みが決まりません（R25）。`
    );
  }
  const lam = makeLambda(op, ctx);
  const named = ctx.F.namedLambdas.has(op);
  // 無名の素の関数は、本体を解く間に引いた仮置きを覚える（collectedRoot の注）。
  const col = lam.params.plain && !named ? beginCollect(ctx.F, `無名の関数 \`[${cutShape(writeTree(op))}]\` の本体`) : null;
  let body;
  try {
    body = resolveBody(op.right, { ...ctx, scope: lam.scope });
  } finally {
    if (col) endCollect(ctx.F, col);
  }
  let fn = { type: "other" };
  if (lam.params.plain) {
    fn = {
      type: "plain",
      origin: "plain",
      n: lam.params.names.length,
      getBodyRoot: named
        ? () => bodyRootOf(ctx.F, op)
        : collectedRoot(ctx.F, col, body.rootKind, () => resolveBody(op.right, { ...ctx, scope: lam.scope, diag: null }).rootKind),
      idKey: lambdaKey(op, ctx.scope.key),
      envDepth: envDepth(ctx.scope), // 鍵の深さ（fnDepth）
    };
  }
  return { t: "lambda", paramsText: op.left ? writeTree(op.left) : "", body: body.tree, kind: { k: "L", fn } };
}

// 括りの関数の `?` の木。名前の定義なら名前で、`?` の括りなら書いた綴りで名指しする（呼んだ行で断るときの言い分）。
// 本体の中の名前は読まないので、未定義でも information を出さない（R25：読まない本体）。
function patternNode(op, pattern, ctx) {
  const def = ctx.F.namedLambdas.get(op);
  const label = def ? def.name : `[${writeTree(op)}]`;
  const fn = patternFn(ctx.F, op, pattern, ctx.scope, label);
  const body = op.right;
  const deferText =
    body && body.type === "seq" && body.terms.length === 1 && isBareBlock(body.terms[0], "indent")
      ? body.terms[0].core.rows.map(writeTree).join(" ⏎ ")
      : writeTree(body);
  const node = { t: "lambda", paramsText: writeTree(op.left), pattern: { op, scopeKey: ctx.scope.key, deferText, insts: null }, kind: { k: "L", fn } };
  ctx.F.patternNodes.push(node);
  return node;
}

// 関数の本体を解く。返す物は {tree, rootKind}。字下げのブロックの本体は、全部の行（枝なら値の側）の根が A の
// ときだけ A（§3.4）。局所の定義の行は、定義か枝か決まらないので A に数えない。
function resolveBody(right, ctx) {
  if (right && right.type === "seq" && right.terms.length === 1 && isBareBlock(right.terms[0], "indent")) {
    const rows = right.terms[0].core.rows.map((r) => resolveTree(r, ctx));
    const k = blockBodyKind(rows);
    const term = right.terms[0];
    return { tree: { t: "leaf", term, cat: "plain", desc: { k }, kind: { k }, view: { v: "block", rows } }, rootKind: k };
  }
  const tree = resolveTree(right, ctx);
  return { tree, rootKind: tree ? tree.kind.k : "U" };
}

function blockBodyKind(rows) {
  const valueKind = (t) => {
    if (!t) return "U";
    if (t.t === "leaf" && t.view.v === "block") return blockBodyKind(t.view.rows);
    return t.kind.k;
  };
  const rowKind = (row) => {
    if (row && row.t === "op" && row.sym === ":") return row.isLocalDef ? "U" : valueKind(row.right);
    return valueKind(row);
  };
  return rows.every((r) => rowKind(r) === "A") ? "A" : "U";
}

// ---------------------------------------------------------------------------
// 余積の並びを解く（§3.3 の手順、R7）
// ---------------------------------------------------------------------------

function leafOf(term, c) {
  return {
    t: "leaf",
    term,
    cat: c.cat,
    desc: c.desc,
    kind: c.desc,
    view: c.view,
    isLambdaName: !!c.isLambdaName,
    isQBracket: !!c.isQBracket,
  };
}

function resolveSeq(terms, ctx) {
  return reduceItems(classifyItems(terms, ctx), ctx);
}

// 0. 項を作る。字下げのブロックは並びの項にならない（§2、refuseIndentBlock の注）。
function classifyItems(terms, ctx) {
  if (terms.length >= 2 && terms.some(isBareIndent)) throw refuseIndentBlock("余積の並びの項");
  return terms.map((t) => leafOf(t, classify(t, ctx)));
}

function reduceItems(items, ctx) {
  // 1項の並びは、その項そのもの（手順の3）。ただし括らない `!_` は手順1で見るので、1項でも G7 にする。手順1の
  // 「括らない `!_`：…それ以外なら G7」は、手順3の「項が1つなら終わる」より前にあり、項の数を問わない（R18
  // 「それ以外の位置は G7」、§2「それ以外の位置」）。1項で終わらせると、`x : !_` や本体が `!_` だけの関数が、
  // 恒等射とも K とも決まらないまま値の段へ流れる。
  if (items.length === 1) {
    if (items[0].cat === "idNeg") throw refuseIdNeg("1項の並び");
    return single(items[0]);
  }

  // 1. 前検査
  const unknown = items.find((i) => i.cat === "plain" && i.desc.k === "U");
  if (unknown) {
    throw gate("G7", `種類の決まらない項 \`${showView(unknown.view)}\` が余積の並びにあります。隣とどう結ぶかが決まりません（R24・R26、§5 Q10・Q19・Q22）。`);
  }
  if (items.some((i) => i.cat === "ptilde")) {
    throw gate("G4", "前置 `~` の項が2項以上の並びにあります。前置 `~` の被演算子は決まっていません（§5 Q14）。");
  }
  // R18：括らない `!_` は、すぐ左が L・すぐ右が A のときだけ取り除く（恒等射の単位律 f ; id = f の読み）。
  // 撒く項（`go !_ vs~`）も §2 では A（撒く印つき）なので、すぐ右が A に数える。取り除く根拠は単位律 f ; id = f
  // で、すぐ右の A が撒くかどうかは単位律に関わらない（撒く項を外す根拠は仕様に無い）。
  for (let i = 0; i < items.length; ) {
    if (items[i].cat !== "idNeg") {
      i++;
      continue;
    }
    const l = items[i - 1];
    const r = items[i + 1];
    if (l && r && l.cat === "plain" && l.desc.k === "L" && r.cat === "plain" && r.desc.k === "A") {
      items.splice(i, 1);
      continue;
    }
    throw refuseIdNeg("並びの中の、すぐ左が関数ですぐ右が値でない位置");
  }
  items.forEach((it, i) => {
    if (it.cat !== "input") return;
    if (i !== 0) throw gate("G6", `前置 \`@\` の項 \`${showView(it.view)}\` が並びの頭以外にあります（§5 Q9）。`);
    const r = items[1];
    if (r && r.cat === "plain" && r.desc.k === "L") throw gate("G6", `前置 \`@\` の項 \`${showView(it.view)}\` のすぐ右が関数です（§5 Q9）。`);
  });

  // 2. 字面の `_`（§3.5）
  if (items.some((i) => i.cat === "unit")) {
    if (items.every((i) => i.cat === "unit")) return single(items[0]);
    const hole = tryHole(items, ctx);
    if (hole) return hole;
    let j = 0;
    while (items[j].cat === "unit") j++;
    const isCleanA = (i) => i.cat === "plain" && i.desc.k === "A" && !containsUnit(i.term);
    if (j > 0 && items.slice(j).every(isCleanA)) items = items.slice(j); // R15：0 ⊕ A ≅ A
    else {
      throw gate("G5", "字面の `_` が、§3.5 の3つの形（全部が `_`・先頭の `_`・穴）の外にあります。適用か合成か・単位か穴かが決まりません（§5 Q7・Q18）。");
    }
    if (items.length === 1) return items[0];
  }

  // 3〜7. 縮める
  while (items.length > 1) {
    checkNodes(items);
    let i = findPair(items, (a, b) => (a === "A" && b === "A") || (a === "L" && b === "L"));
    if (i >= 0) {
      const k = items[i].kind.k;
      let j = i;
      while (j + 1 < items.length && items[j + 1].kind.k === k) j++;
      const group = items.slice(i, j + 1);
      items.splice(i, group.length, k === "A" ? makeConstruct(group) : makeCompose(group));
      continue;
    }
    i = findPair(items, (a, b) => a === "L" && b === "A");
    if (i >= 0) {
      items.splice(i, 2, makeApply(items[i], items[i + 1]));
      continue;
    }
    i = findPair(items, (a, b) => a === "A" && b === "L");
    if (i >= 0) {
      items.splice(i, 2, makeReverse(items[i], items[i + 1]));
      continue;
    }
    throw gate("G11", "余積の並びに、どの対（構築・合成・適用・逆適用）も見つかりません（§5 Q16）。");
  }
  return items[0];
}

// 1項の並びは、その項そのもの。前置 `@`・前置 `~`・字面の `_` が1つだけの根は、種類を決めない。
function single(item) {
  if (item.cat === "input" || item.cat === "ptilde" || item.cat === "unit") {
    return { ...item, kind: U() };
  }
  return item;
}

// 項が字面の `_` を含むか（R15「`_` を含まない A の項」）。括りや囲みの中の行も見る。`_ [_ 1]` の中の `_` を
// 見ないと、R15 の文面の外（`_` を含む項）まで先頭の `_` を取り除いてしまう。R15 は `_` を関数と読んでも値が
// 割れない形だけに狭めた規則なので、文面より広げない。
function containsUnit(term) {
  if (!term) return false;
  if (term.type === "infix") return containsUnit(term.left) || containsUnit(term.right);
  if (term.core.c === "unit") return true;
  return !!term.core.rows && term.core.rows.some(treeContainsUnit);
}
function treeContainsUnit(tree) {
  if (!tree) return false;
  if (tree.type === "seq") return tree.terms.some(containsUnit);
  return treeContainsUnit(tree.left) || treeContainsUnit(tree.right);
}

function findPair(items, test) {
  for (let i = 0; i + 1 < items.length; i++) if (test(items[i].kind.k, items[i + 1].kind.k)) return i;
  return -1;
}

// 手順の 8：節が対に入ろうとしたら、種類の未知な節（G2(a)）と `excess` の節（G12(a)）を断る。2項以上が残って
// いれば、その節はいずれ隣と結ぶので、縮めるたびに見ればよい。
function checkNodes(items) {
  if (items.length < 2) return;
  for (const it of items) {
    if (it.t === "leaf") continue;
    if (it.kind.k === "U") throw gate("G2(a)", `種類の決まらない節 \`${show(it)}\` が隣と結ぼうとしています（R24、§5 Q8・Q13・Q17・Q21）。`);
    if (it.excess) throw gate("G12(a)", `実引数がアリティより多い適用 \`${show(it)}\` が隣と結ぼうとしています。余りの扱いは値の段で決まります（§5 Q11・Q6）。`);
  }
}

// R8：構築の子の構築は開いて並べる（左からの畳み込みと同じ）。括りと囲みは葉なので開かない。
function makeConstruct(group) {
  return { t: "construct", items: group.flatMap((g) => (g.t === "construct" ? g.items : [g])), kind: A() };
}

function makeCompose(group) {
  const items = group.flatMap((g) => (g.t === "compose" ? g.items : [g]));
  const partial = group.some((g) => (g.t === "apply" && g.insufficient) || (g.kind.fn && g.kind.fn.type === "compose" && g.kind.fn.partial));
  const fns = items.flatMap((i) => (i.kind.fn && i.kind.fn.type === "compose" ? i.kind.fn.fns : [i.kind.fn]));
  return { t: "compose", items, partial, kind: { k: "L", fn: { type: "compose", fns, partial } } };
}

function isPartialCompose(x) {
  return !!(x.kind.fn && x.kind.fn.type === "compose" && x.kind.fn.partial);
}

// 5. 適用（L, A）。実引数は右の値の並び全体（R10）。
function makeApply(head, arg) {
  if (isPartialCompose(head)) {
    throw gate("G2(b)", `足りない適用を含む合成 \`${show(head)}\` が適用の頭になっています。\`f 1 g 2\` の読みは決まっていません（§5 Q4）。`);
  }
  return { t: "apply", head, arg, rev: false, ...applyKind(head.kind.fn, arg) };
}

// 6. 逆適用（A, L）：`x h` は `(apply h x ·rev)`（R12）。左は撒かない1項、右はアリティ1の素の関数（名前か
// `?` の括り）か、最初の関数がそれにあたり点なしも足りない適用の節も含まない合成だけを通す。
function makeReverse(left, right) {
  if (left.t === "construct") throw gate("G1", `逆適用の左が構築の並び \`${show(left)}\` です（§5 Q6）。`);
  if (left.t === "leaf" && left.desc.spread) throw gate("G9", `逆適用の左に撒く項 \`${show(left)}\` は書けません（R14）。`);
  if (left.excess) throw gate("G12(a)", `実引数がアリティより多い適用 \`${show(left)}\` が逆適用の左にあります（§5 Q11・Q6）。`);
  const fn = right.kind.fn;
  const fns = fn && fn.type === "compose" ? fn.fns : [fn];
  if (fns.some((f) => f && f.pointfree)) throw gate("G10", `逆適用の右 \`${show(right)}\` が点なしか、点なしを含む合成です（R13、§5 Q23）。`);
  if (isPartialCompose(right)) throw gate("G2(b)", `足りない適用を含む合成 \`${show(right)}\` が逆適用の右になっています（§5 Q4）。`);
  const unaryPlainLeaf = (x) =>
    x.t === "leaf" && x.kind.fn && x.kind.fn.type === "plain" && x.kind.fn.origin === "plain" && x.kind.fn.n === 1 && (x.isLambdaName || x.isQBracket);
  const ok = right.t === "compose" ? unaryPlainLeaf(right.items[0]) : unaryPlainLeaf(right);
  if (!ok) throw gate("G8", `逆適用の右 \`${show(right)}\` が、アリティ1の素の関数でも、それで始まる合成でもありません。主語がどの仮引数に入るかは決まっていません（§5 Q5）。`);
  return { t: "apply", head: right, arg: left, rev: true, ...applyKind(fn, left) };
}

// できた適用の節の種類（§3.4、R9）。返す物は {kind, excess?, insufficient?}。挙げた形だけを決め、ほかは未知。
function applyKind(fn, arg) {
  // 合成は、撒く項があっても最初の関数への適用から畳む（composeApply の注）。撒く項は k を数えない（未知）だけで、最初の
  // 関数は呼ばれるので、足りたか決まらない頭（§5 Q27）と同じく、後ろの括りの関数は未知を受けて実体を作る。前はここで
  // 合成ごと未知で返し、後ろの実体を作らなかった（`inc bad vs~` が通っていた）。
  // 撒く項を受ける関数そのものが括りの関数なら、下の spread で未知を返し、実体は作らない（R24「撒く項があれば k は数えない
  // （未知）」。どの仮引数に何が当たるかが決まらない）。だから `bad inc vs~`・`bad 1 vs~` は bad の本体を読まずに通り、
  // `inc bad vs~` は G5 で断る。未知を受けて作るか、名指しの門で断るかは決めていない（§5 の未決、合成の畳み込みの確かめの F3）。
  if (fn && fn.type === "compose") return composeApply(fn, arg);
  const args = arg.t === "construct" ? arg.items : [arg];
  const k = args.length;
  const spread = args.some((a) => a.t === "leaf" && a.desc.spread); // 撒く項があれば k は数えない
  if (!fn || spread) return { kind: U() };
  switch (fn.type) {
    case "plain":
      return plainApply(fn, k);
    case "pfUnary":
      return k === 1 ? { kind: A() } : { kind: A(), excess: true };
    case "pfGreedyUnary":
      return { kind: A() };
    case "pfGreedyBinary":
      return k >= 2 ? { kind: A() } : { kind: U() }; // `[+]` に1項は未知（§5 Q17）
    case "pfPick":
      // `[' k] x` は `x ' k` と同じ desc（R26）。引いた物が関数なら L（fn つき）。k ≠ 1 と鍵の無い形は未知。
      return k === 1 && fn.key ? { kind: pickDesc(descOfTree(args[0]), fn.key) } : { kind: U() };
    case "pattern":
      // 括りの関数（R24）：k = n のときは前から順に当てて実体を作る。
      if (k === fn.n) return fn.instantiate(args.map(descOfTree));
      // 最後の仮引数が括りなら、k > n のとき前の仮引数に1つずつ当てて、残りの並び全体を最後の括りが1つの List として
      // 受ける（`map $[* 2] 1 2 3 4 5` は `map $[* 2] [1 2 3 4 5]` と、`f 1 2 3` は `f [1 2 3]` と同じ）。利用者 2026-10-19
      // 「括りの仮引数が1つの関数に `f 1 2 3` を渡したら、`f [1 2 3]` と同じでいい？」に「それでいいよ」（撒いて渡す先
      // だった裸の `x ~xs` は廃止したので、並びは括りが受ける）、続けて「最後の仮引数が括りの関数は、前の仮引数に1つずつ
      // 当てて、残りの並び全体を最後の括りが受ける。」。残りは実引数1つなので、`excess` は付けない。
      if (fn.lastBracket && k > fn.n) {
        const front = args.slice(0, fn.n - 1).map(descOfTree);
        const rest = descOfTree({ t: "construct", items: args.slice(fn.n - 1), kind: A() });
        return fn.instantiate([...front, rest]);
      }
      // k < n は、素の関数と同じく部分適用（残り n − k の L）。当てた物は覚えておき、残りが来た所で合わせて実体を作る
      // （利用者 2026-10-19「括りの関数に実引数が足りないときも、素の関数と同じく部分適用（残りの仮引数を待つ関数）に
      // する。」）。足りない適用なので、素の関数と同じく `insufficient`（合成に入れば partial、G2(b)）。
      if (k < fn.n) return { kind: { k: "L", fn: patternPartial(fn, args.map(descOfTree)) }, insufficient: true };
      // 最後の仮引数が裸で k > n は、素の関数と同じく前から n 個を当てて、余り（`excess`）にする。本体の根が A でなければ
      // G12(b)（plainApply と同じ）。余りの扱いは値の段（§5 Q11）。利用者 2026-10-19「最後の仮引数が裸の括りの関数に
      // 多く渡したときは、素の関数と同じく前から n 個を当てて、余り（excess）にする。」
      if (fn.instantiate(args.slice(0, fn.n).map(descOfTree)).kind.k !== "A") {
        throw gate("G12(b)", `実引数がアリティより多いのに、頭の本体の根が値ではありません（§5 Q21・Q11）。`);
      }
      return { kind: A(), excess: true };
    default:
      return { kind: U() }; // `@p`・`[|]` など・既定値のある関数
  }
}

function plainApply(fn, k) {
  if (k < fn.n) {
    // 足りない適用は L（残り n−k）。本体の根は元の関数のもの。穴の部分適用（`[f3 _ _ 3] 1`・`h2 : h1 1`）は穴の出どころ
    // （origin "hole"）のまま持つ。出どころを見るのは、逆適用の右と穴の頭（どちらも "plain" だけを通すので、"hole" と
    // "partial" を分けない）と実体の鍵（fnKey）だけである。合成はもう出どころを見ない（composeApply：合成は適用の畳み込み
    // なので、後ろの穴も、穴の部分適用も、直接書いた `[f3 1 _ 3] (inc 5)` と同じ読み）。
    const origin = fn.origin === "hole" ? "hole" : "partial";
    return { kind: { k: "L", fn: { type: "plain", origin, n: fn.n - k, getBodyRoot: fn.getBodyRoot, idKey: fn.idKey, envDepth: fn.envDepth } }, insufficient: true };
  }
  const root = fn.getBodyRoot();
  if (k === fn.n) return { kind: root === "A" ? A() : U() };
  if (root !== "A") {
    throw gate("G12(b)", `実引数がアリティより多いのに、頭の本体の根が値ではありません（§5 Q21・Q11）。`);
  }
  return { kind: A(), excess: true };
}

// 合成の適用は、適用の繰り返しである：(g∘f) x = g (f x)。合成は左から実行する（R11）ので、`f1 f2 … fm x` は
// fm (… (f2 (f1 x)) …)。だから種類は、最初の関数を並び x に当てた適用から始めて、後ろの関数に前の結果を1つの実引数として
// 当てた適用を左から畳んで決める（どれも applyKind）。合成のための表は持たない。前は合成の行（§3.4）を適用とは別の表と
// して育て、後ろの関数を名簿（本体の根が A のアリティ1の素の関数・その部分適用・貪欲な単項・アリティ1の括りの関数）で
// 数えていたので、直接書いた g (f x) と答えが割れていた（§5 Q13・Q24・Q26・Q27 は、その割れが表に出た物。主の Claude が
// 「合成の適用を、適用を左から畳む形に作り直して合成用の表を消す」と言い、利用者 2026-10-19「その方向でお願い」）。
// - 最初の関数は、頭の適用と同じ（k = n・残りを最後の括り・部分適用・余り）。足りなければ L で、足りない適用の印つき。
//   何を残すかは後ろの関数まで含めて決まらないので、アリティは未知にする。G12(b) と、括りの関数の実体の門（R25）は
//   applyKind がそのまま投げる。
// - 前の結果が A（足りた適用で、余りでない）なら、その desc（形を持っていれば形ごと、R24・R26）を1項の実引数として次の
//   関数に当てる。直接書いた g (f x) の g が受ける物と同じにするためである。
// - 前の結果が L か未知なら、そこから先は未知。関数を値として次へ渡す読みは決めていない（素の関数の裸の仮引数は A しか
//   受けない）。ただし括りの関数（とその部分適用）は、前の結果（未知）を受けて実体を作る。後ろの関数は前の結果を受けて
//   呼ばれ（R11）、呼ばれた本体は読む（R25、§5 Q24）。最初の関数に足りたか決まらない形（`[+]` に1項 Q17・既定値のある
//   関数 Q8・撒く項を含む並び）でも作る（§5 Q27 の断る側）。作らないと、呼ばれるかもしれない本体の門が合成の頭に置く
//   だけですり抜ける（前は `[+] bad 5` を通し、`inc [+] bad 5` を断っていた）。ほかの関数は本体の根を引かない（答えに
//   使わない）。前は、使わない根を引くと、解いている途中の関数の仮置き（consult）の依りが増え、仮置きが外れると、それを
//   使っていない外の本体の根まで未知に替わって、定義の順で答えが割れた（§5 Q28。確かめ 2026-10-19 の F1：
//   `g : y ? (adder (f 1) y) , 1` は f が先だと `g 5 inc` が G2(a)、g が先だと A）。外れた仮置きに頼った答えを解き直すように
//   した（2026-10-20、「仮置きの記録」の注）後は、依りが増えても解き直しの手間が増えるだけで、答えは割れない。
//   前の結果が A の間は、後ろの関数に当てて根を引く（直接書いた g (f x) と同じ）ので、その後で未知になれば、引いた根は
//   答えに使われない（`inc [+ 1] f [+] y`）。未知の後ろの括りの関数の実体の本体が引く根も同じ（`[+] tl y` の tl の本体が
//   `f 1 5` を呼ぶ形）。どちらも直接書いた入れ子（`[+] (f ([+ 1] (inc y)))`・`tl y`）が同じ根を引くので、法則どおりである。
//   解き直す前は、ここから Q28 の割れに入った（合成の畳み込みの確かめの F2。法則の試験の Q28_FORMS の4〜9つ目）。
//   直接書いた g (f x) と同じになるのは、f x が A のときである。f x が未知なら、直接書いた形は未知の項を並びに置くので
//   G7 で断るが、合成は節ごと未知にして根なら通す（§3.4 の「上に無いもの」と同じ扱い）。
// - 最初の関数の余り（`excess`）は、結果が A なら最後まで持ち越す（R10。余りは最初の関数の実引数の話）。
function composeApply(fn, arg) {
  const [first, ...rest] = fn.fns;
  if (!first) return { kind: U() };
  const r0 = applyKind(first, arg);
  if (r0.insufficient) return { kind: { k: "L", fn: { type: "other" } }, insufficient: true };
  // prev：前の結果が A ならその desc、L か未知なら null。
  let prev = r0.kind.k === "A" ? r0.kind : null;
  for (const f of rest) {
    if (prev) {
      const r = applyKind(f, composeLeaf(prev));
      prev = r.kind.k === "A" && !r.insufficient && !r.excess ? r.kind : null;
    } else if (f && f.type === "pattern") {
      applyKind(f, composeLeaf(U()));
    }
  }
  if (!prev) return { kind: U() };
  return r0.excess ? { kind: prev, excess: true } : { kind: prev };
}

// 合成の中で、前の関数の結果を次の関数へ渡す1項の実引数。applyKind と descOfTree がそのまま読む葉にする。
function composeLeaf(desc) {
  return { t: "leaf", term: null, cat: "plain", desc, kind: desc, view: { v: "atom", text: "·" } };
}

// R16：穴。並び全体が `h t1 … tn` で、h が素の関数・撒く項が無い・k = n・`_` 以外の ti が全部 A・`_` がどれも
// 最後の項でないとき、各 `_` を生成名に替えて `(? [$p0 …] (apply h …))` にする。種類は L、アリティは穴の数。
function tryHole(items, ctx) {
  const h = items[0];
  const fn = h.kind.fn;
  if (h.cat !== "plain" || h.kind.k !== "L" || !fn || fn.type !== "plain" || fn.origin !== "plain" || !(h.isLambdaName || h.isQBracket)) return null;
  const ts = items.slice(1);
  if (ts.length !== fn.n) return null;
  if (!ts.some((t) => t.cat === "unit") || ts[ts.length - 1].cat === "unit") return null;
  if (!ts.every((t) => t.cat === "unit" || (t.cat === "plain" && t.desc.k === "A" && !t.desc.spread))) return null;
  const params = [];
  const args = ts.map((t) => {
    if (t.cat !== "unit") return t;
    const name = `$${ctx.F.holePrefix}${params.length}`;
    params.push(name);
    return { t: "leaf", term: null, cat: "plain", desc: A(), kind: A(), view: { v: "atom", text: name } };
  });
  const arg = args.length === 1 ? args[0] : makeConstruct(args);
  const body = { t: "apply", head: h, arg, rev: false, ...applyKind(fn, arg) };
  return { t: "hole", params, body, kind: { k: "L", fn: { type: "plain", origin: "hole", n: params.length, getBodyRoot: fn.getBodyRoot, idKey: fn.idKey, envDepth: fn.envDepth } } };
}

// ---------------------------------------------------------------------------
// 入り口
// ---------------------------------------------------------------------------

/**
 * ソースを前段に通し、余積を解いた木を返す。
 * @param {string} source
 * @returns {{ trees: object[], diagnostics: object[] }}
 */
export function resolve(source) {
  const lines = frontEnd(source).map((words) => parseRow(words));

  const diagnostics = [];
  const F = {
    defs: new Map(),
    namedLambdas: new Map(),
    valueMemo: new Map(),
    bodyMemo: new Map(),
    stack: [],
    inProgress: new Map(),
    fileScope: null,
    holePrefix: "p",
    reported: new Set(),
    // 括りの関数の実体（R24・R25）：鍵 → 実体、書いた `?` → 範囲の鍵 → その `?` を通って呼んだ実体（recordCall）、
    // 根の種類の仮置きの記録、木を解いている途中の実体、定義の行の `?` の木（最後に実体で埋める）、実体の本体の
    // information の出し先。
    instances: new Map(),
    // 書いた `?` → それを通って呼んだ確定した実体の集まり（INSTANCE_TOTAL_LIMIT）、作って外れていない実体の数
    // （INSTANCE_WORK_LIMIT）。
    instanceTotals: new Map(),
    instancesMade: new Map(),
    calls: new Map(),
    instMemo: new Map(),
    matStack: [],
    patternNodes: [],
    diag: diagnostics,
    // 無名の素の関数の本体を解いている間に引いた仮置き（collectedRoot）。
    collectors: [],
    // 記録の鍵 → 古くなって解き直した回数（freshMemo）、枠を積んだ鍵、解き直しの守りで断った誤り（guardAgain）。
    againCounts: new Map(),
    frameKeys: new Set(),
    againRefused: null,
    // 値を含む輪で断った誤り（cycleError）。
    cycleRefused: null,
    // 実体の守りで断った誤り（guardRefusal。total・work・nest）と、解いている途中の実体の入れ子の数（enterNest）。
    guards: {},
    instNest: 0,
  };
  resetIntern();

  // P2：ファイルのいちばん外の定義を、先に全部集める（順序に依らない）。
  for (const line of lines) {
    const def = asDefinition(line);
    if (!def) continue;
    if (F.defs.has(def.name)) throw nameError("name-duplicate", `\`${def.name}\` がファイルのいちばん外で2回定義されています。`);
    F.defs.set(def.name, def);
    if (def.lambda) F.namedLambdas.set(def.lambda, def);
  }
  checkParamNames(lines, F);
  F.fileScope = { parent: null, params: null, locals: null, hasImport: lines.some(hasImportIn), key: "file" };

  // 穴の生成名は、ソースの名前と衝突しない綴りにする（`$p0` が `p0` の番地と読めないように）。
  const names = new Set();
  for (const line of lines) forEachNameInTree(line, (n) => names.add(n));
  while ([...names].some((n) => new RegExp(`^${F.holePrefix}\\d+$`).test(n))) F.holePrefix += "_";

  // 種類を計算する順（§6.4 の1）：名前の種類、次に各「素の」関数の本体の根。ここで輪（name-cycle）を先に見つける。
  // 括りの関数の本体は、ここでは解かない（R25：実体を作るとき＝呼ばれたときにだけ解く）。§6.4 の1の3は「各関数の
  // 本体の根」と書いたままだが、R25 が後から決まったので、素の関数に読む。
  // 門はここでは止めない——その行を解くときに、行の順に同じ門で断る。
  // 解き直しの守り（guardAgain）で断ったら、ほかの誤りより先に、その言い分で断る（握りつぶされても、ほかの門に化けても）。
  // 値を含む輪（cycleError）で断ったら、その次に、その言い分で断る（輪は種類を計算する所で見つかるので、普通は行を解く
  // 前に、輪の言い分のまま投げ上がる）。
  // 実体の守り（総数・作った実体の数・入れ子の数、guardRefusal）に当たったら、その次に、ほかの門より先に断る（当たった所は
  // 門として未知になり、根の種類を解く所や namesPattern に握りつぶされても、覚えた断りは残る）。輪より後に置くのは、守りの
  // 断りが解く順に依らずに見つかる輪を覆わないため（前は総数の守りが先に投げ上がり、輪を見る前に止まる並べ方があった。確かめ
  // 2026-10-20）。実体の深さの守りは、鍵だけで決まる普通の門なので、ほかの門と同じく行を解くときに断る（INSTANCE_DEPTH_LIMIT
  // の注の1）。
  let trees;
  try {
    for (const def of F.defs.values()) {
      if (def.lambda) continue;
      try {
        nameKindOf(F, def);
      } catch (e) {
        if (!isGate(e)) throw e;
      }
    }
    for (const def of F.defs.values()) if (def.lambda && def.plain) bodyRootOf(F, def.lambda);

    // 各行を解く。括りの関数の実体は、呼んだ所で作って木まで解く（instantiate）。
    trees = lines.map((line) => resolveTree(line, { F, scope: F.fileScope, diag: diagnostics }));
  } catch (e) {
    throw F.againRefused || F.cycleRefused || guardRefused(F) || stackRefusal(e) || e;
  }
  if (F.againRefused) throw F.againRefused;
  // 値を含む輪を、どこかで握りつぶしても断る（namesPattern は、既定値を覗いた所を通る輪だけを握りつぶし、そのときは
  // F.cycleRefused を覗く前に戻す。namesPattern の注）。
  if (F.cycleRefused) throw F.cycleRefused;
  const guarded = guardRefused(F);
  if (guarded) throw guarded;

  // 括りの関数の `?` の木を、ファイル全体で集めた実体で埋める（R25）。全部の行を解き終えてから埋めるので、呼ぶ行が
  // 定義の前でも後でも同じ木になる。並べるのは、その `?` を通って呼ばれ（recordCall）、木まで解けた実体だけ：門に
  // 当たった実体は呼んだ行で断る（定義の行では断らず、描かない）。根の種類を出すときだけ仮に作った実体（仮置きの上で
  // 作った形）も、木まで解かれないので描かない。並び順は形の綴り、同じ綴りなら鍵（どちらも書いた物だけで決まる。
  // 鍵は canonKey なので、形を見た順に依らない）。
  for (const node of F.patternNodes) {
    const byScope = F.calls.get(node.pattern.op);
    const called = byScope && byScope.get(node.pattern.scopeKey);
    const insts = [...(called || [])].filter((i) => i.done && !i.error && i.tree);
    insts.sort((a, b) => (a.shapeText < b.shapeText ? -1 : a.shapeText > b.shapeText ? 1 : a.key < b.key ? -1 : a.key > b.key ? 1 : 0));
    node.pattern.insts = insts;
  }
  return { trees, diagnostics };
}

// ---------------------------------------------------------------------------
// 木を文字列にする
// ---------------------------------------------------------------------------

function showView(v) {
  if (!v) return "·";
  if (v.v === "atom") return v.text;
  if (v.v === "block") return `(block ${v.rows.map(show).join(" ")})`;
  return `(${v.sym} ${showView(v.left)} ${showView(v.right)})`;
}

/** 解いた木を S 式の文字列にする（書き方はファイルの頭の注）。 */
export function show(tree) {
  if (tree === null || tree === undefined) return "·";
  switch (tree.t) {
    case "leaf":
      return showView(tree.view);
    case "raw":
      return showView(tree.view);
    case "construct":
      return `(construct ${tree.items.map(show).join(" ")})`;
    case "compose":
      return `(compose ${tree.items.map(show).join(" ")})`;
    case "apply":
      return `(apply ${show(tree.head)} ${show(tree.arg)}${tree.rev ? " ·rev" : ""})`;
    case "hole":
      return `(? [${tree.params.join(" ")}] ${show(tree.body)})`;
    case "lambda":
      if (tree.pattern) {
        const insts = tree.pattern.insts || [];
        if (!insts.length) return `(? [${tree.paramsText}] (defer {${tree.pattern.deferText}}))`;
        return `(? [${tree.paramsText}] ${insts.map((i) => `(inst ${i.shapeText} ${show(i.tree)})`).join(" ")})`;
      }
      return `(? [${tree.paramsText}] ${show(tree.body)})`;
    case "op":
      return `(${tree.sym} ${show(tree.left)} ${show(tree.right)})`;
    default:
      throw new Error(`知らない節: ${tree.t}`);
  }
}

/** 木の根の種類：'A'・'L'・'未知'。 */
export function kindOf(tree) {
  const k = tree && tree.kind && tree.kind.k;
  return k === "A" ? "A" : k === "L" ? "L" : k === "U" ? "未知" : null;
}
