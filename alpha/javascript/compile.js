/**
 * コンパイルパイプラインの単一ドライバ（compiler_pipeline.md §3 のフロントエンド Pass 1〜3）。
 *
 * これまで各テスト・playgroundが同じ手順（preprocess → parse → buildEnv → reduceAll）を
 * それぞれコピーして持っており、pass1b と pass3 はどこからも呼ばれていなかった
 * （型を出しても消費者が存在しない状態）。ここに一本化する。
 *
 *   1. preprocess   lexer.js       前処理（separateInfix + markBlock）
 *   2. parse        parser.js      フラットなTerm列（sign.pegjs から生成）
 *   3. buildEnv     pass1.js       Pass 1a: 識別子テーブル（Layer 1 カテゴリ・アリティ）
 *   4. reduceAll    pass2.js       Pass 2: 余積の解決 → 二分木AST
 *   5. specialize   pass1b.js      Pass 1b: ジェネリック仮引数（@ref）の具体化
 *   6. annotate     pass3.js       Pass 3: Layer 2 型を全ノードへ注釈
 *
 * 【Passの順序が type_system.md §5 と食い違っている点】
 * §5 は Pass 1a → Pass 1b → Pass 2 → Pass 3 の順を書いており、呼び出しサイトの収集も
 * 「Pass 1a と同じ線形スキャンで記録する」としている。しかし実装では Pass 1b は Pass 2 の
 * **後**に走る。理由は、呼び出しサイトが何であるかは Pass 2 が余積（スペース）を
 * apply/compose/concat のどれに解決するかを決めるまで確定しないためである——
 * トークン列の段階では `f x` が関数適用なのかリスト構築なのか判定できない。
 * これは B-1（§5 Pass 1a の擬似コード）・B-3（§3.2 の左辺優先ルール）と同じ
 * 「§5 の記述が実装より単純化されている」系の食い違いであり、仕様側の修正候補。
 */

import { preprocess } from "./lexer.js";
import { parse } from "./parser.js";
import { buildEnv } from "./pass1.js";
import { reduceAll, desugarIndexRest } from "./pass2.js";
import { specializeGenericParams } from "./pass1b.js";
import { annotateAll, checkLayerConstraints, checkCharsetConstraints } from "./pass3.js";
import { findStreamFunctions, generatePullers, groupStreamFunctions, CURSOR_SUFFIXES } from "./stream_desugar.js";

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

// Pass 1b: トップレベルの各ラムダ定義について、ジェネリック仮引数（本体で `@` が
// 直接かかっている仮引数）を呼び出しサイトの実引数カテゴリで具体化する。
// 対象が無ければ空のMapが返るだけなので、ジェネリックを含まないプログラムでは実質no-op。
function runPass1b(nodes, env) {
  const specializations = new Map();
  for (const node of nodes) {
    if (!isDefineNode(node) || !node.right || node.right.name !== "lambda") continue;
    const result = specializeGenericParams(node, nodes, env);
    if (result.size > 0) specializations.set(node.left.value, result);
  }
  return specializations;
}

/**
 * ソースを Pass 1〜3 に通し、型注釈済みのASTを返す。
 *
 * @param source Sign のソース文字列
 * @param options.parse パーサーの差し替え（省略時はビルド済みの `parser.js`）。
 *   テストは `sign.pegjs`（正式仕様）から peggy で都度ビルドしたパーサーを渡す——
 *   `parser.js` は `npm run build:parser` の成果物であり、実際に一度8/4時点で
 *   止まったまま `sign.pegjs` の修正が反映されていなかったことがあるため、
 *   テストが文法ソースを直接検証する性質は保つ必要がある。
 * @returns {{ nodes, env, specializations, diagnostics }}
 *   nodes           行ごとの型注釈済みAST（各ノードに `atomType` が載る）
 *   env             Pass 1a の識別子テーブル（.ist 相当、プロセス内メモリのみ）
 *   specializations Pass 1b の具体化結果 Map<関数名, Map<仮引数名, {callsiteCount, categories}>>
 *   diagnostics     コンパイル時に検出した診断（Pass 3b の Unit 収束理由など。現状は空）
 */
