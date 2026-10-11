/**
 * **観測の記録器**（RTTI の計画 R2、利用者の裁定 2026-09-27「静的な側は動的な側が付けた型を信じる」・
 * 2026-10-09「解釈器が動いてるなら型も出てるはず」・2026-10-11 の並び）。
 *
 * 解釈器がプログラム（テスト・自己適用の束）を走らせる間、**ユーザーが定義した関数ごとに、仮引数の位置と返値に
 * 来た値の種類**を合流して数える。型は使われ方が決める（[[dynamic_equals_static]]）——走った値が使われ方そのもの
 * である。ここは記録するだけで、解釈器の意味には触れない（記録器を付けても外しても値は同じ）。
 *
 * ## 種類（Sign の型の項、メモリの中だけ）
 *
 *   Int             整数の値（番地と Float の整数は値では割れない——R3・R4 の箱まで、Int と読むのは記録の側の
 *                   約束で、静的な側は pass3 が Address・Float と言う所を名指しで断る）
 *   Float           整数でない数
 *   Char            文字（箱、runtime_kind.js の `chr`——RTTI の計画 R6）
 *   String          文字列（長さ1も。空の文字列は String の `__`、runtime_kind の `kindOf` と同じ）
 *   List(T)         器。要素の種類は中身ぜんぶの合流で、空の器は要素の証拠を持たない（`List(_)`）
 *   Struct{…}       名前付きスロット（鍵と、スロットごとの種類）
 *   Lambda          関数（閉包・合成・部分適用・点なし・恒等射・組み込み）
 *   Address         `$` の参照セル
 *   Iterator        規則
 *   __              種類の無い `__`（証拠ではない。`__` しか来なかった位置は「観測が無い」）
 *
 * 1つの位置に合流しない種類が来たら、合流は種類の並び（`Int | String`）になる——型ごとの実体の候補で、
 * つなぐ側は名指しで断る。合流で1つにまとめるのは器どうし（要素を合流する）と名前付きスロットどうし（鍵が同じなら
 * スロットごとに合流する）だけで、文字と文字列も並び（`Char | String`）である。以前は文字と長さ1の文字列を値で
 * 割れず（`Char-or-String`）、長い文字列と合流させて String にしていた——文字が箱になって（R6）その合流は要らない。
 *
 * ## 位置
 *
 * 仮引数の並びの位置ごとに1つ（裸の名前・混在形の中の括りはどれも1位置）。**括りだけの並び（`[h ~t]`・`[~s]`）は
 * 器1つの位置**である——渡された1つを分解するので、記録するのは渡された器そのもの。器でない値（数・番地・関数）を
 * 括りが受けると、解釈器は1要素の器へ持ち上げて分解する（`bindBracketParams`）ので、記録も持ち上げた器にする（文字は
 * 文字のまま、`bracketKindOf`）。実引数が2つ以上で括りに来たら（`f 1 2` を `[~xs]` で受ける）、実引数の並びが器である。
 *
 * - **潰れた呼び出し**（完全性公理、`f __ = __`）も呼び出しとして数え、来ていた実引数の種類は証拠にする。返値は
 *   `__` で、証拠にしない（数だけ数える）。
 * - **部分適用**は呼び出しではない。渡した実引数はその位置の証拠にし、残りは後で当てたときに数える。既定値を持つ
 *   位置に `__` を渡したら、束縛した既定値の種類を数える（直の呼び出しと同じ。interpreter.js の `makePartialClosure`
 *   は束縛した値を渡す）。
 * - 返値は、末尾呼び出しで渡り歩いた関数のどれにも付く——鎖の後ろの関数の返値に、その関数より後に溜めた前置き
 *   （`構築 ＋ 再帰`）を繋いだものが、その関数の返値である（interpreter.js の `applyClosure` が畳みながら渡す）。
 *
 * ## 費用
 *
 * 記録器を付けていない解釈器が払うのは、関数の適用1回ごと・部分適用1回ごとの、モジュールの変数1つの null の
 * 照合と、その写し（局所の変数）の null の照合——適用はトランポリンの周ごとに1つ（interpreter.js の `applyClosure`
 * の `chain`）、部分適用は終わりにもう1つ——だけである（interpreter.js の `observer`）。付けたときは実引数と返値の
 * 種類を毎回数える——器は中身を全部見る（見本で済ませると、見ていない要素の種類を取りこぼし、間違った事実を作る）。
 *
 * ## 置き場
 *
 * 観測はプロセスのメモリにだけ置く——`.ist` と同じ理由でディスクへ書かない（compiler_pipeline.md §4、利用者の規則）。
 * 試験も道具も同じで、綴りを書き出すのは数と類と、例としての数個だけ。
 *
 * 使い方：
 *
 *     const rec = makeRecorder(nodes);   // 走らせるプログラムの縮約済みノード列（トップレベルの関数の定義を見る）
 *     observeCalls(rec.hooks);           // interpreter.js
 *     try { …走らせる… } finally { observeCalls(null); }
 *     const observed = rec.observations(); // 名前 → { calls, collapsed, partial, params: [位置], ret: 位置 }
 */
