/**
 * 形の解決（Pass 3.5）——大きさとバイトオフセットを出す。
 *
 * Pass 3 は型の**名前**を、`target_info.js` はスカラーの**幅**を出す。ここはその2つを
 * 合わせて、`Struct` の各スロットが**どこに在るか**（オフセット）と、値全体が**どれだけ
 * 場所を取るか**（大きさ）を確定させる。`compiler_pipeline.md` §3 が Pass 4 へ渡すと定めた
 * 情報のうち、幅と符号の次に来る最後の一片である。
 *
 * ## 並び順は既に決まっている
 *
 * `stack_abi.md` §7.1 が定める通り、
 *
 * - **名前付きスロット**（`[x : 1 / y : 2]`）は**フィールド名でソートした正規順**に並ぶ。
 *   `==` で等しい構造体が同じ物理配置を持つための規則であり、宣言順は型が (型, 連番) の
 *   形で別に保存している。したがって**詰め込み効率のための並べ替えはしない**——並びは
 *   名前が決めるのであって、コンパイラの裁量ではない。
 * - **連番スロット**（`1 , 2 , 3`）は**宣言順**がそのまま物理配置になる。ソートの鍵となる
 *   名前が無いためである。MMIO・FFI・シリアライズはこちらで書く。
 *
 * ## アラインメントは自然境界（仕様に規定が無かったので、ここで決める）
 *
 * 各スロットは**自分の幅の境界**に置き、構造体全体の境界は最大スロットの境界、全体の
 * 大きさはその境界へ切り上げる。理由は AArch64 のハードウェアにある。
 *
 * - **Device メモリ（MMIO、`Device-nGnRnE`）は境界を跨いだアクセスでフォールトする。**
 *   連番スロットは MMIO を書くための形なので、ここで詰めると動かない
 * - `ldp`/`stp`（ペア転送）は境界を要求する
 * - Normal メモリでも境界跨ぎは遅い
 *
 * 全体を境界へ切り上げるのは、`List(Struct)` の各要素が同じ境界に載るためである
 * ——ストライドが揃わないと `base + i × size` が壊れる。
 */

import { widthsOf, sizeOf, charSizeOf, DEFAULT_CHARSET } from "./target_info.js";
import { envLookup } from "./pass1.js";

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

function bareName(value) {
  return typeof value === "string" && value.startsWith("<") && value.endsWith(">") ? value.slice(1, -1) : value;
}

/**
 * 識別子を束縛先の値ノードまで辿る（Pass 3 の `derefToNode` と同じ規則）。
 *
 * **名前は場所を持たない。** `s : r` の `s` が何バイト要るかは `r` が何であるかで決まり、
 * それは識別子テーブルにしか無い。ここを辿らないと、名前を1つ挟んだだけで大きさが
 * 出せなくなる——`l : [1 2 3]` の後の `s : l` すら測れなかった。
 *
 * 実体の種類（`repr`）も同じ経路で運ばれる。Pass 3 が束縛へ書き戻しているので、
 * 名前を何段挟んでも「これは規則裏打ちである」が Pass 4 まで届く。
 */
function applyBase(node) {
  let n = node;
  while (n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) n = n.left;
  return n;
}

function deref(node, env, seen = new Set()) {
  if (!node || !env) return node;
  // 適用の結果は呼び先の返値である。`mk : n ? [1 ~ n]` の `mk 5` が何バイト要るかは
  // `mk` の本体にしか無い——そして**それは実行時の `n` に依らない**。規則裏打ちの
  // 大きさは要素数に依らないので、終端が実行時変数でも形は静的に決まる
  // （list_model.md §2.3「終端値 n が実行時変数であっても静的型付け原則は維持される」）。
  if (node.type === "operation" && (node.name === "apply" || node.name === "partial_apply")) {
    const base = applyBase(node);
    if (base && base.type === "atom" && base.kind === "identifier" && !seen.has(base.value)) {
      seen.add(base.value);
      const b = envLookup(env, base.value);
      if (b && b.returnsNode) return deref(b.returnsNode, env, seen);
    }
    return node;
  }
  if (node.type !== "atom" || node.kind !== "identifier") return node;
  // 自己参照・相互参照で回らないようにする（`a : b` / `b : a` は解けないので諦める）。
  if (seen.has(node.value)) return node;
  seen.add(node.value);
  const b = envLookup(env, node.value);
  const next = b && (b.valueNode || b.rhsNode);
  if (!next) return node;
  // 束縛が実体の種類を知っていて、値ノード側が知らないなら引き継ぐ。
  if (b.repr && !next.repr) next.repr = b.repr;
  if (b.elementType && !next.elementType) next.elementType = b.elementType;
  return deref(next, env, seen);
}