// 縮約しきれずに残った式（pass2 が `{type:"unresolved"}` として返したもの）を探す。
// pass2 側のコメントが言う通りこれは「未対応の演算子等」であり、静的に判定できる
// 構文の誤りである。原理4（静的に決定可能な違反は自己責任に丸投げせず弾く）に従って
// ここで止める——以前はどこにも消費されず、評価時に静かに無視されていたため、
// `[5 !] 1` が 1 を返すなど、解決できていない式が無言で別の値になっていた。
function findUnresolved(node) {
  if (!node || typeof node !== "object") return null;
  if (node.type === "unresolved") return node;
  for (const key of ["left", "right", "operand"]) {
    const found = findUnresolved(node[key]);
    if (found) return found;
  }
  if (Array.isArray(node.lines)) {
    for (const line of node.lines) {
      const found = findUnresolved(line);
      if (found) return found;
    }
  }
  return null;
}

function describeUnresolved(node) {
  return node.items
    .map((x) => (typeof x === "string" ? x : x && x.type === "atom" ? x.value : "(式)"))
    .join(" ");
}

/**
 * 糖衣が置き換えた定義に印を付ける。同じ名前が2回出てくるので、**後ろがカーソルの入口**、
 * 前は元の関数である。元は AST に残す——インタプリタは元の形をそのまま走らせられるし、
 * 「均した先が同じ列になるか」はそれと突き合わせて初めて言える。
 */
function markCursorEntries(nodes, entries, superseded, group) {
  const names = new Set(entries);
  const dead = new Set(superseded);
  const last = new Map();
  const advName = group ? group + CURSOR_SUFFIXES.adv : null;
  let adv = null;
  for (const node of nodes) {
    if (!node || node.type !== "operation" || node.name !== "define") continue;
    const id = node.left;
    if (!id || id.type !== "atom" || id.kind !== "identifier") continue;
    const raw = String(id.value).replace(/^<|>$/g, "");
    if (names.has(raw)) last.set(raw, node);
    if (raw === advName) adv = node;
  }
  // `isEntry` は「元の名前」だけ。**入口は捕まえた入力を仮引数に持つ**ので、pullers の
  // 署名の種はそこから撒ける（pass3 の `seedCursorPullers`）。`_adv` はカーソルを返すが
  // 入口ではない——第1仮引数は枝番号であって入力ではないので、混ぜると種が間違う。
  const markBody = (node, raw, isEntry) => {
    if (!node.right || node.right.type !== "operation" || node.right.name !== "lambda") return;
    if (isEntry) node.right.cursorEntry = true;
    else node.right.cursorReturns = true;
    node.right.cursorGroup = raw;
    // 本体（`(arm s) , 0 , s`）にも印を付ける。積に見えるが、置かれるのは
    // `{arm, k, 入力}` の3つ組であってメモリ上の並びではない。分岐の場合は枝それぞれ。
    const body = node.right.right;
    if (!body) return;
    const arms = Array.isArray(body.lines) ? body.lines : [body];
    for (const line of arms) {
      const v = line && line.type === "operation" && line.name === "define" ? line.right : line;
      if (v) v.cursorGroup = raw;
    }
    // 分岐そのものにも印を付ける。どの枝もカーソルを返すので、合流した結果もカーソルである。
    body.cursorGroup = raw;
  };
  for (const [raw, node] of last) markBody(node, raw, true);
  // 進めた結果もカーソルである（`<g>_adv`）。枝はどちらも3つ組を返す。
  if (adv) markBody(adv, group, false);
  // 元の定義（同じ名前の、入口ではない方）は機械語を出さない。糖衣が置き換えたものを
  // もう一度出しても、同じ列を2通りに出すだけである。
  for (const node of nodes) {
    if (!node || node.type !== "operation" || node.name !== "define") continue;
    const id = node.left;
    if (!id || id.type !== "atom" || id.kind !== "identifier") continue;
    const raw = String(id.value).replace(/^<|>$/g, "");
    if (dead.has(raw) && last.get(raw) !== node) node.supersededByDesugar = true;
  }
}

