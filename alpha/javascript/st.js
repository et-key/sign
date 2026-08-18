/**
 * SignType（`.st` / `.ist`）の生成。
 *
 * type_system.md §6 が定める型シグネチャ形式へ、Pass 1〜3 が確定した型情報を書き出す。
 * 型は「宣言」されるものではなく「コードから読み取って書き写す」だけの存在であり（§1）、
 * ここはその書き写しを行う場所である。
 *
 * ## `.st` と `.ist` の違いは**範囲だけ**で、形式は同じ
 *
 * | | 内容 | 実体 |
 * |---|---|---|
 * | `.st` | `#`/`##`/`###` で export された識別子のみ | ディスク上のビルド成果物 |
 * | `.ist` | 非公開の内部識別子を含む全て | **プロセス内メモリのみ**（compiler_pipeline.md §4） |
 *
 * `.ist` をディスクへ書かないのはセキュリティ上の規定である——内部識別子名・内部 struct の
 * フィールド構成・アクセスパターンが載るため、ファイルを経由させると意図しない漏洩経路に
 * なりうる。したがって `scope: "ist"` は**デバッグ目的の文字列生成のみ**に使い、ビルド
 * 成果物として永続化してはならない。
 *
 * ## 未解決の型は `_`（ホール）で書く
 *
 * §6 の形式は「型が分からない」を表す記法を定めていない。ここでは Sign のホール記法 `_` を
 * 「まだ埋まっていないスロット」の意味で流用する。これは提案であり確定した記法ではない。
 * 未解決を伏せずに出すことが目的である——型システムに消費者が居ないうちは、間違った型も
 * 欠けた型も観測されないままになる。`.st` はその最初の観測手段である。
 */

import { inferLambdaParamTypes } from "./pass3.js";

const UNKNOWN = "_";

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

function isLambdaNode(n) {
  return !!n && n.type === "operation" && n.name === "lambda";
}

// `<name>` → `name`。識別子トークンは常に山括弧で囲まれている（pass1 の判定基準と同じ）。
function bareName(value) {
  return typeof value === "string" && value.startsWith("<") && value.endsWith(">") ? value.slice(1, -1) : value;
}

// 単一の identifier ノード、または params ノードから仮引数エントリを取り出す。
function paramEntries(paramNode) {
  if (!paramNode) return [];
  if (isIdentifierNode(paramNode)) return [{ name: paramNode.value, rest: false, hasDefault: false }];
  if (paramNode.type === "params") {
    return (paramNode.entries || []).map((e) => ({
      name: e.name,
      rest: !!e.rest,
      hasDefault: e.default !== null && e.default !== undefined,
      pattern: e.pattern || null,
    }));
  }
  return [];
}

/**
 * 本体が `'` でどのフィールドへアクセスしているかを識別子ごとに集める
 * （§6.2「関数仮引数のフィールド要求も `.st` に自動生成する」）。
 *
 * Hindley-Milner のような制約ソルビングではなく、アクセスされたキー名を集合として
 * 集めるだけの単純な走査である。分岐でアクセスが変わる場合は和集合になる。
 * 別関数へのパススルーは追わない（§6.2 の NOTE が別途の課題としている）。
 */
function collectFieldRequirements(bodyNode, paramNames) {
  const fields = new Map();
  function visit(node) {
    if (!node || typeof node !== "object") return;
    if (node.type === "operation" && node.name === "get_prop") {
      const base = node.left;
      const key = node.right;
      if (isIdentifierNode(base) && paramNames.has(base.value) && isIdentifierNode(key)) {
        if (!fields.has(base.value)) fields.set(base.value, new Set());
        fields.get(base.value).add(bareName(key.value));
      }
    }
    for (const k of ["left", "right", "operand", "middle"]) visit(node[k]);
    for (const line of node.lines || []) visit(line);
    for (const e of node.entries || []) visit(e.default);
  }
  visit(bodyNode);
  return fields;
}

