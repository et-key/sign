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
import { buildEnv, buildEnvScope, bindEnv, envLookupScope, EXPORT_MARKERS } from "./pass1.js";
import { reduceAll, desugarIndexRest, getCategory } from "./pass2.js";
import { OperationError } from "./errors.js";
import { specializeGenericParams } from "./pass1b.js";
import { annotateAll, checkLayerConstraints, checkCharsetConstraints } from "./pass3.js";
import { findStreamFunctions, generatePullers, groupStreamFunctions, CURSOR_SUFFIXES } from "./stream_desugar.js";

function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

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

/**
 * **インポートはコンパイル時に解ける**（build_system.md §4.2）。
 *
 * `` `lib/x.sn`@~ `` は「そのファイルを読んで（`@`）、束縛をここへ撒く（`~`）」であり、
 * 後置演算子2つの意味そのままである。専用の構文は要らないし、走らせる側には何も残らない
 * ——読むのはビルド時である（Zig の `@import` と同じ立場で、layer 4 の話ではない）。
 *
 * 解くのは**行の段階**である。ここがまだ「ファイルが1つに見えている」最後の場所であり、
 * 以降のパスは `lines` しか見ない——束縛表もそこから作るので、撒いた先の名前が普通に引ける。
 */
function importPathOf(line) {
  // `[text, "_@", "_~"]` の形だけがインポートである。`@` だけ（撒かない）は「そのファイルの
  // 値を1つ読む」であって、束縛を並べる話ではない。裸のテキスト1つはコメントである。
  if (!Array.isArray(line) || line.length !== 3) return null;
  const [t, at, spread] = line;
  if (at !== "_@" || spread !== "_~") return null;
  if (typeof t !== "string" || t.length < 2 || t[0] !== "`" || t[t.length - 1] !== "`") return null;
  return t.slice(1, -1);
}

/** その行は束縛か。撒くのは**束縛**であって、そのファイルの実行例ではない。 */
function definedNameOf(line) {
  if (!Array.isArray(line)) return null;
  const at = typeof line[0] === "string" && EXPORT_MARKERS[line[0]] ? 1 : 0;
  const id = line[at];
  if (typeof id !== "string" || id[0] !== "<" || id[id.length - 1] !== ">") return null;
  return line[at + 1] === ":" ? { name: id, exported: at > 0 } : null;
}

function dirOf(path) {
  const n = normPath(path);
  const i = n.lastIndexOf("/");
  return i < 0 ? "" : n.slice(0, i);
}

/** 区切りは `/` に均す（Windows の区切りも同じ意味である）。 */
const normPath = (x) => String(x).split(String.fromCharCode(92)).join("/");

function joinPath(base, rel) {
  const r = normPath(rel);
  const drive = r.length > 2 && r[1] === ":" && r[2] === "/";
  const raw2 = r.startsWith("/") || drive ? r : (base ? normPath(base) + "/" : "") + r;
  const abs = raw2.startsWith("/");
  const seg = [];
  for (const x of raw2.split("/")) {
    if (x === "" || x === ".") continue;
    if (x === "..") { seg.pop(); continue; }
    seg.push(x);
  }
  return (abs ? "/" : "") + seg.join("/");
}

function resolveImports(lines, options, parseFn, base, state) {
  const out = [];
  for (const line of lines) {
    const rel = importPathOf(line);
    if (rel === null) { out.push(line); continue; }
    if (!options.readImport)
      throw new SyntaxError(`インポートを解決する手段がありません（${rel}——compile に readImport を渡してください）`);
    const full = joinPath(base, rel);
    // **同じファイルは一度だけ撒く。** 2つのモジュールが同じものを読んでいても定義が2つに
    // なってはいけない——後の定義が勝つので、黙って別物になる。
    if (state.done.has(full)) continue;
    // **循環は通してよい。** 同じファイルは一度しか撒かないので、定義はそれぞれ1つに
    // なる。トップレベルの定義は順序に依らない（`buildEnv` が先に全部集める）ので、
    // 循環するインポートは**ファイルを跨いだ相互再帰**でしかない——`sep` と `in_quote` が
    // 同じファイルで呼び合えるのと同じ話であり、断る理由が無い（原理4）。
    let src;
    try { src = options.readImport(full); } catch { throw new SyntaxError(`インポートが読めません: ${full}`); }
    state.done.add(full);
    // **撒くのは束縛だけである。** モジュールの末尾にある実行例まで持ってくると、
    // 最後の式が入れ替わる——`_sign_main` が返すのはそれなので、黙って別の値になる。
    const inner = resolveImports(parseFn(preprocess(src)), options, parseFn, dirOf(full), state);
    for (const l of inner) if (definedNameOf(l)) out.push(l);
  }
  return out;
}

// 呼び出しの実引数を読むときに「ここで式が切れる」と判る字句の頭文字（演算子）。
const OPERATOR_HEADS = new Set([..."?:#;|&=<>!+*/%^~@$,", "-"]);

/**
 * **`$` で渡した関数を、実体ごとに pass2 へ通し直す**（ref の具体化）。
 *
 * `app : f x y ? @f x y` を `app $add 3 4` と呼ぶと、`@f` の先は呼び出しサイトごとに
 * 決まっている（ここでは `add`）。ところが pass2 は `app` の本体を**総称のまま1回だけ**
 * 読むので、`@f` のアリティも仮引数の型も知らない——そのぶんは pass4 の単相化が
 * アセンブリの段で後から拾っていた。後からでは Pass 3 が型を付けられない：
 *
 *   多引数の無名 `$(p q ? p * q)` は直接呼ばれる場所が無く、仮引数の型が決まらない
 *   `a : ap $dbl 5` の `a` は `@f` 越しの返り値なので型が届かない
 *
 * そこで**実体を構文木の段で作る**。還元前の行（平らな字句の並び）を複製して
 *
 *   <app> : <f> <x> <y> ? @_ <f> <x> <y>     →     <app$add> : <x> <y> ? <add> <x> <y>
 *   <app> $_ <add> 3 4                      →     <app$add> 3 4
 *
 * と書き換え、pass2 へ通し直す。還元前の行にはまだスコープが無い（pass2 が付ける）ので、
 * 通し直すたびに**実体ごとに新しいスコープ**ができ、束縛を共有しない——共有すると
 * 型がラッチする。名前に `$` を含めるのは、字句の後の並びなので字句解析を通らず、
 * 利用者の識別子とも衝突しないからである（Sign の字句では `$` は演算子）。
 *
 * **再帰する関数も実体になる。** 実体の中の `take_while p (s ' 1~)` は `take_while$is_digit (s ' 1~)`
 * へ付け替える——実体の中では `p` はもう決まっているので、渡し直す必要が無い。
 *
 * **扱えない形は触らない。** 仮引数を `@` 以外にも使う本体（自分への素通しは除く）、単純で
 * ない呼び出しは書き換えずに残す——そちらは今まで通り pass4 の単相化が拾う。だからこの
 * 段は足し算にしかならない。
 */