// `n` を `align` の倍数へ切り上げる。align が 0/未定なら切り上げない。
function alignUp(n, align) {
  return align > 0 ? Math.ceil(n / align) * align : n;
}

/**
 * 余積の連なりを平らな要素の並びへ均す。`[1 2 3]` の中身がこの形で来る。
 *
 * `push` と `unshift` も余積である。pass2 が空白の解決結果として出す4つの名前
 * （`construct` / `concat` / `push` / `unshift`）は、どれも「列が1段の中で伸びる」ことを
 * 言っているにすぎず、**どちら側から伸びたか**が違うだけである。ここで `push` /
 * `unshift` を均さないと、`[1 2] 3` のように名前を経由せず伸びた列だけ大きさが
 * 出せなくなる——文字列側（``ab` `cd``）が数えられるのと食い違う。
 *
 * 名前も辿る。要素の並びは名前ではなく中身にしか無い。
 */
function flattenConstruct(node, env = null, seen = new Set()) {
  node = deref(node, env, seen);
  if (!node) return [];
  if (node.type === "operation") {
    // `construct` / `concat` は左右とも列。`push` は右が要素、`unshift` は左が要素。
    if (node.name === "construct" || node.name === "concat" || node.name === "push" || node.name === "unshift") {
      return [...flattenConstruct(node.left, env, seen), ...flattenConstruct(node.right, env, seen)];
    }
  }
  // 1行だけのブロックは括りでしかない（`[[1 2] 3]` の外側）。
  if (Array.isArray(node.lines) && node.lines.length === 1) return flattenConstruct(node.lines[0], env, seen);
  return [node];
}

// 直積（`product` の連なり）を平らな配列へ均す。連番スロットがこの形で来る。
function flattenProduct(node) {
  if (node && node.type === "operation" && node.name === "product") {
    return [...flattenProduct(node.left), flattenProduct(node.right)].flat();
  }
  return [node];
}

/**
 * ノード1つ分の大きさと境界を返す。決まらなければ null。
 *
 * @returns {{ size: number, align: number }|null}
 */
function measure(node, conf) {
  if (!node) return null;
  const { target, charset = DEFAULT_CHARSET, env = null } = conf;
  if (!widthsOf(target)) return null;
  // 型は識別子のノードにも付いているが、**大きさは中身にしか無い**ので辿る。
  const named = node;
  node = deref(node, env);
  const type = node.atomType || named.atomType;
  if (!type) return null;

  // 零対象は場所を占めない。
  if (type === "Unit") return { size: 0, align: 1 };

  // `String ≅ List(0u)`。要素幅は charset が決める。長さはリテラルなら数えられる。
  if (type === "String") {
    const w = charSizeOf(charset);
    const n = stringLength(node, env);
    return n === null ? null : { size: n * w, align: w, repr: "cells", stride: w, count: n };
  }

  // **規則裏打ち**（レンジ）は要素を持たない。置かれるのは規則そのものである。
  if (node.repr === "rule") return measureRule(node, conf);
  if (type === "List") return measureList(node, conf);
  if (type === "Struct") {
    const l = layoutOfStruct(node, conf);
    return l && { size: l.size, align: l.align };
  }

  // スカラー。幅がそのまま境界になる（自然境界）。
  const size = sizeOf(type, target);
  return size === null ? null : { size, align: size };
}

