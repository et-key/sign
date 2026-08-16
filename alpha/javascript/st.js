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
  const base = inferred || UNKNOWN;
  return entry.rest ? `${base}~` : base;
}

/**
 * `Struct` を、名前付きスロットか連番スロットかが分かる形で書く。
 *
 * 両者は同じ構造（固定オフセットで並ぶ連続ブロック）だが**関心事が違う**（§2）。
 *
 *   Struct{x : 1 y : 0}  名前付き。**名前をソート順に並べ、各名前が宣言順（連番）を持つ**
 *   Struct(_ _ _)        連番。順序が意味そのもの。スロット型を並べる
 *
 * 名前付きの書き方は、それ自体が名前付きスロットの形をしている（名前→連番の写像）。
 * 名前がソート順に並ぶので**物理配置がそのまま読め**、各名前が持つ値が宣言順なので
 * **ねじれもそのまま読める**。どちらも導出に頼らず明示されている。
 *
 *   point  : [x : 3 / y : 4]  →  Struct{x : 0 y : 1}   恒等置換
 *   point2 : [y : 4 / x : 3]  →  Struct{x : 1 y : 0}   互換が入っている
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
        const name = isDefineNode(l) && isIdentifierNode(l.left)
          ? bareName(l.left.value)
          : isIdentifierNode(l)
            ? bareName(l.value)
            : null;
        return name === null ? null : { name, ordinal };
      })
      .filter(Boolean);
    if (slots.length === 0) return "Struct";
    slots.sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
    return `Struct{${slots.map((s) => `${s.name} : ${s.ordinal}`).join(" ")}}`;
  }
  if (node.slotKind === "positional") {
    const slots = [];
    const walk = (n) => {
      if (n && n.type === "operation" && n.name === "product") {
        walk(n.left);
        slots.push(n.right && n.right.atomType ? n.right.atomType : UNKNOWN);
        return;
      }
      slots.push(n && n.atomType ? n.atomType : UNKNOWN);
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
function entryFor(defineNode) {
  if (!isDefineNode(defineNode) || !isIdentifierNode(defineNode.left)) return null;
  const name = bareName(defineNode.left.value);
  const rhs = defineNode.right;

  if (!isLambdaNode(rhs)) {
    // Atom: 右辺式の Layer 2 型がそのまま識別子の型になる（§5 Pass 1a）。
    const t = rhs && rhs.atomType ? rhs.atomType : UNKNOWN;
    return { name, text: `${name} : ${structTypeText(rhs, t)}`, unresolved: t === UNKNOWN ? 1 : 0 };
  }

  const entries = paramEntries(rhs.left);
  const paramNames = new Set(entries.map((e) => e.name).filter(Boolean));
  const usageTypes = inferLambdaParamTypes(rhs);
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
  const ret = rhs.right && rhs.right.atomType ? rhs.right.atomType : UNKNOWN;

  const unresolved = params.filter((p) => p === UNKNOWN || p === `${UNKNOWN}~`).length + (ret === UNKNOWN ? 1 : 0);
  const lhs = params.length > 0 ? params.join(" ") : "__";
  return { name, text: `${name} : ${lhs} -> ${ret}`, unresolved };
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

  const out = [];
  let entries = 0;
  let unresolved = 0;

  for (const node of nodes) {
    const e = entryFor(node);
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