// 仮引数1つ分の型表記を作る。フィールド要求が集まっていればそれを優先する
// （`{x, y}` は「少なくとも x, y を持つ構造体」という構造的な要求）。
function paramTypeText(entry, usageTypes, fieldReqs) {
  if (entry.pattern) {
    // ブラケット分割代入パターン。実引数は1個で、その中身が分解される。
    const inner = entry.pattern.map((p) => bareName(p.name) + (p.rest ? "~" : "")).join(" ");
    return `[${inner}]`;
  }
  const fields = fieldReqs.get(entry.name);
  if (fields && fields.size > 0) return `{${[...fields].sort().join(", ")}}`;
  const inferred = usageTypes.get(entry.name);
  if (inferred) return entry.rest ? `${inferred}~` : inferred;
  // 裸の仮引数（rest でもブラケット分割代入でもない）は**1個の値**を受ける。集合を受け取る
  // なら `[x ~xs]`（参照渡し）か `~xs`（stream）で宣言するので、宣言の形が既に「点である」
  // ことを語っている（原理3 の表）。さらにデフォルトが無ければ `__` を渡せない——完全性
  // 公理により呼び出しごと潰れるので、本体に入った時点で非Unitが保証される。
  //
  // したがって演算子から何も逆算できなくても `_` ではなく `Atom` まで書ける。`Atom` は
  // §4 の記法定義で「String を**含む**スカラー」＝ `Scalar | String` である。多相に見えて
  // 下限が決まっている——具体的な型は呼び出しサイトで確定する（§5 Pass 1b）。
  //
  // rest とブラケットには付けない。前者は stream、後者は構造であり、どちらも点ではない。
  return entry.rest ? `${UNKNOWN}~` : UNKNOWN;
}

// ノード1つ分の型表記。`List` は要素型を伴って `List(T)` と書く（§2 の記法）。
//
// 要素型を落とすと「整数のリスト」と「実数のリスト」が同じ `List` になり、単一の実数
// （`Float`）とも区別が付かなくなる。要素型は Pass 4 が `base + i × sizeof(T)` を出すのに
// 要る情報であり、型の側で最も落としてはいけない部分である。
//
// なお1要素のリストはスカラーと同型なので（`[5]` は `Int`）、`List(T)` が付くのは
// 2要素以上か構文的にリストと確定している場合だけである。これは設計上の同一視であり
// 欠落ではない——1要素の連続ブロックとレジスタ上のスカラーは同じビット列を持つ。
function slotTypeText(node) {
  if (!node) return UNKNOWN;
  const t = node.atomType || UNKNOWN;
  if (t === "List") return node.elementType ? `List(${node.elementType})` : "List";
  // `Implicit(T)`（暗黙のアドレス＝場所）も要素型を伴う。前置 `~`（持ち上げ）が生む。
  if (t === "Implicit") return node.elementType ? `Implicit(${node.elementType})` : "Implicit";
  if (t === "Struct") return structTypeText(node, t);
  return t;
}

/**
 * `Struct` を、名前付きスロットか連番スロットかが分かる形で書く。
 *
 * 両者は同じ構造（固定オフセットで並ぶ連続ブロック）だが**関心事が違う**（§2）。
 *
 *   Struct{x : Int , 0  y : Int , 1}  名前付き
 *   Struct(Int String Float)             連番
 *
 * どちらのスロットも **(型, 連番)** を持つ。違いは連番の書き表し方だけである。
 * 連番スロットには名前が無いので並べ替える鍵が無く、**記法上の位置がそのまま連番**に
 * なる（だから書かない）。名前付きスロットは名前でソートして並べるため、連番は
 * 明示するしかない——そこで `型 , 連番` という直積で書く。
 *
 * 名前付きの書き方は、それ自体が名前付きスロットの形をしている（名前→(型,連番) の写像）。
 * 名前がソート順に並ぶので**並びが物理配置**、各名前が持つ連番が**宣言順**であり、
 * どちらも導出に頼らず明示されている。
 *
 *   point  : [x : 3 / y : 4]  →  Struct{x : Int , 0  y : Int , 1}
 *   point2 : [y : 4 / x : 3]  →  Struct{x : Int , 1  y : Int , 0}
 *
 * 括弧の違いが**位置の確約の有無**を表す。`{}` は名前で同定するものであり、物理
 * オフセットは名前ソートの正規順（stack_abi.md §7.1）なので「N番目は offset N×幅」
 * という確約は無い——そして名前で引く以上、要らない。`()` はソートの鍵となる名前が
 * 無いため宣言順がそのまま物理配置になり、確約が在る。MMIO・FFI・シリアライズのように
 * 外が配置を決める場面は `()` の側で書く。
 *
 * 名前付きスロットは「名前・連番・実データ」の三つを持つ。ここに書き写すのは
 * **宣言順**である——物理配置は名前でソートした正規順（stack_abi.md §7.1）だが、
 * それは宣言順から `sort` で導出できる。逆は導出できない。したがって宣言順の方が
 * 情報として厳密に大きく、ソート順を書き写すと**ねじれが失われる**。
 *
 * ねじれ（宣言順と正規順の置換）自体が情報である。`point : [x y]` と
 * `point2 : [y x]` は `==` では等しい（Hom集合の一致は宣言順を問わない）が、
 * 連番で引けば違う値を返す。これは矛盾ではなく、`==` が比較していない性質を
 * 測っているだけである（§2、`==` は同一性ではない）。`.st` がソート順しか書かないと
 * この差が消え、「正した」事実だけが残って「何を正したか」が暗黙化してしまう。
 */