import { kindOf } from "./runtime_kind.js";
import { isDefineNode, isIdentifierNode, bareName } from "./layout.js";

// ---------------------------------------------------------------------------------------------
// 種類（同じ綴りは同じ物——比べるのは `===` で足りる）
// ---------------------------------------------------------------------------------------------

const KINDS = new Map();
function kindOfKey(key, t, extra) {
  let k = KINDS.get(key);
  if (!k) {
    k = Object.freeze({ key, t, ...extra });
    KINDS.set(key, k);
  }
  return k;
}

const K_UNIT = kindOfKey("__", "Unit");
const K_INT = kindOfKey("Int", "Int");
const K_FLOAT = kindOfKey("Float", "Float");
const K_CHAR = kindOfKey("Char", "Char");
const K_STRING = kindOfKey("String", "String");
const K_LAMBDA = kindOfKey("Lambda", "Lambda");
const K_ADDRESS = kindOfKey("Address", "Address");
const K_ITERATOR = kindOfKey("Iterator", "Iterator");
const K_UNKNOWN = kindOfKey("?", "Unknown");

/** 器の種類。`e` は要素の種類の合流で、空の器（証拠なし）は null。 */
function listKind(e) {
  return kindOfKey(`List(${e ? e.key : "_"})`, "List", { e });
}

