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

function isDefineNode(n) {
  return !!n && n.type === "operation" && n.name === "define";
}

function isIdentifierNode(n) {
  return !!n && n.type === "atom" && n.kind === "identifier";
}

function bareName(value) {
  return typeof value === "string" && value.startsWith("<") && value.endsWith(">") ? value.slice(1, -1) : value;
}

// `n` を `align` の倍数へ切り上げる。align が 0/未定なら切り上げない。
function alignUp(n, align) {
  return align > 0 ? Math.ceil(n / align) * align : n;
}

// 余積（`construct` の連なり）を平らな配列へ均す。`[1 2 3]` の中身がこの形で来る。
function flattenConstruct(node) {
  if (!node) return [];
  if (node.type === "operation" && (node.name === "construct" || node.name === "concat")) {
    return [...flattenConstruct(node.left), ...flattenConstruct(node.right)];
  }
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
  const { target, charset = DEFAULT_CHARSET } = conf;
  if (!widthsOf(target)) return null;

  const type = node.atomType;
  if (!type) return null;

  // 零対象は場所を占めない。
  if (type === "Unit") return { size: 0, align: 1 };

  // `String ≅ List(0u)`。要素幅は charset が決める。長さはリテラルなら数えられる。
  if (type === "String") {
    const w = charSizeOf(charset);
    const n = stringLength(node);
    return n === null ? null : { size: n * w, align: w };
  }

  if (type === "List") return measureList(node, conf);
  if (type === "Struct") {
    const l = layoutOfStruct(node, conf);
    return l && { size: l.size, align: l.align };
  }

  // スカラー。幅がそのまま境界になる（自然境界）。
  const size = sizeOf(type, target);
  return size === null ? null : { size, align: size };
}

// 文字列リテラルの文字数。バッククォートを剥がしてコードポイント単位で数える
// （サロゲートペアを2文字と数えないため `[...s]` を使う）。
function stringLength(node) {
  if (node.type === "atom" && node.kind === "string") return [...node.value.slice(1, -1)].length;
  if (node.type === "atom" && node.kind === "char") return 1;
  // `0u….` は Char 1個。U+0000 は Unit なので 0 個（niche、value_representation.md §3）。
  if (node.type === "atom" && node.kind === "unicode") return parseInt(node.value.slice(2), 16) === 0 ? 0 : 1;
  return null; // 連結の結果など、静的に長さが決まらないもの
}

function measureList(node, conf) {
  const items = listItems(node);
  if (items === null) return null;
  // 要素は同一型（`List` の同一型制約、§2）なので、先頭1個を測れば全体が出る。
  const first = items.length > 0 ? measure(items[0], conf) : null;
  if (!first) return null;
  // 要素をその境界へ切り上げた大きさがストライドになる。
  const stride = alignUp(first.size, first.align);
  return { size: stride * items.length, align: first.align, stride, count: items.length };
}

// List の要素ノードを取り出す。`[1 2 3]` は paren ブロックの中に余積1本が入っている。
function listItems(node) {
  if (!Array.isArray(node.lines)) return null;
  if (node.lines.length === 1) return flattenConstruct(node.lines[0]);
  return node.lines;
}

/**
 * `Struct` のレイアウトを出す。
 *
 * @returns {{ size, align, slotKind, slots: Array<{name?, ordinal, type, offset, size, align}> }|null}
 */
function layoutOfStruct(node, conf) {
  if (!node || node.atomType !== "Struct") return null;

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
  const head = `size ${layout.size} / align ${layout.align} / ${layout.slotKind}`;
  const body = layout.slots.map(
    (s) => `  +${String(s.offset).padStart(3)}  ${(s.name !== undefined ? s.name : `[${s.ordinal}]`).padEnd(8)} ${String(s.type).padEnd(8)} ${s.size} byte  (宣言順 ${s.ordinal})`
  );
  return [head, ...body].join("\n");
}

export { measure, layoutOfStruct, formatLayout, alignUp };