function structTypeText(node, atomType) {
  if (atomType !== "Struct" || !node) return atomType;
  if (node.slotKind === "named") {
    // 宣言順（連番）を先に確定させてから、名前でソートして並べる。
    // 並び＝物理配置（正規順）、各名前が持つ値＝宣言順。両方が明示される。
    const slots = (node.lines || [])
      .map((l, ordinal) => {
        if (isDefineNode(l) && isIdentifierNode(l.left)) {
          return { name: bareName(l.left.value), ordinal, type: slotTypeText(l.right) };
        }
        // フィールド名の省略記法（`x` だけの行）。値はその識別子自身。
        if (isIdentifierNode(l)) return { name: bareName(l.value), ordinal, type: slotTypeText(l) };
        return null;
      })
      .filter(Boolean);
    if (slots.length === 0) return "Struct";
    slots.sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
    return `Struct{${slots.map((s) => `${s.name} : ${s.type} , ${s.ordinal}`).join("  ")}}`;
  }
  if (node.slotKind === "positional") {
    const slots = [];
    const walk = (n) => {
      if (n && n.type === "operation" && n.name === "product") {
        walk(n.left);
        slots.push(slotTypeText(n.right));
        return;
      }
      slots.push(slotTypeText(n));
    };
    walk(node);
    return `Struct(${slots.join(" ")})`;
  }
  return atomType;
}

/**
 * 1つの定義行から SignType の1エントリを組み立てる。
 * @returns {{ name: string, text: string, unresolved: number } | null}
 */
function isComposeNode(node) {
  return node && node.type === "operation" && node.name === "compose";
}

// 合成木の端の項を返す。`f g h` のような多段合成でも、シグネチャを決めるのは
// 両端だけである（間の関数は型の受け渡しにしか関与しない）。
function composeEndNode(node, side) {
  let n = node;
  while (isComposeNode(n)) n = side === "left" ? n.left : n.right;
  return n;
}

// 合成の端をラムダノードへ解決する。その場に書かれた無名ラムダ（`(x ? x + 1) f`）は
// そのまま使えるし、識別子なら束縛を引く。どちらでもない端（ポイントフリーの `[+ 1]` や
// `@p` のような間接呼び出し）は辿れないので null——分からないことは `_` のままにする。
function lambdaOf(node, lambdaByName) {
  // その場に書いた無名ラムダは `(x ? x + 1)` のように括弧で包まれて来るので、
  // 1文だけの括弧ブロックは剥がしてから見る。
  let n = node;
  while (n && n.type === "block" && n.kind === "paren" && Array.isArray(n.lines) && n.lines.length === 1) {
    n = n.lines[0];
  }
  if (isLambdaNode(n)) return n;
  if (!isIdentifierNode(n) || !lambdaByName) return null;
  return lambdaByName.get(n.value) || null;
}

// ラムダ1つ分のシグネチャ（仮引数の並びと返値）を組み立てる。`名前 : ラムダ` の分岐と、
// 合成（`h : f g`）が両端から拾う分岐とで共有する。
function lambdaSignature(rhs) {
  const entries = paramEntries(rhs.left);
  const paramNames = new Set(entries.map((e) => e.name).filter(Boolean));
  const usageTypes = inferLambdaParamTypes(rhs, null);
  const fieldReqs = collectFieldRequirements(rhs.right, paramNames);

  // 仮引数リスト全体が1個のブラケット（`[h ~t]`）なら、**要求する実引数は1個**である
  // ——ブラケットは渡された単一の List/Struct をその場で分割代入する（Eagerパターン、
  // list_model.md §2.4）。エントリ数は分解後の束縛の数であって実引数の数ではないので、
  // 型としても1スロットにまとめて書く。混在形（`dist [h ~t]`）の場合は entry.pattern
  // として1エントリに畳まれているので、こちらの分岐には来ない。
  const wholeBracket = rhs.left && rhs.left.type === "params" && rhs.left.bracket;
  const params = wholeBracket
    ? [`[${entries.map((e) => bareName(e.name) + (e.rest ? "~" : "")).join(" ")}]`]
    : entries.map((e) => paramTypeText(e, usageTypes, fieldReqs));
  // 返値型は本体ノードの Layer 2 型そのもの。Lambda 自身は Layer 1 のカテゴリであり
  // Layer 2 型を持たないが（§2）、本体は値を作るので型を持つ。
  const ret = rhs.right && rhs.right.atomType ? slotTypeText(rhs.right) : UNKNOWN;
  return { params, ret };
}