/**
 * 文字列の文字数。バッククォートを剥がしてコードポイント単位で数える
 * （サロゲートペアを2文字と数えないため `[...s]` を使う）。
 *
 * **連結も数える。** `String ≅ List(0u)`（type_system.md §2）である以上、文字列は
 * 余積で伸びる列であり、両辺の長さが分かれば全体の長さも分かる——`[1 2] ~ [3 4]` の
 * 要素数が数えられるのと同じことである。ここを数えないと、同型が片側だけ成立している
 * ことになる（型は `String` と言えるのに大きさが言えない）。
 *
 * 名前も辿る。長さは名前ではなく中身にしか無い。
 *
 * 静的に決まらないもの（実行時に伸びる連結）は null。**それは失敗ではなく事実である**
 * ——長さが実行時に決まる値は場所を先に取れないので、参照として渡すしかない
 * （`Implicit`、return_value_addressing.md）。ここで嘘の数を返してはいけない。
 */
function stringLength(node, env = null, seen = new Set()) {
  node = deref(node, env, seen);
  if (!node) return null;
  if (node.type === "atom" && node.kind === "string") return [...node.value.slice(1, -1)].length;
  if (node.type === "atom" && node.kind === "char") return 1;
  // `0u….` は Char 1個。U+0000 は Unit なので 0 個（niche、value_representation.md §3）。
  if (node.type === "atom" && node.kind === "unicode") return parseInt(node.value.slice(2), 16) === 0 ? 0 : 1;
  // 余積（`construct` / `concat`）は両辺の和。片方でも決まらなければ全体も決まらない。
  if (node.type === "operation" && (node.name === "construct" || node.name === "concat")) {
    const l = stringLength(node.left, env, seen);
    if (l === null) return null;
    const r = stringLength(node.right, env, seen);
    return r === null ? null : l + r;
  }
  // 1行だけのブロックは括りでしかない（`[`ab`]` は ``ab`` と同じ）。
  if (Array.isArray(node.lines) && node.lines.length === 1) return stringLength(node.lines[0], env, seen);
  return null;
}

/**
 * 規則裏打ち（レンジ）の大きさ。要素は**置かれない**——置かれるのは規則である。
 *
 * ここで `Iterator` と `List` の差がバイト単位で現れる。**差は `end` フィールド1つ**である。
 *
 *   `0 ~+ 1`   → `{start, step}`        終端が無い＝数え上げられない → `Iterator(T)`
 *   `1 ~ 5`    → `{start, step, end}`   終端がある＝数え上げられる   → `List(T)`
 *
 * 型が「何ができるか」（`|.|` が答えられるか）で2つを分けているのと、レイアウトが
 * フィールド1つで分けているのが**同じ線**になっている。型と実体が別々の話でありながら
 * 食い違っていない、という確認でもある。
 *
 * 添字は `base` からのロードではなく `start + i × step` の**算術**になる
 * （type_system.md §2 のアクセス表、`Iterator(T)` の行）。
 */
function measureRule(node, conf) {
  const { target } = conf;
  const el = node.elementType;
  const w = el ? sizeOf(el, target) : null;
  if (w === null) return null;
  const fields = node.atomType === "Iterator" ? ["start", "step"] : ["start", "step", "end"];
  return {
    size: w * fields.length,
    align: w,
    repr: "rule",
    fields: fields.map((name, i) => ({ name, offset: i * w, size: w, type: el })),
    access: "start + i × step",
  };
}

function measureList(node, conf) {
  const items = listItems(node, conf && conf.env);
  if (items === null) return null;
  // 要素は同一型（`List` の同一型制約、§2）なので、先頭1個を測れば全体が出る。
  const first = items.length > 0 ? measure(items[0], conf) : null;
  if (!first) return null;
  // 要素をその境界へ切り上げた大きさがストライドになる。
  const stride = alignUp(first.size, first.align);
  return { size: stride * items.length, align: first.align, stride, count: items.length, repr: "cells" };
}

// List の要素ノードを取り出す。`[1 2 3]` は paren ブロックの中に余積1本が入っているが、
// `[1 2] 3` のようにブロックを経ずに伸びた形もある。どちらも同じ余積である。
function listItems(node, env = null) {
  if (Array.isArray(node.lines)) {
    if (node.lines.length === 1) return flattenConstruct(node.lines[0], env);
    return node.lines;
  }
  const items = flattenConstruct(node, env);
  // 均せずに自分自身が返ってきたなら、それは列ではない（数えようがない）。
  return items.length === 1 && items[0] === node ? null : items;
}