function compile(source, options = {}) {
  const parseFn = options.parse || parse;
  const lines = parseFn(preprocess(source));
  const env = buildEnv(lines);
  // 添字位置の `N~` を終端の無いレンジへ均す（糖衣）。**後置 `~` の意味を「撒く」
  // 1つに絞るための書き換え**であり、逆適用（`x f`）と同じ扱いである——記号は残し、
  // 意味論からは消す。Pass 2 の出口でやるのは、ここが「構文の形が最後に見える場所」
  // だからである（Pass 3 以降は型の話しかしない）。
  const nodes = lines.map((line) => desugarIndexRest(reduceAll(line, env)));
  for (const node of nodes) {
    const bad = findUnresolved(node);
    if (bad) {
      throw new SyntaxError(
        `解決できない式です: ${describeUnresolved(bad)}` +
          `（演算子の位置・空白の付け方を確認してください。中置演算子は空白で区切り、` +
          `前置・後置演算子は対象値に密着させます）`
      );
    }
  }
  // **ストリームを返す関数を、引ける規則へ均す**（糖衣、stream_desugar.js）。
  //
  // 生成するのは Sign のソースなので、ここでソースを足して**もう一度同じ道を通す**。
  // 手で書いたコードと同じパイプラインを通るので、生成側だけが通る抜け道が生まれない。
  // 元の名前はカーソルの入口として再定義され（後の定義が勝つ）、Pass 4 は元を飛ばす。
  //
  // 既定では走らせない。均すと `sep s` が列ではなくカーソルを返すようになるので、
  // 消費側もカーソルを引ける必要がある——それが揃うまでは、頼まれたときだけ動かす。
  if (options.desugarStreams && !options.__desugared) {
    // **呼び合う塊ごとに均す。** 関係の無い関数を1つの群にまとめると、片方が均せない
    // ときに巻き添えになるし、引くたびに関係の無い枝まで比べることになる。
    const groups = groupStreamFunctions(findStreamFunctions(nodes)).map(generatePullers).filter(Boolean);
    if (groups.length > 0) {
      return compile(`${source}\n${groups.map((g) => g.source).join("\n")}`, {
        ...options,
        __desugared: true,
        __cursorGroups: groups.map((g) => ({ group: g.group, entries: g.entries })),
      });
    }
  }
  // 均した先の入口に印を付ける。**同じ名前が2回定義されている**ので、後の方（生成側）が
  // カーソルの入口で、前の方（元の関数）は Pass 4 が飛ばす対象である。
  for (const g of options.__cursorGroups || []) markCursorEntries(nodes, g.entries, g.entries, g.group);
  const specializations = runPass1b(nodes, env);
  // Pass 3 の型注釈と Pass 3b（`__` へ収束する経路の静的記録）は同じ走査で行う。
  const diagnostics = [];
  annotateAll(nodes, env, diagnostics);
  // layer による使用可能リテラル型の門番（option_ms_schema.md §4）。型が確定した後でないと
  // 判定できないのでここに置く。`options.layer` を渡さなければ検査しない——`option.ms` を
  // 読まない経路（テスト・playground の素の評価）まで std 相当を強制しないためである。
  if (options.layer !== undefined) checkLayerConstraints(nodes, options.layer);
  // charset に収まらない文字も同じ門番で見る（option_ms_schema.md §4.2）。
  if (options.charset !== undefined) checkCharsetConstraints(nodes, options.charset);
  return { nodes, env, specializations, diagnostics };
}

export { compile };