/** 名前付きスロットの種類。鍵は名前順に並べ、綴りは .ist と同じく鍵をバッククォートで囲む。 */
function structKind(slots) {
  const sorted = [...slots].sort((a, b) => (a[0] < b[0] ? -1 : a[0] > b[0] ? 1 : 0));
  return kindOfKey(`Struct{${sorted.map(([k, v]) => `\`${k}\` : ${v.key}`).join("  ")}}`, "Struct", { slots: new Map(sorted) });
}

/** 合流しない種類の並び。綴りの順にそろえるので、同じ集まりは同じ物になる。 */
function severalKind(members) {
  const sorted = [...new Set(members)].sort((a, b) => (a.key < b.key ? -1 : a.key > b.key ? 1 : 0));
  return kindOfKey(sorted.map((m) => m.key).join(" | "), "Several", { of: sorted });
}

/** 2つの種類の合流（頭の注記）。合流しなければ種類の並び。 */
function joinKinds(a, b) {
  if (a === b) return a;
  if (a.t === "Unit") return b;
  if (b.t === "Unit") return a;
  if (a.t === "Several" || b.t === "Several") {
    // 並びの中で合流できるものは合流し直す（`Int | List(Int)` に `List(_)` が来ても `Int | List(Int)`）
    const out = [];
    for (const m of [...(a.t === "Several" ? a.of : [a]), ...(b.t === "Several" ? b.of : [b])]) {
      const i = out.findIndex((x) => joinKinds(x, m).t !== "Several");
      if (i >= 0) out[i] = joinKinds(out[i], m);
      else out.push(m);
    }
    return out.length === 1 ? out[0] : severalKind(out);
  }
  if (a.t === "List" && b.t === "List") return listKind(a.e === null ? b.e : b.e === null ? a.e : joinKinds(a.e, b.e));
  if (a.t === "Struct" && b.t === "Struct") {
    const ka = [...a.slots.keys()].join("\u0000");
    const kb = [...b.slots.keys()].join("\u0000");
    if (ka === kb) return structKind([...a.slots].map(([k, v]) => [k, joinKinds(v, b.slots.get(k))]));
  }
  return severalKind([a, b]);
}

/** 値の種類。器と名前付きスロットは中身を全部見る（見本で済ませない——頭の「費用」）。 */
function kindOfValue(v) {
  switch (kindOf(v)) {
    case "Unit":
      return K_UNIT;
    case "Num":
      return typeof v === "bigint" || Number.isInteger(v) ? K_INT : K_FLOAT;
    case "Char":
      return K_CHAR;
    case "String":
      return K_STRING;
    case "List": {
      let e = null;
      for (let i = 0; i < v.length; i++) {
        const k = kindOfValue(v[i]);
        if (k.t !== "Unit") e = e === null ? k : joinKinds(e, k);
      }
      return listKind(e);
    }
    case "Struct":
      return structKind(Object.keys(v).map((k) => [k, kindOfValue(v[k])]));
    case "Lambda":
    case "Identity":
      return K_LAMBDA;
    case "Address":
      return K_ADDRESS;
    case "Iterator":
      return K_ITERATOR;
    default:
      return K_UNKNOWN;
  }
}

/**
 * **括りが受けた1つの値の種類。** 器でない値（数・番地・関数）は、解釈器が1要素の器へ持ち上げて分解する
 * （`bindBracketParams` の `[value]`）ので、記録も持ち上げた器にする。**文字は持ち上げずに Char**——解釈器は文字を
 * 1文字の並びとして分解するが、全部を受ける残り（`[~s]`）は文字そのもので（`[x] ≅ x`）、算術も数との比較も文字の
 * 射で走る。String と記録すると、本体を文字列の型で読ませて（`s + 1` が `__`）、解釈器の値と食い違う。`__` は呼び出し
 * ごと潰れる。
 */
function bracketKindOf(v) {
  const k = kindOfValue(v);
  if (k.t === "Unit" || k.t === "List" || k.t === "String" || k.t === "Char" || k.t === "Struct" || k.t === "Iterator") return k;
  return listKind(k);
}

// ---------------------------------------------------------------------------------------------
// 記録器
// ---------------------------------------------------------------------------------------------

/** 仮引数の並びのノードから、位置の数と、括りだけの並びか。 */
function arityOf(params) {
  if (!params) return { n: 0, bracket: false };
  if (isIdentifierNode(params)) return { n: 1, bracket: false };
  if (params.type === "params") return params.bracket ? { n: 1, bracket: true } : { n: (params.entries || []).length, bracket: false };
  return { n: 0, bracket: false };
}

/**
 * 位置1つ分の記録。`kind` は種類の合流、`kinds` は種類ごとの回数、`evidence` は証拠になった回数（`__` は
 * `units`）、`lens` は来た器の長さ（8 通りまで）、`tuple` は長さ 8 以下の器の添字ごとの種類の合流——JS の配列は
 * 器（List）とも連番の構造体（`a , b`）とも読めるので、連番の構造体と突き合わせるときに添字ごとに見る。
 */
function newPosition() {
  return { kind: K_UNIT, kinds: new Map(), evidence: 0, units: 0, lens: new Set(), tuple: [] };
}

/**
 * 記録器を作る。`nodes` は走らせるプログラムの縮約済みノード列で、トップレベルの `名前 : ラムダ` の本体ノードを
 * 鍵に関数を見分ける（閉包・部分適用の閉包は本体のノードを共有する）。
 */
function makeRecorder(nodes) {
  const byBody = new Map();
  const byName = new Map();
  for (const node of nodes || []) {
    if (!isDefineNode(node) || !isIdentifierNode(node.left)) continue;
    const rhs = node.right;
    if (!rhs || rhs.type !== "operation" || rhs.name !== "lambda" || byBody.has(rhs.right)) continue;
    const name = bareName(node.left.value);
    if (byName.has(name)) continue;
    const { n, bracket } = arityOf(rhs.left);
    const f = { name, arity: n, bracket, calls: 0, collapsed: 0, partial: 0, params: Array.from({ length: n }, newPosition), ret: newPosition(), retCollapsed: 0 };
    byBody.set(rhs.right, f);
    byName.set(name, f);
  }
  const put = (pos, k, v) => {
    if (k.t === "Unit") {
      pos.units++;
      return;
    }
    pos.evidence++;
    pos.kinds.set(k, (pos.kinds.get(k) || 0) + 1);
    pos.kind = joinKinds(pos.kind, k);
    if (kindOf(v) !== "List") return;
    if (pos.lens.size < 8) pos.lens.add(v.length);
    if (v.length <= 8) for (let i = 0; i < v.length; i++) pos.tuple[i] = joinKinds(pos.tuple[i] || K_UNIT, kindOfValue(v[i]));
  };
  // 返値の種類の写し。1回の finish の中で、前置きを繋がずに続く関数（末尾の自己再帰）は同じ値を返すので、種類は
  // 1度だけ数える。写しを使ってよいのは解釈器が `fresh` を偽で渡す間だけである——finish をまたぐと、内側の関数が
  // 返した器を外の関数がその場で書き換えて返すことがある（名前付きスロットの連結は左の器へ書き足す）ので、同じ物が
  // 別の種類になる。写しを物の同一性で引いていたときは、外の関数の返値に内側の古い種類が付いていた。
  let lastKind = null;
  const entriesOf = (p) => (!p ? [] : isIdentifierNode(p) ? [{ name: p.value }] : p.type === "params" ? p.entries || [] : []);
  // 解釈器が呼ぶ口（interpreter.js の `observeCalls`）
  const hooks = {
    /**
     * 関数を呼んだ（`bindParams` の直後）。`callEnv` が null なら完全性公理で潰れた。`from` はその時点で溜まって
     * いた前置きの数（返値を畳む位置）。記録しない関数（トップレベルの定義でない閉包）には null を返す。
     */
    called(closure, argValues, callEnv, from) {
      const f = byBody.get(closure.body);
      if (!f) return null;
      f.calls++;
      if (callEnv === null) f.collapsed++;
      const p = closure.params;
      if (p && p.type === "params" && p.bracket) {
        const v = argValues.length === 1 ? argValues[0] : argValues;
        put(f.params[0], bracketKindOf(v), v);
        return { f, from, collapsed: callEnv === null };
      }
      const es = entriesOf(p);
      const off = f.arity - es.length;
      for (let j = 0; j < es.length; j++) {
        const e = es[j];
        // 名前で束縛した値（デフォルトが入ったならその値）。括りの項目は渡された器そのもの
        let v = argValues[j];
        if (callEnv !== null && !e.pattern && e.name && callEnv.bindings.has(e.name)) v = callEnv.bindings.get(e.name);
        put(f.params[off + j], e.pattern ? bracketKindOf(v) : kindOfValue(v), v);
      }
      return { f, from, collapsed: callEnv === null };
    },
    /**
     * 呼んだ関数の返値（`called` が返した印と、畳み終えた値）。`fresh` が偽なのは、同じ finish の中で前の関数と
     * 同じ値を返すときだけ（interpreter.js の `finish`）——印を渡さない呼び手には写しを使わない。
     */
    returned(entry, out, fresh) {
      if (fresh !== false) lastKind = null;
      const f = entry.f;
      if (entry.collapsed) {
        f.retCollapsed++;
        return;
      }
      if (lastKind === null) lastKind = kindOfValue(out);
      put(f.ret, lastKind, out);
    },
    /** 部分適用（`makePartialClosure`）。束縛した値（既定値が入ったならその値）をその位置の証拠にする。 */
    partial(closure, supplied) {
      const f = byBody.get(closure.body);
      if (!f) return;
      f.partial++;
      const es = entriesOf(closure.params);
      const off = f.arity - es.length;
      for (let j = 0; j < supplied.length && j < es.length; j++) put(f.params[off + j], es[j].pattern ? bracketKindOf(supplied[j]) : kindOfValue(supplied[j]), supplied[j]);
    },
  };
  /** 観測：名前 → 関数ごとの記録（呼ばれなかった関数も載る——呼び出し 0 の印）。 */
  const observations = () => {
    const out = new Map();
    for (const [name, f] of byName) {
      const pos = (p) => ({ kind: p.kind, evidence: p.evidence, units: p.units, kinds: new Map(p.kinds), lens: new Set(p.lens), tuple: [...p.tuple] });
      out.set(name, { name, arity: f.arity, bracket: f.bracket, calls: f.calls, collapsed: f.collapsed, partial: f.partial, params: f.params.map(pos), ret: { ...pos(f.ret), collapsed: f.retCollapsed } });
    }
    return out;
  };
  return { hooks, observations };
}

export { makeRecorder, kindOfValue, joinKinds, listKind, structKind, severalKind, K_UNIT, K_INT, K_FLOAT, K_CHAR, K_STRING, K_LAMBDA, K_ADDRESS, K_ITERATOR };