function specializeRefCalls(lines, nodes, env, options) {
  const top = env && env.bindings;
  if (!top) return;
  const isId = (x) => typeof x === "string" && x.startsWith("<") && x.endsWith(">");
  // 1. `@p` を持つ関数：`<F> : 仮引数… ? 本体` で、本体に `@_ <p>` が在る
  const fns = new Map();
  // 入れ子の中まで見る：`@_ <p>` がどこかに在るか。本体は字下げのブロックや括りを持つ。
  const hasAt = (x, pn) => Array.isArray(x) && x.some((t, i) => (t === "@_" && x[i + 1] === pn) || hasAt(t, pn));
  lines.forEach((line, idx) => {
    if (!Array.isArray(line) || !isId(line[0]) || line[1] !== ":") return;
    const q = line.indexOf("?", 2);
    if (q < 0) return;
    // **仮引数の形は問わない。** `take_while : p [~s]` の `[~s]` のような括りの仮引数は、
    // 実体にそのまま残す。落とすのは裸で `@` される仮引数（ptr）だけである。
    const params = line.slice(2, q);
    const body = line.slice(q + 1);
    const ptr = params.filter((pn) => isId(pn) && hasAt(body, pn));
    if (ptr.length === 0) return;
    const ptrIdx = ptr.map((pn) => params.indexOf(pn));
    // 仮引数を `@` 以外に使ってよいのは、**自分への呼び出しで同じ位置へそのまま渡す**とき
    // だけである（`take_while p (s ' 1~)` の `p`）。実体の中ではその呼び出しが実体自身への
    // 呼び出しになり、`p` は落ちる。別の関数へ渡している等なら落とせない。
    const F = line[0];
    const badUse = (x) => {
      if (!Array.isArray(x)) return false;
      for (let i = 0; i < x.length; i++) {
        const t = x[i];
        if (ptr.includes(t) && x[i - 1] !== "@_" && x[i - 1 - ptrIdx[ptr.indexOf(t)]] !== F) return true;
        if (Array.isArray(t) && badUse(t)) return true;
      }
      return false;
    };
    if (badUse(body)) return;
    // **残る仮引数がゼロなら実体にしない。** `apply5 : ref ? @ref 5` の `ref` を落とすと
    // `apply5$add : ? add 5` になるが、仮引数ゼロの関数を名前だけ書いたときに呼ぶのか値の
    // ままなのかは、元の `apply5 $add`（＝ `add 5`、未飽和の Lambda）と意味が変わりうる。
    // ただし**呼び出しは読む**——渡した関数に当てる数が足りない形（`k : f ? @f`）を名指しする
    // ために（tryCall）。
    fns.set(F, { idx, params, ptr, ptrIdx, q, underOnly: params.length - ptr.length === 0 });
  });
  if (fns.size === 0) return;
  // 本体で `@p` に当てている引数の数（適用の鎖の深さ）。pass2 は `@` の先を Infinity の
  // アリティで読むので、書かれた分だけ鎖が伸びている。
  const appliedDepth = (root, pn) => {
    let most = 0;
    const spine = (n) => { let d = 0; while (n && n.type === "operation" && n.name === "apply") { d++; n = n.left; } return { d, base: n }; };
    const visit = (n) => {
      if (!n || typeof n !== "object") return;
      if (n.type === "operation" && n.name === "apply") {
        const { d, base } = spine(n);
        if (base && base.type === "operation" && base.position === "prefix" && base.name === "input" &&
            base.operand && base.operand.type === "atom" && base.operand.value === pn) most = Math.max(most, d);
      }
      for (const k of ["left", "right", "operand", "middle"]) visit(n[k]);
      for (const l of n.lines || []) visit(l);
    };
    visit(root);
    return most;
  };
  // 呼び出しの鎖の根（F への適用のうち一番外）に印を付ける。
  const markCall = (root, F, info) => {
    const baseIs = (n) => { while (n && n.type === "operation" && n.name === "apply") n = n.left; return n && n.type === "atom" && n.value === F; };
    const visit = (n, onSpine) => {
      if (!n || typeof n !== "object") return;
      const isApply = n.type === "operation" && n.name === "apply";
      if (isApply && !onSpine && baseIs(n)) n.refOverApply = info;
      if (isApply) { visit(n.left, true); visit(n.right, false); }
      else for (const k of ["left", "right", "operand", "middle"]) visit(n[k], false);
      for (const l of n.lines || []) visit(l, false);
    };
    visit(root, false);
  };
  // 無名のラムダを名前付きの定義として吊り上げる。捕獲しているものは吊り上げない
  // ——トップへ出すと捕まえた変数の置き場が無い（リフティングの仕事で、まだ無い）。
  let anonSeq = 0;
  // 持ち上げた関数が捕まえていた変数（名前 → 呼び出しサイトでの名前の並び）。
  const liftCaps = new Map();
  const idsIn = (x, out = []) => { if (Array.isArray(x)) x.forEach((y) => idsIn(y, out)); else if (isId(x)) out.push(x); return out; };
  const hoistAnon = (block, encl, F, pn) => {
    const lam = Array.isArray(block) && block.length === 1 && Array.isArray(block[0]) ? block[0] : null;
    if (!lam) return null;
    const q = lam.indexOf("?");
    if (q <= 0) return null;
    const own = lam.slice(0, q);
    if (!own.every(isId)) return null;
    // 囲む定義の仮引数（`<g> : <a> ? …` の `<a>`）に触れていたら捕獲である
    const eq = Array.isArray(encl) && isId(encl[0]) && encl[1] === ":" ? encl.indexOf("?", 2) : -1;
    const outer = eq > 0 ? encl.slice(2, eq) : [];
    // **捕まえた変数は、前の仮引数として持ち上げる**（リフティング）。囲む定義の仮引数に
    // 触れていたら、それを仮引数に足してトップへ出す——もう何も捕まえていない関数になる。
    // 捕まえた変数は呼び出しサイトに居るので、そこで渡せばよい（下の呼び出しの書き換え）。
    // 囲む定義の仮引数でもトップの束縛でもない名前（入れ子の局所など）は、まだ扱わない。
    const captured = [];
    for (const id of idsIn(lam.slice(q + 1))) {
      if (own.includes(id)) continue;
      if (outer.includes(id)) { if (!captured.includes(id)) captured.push(id); continue; }
      if (!top.has(id)) return null;
    }
    const name = "<" + F.slice(1, -1) + "$" + pn.slice(1, -1) + "$" + anonSeq++ + ">";
    const def = [name, ":", ...captured, ...own, "?", ...lam.slice(q + 1)];
    liftCaps.set(name, captured);
    const bind = buildEnvScope([def]).get(name);
    if (!bind) return null;
    top.set(name, bind);
    newDefs.push(def);
    return name;
  };
  // 2. 呼び出しサイト：`<F> …` で、ptr の位置が `$_ <X>`（X はトップの関数）。**入れ子の奥まで
  //    探す**——`tokens` の本体のように、呼び出しは字下げのブロックや括りの中に居る。
  const made = new Map();
  // η 簡約した実体の名前 → 呼び先。実体の定義は作らない。
  const etas = new Map();
  const dirty = new Set();
  const newDefs = [];
  // 多すぎる引数の印。付けるのは通し直しの**後**である——同じ行の別の呼び出しを書き換えると
  // 行ごと還元し直すので、先に付けた印はそこで消え、pass4 が名指しできなくなる。
  const overMarks = [];
  // その行で束縛し直している名前（仮引数・局所の定義）。そこでの `<F>` はトップの F ではない。
  const bindersOf = (x, out = new Set(), nested = false) => {
    if (!Array.isArray(x)) return out;
    const q = x.indexOf("?");
    if (q > 0) x.slice(nested ? 0 : 1, q).forEach((t) => { if (isId(t)) out.add(t); });
    if (nested && isId(x[0]) && x[1] === ":") out.add(x[0]);
    x.forEach((t) => bindersOf(t, out, true));
    return out;
  };
  // 本体の返り値の位置で `@p` に当てている数（適用の鎖の深さ）。`@p` をそのまま返すなら 0。
  const tailDepthsOf = (lam, pn) => {
    const out = [];
    for (const t of returnTails(lam && lam.right)) {
      let n = t;
      let d = 0;
      while (n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) { d++; n = peelWrappers(n.left); }
      if (n && n.type === "operation" && n.position === "prefix" && n.op === "@" && isIdentNode(n.operand) && n.operand.value === pn) out.push(d);
    }
    return out;
  };
  // 1つの呼び出しを読む。書き換えるなら、置き換える頭と、残す実引数と、読み終えた位置を返す。
  const tryCall = (arr, s, fn, idx, binders) => {
    const F = arr[s];
    const isPrefixMark = (t) => typeof t === "string" && (t === "$_" || /^[^\w<`"$]+_$/.test(t));
    const isPostfixMark = (t) => typeof t === "string" && /^_[^\w<`"]+$/.test(t);
    // 実引数を仮引数の数ぶん読む。単純な形（識別子・字面・括り・`$_ <X>`・前置の印の連なりと
    // その対象）だけ。**区切りは pass2 と同じ所で切る**——ずれると別の `$` を実体化し、黙って
    // 違う答えを返す（`h ~@p $dbl $inc` で `~` と `@p` を別の実引数に読んでいた）。
    const args = [];
    let i = s + 1;
    while (args.length < fn.params.length && i < arr.length) {
      const tok = arr[i];
      let arg;
      if (tok === "$_" && Array.isArray(arr[i + 1])) {
        // 無名の関数 `$(p q ? p * q)`。吊り上げるのは書き換えが決まってから（下）——読むだけで
        // 吊り上げると、書き換えない呼び出しに持ち主の無い定義が残り、機械で名前が重複した。
        // 仮引数の数は字句から数えられる（吊り上げられない形でも）。
        const lam = arr[i + 1].length === 1 && Array.isArray(arr[i + 1][0]) ? arr[i + 1][0] : null;
        const q = lam ? lam.indexOf("?") : -1;
        arg = { from: i, to: i + 1, ref: null, anon: arr[i + 1], anonArity: q > 0 && lam.slice(0, q).every(isId) ? q : null };
      } else if (tok === "$_" && isId(arr[i + 1])) {
        arg = { from: i, to: i + 1, ref: arr[i + 1] };
      } else if (isPrefixMark(tok)) {
        // 前置演算子の連なり（`-y`・`~@p`・`!!x`）は、対象と合わせて1つの実引数である
        let j = i;
        while (j < arr.length && isPrefixMark(arr[j])) j++;
        if (j >= arr.length) break;
        arg = { from: i, to: j, ref: null };
      } else if (typeof tok === "string" && !isId(tok) && OPERATOR_HEADS.has(tok[0]) && !/^-?[0-9`]/.test(tok)) {
        // 負の字面（`-1`）は演算子ではない。演算子として読むと実体を作らずに素通ししていた。
        break;
      } else {
        arg = { from: i, to: i, ref: null };
      }
      // 後置演算子（`3!`・`ys~`）は直前の実引数のものである
      while (arg.to + 1 < arr.length && isPostfixMark(arr[arg.to + 1])) arg.to++;
      args.push(arg);
      i = arg.to + 1;
    }
    // **`$` で渡した関数に、返り値の位置で当てる数が足りない**なら、その関数は関数を返すことに
    // なる（`ap : g x ? @g x` に `$add3`、`k : f ? @f` に `$inc`）。多すぎる引数の裏返しで
    // あり、関数を返す関数は関数オブジェクトの番地で返す（type_system.md §3.5）。実体を作るか
    // どうかに依らず、呼び出しサイトで名指しする——作らない形でも抜けないように：
    //
    //   仮引数が `$` の分しか無い関数    `k : f ? @f`（実体を作らない）
    //   実引数が足りない呼び出し          `q : ap $add3`（`$` の実引数さえ読めれば判じられる）
    //   値の束縛を `$` で渡す             `p : add3 1` / `ap $p 2`（右辺の式で判じる）
    //   吊り上げられない無名の関数        仮引数の数を字句から数える
    //
    // `$X` が関数かどうかは functionKindOf と同じく**束縛の右辺の式**で判じる。pass2 の分類は
    // `r : first [1 2 3]`・`Red : !__`・`v : @buf` を Lambda と答え、値を読むだけの `f $r` を
    // 止めていた。仮引数と同じ名前の `$X` はトップの関数ではない（`g : inc ? rd $inc`）。
    fn.ptr.forEach((pn) => {
      const k = fn.params.indexOf(pn);
      const a = k < args.length ? args[k] : null;
      if (!a) return;
      let need = null;
      let callee = "無名の関数";
      if (a.ref) {
        if (binders.has(a.ref) || !top.has(a.ref)) return;
        if (!functionKindOf({ type: "atom", kind: "identifier", value: a.ref }, env, null)) return;
        const c = top.get(a.ref);
        const caps = (liftCaps.get(a.ref) || []).length;
        need = typeof c.requiredArity === "number" ? c.requiredArity - caps : typeof c.arity === "number" ? c.arity - caps : null;
        const raw = String(a.ref).replace(/^<|>$/g, "");
        if (!liftCaps.has(a.ref) && !/\$\d+$/.test(raw)) callee = raw;
      } else if (a.anonArity != null) need = a.anonArity;
      else return;
      const Fname = functionLabel(F);
      for (const d of tailDepthsOf(nodes[fn.idx] && nodes[fn.idx].right, pn)) {
        if (d > 0 && (need == null || d >= need)) continue;
        const what = d === 0
          ? `${Fname} は \`@${pn.slice(1, -1)}\` をそのまま返しています——\`$\` で渡した ${callee} そのもの（関数）を返すことになります`
          : `\`@${pn.slice(1, -1)}\` に渡した ${callee} はアリティ ${need} だが、${Fname} の本体は返り値の位置で ${d} 個しか当てていません——${Fname} が関数（部分適用）を返すことになります`;
        throw new OperationError(`${what}。${FUNCTION_RETURN_ADVICE}`, {
          spec: "type_system.md §3.5",
          reason: "function-returned-without-address",
        });
      }
    });
    if (fn.underOnly) return null;
    if (args.length !== fn.params.length) return null;   // 足りない・読めないなら触らない
    // 仮引数と同じ名前の `$X` は、その仮引数である（トップの関数へ焼き込んではいけない）
    if (fn.ptr.some((pn) => { const a = args[fn.params.indexOf(pn)]; return a.ref && binders.has(a.ref); })) return null;
    // 無名の関数を吊り上げる。ここから先で書き換えをやめるなら、吊り上げた定義は巻き戻す。
    const hoisted = [];
    const rollback = () => {
      for (const nm of hoisted) {
        top.delete(nm);
        liftCaps.delete(nm);
        const k = newDefs.findIndex((d) => d[0] === nm);
        if (k >= 0) newDefs.splice(k, 1);
      }
      return null;
    };
    for (const pn of fn.ptr) {
      const a = args[fn.params.indexOf(pn)];
      if (!a.anon) continue;
      a.ref = hoistAnon(a.anon, lines[idx], F, pn);
      if (!a.ref) return rollback();
      hoisted.push(a.ref);
    }
    const callees = fn.ptr.map((pn) => args[fn.params.indexOf(pn)].ref);
    // **値の束縛・別名（`g : add`・`p : add3 1`）は実体にしない。** 当てる数の検査は右辺で判じる
    // が、実体を作ると本体の中から別名越しに呼ぶ形になり、器を返す関数の別名でそこを踏むと機械が
    // 0 や `__` を返す（以前から在る穴）。作らなかった頃の振る舞いを保つ。
    if (callees.some((c) => !c || !top.has(c) || top.get(c).category !== "Lambda" || top.get(c).rhsNode)) return rollback();
    // **多すぎる引数は捨てられない。** `@a b c` は適用以外にありえない——前置 `@` の先は
    // 必ず Lambda だからである。本体で `@p` に当てている数が、渡した関数のアリティより多ければ、
    // 余った引数は飽和した結果（値）へ当てることになる。実体を作ると `<dbl> <x> <y>` が名前の
    // 読み方で余積（`[6 4]`）に戻ってしまい、`@` の意図が消える。作らずに印を付け、pass4 が
    // 名指しする。
    const over = fn.ptr.map((pn, j) => {
      // 持ち上げた関数のアリティには捕まえた分が入っている。利用者が `@p` に当てるのは
      // 残りだけなので、そちらで比べる。
      const all = top.get(callees[j]).arity;
      const want = typeof all === "number" ? all - (liftCaps.get(callees[j]) || []).length : all;
      const got = appliedDepth(nodes[fn.idx], pn);
      return typeof want === "number" && got > want ? { param: pn, callee: callees[j], want, got } : null;
    }).find(Boolean);
    if (over) { overMarks.push({ idx, F, over }); return rollback(); }
    const name = "<" + [F.slice(1, -1), ...callees.map((c) => c.slice(1, -1))].join("$") + ">";
    if (!made.has(name)) {
      const src = lines[fn.idx];
      const keep = fn.params.filter((pn) => !fn.ptr.includes(pn));
      // 捕まえた変数を運ぶ仮引数。名前には `$` を含める——`ap : f x` が `x` を捕まえた
      // ラムダを受けると、元の名前のままでは実体の仮引数と衝突する。`$` は利用者が書けない。
      let cseq = 0;
      const capParams = callees.map((c) => (liftCaps.get(c) || []).map(() => "<$c" + cseq++ + ">"));
      // **本体を入れ子の中まで書き換える。** `@_ <p>` を渡した関数へ、自分への呼び出し
      // `<F> … <p> …` を実体自身への呼び出し `<実体> …` へ（ptr の位置の実引数を落とし、
      // 捕まえた変数を運ぶ仮引数をそのまま渡し直す）。再帰する関数もこれで実体になる——
      // 実体の中では `p` がもう決まっているので、渡し直す必要が無い。
      let intact = true;
      const rw = (x) => {
        if (!Array.isArray(x)) return x;
        const out = [];
        for (let j = 0; j < x.length; j++) {
          const t = x[j];
          if (t === "@_" && fn.ptr.includes(x[j + 1])) {
            const ci = fn.ptr.indexOf(x[j + 1]);
            out.push(callees[ci], ...capParams[ci]);
            j++;
            continue;
          }
          if (t === F) {
            // `$F`（自分を値として渡す）は呼び出しではない。実体の名前へ付け替えると意味が変わる。
            if (x[j - 1] === "$_") { intact = false; return out; }
            const argv = x.slice(j + 1, j + 1 + fn.params.length);
            // 実引数が揃っていて、ptr の位置がちょうど ptr 自身（素通し）のときだけ
            if (argv.length !== fn.params.length || fn.ptrIdx.some((pi) => argv[pi] !== fn.params[pi])) { intact = false; return out; }
            out.push(name, ...capParams.flat());
            argv.forEach((a, k) => { if (!fn.ptrIdx.includes(k)) out.push(rw(a)); });
            j += fn.params.length;
            continue;
          }
          out.push(rw(t));
        }
        return out;
      };
      const body = rw(src.slice(fn.q + 1));
      if (!intact) return rollback();
      // **η 簡約。** 本体が「呼び先へ仮引数を同じ順でそのまま渡すだけ」なら、実体は呼び先
      // そのものである（`<app$add> : <x> <y> ? <add> <x> <y>` ≡ `add`）。実体を作らず、呼び出し
      // サイトで呼び先を直に呼ぶ——1段挟むぶんの呼び出しとフレームが消える。
      //
      // **最適化なので、呼び出しサイトの読み方を変えてはいけない。** 続く字句をいくつ食べるかは
      // 呼ぶ関数の仮引数の並びが宣言していて、pass2 はそれを束縛の**アリティ**と**器を丸ごと
      // 受けるか**（wantsMore）で読む。実体の束縛と呼び先の束縛でこの2つが一致するときだけ
      // 入れ替えてよい。
      //
      //   アリティが多い     `ap $add3 1 2 3` が `add3 1 2 3`（6）になり、手で書いた同じ射
      //                      `h : x ? add3 x` の `h 1 2 3`（構築）とずれた。一度そう広げていた
      //   器を丸ごと受ける   `f : [a]` はアリティ1でも `f 1 2 3` を器ごと食べる
      //   rest・既定値       アリティが一致しない（裸の rest は読めない＝null）
      //
      // 必須の数は比べない。書き換える呼び出しサイトでは引数が揃っている（揃っていなければ
      // 書き換えない）ので、既定値で埋まるかどうかは読みに効かない。
      //
      // 余る引数を取りたい関数は、仮引数の並びでそう宣言する（`~x` / `[~x]`）。
      const formals = [...capParams.flat(), ...keep];
      const def = [name, ":", ...formals, "?", ...body];
      const bind = buildEnvScope([def]).get(name);
      if (!bind) return rollback();
      const head = body[0];
      const hb = isId(head) && top.has(head) ? top.get(head) : null;
      const reads = (b) => [b.arity, !!b.containerParam].join();
      if (formals.every(isId) && body.length === formals.length + 1 && body.slice(1).every((t, k) => t === formals[k]) &&
          !formals.includes(head) && hb && hb.category === "Lambda" && reads(hb) === reads(bind)) {
        made.set(name, null);
        etas.set(name, head);
      } else {
        top.set(name, bind);
        made.set(name, def);
        newDefs.push(def);
      }
    }
    // 呼び出しを書き換える：`<F>` を実体の名前へ（η 簡約したなら呼び先へ）、ptr の実引数（`$_ <X>`）を落とす
    const drop = new Set();
    for (const pn of fn.ptr) { const a = args[fn.params.indexOf(pn)]; for (let k = a.from; k <= a.to; k++) drop.add(k); }
    const end = args[args.length - 1].to;
    const kept = [];
    for (let k = s + 1; k <= end; k++) if (!drop.has(k)) kept.push(arr[k]);
    return { head: [etas.get(name) || name, ...callees.flatMap((c) => liftCaps.get(c) || [])], kept, end };
  };
  const scan = (arr, idx, binders) => {
    const out = [];
    for (let s = 0; s < arr.length; s++) {
      const tok = arr[s];
      const fn = fns.get(tok);
      // 自分の定義の中の自分への呼び出しは、実体を作るときに付け替える（上の rw）
      if (fn && fn.idx !== idx && arr[s - 1] !== "$_" && !binders.has(tok)) {
        const r = tryCall(arr, s, fn, idx, binders);
        if (r) {
          // 残した実引数の中にも呼び出しは居る（`take_while $is_digit (drop_while $is_space s)`）
          out.push(...r.head, ...r.kept.map((a) => (Array.isArray(a) ? scan(a, idx, binders) : a)));
          s = r.end;
          dirty.add(idx);
          continue;
        }
      }
      out.push(Array.isArray(tok) ? scan(tok, idx, binders) : tok);
    }
    return out;
  };
  // **総称の定義の行を先に見る。** その本体の中の呼び出しを先に実体へ付け替えておけば、
  // そこから作る実体もそれを引き継ぐ。
  const fnLines = [...new Set([...fns.values()].map((f) => f.idx))];
  for (const idx of [...fnLines, ...[...lines.keys()].filter((k) => !fnLines.includes(k))]) {
    const line = lines[idx];
    if (!Array.isArray(line)) continue;
    const next = scan(line, idx, bindersOf(line));
    if (dirty.has(idx)) lines[idx] = next;
  }
  // 3. 通し直す。多すぎる引数の印は、通し直した木に付ける
  //
  // **通し直した行には、compile がここまでに当てた段を全部当てる。** pass2 の出口の段
  // （`desugarIndexRest`・`synthesizePointfreeIn`）だけでは足りない——`[+] 1 2 3` の畳み込みの
  // 展開と名前への差し替えが消え、同じ行に `$` の呼び出しがあるだけで機械が断っていた。
  const reduce = (line) => { const n = desugarIndexRest(reduceAll(line, env)); synthesizePointfreeIn(n, env); return n; };
  const refold = () => { expandGreedyFoldsIn(nodes); if (options.__pfFolded) replaceGreedyFolds(nodes); };
  const mentions = (x, id) => Array.isArray(x) ? x.some((y) => mentions(y, id)) : x === id;
  // **書き換えた値の定義は、束縛を作り直す。** `p : ap $add3 1` が `p : add3 1` になると `p` は
  // 部分適用（アリティ2の関数）だが、束縛は書き換える前の右辺から読んだカテゴリとアリティを
  // メモ化している（pass2 の resolveBindingCategory）。そのままだと `p 2 3` が構築に読まれ、
  // インタプリタが黙って 3 を返す。作り直した名前を使う行も通し直す（その行がまた値の
  // 定義なら、その束縛も）。関数の定義は仮引数で決まるので、本体を書き換えても変わらない。
  const work = [...dirty];
  const refreshed = new Set();
  while (work.length > 0) {
    const idx = work.pop();
    const d = definedNameOf(lines[idx]);
    if (!d || refreshed.has(d.name) || !top.has(d.name)) continue;
    const fresh = buildEnvScope([lines[idx]]).get(d.name);
    if (!fresh || fresh.category === "Lambda") continue;
    const old = top.get(d.name);
    for (const k of Object.keys(old)) delete old[k];     // メモ（rhsNode 等）ごと捨てる
    Object.assign(old, fresh);                           // 同じ物を指している表があるので中身を入れ替える
    refreshed.add(d.name);
    lines.forEach((line, j) => { if (!dirty.has(j) && mentions(line, d.name)) { dirty.add(j); work.push(j); } });
  }
  for (const idx of dirty) nodes[idx] = reduce(lines[idx]);
  if (dirty.size > 0) refold();
  for (const m of overMarks) markCall(nodes[m.idx], m.F, m.over);
  // η 簡約だけで済んだときも、呼ばれなくなった総称は落とす（実体の定義は1つも無い）
  if (made.size === 0 && newDefs.length === 0) return;
  // **使われなくなった元の総称関数は落とす。** 呼び出しを全部実体へ付け替えたので、
  // `@` の仮引数を持ったまま誰にも呼ばれない——残すと pass4 の単相化が「呼び出しサイトが
  // 無い」と断る。他の行から参照されておらず、エクスポートもされていないものだけ落とす。
  const dead = [];
  for (const [F, fn] of fns) {
    if (![...made.keys()].some((nm) => nm.startsWith(F.slice(0, -1) + "$"))) continue;
    const b = top.get(F);
    if (b && b.exported) continue;
    // 実体の本体からも呼ばれていないこと。総称の行を先に書き換えても、まだ見ていない総称の
    // 本体から作った実体は、別の総称への呼び出しを持ったままでありうる。
    if (lines.some((line, idx) => idx !== fn.idx && mentions(line, F)) || newDefs.some((d) => mentions(d, F))) continue;
    dead.push(fn.idx);
  }
  // 実体は前に置く（使う場所より先に定義が要り、最後の式は最後のまま）
  for (const idx of dead.sort((x, y) => y - x)) { nodes.splice(idx, 1); lines.splice(idx, 1); }
  nodes.unshift(...newDefs.map(reduce));
  lines.unshift(...newDefs);
  // 実体の本体は総称の本体の写しなので、畳み込みも持ちうる
  if (newDefs.length > 0) refold();
}

const isArmNode = (l) => !!l && l.type === "operation" && l.name === "define";
const isIdentNode = (n) => !!n && n.type === "atom" && n.kind === "identifier";

/**
 * 式の外側の包みを剥がす：1行の括り、後置 `@`（取り込み）、前置 `~`・後置 `~`、そして `@$X`。
 * `$` と `@` は往復なので `@$X` は X そのものである（LambdaLift）。前置 `@` の先が番地の往復で
 * なければ剥がさない——それは読むことであって、関数を運ぶことではない。
 */
function peelWrappers(n) {
  for (;;) {
    if (!n || typeof n !== "object") return n;
    if (n.type === "block" && n.kind === "paren" && Array.isArray(n.lines) && n.lines.length === 1) { n = n.lines[0]; continue; }
    if (n.type === "operation" && n.operand && (n.name === "import" || n.name === "continuous" || n.name === "expand")) { n = n.operand; continue; }
    if (n.type === "operation" && n.position === "prefix" && n.op === "@" && n.operand) {
      const a = peelWrappers(n.operand);
      if (a && a.type === "operation" && a.name === "address" && a.operand) { n = a.operand; continue; }
    }
    return n;
  }
}

/**
 * 本体の**返り値の位置**にある式を集める。
 *
 *   枝のある並び（字下げでも括りでも）   各枝 `左 : 右` の右と、最後の行（既定）
 *   1行の枝 `n = 1 : inc`              右（1スロットの構造体 `[a : inc]` も `[x] ≅ x` で同じ）
 *   選び                                `|` と `;` の両辺、`&` の右
 *
 * 本体の中の `左 : 右` は**左が識別子でも枝である**（局所の束縛ではない）。`t : 1` のもとで
 * `f : n ?` / `t : 42` / `0` は 42 を返す。
 *
 * **枝の無い2行以上の並びと、全部が `名前 : 値` の括りは器である**（行の並び・構造体）。
 * `f : n ?` / `1` / `2` は `[1, 2]` を返す——最後の行が返り値なのは、枝があるときだけである。
 * 器の中に関数を入れて返す形は、まだ決めていない。
 */
function returnTails(b, out = []) {
  b = peelWrappers(b);
  if (!b || typeof b !== "object") return out;
  if (b.type === "block" && Array.isArray(b.lines) && (b.kind === "indent" || b.kind === "paren")) {
    const lines = b.lines;
    if (!lines.some(isArmNode)) {
      if (lines.length === 1) returnTails(lines[0], out);
      return out;
    }
    if (b.kind === "paren" && lines.every((l) => isArmNode(l) && isIdentNode(l.left))) return out;
    for (const l of lines) if (isArmNode(l)) returnTails(l.right, out);
    if (!isArmNode(lines[lines.length - 1])) returnTails(lines[lines.length - 1], out);
    return out;
  }
  if (isArmNode(b)) return returnTails(b.right, out);
  if (b.type === "operation" && (b.name === "or" || b.name === "xor")) { returnTails(b.left, out); returnTails(b.right, out); return out; }
  if (b.type === "operation" && b.name === "and") return returnTails(b.right, out);
  out.push(b);
  return out;
}

/** 貪欲な点なしの括りへ付けた名前（`_pf_fold_2b`）を、書かれた綴り（`[+]`）へ戻す。 */
function pointfreeSpelling(name) {
  const raw = String(name).replace(/^<|>$/g, "");
  const unhex = (h) => (h.match(/../g) || []).map((x) => String.fromCharCode(parseInt(x, 16))).join("");
  let m = /^_pf_fold_([0-9a-f]+)$/.exec(raw);
  if (m) return `[${unhex(m[1])}]`;
  m = /^_pf_map_([0-9a-f]+)_([0-9a-f]+)$/.exec(raw);
  if (m) return `[${unhex(m[1])} ${unhex(m[2])},]`;
  return null;
}

/** `add _ n` の穴が作ったラムダか（仮引数が `$p0`, `$p1`, … だけ）。 */
function isHoleLambda(lam) {
  const L = lam.left;
  const names = isIdentNode(L) ? [L.value] : ((L && L.entries) || []).map((x) => x.name);
  return names.length > 0 && names.every((x) => /^<\$p\d+>$/.test(String(x)));
}

/**
 * その式は関数そのものか。関数なら何であるかを言う語を、そうでなければ null を返す。
 *
 * **識別子は束縛の右辺の式で判じる**（pass2 の分類ではなく）。分類は値の束縛を右辺の
 * 還元結果で Lambda と答えることがある——`r : first [1 2 3]`（器を丸ごと受ける関数の飽和した
 * 呼び出し）、`Red : !__`（真）、`v : @buf`（読み）はどれも値だが、分類だけ見ると関数に見え、
 * 正しいプログラムを止めていた。
 */
function functionKindOf(e, scope, defaults, seen = new Set()) {
  e = peelWrappers(e);
  if (!e || typeof e !== "object") return null;
  if (e.type === "operation") {
    if (e.op === "?") return isHoleLambda(e) ? "`_` による部分適用" : "ラムダ";
    if (e.name === "compose") return "合成";
    if (e.name === "partial_apply") return "部分適用";
    if (e.partial) return "点なしの括り";
    return null;
  }
  if (!isIdentNode(e) || seen.has(e.value)) return null;
  seen.add(e.value);
  const pf = pointfreeSpelling(e.value);
  if (pf) return `点なしの括り ${pf}`;
  const nm = String(e.value).replace(/^<|>$/g, "");
  // 既定値を持つ仮引数は、その既定値で判じる（`f : inc` を既定に持つ `f` を返す形）
  if (defaults && defaults.has(e.value)) return functionKindOf(defaults.get(e.value), scope, null, seen) ? `関数を既定値に持つ仮引数 ${nm}` : null;
  const found = scope ? envLookupScope(scope, e.value) : null;
  if (!found) return null;
  getCategory(e, scope);                               // 値の束縛の右辺を還元させる（rhsNode ができる）
  const b = found.binding;
  if (b.rhsNode) return functionKindOf(b.rhsNode, found.scope, null, seen) ? `関数を束縛した名前 ${nm}` : null;
  // 残るのは関数の定義（`名前 : 仮引数 ? 本体`）と仮引数。仮引数の束縛は Atom である。
  return b.category === "Lambda" ? `関数の名前 ${nm}` : null;
}

/** 検査で名指しする関数の呼び方。実体化の段が作った名前（`$` を含む）は、利用者の言葉へ戻す。 */
function functionLabel(name) {
  const raw = String(name).replace(/^<|>$/g, "");
  if (!raw.includes("$")) return raw;
  const parts = raw.split("$");
  // 吊り上げた無名の関数（`<F$仮引数$番号>`）。書いたのは呼び出しサイトの無名の関数である。
  if (parts.length === 3 && /^\d+$/.test(parts[2])) return `${parts[0]} の仮引数 ${parts[1]} へ \`$\` で渡した無名の関数`;
  return `${parts[0]}（\`$\` で渡した関数ごとの実体 ${raw}）`;
}

const FUNCTION_RETURN_ADVICE =
  "関数を返す関数は、関数オブジェクトの番地で返します。`$(…)` を付けて返し、使う側は `@` で当ててください" +
  "（余る引数を取りたいなら仮引数の並びで `~x` / `[~x]` と宣言します）";

/**
 * **関数を返す関数は、関数オブジェクトの番地で返す**（type_system.md §3.5）。
 *
 * 本体の返り値の位置（`returnTails`）に、関数そのもの（部分適用・ラムダ・合成・点なしの括り・
 * 関数の名前）が `$` 無しで居たら止める。そのまま返すと実行時の値を捕まえた閉包を返すことに
 * なり、部分適用はコンパイル時の特殊化である（execution_model.md §3）という前提の外へ出る。
 * 番地で返せば（`g : x ? $(add3 x + 1)`）、関数を値として運んでいることが綴りに現れ、使う側は
 * `@` で当てる。
 *
 * **自動カリー化とは別である。** 呼び出しサイトや束縛で引数が足りない形（`p : add3 1`、
 * `(add3 1) 2 3`）は返り値の位置ではないので見ない。`!__`（真＝恒等射）と、前置 `@` の読みも
 * 関数オブジェクトの受け渡しではない。飽和した `apply` も見ない——本当に引数が足りない適用は、
 * pass2 が既に `partial_apply` へ改名している。
 *
 * `$` で渡した関数に本体が当てる数が足りない形（`ap : g x ? @g x` に `$add3`）は、実体化の段
 * （specializeRefCalls）が呼び出しサイトで名指しする。
 */
function checkFunctionReturns(nodes) {
  const defaultsOf = (lam) => new Map(((lam.left && lam.left.entries) || []).filter((x) => x.name && x.default).map((x) => [x.name, x.default]));
  const check = (lam, who) => {
    const defaults = defaultsOf(lam);
    for (const t of returnTails(lam.right)) {
      const kind = functionKindOf(t, lam.scope, defaults);
      if (!kind) continue;
      throw new OperationError(`${who} は関数を返しています（${kind}）——${FUNCTION_RETURN_ADVICE}`, {
        spec: "type_system.md §3.5",
        reason: "function-returned-without-address",
      });
    }
  };
  const seen = new Set();
  // `who` は一番近い名前付きの関数の呼び方。無名の関数は「〜の中の無名の関数」と言う。
  const visit = (n, who) => {
    if (!n || typeof n !== "object" || seen.has(n)) return;
    seen.add(n);
    if (n.type === "operation" && n.name === "define" && isIdentNode(n.left) && n.right && n.right.op === "?") {
      const me = functionLabel(n.left.value);
      seen.add(n.right);
      check(n.right, me);
      visitLambda(n.right, me);
      return;
    }
    if (n.type === "operation" && n.op === "?") {
      check(n, who ? `${who} の中の無名の関数` : "無名の関数");
      visitLambda(n, who);
      return;
    }
    // 値の定義（`h : dbl (y ? inc)` のような合成）の中の無名の関数も、その名前で言う
    if (n.type === "operation" && n.name === "define" && isIdentNode(n.left)) { visit(n.right, functionLabel(n.left.value)); return; }
    for (const k of ["left", "right", "operand", "middle"]) visit(n[k], who);
    for (const l of n.lines || []) visit(l, who);
    for (const x of n.entries || []) visit(x.default, who);
  };
  // 本体と、仮引数の既定値の中（`f : (y ? inc)` のようなラムダが居る）を見る。
  const visitLambda = (lam, who) => {
    visit(lam.right, who);
    for (const x of (lam.left && lam.left.entries) || []) visit(x.default, who);
  };
  for (const n of nodes) visit(n, null);
}

function compile(source, options = {}) {
  const parseFn = options.parse || parse;
  // **入口のファイル自身も「撒き済み」として数える。** 循環したときに入口が自分を撒き直し、
  // 同じ定義が2つになる——後の定義が勝つので、黙って別物になりうる。
  const selfPath = options.sourcePath ? joinPath("", options.sourcePath) : null;
  const lines = resolveImports(
    parseFn(preprocess(source)),
    options,
    parseFn,
    options.importBase !== undefined ? options.importBase : selfPath ? dirOf(selfPath) : "",
    { done: new Set(selfPath ? [selfPath] : []) }
  );
  const env = buildEnv(lines);
  // 添字位置の `N~` を終端の無いレンジへ均す（糖衣）。**後置 `~` の意味を「撒く」
  // 1つに絞るための書き換え**であり、逆適用（`x f`）と同じ扱いである——記号は残し、
  // 意味論からは消す。Pass 2 の出口でやるのは、ここが「構文の形が最後に見える場所」
  // だからである（Pass 3 以降は型の話しかしない）。
  const nodes = lines.map((line) => desugarIndexRest(reduceAll(line, env)));
  for (const node of nodes) synthesizePointfreeIn(node, env);

  // **並べた相手は、ここで畳み終える。** 個数が構文から見えているなら関数も器も要らない
  // ——`construct` の連鎖が既に左畳みの括弧の形をしている。残った（相手が実行時の器の）
  // 形だけが、下の合成へ回る。
  expandGreedyFoldsIn(nodes);

  // **貪欲な畳み込みへ名前と本体を与える。** `[+]` は残りアリティ2なので受け口1つの
  // 合成には収まらない——トップレベルへ持ち上げてから、その場の `[+]` を名前へ差し替える。
  if (!options.__pfFolded) {
    const folds = collectGreedyFolds(nodes);
    if (folds.length > 0) {
      // **前に置く。** ストリームの糖衣は元の名前を上書きするので後ろだったが、畳み込みは
      // 新しい名前を足すだけなので、使う場所より先に定義が要る。元の最後の式が最後のまま
      // 残る、という点でも前置きが正しい——`_sign_main` はそれを返す。
      return compile([...folds, source].join("\n"), { ...options, __pfFolded: true });
    }
  } else {
    replaceGreedyFolds(nodes);
  }
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
  // 均した先の入口に印を付ける。**同じ名前が2回定義されている**ので、後の方（生成側）が
  // カーソルの入口で、前の方（元の関数）は Pass 4 が飛ばす対象である。
  for (const g of options.__cursorGroups || []) markCursorEntries(nodes, g.entries, g.entries, g.group);
  // **`$` で渡した関数を、実体ごとに pass2 へ通し直す。** 型とアリティが実体の中へ
  // 流れ込むように、Pass 3 より前でやる（specializeRefCalls の注記）。
  specializeRefCalls(lines, nodes, env, options);
  // 実体を作った後で見る——`$` で渡した関数ごとの実体の本体が、関数を返す形になりうる。
  checkFunctionReturns(nodes);
  const specializations = runPass1b(nodes, env);
  // **鍵が増えるマージのぶんまで、器の並びを先に決める。**
  //
  // `p~ [ zzz : 1 ]~` は p の器へ入れる形だが鍵が1本増える。増える鍵が `aa` なら名前順
  // なので既存のスロットが全部ずれるので、少しずつ伸ばす手は無い——全プログラムを見る
  // のだから、和集合はコンパイル時の事実として先に確定させる（layout.js）。
  //
  // **Pass 3 より前でなければならない。** Pass 3 は仮引数へ届ける並び（`binding.shape`）
  // を `layoutOfStruct` のスナップショットとして焼くので、後から和集合を足すとそこだけ
  // 古い並びが残り、`f p` の中の `this ' foo` が隣のスロットを読む。
  // Pass 3 の型注釈と Pass 3b（`__` へ収束する経路の静的記録）は同じ走査で行う。
  const diagnostics = [];
  annotateAll(nodes, env, diagnostics);
  // layer による使用可能リテラル型の門番（option_ms_schema.md §4）。型が確定した後でないと
  // 判定できないのでここに置く。`options.layer` を渡さなければ検査しない——`option.ms` を
  // 読まない経路（テスト・playground の素の評価）まで std 相当を強制しないためである。
  if (options.layer !== undefined) checkLayerConstraints(nodes, options.layer);
  // charset に収まらない文字も同じ門番で見る（option_ms_schema.md §4.2）。
  if (options.charset !== undefined) checkCharsetConstraints(nodes, options.charset);

  // **均すのは型が付いてからである。**
  //
  // 認識器は「並べるものが器か」を型で見る（器が並ぶ形は個数が固定でないので均せない）。
  // 注釈の前に走らせると `atomType` が無く、その判定が素通りする——実際 `lexer.sn` で
  // 均せないはずの形まで均し、診断が 3 件から 8 件へ増えていた。**同じ入力に対して
  // 認識器が2つの答えを出す**形であり、いつもの壊れ方である。
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

  return { nodes, env, specializations, diagnostics };
}


/**
 * 畳み込みの本体を Sign のソースとして書き下す。
 *
 * **左から畳む。** 貪欲な連鎖は隣り合う2つを左から潰していくので、`[-] 10 3 2` は
 * `(10 - 3) - 2 = 5` である。右から畳むと 9 になり、非可換な演算子で黙って答えが変わる。
 *
 * 累算器を別の仮引数に出すのは、そうすれば**器を組み直さずに済む**からである。頭2つを
 * 潰して残りへ繋ぐ形（`自分 ((x OP y) ~xs)`）だと再帰のたびに列を作ることになるが、
 * 累算器なら残りをそのまま渡せる。しかも `自分 (acc OP x) xs` は末尾呼び出しなので、
 * 走査はループへ潰れる。
 */
function foldSource(op) {
  const f = foldNameFor(op);
  const go = `${f}_go`;
  // **空側を `!xs` で名指しする。** `xs & 本体 | x` と書くと、本体が正当に `__` を返した
  // とき（`` `abc` + 1 `` のような型エラー）にも `| x` へ落ちて、黙って違う値が出る。
  // 両側を条件付きにすれば、`__` は `__` のまま通る。
  //
  // **枝は match_case で書く。** 同じ意味を `条件 & 本体 | 条件 & 本体` で書くと、`|` の
  // 左辺は「値を見てから飛び先を決める」ので**末尾位置にならない**——再帰が `bl` になり、
  // フレームが積み上がる。match_case ならどの腕も末尾位置なので、自分への再帰がその場の
  // 分岐に畳まれる。実測で 145 → 110 命令（`bl` 3 → 1）。
  //
  // **公理だけで終端する形（`f : [x ~xs] ? x ${op} (f xs)`）は採らない。** 40 命令まで
  // 落ちて一番小さいが、二重に間違っている：
  //
  // 1. **右畳みになる。** `[-] [10 3 2]` が `10 - (3 - 2) = 9` で、左畳みの 5 ではない。
  // 2. **正当な `__` を飲む。** 完全性公理は右辺の `__` を単位元にするので（`x + __` は
  //    `x`）、「列が尽きた」と「計算が `__` を返した」が同じ形になる。`[+] `abc`` は
  //    `` `a` + `b` `` が charset の外（符号位置 195）で正当に `__` になるのに、公理が
  //    それを吸収して先頭の `a` を返してしまう。
  //
  // **単位元と誤りの印は、同じ位置で兼ねられない。** `!xs` はその2つを分けるために在る。
  return [
    `${go} : acc [x ~xs] ?`,
    `\t!xs : acc ${op} x`,
    `\t${go} (acc ${op} x) xs`,
    `${f} : [x ~xs] ?`,
    `\t!xs : x`,
    `\t${go} x xs`,
  ].join("\n");
}
/**
 * **貪欲な写像（`[* 2,]`）に名前と本体を与える。**
 *
 * 残りアリティ1——各要素へ同じ演算を当てて器を返す。畳み込みと同じく器を1本走査する
 * だけで、違うのは畳むか並べるかである。
 *
 * **顔は2つあるが規則は1つ。** 各要素に `x OP k` を当て、`__` になったものを落とす。
 * 算術ならどれも `__` にならないので素直な写像になり、比較なら偽が `__` になるので
 * **選択**になる（`[< 3,] [1 2 3]` が `[1 2]`）。落とすのは構築がやる（`1 __ 3` は
 * `[1 3]`）ので、規則を2つ持つ必要は無い。
 *
 * ただし**書き下し方は2つ要る**。比較で残すのは判定の値ではなく**要素そのもの**なので
 * （`[< 3,]` は 3 ではなく 1 を残す）、`(x OP k) & x` と書く。そしてその形は「通れば
 * 並べて再帰、落ちれば並べずに再帰」の枝分かれにしないと、機械の側で長さが上界のまま
 * になる——飛ばした個数を返り値の長さへ反映できないからである。
 *
 * 相手（`2`）は仮引数で受ける。生成するのはソースなので、相手が任意の式だと書き下せない
 * ——仮引数にしておけば、呼ぶ側が元の式のノードをそのまま実引数として渡せる。
 *
 * 繋ぎの後置 `~` は**列の μ が任意である**ことから来る（原理7）。文字列なら要らないが、
 * 追記の位置では 0 命令なので、どちらでも同じ命令に落ちる。
 */
// 比較族（Pass 2 が付ける名前）。`=` は `assign_equal`、構造比較は `equal`/`xnot_equal`。
const COMPARE_MAP_OPS = new Set([
  "less",
  "less_equal",
  "more",
  "more_equal",
  "assign_equal",
  "not_equal",
  "equal",
  "xnot_equal",
]);

function mapSource(m) {
  const f = mapNameFor(m);
  const k = m.operand;
  const step = `(${f} (s ' 1~))~`;
  if (COMPARE_MAP_OPS.has(m.name)) {
    // 比較は選択である。残すのは判定の値ではなく要素そのもの。
    //
    // 「通れば並べて再帰、落ちれば並べずに再帰」に枝分かれさせる。`(x OP k) & x` と
    // 1本で書いても解釈側は同じ答えを出すが、機械の側は飛ばした個数を長さへ反映できず
    // 上界のままになる——枝にすれば、落ちる枝が「0 個書いて続ける」ことになる。
    return [`${f} : [~s] ?`, `\t!s : __`, `\t(s ' 0) ${m.op} ${k} : (s ' 0) ${step}`, `\t${f} (s ' 1~)`].join("\n");
  }
  return [`${f} : [~s] ?`, `\t!s : __`, `\t((s ' 0) ${m.op} ${k}) ${step}`].join("\n");
}

function mapNameFor(m) {
  const hex = (s) => [...String(s)].map((c) => c.charCodeAt(0).toString(16)).join("");
  return `_pf_map_${hex(m.op)}_${hex(m.operand)}`;
}

/**
 * その式は「残りアリティ1の貪欲なポイントフリー」か（`[* 2,]`）。穴は左辺である。
 *
 * **相手はリテラルのときだけ扱う。** 生成するのは Sign のソースなので、相手が任意の式だと
 * 書き下せない。仮引数で受ける手もあるが、それだと合成した関数のアリティが 2 になり、
 * 書き換え前に `buildEnv` が記録した束縛（`g : [* 2,]` の `g`）と食い違う——木だけ
 * 差し替えても、束縛の言うアリティは古いままだからである。リテラルを焼き込めば受け口は
 * 器1つのままで、畳み込みと同じく**名前へ差し替えるだけ**で済む。
 *
 * 相手が式の形は、これまで通り解釈側の貪欲な道を通る（機械では出せないと名指しされる）。
 */
function greedyMapOf(node) {
  const n = node && Array.isArray(node.lines) && node.lines.length === 1 ? node.lines[0] : node;
  if (!n || n.type !== "operation" || !n.partial || !n.pointfreeMap || n.position !== "infix") return null;
  if (n.left || !n.right || !n.op) return null;
  // **添字の写像（`[' 0,]`）は扱わない。** 相手は要素の中の位置であって、走査する器の
  // 切り出し方（`s ' 1~`）と同じ演算子を別の意味で使うことになる。実際、積を渡した形
  // （`[' 0,] ([1 2] , [3 4])`）で残りの取り方が食い違う。ここは積の切り出しが揃って
  // からで、それまでは解釈側の貪欲な道に残す。
  if (n.name === "get_prop") return null;
  const r = n.right;
  if (!r || r.type !== "atom" || !(r.kind === "number" || r.kind === "address")) return null;
  return { op: n.op, name: n.name, operand: String(r.value), node: n };
}

function foldNameFor(op) {
  return `_pf_fold_${[...op].map((c) => c.charCodeAt(0).toString(16)).join("")}`;
}

/** その式は「残りアリティ2の貪欲なポイントフリー」か（`[+]` / `[*]`）。 */
function isGreedyFold(node) {
  const n = node && Array.isArray(node.lines) && node.lines.length === 1 ? node.lines[0] : node;
  return !!(n && n.type === "operation" && n.partial && !n.pointfreeMap && n.position === "infix" && !n.left && !n.right && n.op);
}

/**
 * **並べた相手なら、畳み込みはコンパイル時に終わる。**
 *
 * `[-] 1 2 3 4 5` の右辺は、Pass 2 を出た時点で既に**左に入れ子の `construct` 連鎖**に
 * なっている——`construct(construct(construct(construct(1,2),3),4),5)`。これは左畳みの
 * 括弧の付き方そのものなので、**`construct` を演算子に差し替えるだけ**で畳み終わる。
 *
 *     [-] 1 2 3 4 5   →   ((((1 - 2) - 3) - 4) - 5)
 *
 * 個数が構文から見えているときだけできる。相手が識別子（実行時の器）や後置 `~` なら
 * 長さが分からないので、これまで通り再帰する関数を合成する。
 *
 * これが効くのは命令数だけではない。**実行時の値に対するポイントフリーが出せるように
 * なる**——`f : a b c ? [+] a b c` は器を組んで走ろうとして「器の構築はまだ出せません
 * （フレームから出る）」で止まっていたが、展開すれば器そのものが要らない。
 *
 * @returns 畳み終えたノード。展開できない形なら null。
 */
function expandGreedyFold(node) {
  if (!node || node.type !== "operation" || node.name !== "apply" || node.position !== "infix") return null;
  if (!isGreedyFold(node.left)) return null;
  const inner = node.left.lines ? node.left.lines[0] : node.left;
  const leaves = constructLeaves(node.right);
  if (!leaves || leaves.length < 2) return null; // 1つだけの形は畳む相手が無く、器かもしれない
  return leaves.reduce((acc, x) => ({
    type: "operation",
    name: inner.name,
    op: inner.op,
    position: "infix",
    left: acc,
    right: x,
  }));
}

/**
 * 左に入れ子の `construct` 連鎖を、並びとして読む。連鎖でなければ null。
 *
 * 一番外側の括弧だけ剥がす（`[+] [1 2 3]` の `[…]`）。**要素の括弧は剥がさない**
 * ——`(1 2)` は入れ子の器であって、外の並びの1要素である。
 */
function constructLeaves(node) {
  const outer = node && Array.isArray(node.lines) && node.lines.length === 1 ? node.lines[0] : node;
  const isChain = (n) => !!(n && n.type === "operation" && n.name === "construct" && n.position === "infix");
  if (!isChain(outer)) return null;
  const leaves = [];
  const walk = (n) => {
    if (isChain(n)) { walk(n.left); leaves.push(n.right); return; }
    leaves.push(n);
  };
  walk(outer);
  return leaves;
}

/**
 * **並べた相手なら、写像もコンパイル時に終わる。**
 *
 * 畳み込みが `construct` を演算子に差し替えるのに対し、写像は**連鎖の形を保ったまま
 * 各要素に演算を当てる**——並びの長さは変わらないからである。
 *
 *     [* 2,] 1 2 3   →   (1 * 2) (2 * 2) (3 * 2)
 *
 * **比較は選択になる。** `[< 3,]` が残すのは判定の値ではなく**要素そのもの**なので
 * `(x < 3) & x` と書く。落ちた要素は `__` になり、**落とすのは構築がやる**
 * （`1 __ 3` は `[1 3]`）——規則を2つ持つ必要は無く、合成する関数の側と同じ読みである。
 *
 * これは一度諦めた道である。Pass 4 の構築が `__` を落とさず、`||[< 3,] 1 2 3||` が
 * 3 を返していた（解釈は 2）——**展開が正しくても、置く先が落とさなければ合わない**。
 * 構築がカーソルで書くようになって成り立った。
 */
function expandGreedyMap(node) {
  if (!node || node.type !== "operation" || node.name !== "apply" || node.position !== "infix") return null;
  const m = greedyMapOf(node.left);
  if (!m) return null;
  const leaves = constructLeaves(node.right);
  if (!leaves || leaves.length < 2) return null;
  const k = () => ({ type: "atom", kind: m.node.right.kind, value: m.node.right.value });
  const step = (x) => {
    const hit = { type: "operation", name: m.name, op: m.op, position: "infix", left: x, right: k() };
    // 比較は「通ったら要素を残す」——判定の値ではない。
    return COMPARE_MAP_OPS.has(m.name)
      ? { type: "operation", name: "and", op: "&", position: "infix", left: hit, right: x }
      : hit;
  };
  return leaves.map(step).reduce((acc, x) => ({
    type: "operation",
    name: "construct",
    op: " ",
    position: "infix",
    left: acc,
    right: x,
  }));
}

/**
 * **合成は左から実行する。** `f g` は「`f` してから `g`」であり（operator_table.md
 * 10.6「左結合な関数合成」）、数学の `g ∘ f` と読みの向きが逆である——パイプラインの
 * 順に書ける。したがって `(f g) x` は `g (f x)` に展開する。
 *
 * 呼び先が静的に分かるので実行時に合成を組む必要が無い。畳み込みや写像と同じ「並べた
 * 相手ならコンパイル時に終わる」形であり、これが無いと Pass 4 は
 * 「呼び先が静的に決まりません」「まだ出せない式です（compose）」で止まる。
 *
 * 連なり（`f g h`）は `compose(compose(f,g),h)` なので、外側を1回開くと内側がまた
 * `apply(compose(...), …)` になる——不動点まで回す側が続きを片付ける。
 */
function expandCompose(node, named) {
  if (!node || node.type !== "operation" || node.name !== "apply" || node.position !== "infix") return null;
  const peelParen = (x) => (x && Array.isArray(x.lines) && x.lines.length === 1 ? x.lines[0] : x);
  const isCompose = (x) => !!(x && x.type === "operation" && x.name === "compose" && x.position === "infix");
  let fn = peelParen(node.left);
  // **名前を付けた合成（`h : f g`）も同じ形である。** `buildEnv` の束縛は型とアリティしか
  // 持たないので（値ノードは後の pass が入れる）、トップレベルの定義から直に引く。
  if (!isCompose(fn) && fn && fn.type === "atom" && fn.kind === "identifier" && named) {
    const v = named.get(fn.value);
    if (isCompose(v)) fn = v;
  }
  if (!isCompose(fn)) return null;
  const call = (f, x) => ({ type: "operation", name: "apply", op: " ", position: "infix", left: f, right: x });
  return call(fn.right, call(fn.left, node.right));
}

/**
 * 木の中の展開できる畳み込み・写像・合成を、その場で終わらせる。
 *
 * **内側から畳む必要がある。** `[+] ([* 2,] a b c)` は、写像が並びになって初めて
 * 畳み込みの相手が `construct` 連鎖になる。`walkNodes` は差し替えたところで降りるのを
 * やめるので、**変化が無くなるまで回す**——回数は式の入れ子の深さで、実際には 2〜3 回。
 */
function expandGreedyFoldsIn(nodes) {
  // 名前を付けた合成を先に集める（`h : f g`）。
  const named = new Map();
  for (const n of nodes) {
    if (!n || n.type !== "operation" || n.name !== "define") continue;
    if (!n.left || n.left.type !== "atom" || n.left.kind !== "identifier") continue;
    const v = n.right && Array.isArray(n.right.lines) && n.right.lines.length === 1 ? n.right.lines[0] : n.right;
    if (v && v.type === "operation" && v.name === "compose" && v.position === "infix") named.set(n.left.value, v);
  }
  const one = (n) => expandGreedyFold(n) || expandGreedyMap(n) || expandCompose(n, named) || null;
  for (let pass = 0; pass < 16; pass++) {
    let changed = false;
    for (let i = 0; i < nodes.length; i++) {
      const done = one(nodes[i]);
      if (done) { nodes[i] = done; changed = true; }
    }
    walkNodes(nodes, null, (child) => {
      const d = one(child);
      if (d) changed = true;
      return d || child;
    });
    if (!changed) break;
  }
  // **展開しきった合成の定義は、もう誰も見ない。** `h : f g` の呼び出しは全部
  // `g (f x)` へ開いてあるので、定義そのものは死んでいる——残すと Pass 4 が
  // 「まだ出せない式です（compose）」で止まる。
  //
  // 開けなかった使い方（`$h` のように値として渡す形）が残っていれば、そちらは
  // 「まだ出せない識別子です（h）」と名指しで止まる——**黙って消えることはない**。
  for (const n of nodes) {
    if (!n || n.type !== "operation" || n.name !== "define") continue;
    const v = n.right && Array.isArray(n.right.lines) && n.right.lines.length === 1 ? n.right.lines[0] : n.right;
    if (v && v.type === "operation" && v.name === "compose" && v.position === "infix") n.supersededByDesugar = true;
  }
}

/** 貪欲なポイントフリーを演算子ごとに集め、生成すべきソースを返す。 */
function collectGreedyFolds(nodes) {
  const folds = new Set();
  const maps = new Map(); // 名前 -> 記述（演算子と焼き込む相手で1つに畳む）
  walkNodes(nodes, (n) => {
    if (isGreedyFold(n)) {
      folds.add((n.lines ? n.lines[0] : n).op);
      return;
    }
    const m = greedyMapOf(n);
    if (m) maps.set(mapNameFor(m), m);
  });
  return [...folds].map(foldSource).concat([...maps.values()].map(mapSource));
}

/**
 * 貪欲なポイントフリーを、生成した名前への参照へ置き換える。
 *
 * 畳み込みも写像も**器1つを取る**ので、どちらも名前へ差し替えるだけでよい。写像の相手を
 * 焼き込んであるおかげで受け口が1つに収まり、`buildEnv` が記録した束縛のアリティと
 * 食い違わない。
 */
function replaceGreedyFolds(nodes) {
  walkNodes(nodes, null, (child) => {
    const inner = child && child.lines ? child.lines[0] : child;
    if (isGreedyFold(child)) {
      return { type: "atom", kind: "identifier", value: `<${foldNameFor(inner.op)}>` };
    }
    const m = greedyMapOf(child);
    if (m) return { type: "atom", kind: "identifier", value: `<${mapNameFor(m)}>` };
    return child;
  });
}

/** 子を差し替えられる木歩き。`visit` は観測、`swap` は置き換え。 */
function walkNodes(nodes, visit, swap) {
  const seen = new Set();
  const step = (n) => {
    if (!n || typeof n !== "object" || seen.has(n)) return;
    seen.add(n);
    if (visit) visit(n);
    for (const k of ["left", "right", "operand"]) {
      if (!n[k]) continue;
      const s = swap ? swap(n[k]) : n[k];
      if (s !== n[k]) n[k] = s;
      else step(n[k]);
    }
    if (Array.isArray(n.lines)) {
      for (let i = 0; i < n.lines.length; i++) {
        const s = swap ? swap(n.lines[i]) : n.lines[i];
        if (s !== n.lines[i]) n.lines[i] = s;
        else step(n.lines[i]);
      }
    }
    for (const e of n.entries || []) {
      if (!e.default) continue;
      const s = swap ? swap(e.default) : e.default;
      if (s !== e.default) e.default = s;
      else step(e.default);
    }
  };
  for (const n of nodes) step(n);
}

/** その識別子ノードは「置き場所」を表すホールか（`[!_]` の `_`）。 */
function isHole(n) {
  return !!(n && n.type === "atom" && n.kind === "hole");
}

/**
 * **ポイントフリーを、仮引数を持つ形へ合成する。**
 *
 * `[+ 2]` は「左辺の欠けた演算」であって仮引数を持たない。意味論の上ではそれで足りる
 * （インタプリタは欠けた所へ実引数を入れて評価する）が、機械の上で関数として出すには
 * **受け口**が要る——`genFunction` は仮引数リストが無いと何も束縛できない。
 *
 * そこで書かれた形から `_a ? _a + 2` を組む。意味は変えない——**欠けている所に名前を
 * 置くだけ**である。判定に使う `partial` は縮約時に書かれた形から付く印なので、ここも
 * 「フロントエンドの表現がそのまま型になる」の側に居る。
 *
 * 合成できるのは受け口が1つの形だけである。`[+]`（貪欲な畳み込み）と `[* 2,]`（写像）は
 * 実引数を何個でも食うので、仮引数1つの形には収まらない——そちらは別の合成が要る。
 *
 * @returns 合成したラムダノード。合成できない形なら null。
 */
function synthesizePointfree(node, scope) {
  const inner = node && Array.isArray(node.lines) && node.lines.length === 1 ? node.lines[0] : node;
  if (!inner || inner.type !== "operation" || !inner.partial || inner.pointfreeMap) return null;
  const name = "<_pf>";
  const param = { type: "atom", kind: "identifier", value: name };
  let body = null;
  if (inner.position === "infix" && inner.right && !inner.left) {
    // `[+ 2]` → `_a ? _a + 2`。欠けているのは左辺である。
    body = { ...inner, left: param, partial: undefined };
  } else if ((inner.position === "prefix" || inner.position === "postfix") && isHole(inner.operand)) {
    // `[!_]` / `[_!]` → ホールがそのまま受け口である。
    body = { ...inner, operand: param, partial: undefined };
  }
  if (!body) return null;
  const inner2 = bindEnv([name], scope);
  return {
    type: "operation",
    op: "?",
    name: "lambda",
    position: "infix",
    left: { type: "params", entries: [{ name, rest: false, default: null }], requiredArity: 1, bracket: false },
    right: body,
    scope: inner2,
  };
}

/** 束縛の右辺に書かれたポイントフリーを、その場でラムダへ置き換える。 */
function synthesizePointfreeIn(node, scope) {
  if (!node || typeof node !== "object") return;
  if (node.type === "operation" && node.name === "define" && node.right) {
    const lam = synthesizePointfree(node.right, scope);
    if (lam) {
      node.right = lam;
      return;
    }
  }
  for (const k of ["left", "right", "operand"]) synthesizePointfreeIn(node[k], scope);
  for (const l of node.lines || []) synthesizePointfreeIn(l, scope);
  for (const e of node.entries || []) {
    if (!e.default) continue;
    const lam = synthesizePointfree(e.default, scope);
    if (lam) e.default = lam;
    else synthesizePointfreeIn(e.default, scope);
  }
}

export { compile };