// 仮引数の並びと返値から1行分のテキストを起こす。仮引数が無い関数は `__ -> T`
// ——完全性公理（§3.4）が言う通り、引数を取らない関数は Unit を受ける関数である。
function signatureText(name, params, ret) {
  const unresolved = params.filter((p) => p === UNKNOWN || p === `${UNKNOWN}~`).length + (ret === UNKNOWN ? 1 : 0);
  const lhs = params.length > 0 ? params.join(" ") : "__";
  return { name, text: `${name} : ${lhs} -> ${ret}`, unresolved };
}

function entryFor(defineNode, lambdaByName) {
  if (!isDefineNode(defineNode) || !isIdentifierNode(defineNode.left)) return null;
  const name = bareName(defineNode.left.value);
  const rhs = defineNode.right;

  if (isLambdaNode(rhs)) {
    const { params, ret } = lambdaSignature(rhs);
    return signatureText(name, params, ret);
  }

  // 合成（`h : f g`）は Lambda であって Layer 2 の Atom 内部型を持たないが、
  // シグネチャは両端から決まる。スペースによる合成は**左→右のパイプライン**
  // （`f g` は `g(f(x))`、coproduct_resolver.md §3.1）なので、**仮引数は左端の
  // `f` が、返値は右端の `g` が**決める。
  if (isComposeNode(rhs)) {
    const first = lambdaOf(composeEndNode(rhs, "left"), lambdaByName);
    const last = lambdaOf(composeEndNode(rhs, "right"), lambdaByName);
    if (first && last) {
      return signatureText(name, lambdaSignature(first).params, lambdaSignature(last).ret);
    }
  }

  // Atom: 右辺式の Layer 2 型がそのまま識別子の型になる（§5 Pass 1a）。
  const t = rhs && rhs.atomType ? rhs.atomType : UNKNOWN;
  return { name, text: `${name} : ${slotTypeText(rhs)}`, unresolved: t === UNKNOWN ? 1 : 0 };
}

/**
 * SignType 形式の文字列を生成する。
 *
 * @param {object[]} nodes compile() が返した縮約済みノード列
 * @param {object} env compile() が返した識別子テーブル（ルートスコープ）
 * @param {{ scope?: "st"|"ist", source?: string }} [options]
 *   scope: "st"（既定、export されたもののみ）/ "ist"（全識別子、**メモリ上のみ**）
 *   source: 冒頭のコメントに書くソースファイル名
 * @returns {{ text: string, entries: number, unresolved: number }}
 */
function generateSignType(nodes, env, options = {}) {
  const scope = options.scope === "ist" ? "ist" : "st";
  const bindings = env && env.bindings ? env.bindings : new Map();

  // 合成（`h : f g`）のシグネチャを両端のラムダから拾うための索引。
  const lambdaByName = new Map();
  for (const node of nodes) {
    if (isDefineNode(node) && isIdentifierNode(node.left) && isLambdaNode(node.right)) {
      lambdaByName.set(node.left.value, node.right);
    }
  }

  const out = [];
  let entries = 0;
  let unresolved = 0;

  for (const node of nodes) {
    const e = entryFor(node, lambdaByName);
    if (!e) continue;
    const binding = bindings.get(`<${e.name}>`);
    const exported = binding ? binding.exported : null;
    if (scope === "st" && !exported) continue;
    out.push(exported ? `${exported}${e.text}` : e.text);
    entries++;
    unresolved += e.unresolved;
  }

  const header = [
    `\` SignType (${scope}) — Pass 1〜3 が確定した型を書き写したもの`,
    options.source ? `\` source: ${options.source}` : null,
    scope === "ist" ? "` .ist はメモリ上のみ。ディスクへ永続化しないこと（compiler_pipeline.md §4）" : null,
    unresolved > 0 ? `\` 未解決 ${unresolved} 箇所を \`${UNKNOWN}\` で示している` : null,
  ].filter(Boolean);

  return { text: [...header, "", ...out].join("\n") + "\n", entries, unresolved };
}

export { generateSignType };