/**
 * `Struct` のレイアウトを出す。
 *
 * @returns {{ size, align, slotKind, slots: Array<{name?, ordinal, type, offset, size, align}> }|null}
 */
function layoutOfStruct(node, conf) {
  // 構造体も名前を経由できる。`p2 : p` のスロット配置は `p` にしか無い。
  node = deref(node, conf && conf.env);
  if (!node || node.atomType !== "Struct") return null;

  // マージの結果はスロット表を直接持つ（list_model.md §5.3）。元の宣言は2つ以上の
  // 構造体へ散っているので、並べられるのは畳んだ後のスロットだけである。物理配置は
  // 他の名前付き構造体と同じく名前順——マージで作ったからといって配置規則は変わらない。
  if (node.mergedSlots) {
    const entries = [...node.mergedSlots].map(([k, v], ordinal) => ({ name: bareName(k), ordinal, node: v }));
    entries.sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
    return packSlots(entries, conf, "named");
  }

  // 名前付き: 宣言順（連番）を確定させてから、**名前でソートして並べる**（stack_abi.md §7.1）。
  // 並びが物理配置、各スロットが持つ ordinal が宣言順である。詰め込みのための並べ替えは
  // しない——並びを決めるのは名前であって、コンパイラの裁量ではない。
  if (node.slotKind === "named") {
    const entries = [];
    (node.lines || []).forEach((line, ordinal) => {
      if (isDefineNode(line) && isIdentifierNode(line.left)) {
        entries.push({ name: bareName(line.left.value), ordinal, node: line.right });
      } else if (isIdentifierNode(line)) {
        entries.push({ name: bareName(line.value), ordinal, node: line });
      }
    });
    entries.sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));
    return packSlots(entries, conf, "named");
  }

  // 連番: 宣言順がそのまま物理配置。ソートの鍵となる名前が無いためである。
  if (node.slotKind === "positional") {
    const entries = flattenProduct(node).map((n, ordinal) => ({ ordinal, node: n }));
    return packSlots(entries, conf, "positional");
  }

  return null;
}

// スロットを順に自然境界へ置いていく。全体の境界は最大スロットの境界、全体の大きさは
// その境界へ切り上げ——`List(Struct)` の各要素が同じ境界に載るために要る。
function packSlots(entries, conf, slotKind) {
  const slots = [];
  let offset = 0;
  let maxAlign = 1;
  for (const e of entries) {
    const m = measure(e.node, conf);
    if (!m) return null;
    const align = m.align || 1;
    offset = alignUp(offset, align);
    slots.push({ ...(e.name !== undefined ? { name: e.name } : {}), ordinal: e.ordinal, type: e.node.atomType, offset, size: m.size, align });
    offset += m.size;
    if (align > maxAlign) maxAlign = align;
  }
  return { size: alignUp(offset, maxAlign), align: maxAlign, slotKind, slots };
}

/**
 * レイアウトを1行ずつの読める形にする（観測用）。
 */
function formatLayout(layout) {
  if (!layout) return "(決まらない)";
  // 規則裏打ちは要素ではなく規則が並ぶ。`end` の有無が Iterator と List を分けている。
  if (layout.repr === "rule") {
    const head = `size ${layout.size} / align ${layout.align} / rule`;
    const body = layout.fields.map((f) => `  +${String(f.offset).padStart(3)}  ${f.name.padEnd(8)} ${String(f.type).padEnd(8)} ${f.size} byte`);
    return [head, ...body, `  添字: ${layout.access}`].join("\n");
  }
  const head = `size ${layout.size} / align ${layout.align} / ${layout.slotKind}`;
  const body = layout.slots.map(
    (s) => `  +${String(s.offset).padStart(3)}  ${(s.name !== undefined ? s.name : `[${s.ordinal}]`).padEnd(8)} ${String(s.type).padEnd(8)} ${s.size} byte  (宣言順 ${s.ordinal})`
  );
  return [head, ...body].join("\n");
}

export { measure, layoutOfStruct, formatLayout, alignUp };
