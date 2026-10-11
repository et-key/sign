/**
 * **観測を pass3 へつなぐ**（RTTI の計画、利用者 2026-10-09「解釈器が動いてるなら型も出てるはず、そこ上手く
 * つなげるのが先」・2026-10-11 の並び）。
 *
 * `compile(src, { observed })` の `observed` は、記録器（observe.js）がプログラムを解釈器で走らせて取った観測
 * （同じプロセスのメモリの Map、ディスクには置かない）。ここはそれを**確定した事実**にして pass3 の不動点の外に置く：
 *
 *   1. 決める（`planObservedFacts`）  観測を持たない compile をまず1回回し、位置ごとの pass3 の言い分（`.ist` と同じ
 *      綴り、st.js の `signatureTextsOf`）と観測を突き合わせて、事実か名指しの断りを決める。
 *   2. 置く（`installObservedFacts`）  同じソースをもう1回 compile し、不動点を回す前に事実を置く——束縛と、pass3 が
 *      呼び出しサイトの型を置く欄（`callsiteParamTypes`、`paramTypeOf` が束縛より先に読む）の両方へ。周回は読むだけで、
 *      書き換えようとした回数を数える（書き換えは通さない）。
 *   3. 確かめる（`settleObservedFacts`）  不動点の後、事実と推論が食い違う関数（返値の本体の型・呼ぶ側が渡す型・
 *      pass3 が呼び出しサイトで見た実引数の型）を名指しで断る。断った関数には印（`observedRefusal`）を付け、pass4 は
 *      名指しで断り、`.ist` は署名を書かない（後段の lower.sn も `! type 名前` で断る）。
 *
 * ## 突き合わせ（保守的に）
 *
 *   観測が無い           呼ばれなかった・`__` しか来なかった位置（届く関数だけ）→ 断る「観測が無い」
 *   種類が2つ以上        `Int | String` など → 断る（型ごとの実体は後の片）
 *   整数の値（Int）      pass3 が Int・族（`_`・`Atom`・`Scalar`）なら Int。Address・Float・Raw なら断る——値では
 *                        番地と小数の整数を割れない（箱は R3・R4）
 *   Char                 pass3 が Char・族（`_`・`Atom`・`Scalar`）なら Char、ほかは断る（文字は箱で、長さ1の String と
 *                        値で割れる——R6。以前は割れず、pass3 の言い分を採って反響として数えていた）
 *   String・Float・…     pass3 が同じ型か族なら観測の型、ほかは断る（食い違い）
 *   器 List(T)           pass3 が List(T') なら要素を同じ規則で、族・形（`[s~]`）なら List(要素)。要素が空の器しか
 *                        来なかったら、pass3 が List と言うときだけその要素を採る。pass3 が Struct（素・和の成員）なら
 *                        断る——JS の配列は器とも連番の構造体（`a , b`）とも読めて、値では割れない
 *   連番の Struct(…)     来た器の長さがいつも同じで添字ごとに合えば pass3 の言い分（反響）、ほかは断る
 *   名前付きスロット     pass3 が同じ鍵の Struct・素の Struct・族なら Struct、ほかは断る
 *   公開した関数（`#`）   位置を見ずに関数ごと断る——外の呼び出しは観測にも pass3 にも見えない（pass3 は export された
 *                        関数をジェネリックのまま置く）。観測の走りに出た種類で狭めると `.st` の契約が黙って狭まる
 *   置く名前が無い       事実になる位置でも、器そのものを受ける名前（裸の名前・括りの rest）が無ければ断る（類 unplaced）
 *                        ——rest の無い括り（`[a b]`）。置かずに数えると、事実と数えた位置を周回が書き換える
 *
 * 新しい意味の裁定はしない——事実にするのは観測と pass3 が両立する所だけで、両立しなければ名指しで断る。
 * 観測を渡さない compile は今までと1バイトも変わらない（ここは呼ばれない）。
 */
import { envLookup } from "./pass1.js";
import { isDefineNode, isIdentifierNode, bareName } from "./layout.js";
import { signatureTextsOf } from "./st.js";

// ---------------------------------------------------------------------------------------------
// pass3 の綴りを読む（`.ist` と同じ綴り。中のバッククォートの鍵は飛ばして割る）
// ---------------------------------------------------------------------------------------------

function splitTop(s, sep) {
  const out = [];
  let d = 0;
  let tick = false;
  let start = 0;
  for (let i = 0; i < s.length; i++) {
    const c = s[i];
    if (c === "`") {
      tick = !tick;
      continue;
    }
    if (tick) continue;
    if ("([{".includes(c)) d++;
    else if (")]}".includes(c)) d--;
    else if (d === 0 && s.startsWith(sep, i)) {
      out.push(s.slice(start, i));
      start = i + sep.length;
      i += sep.length - 1;
    }
  }
  out.push(s.slice(start));
  return out;
}

// 族と「まだ分からない」の綴り。どれも「この型だ」とは言っていない
const VAGUE = new Set(["_", "Atom", "Scalar", "Container"]);

/** pass3 の型の綴りを項にする。 */
function parseType(text) {
  const t = String(text).trim();
  const u = splitTop(t, " | ");
  if (u.length > 1) return { k: "union", of: u.map(parseType) };
  if (VAGUE.has(t)) return { k: "vague", v: t };
  if (t.startsWith("[")) return { k: "vague", v: "shape" };
  if (t.startsWith("{")) return { k: "vague", v: "fields" };
  if (t === "List" || t === "Iterator" || t === "Implicit") return { k: "list", head: t, e: null };
  let m = t.match(/^(List|Iterator|Implicit)\((.*)\)$/s);
  if (m) return { k: "list", head: m[1], e: parseType(m[2]) };
  if (t === "Struct") return { k: "struct" };
  m = t.match(/^Struct\{(.*)\}$/s);
  if (m) {
    const named = new Map();
    for (const part of splitTop(m[1], "  ")) {
      const mm = part.match(/^`([^`]*)` : (.*) , \d+$/s);
      if (mm) named.set(mm[1], parseType(mm[2]));
    }
    return { k: "struct", named };
  }
  m = t.match(/^Struct\((.*)\)$/s);
  if (m) return { k: "struct", pos: splitTop(m[1], " ").filter(Boolean).map(parseType) };
  return { k: "prim", v: t };
}

/** 項の綴り（`.ist` と同じ形。名前付きスロットは鍵だけ）。 */
function spell(T) {
  if (!T) return "_";
  switch (T.k) {
    case "prim":
      return T.v;
    case "vague":
      return T.v === "shape" ? "[…]" : T.v === "fields" ? "{…}" : T.v;
    case "list":
      return T.e ? `${T.head}(${spell(T.e)})` : T.head;
    case "struct":
      if (T.pos) return `Struct(${T.pos.map(spell).join(" ")})`;
      if (T.named) return `Struct{${[...T.named.keys()].join(" ")}}`;
      return "Struct";
    case "union":
      return T.of.map(spell).join(" | ");
    default:
      return "?";
  }
}

/** 事実として束縛に置く欄（pass3 の `atomType` と、器なら `elementType`）。 */
const atomOf = (T) => (!T ? null : T.k === "prim" ? T.v : T.k === "list" ? T.head : T.k === "struct" ? "Struct" : null);
const elemOf = (T) => (T && T.k === "list" && T.e ? atomOf(T.e) : null);

// ---------------------------------------------------------------------------------------------
// 突き合わせ：観測の種類（observe.js）× pass3 の項 → 事実か断り
// ---------------------------------------------------------------------------------------------

const refuse = (cls, text) => ({ refuse: { cls, text } });
const fact = (term, echo = false) => ({ fact: term, echo });
const prim = (v) => ({ k: "prim", v });
const hasStructMember = (P) => P.k === "struct" || (P.k === "union" && P.of.some(hasStructMember));

/**
 * 1つの位置。`K` は観測の種類（`kind.t` で見分ける）、`P` は pass3 の項。
 * 返すのは `{ fact, echo }`（echo は pass3 の言い分を採った——値では割れない所）か `{ refuse: { cls, text } }`。
 */
function decide(K, P) {
  if (K.t === "Unit") return refuse("unobserved", "観測が無い（呼ばれなかったか、__ しか来なかった）");
  if (K.t === "Several") return refuse("several", `種類が2つ以上来た（${K.key}）——型ごとの実体は後の片`);
  if (K.t === "Unknown") return refuse("conflict", "読めない値が来た");
  if (P.k === "union") {
    // 器が来た位置で pass3 が器と構造体の和を言うなら、値では割れない
    if (K.t === "List" && hasStructMember(P)) return refuse("conflict", `観測は器（${K.key}）、pass3 は ${spell(P)}——器と連番の構造体は値で割れない`);
    const ok = P.of.map((m) => decide(K, m)).filter((r) => r.fact);
    const distinct = [...new Set(ok.map((r) => spell(r.fact)))];
    if (distinct.length === 1) return ok[0];
    return refuse("conflict", `観測は ${K.key}、pass3 は ${spell(P)}`);
  }
  switch (K.t) {
    case "Int":
    case "Float": {
      if (P.k === "prim" && P.v === K.t) return fact(prim(K.t));
      if (P.k === "vague" && (P.v === "_" || P.v === "Atom" || P.v === "Scalar")) return fact(prim(K.t));
      if (K.t === "Int" && P.k === "prim" && (P.v === "Address" || P.v === "Float" || P.v === "Raw"))
        return refuse("conflict", `観測は整数の値、pass3 は ${P.v}——値では番地・小数の整数と割れない（箱は R3・R4）`);
      return refuse("conflict", `観測は ${K.key}、pass3 は ${spell(P)}`);
    }
    case "Char": {
      // 文字は箱で、長さ1の文字列と値で割れる（R6）——pass3 の言い分を借りない
      if (P.k === "prim" && P.v === "Char") return fact(prim("Char"));
      if (P.k === "vague" && (P.v === "_" || P.v === "Atom" || P.v === "Scalar")) return fact(prim("Char"));
      return refuse("conflict", `観測は Char、pass3 は ${spell(P)}`);
    }
    case "String": {
      if (P.k === "prim" && P.v === "String") return fact(prim("String"));
      if (P.k === "vague" && (P.v === "_" || P.v === "Atom" || P.v === "Container" || P.v === "shape")) return fact(prim("String"));
      return refuse("conflict", `観測は String、pass3 は ${spell(P)}`);
    }
    case "List": {
      if (P.k === "list" && P.head === "List") {
        if (K.e === null) return P.e ? fact({ k: "list", head: "List", e: P.e }, true) : refuse("unobserved", "観測が無い（空の器しか来ず、pass3 も要素を言わない）");
        const e = P.e ? decide(K.e, P.e) : decideElemVague(K.e);
        if (e.refuse) return refuse(e.refuse.cls, `要素：${e.refuse.text}`);
        return fact({ k: "list", head: "List", e: e.fact }, e.echo);
      }
      if (P.k === "vague" && (P.v === "_" || P.v === "Container" || P.v === "shape")) {
        if (K.e === null) return refuse("unobserved", `観測が無い（空の器しか来ず、pass3 は ${spell(P)}）`);
        const e = decideElemVague(K.e);
        if (e.refuse) return refuse(e.refuse.cls, `要素：${e.refuse.text}`);
        return fact({ k: "list", head: "List", e: e.fact }, e.echo);
      }
      if (P.k === "struct") return refuse("conflict", `観測は器（${K.key}${K.lens ? `、長さ ${K.lens}` : ""}）、pass3 は ${spell(P)}——器と連番の構造体は値で割れない`);
      return refuse("conflict", `観測は ${K.key}、pass3 は ${spell(P)}`);
    }
    case "Struct": {
      if (P.k === "struct" && P.named) {
        const keys = [...K.slots.keys()].sort().join(" ");
        if (keys !== [...P.named.keys()].sort().join(" ")) return refuse("conflict", `観測の鍵（${keys}）と pass3 の鍵（${[...P.named.keys()].join(" ")}）が違う`);
        for (const [k, kk] of K.slots) {
          const r = decide(kk, P.named.get(k));
          if (r.refuse) return refuse(r.refuse.cls, `スロット ${k}：${r.refuse.text}`);
        }
        return fact(P, true);
      }
      if ((P.k === "struct" && !P.pos) || (P.k === "vague" && (P.v === "_" || P.v === "Atom" || P.v === "Container" || P.v === "fields"))) return fact({ k: "struct" });
      return refuse("conflict", `観測は名前付きスロット、pass3 は ${spell(P)}`);
    }
    case "Lambda":
      if (P.k === "prim" && (P.v === "Lambda" || P.v === "Identity")) return fact(P, true);
      return refuse("conflict", `観測は関数、pass3 は ${spell(P)}`);
    case "Address":
      if (P.k === "prim" && P.v === "Address") return fact(P);
      return refuse("conflict", `観測は $ の参照セル、pass3 は ${spell(P)}`);
    case "Iterator":
      return refuse("conflict", `観測は規則（Iterator）、pass3 は ${spell(P)}——規則はまだつながない`);
    default:
      return refuse("conflict", `観測は ${K.key}、pass3 は ${spell(P)}`);
  }
}

/** pass3 が要素を言わない器の要素（族と同じ扱い）。 */
function decideElemVague(K) {
  return decide(K, { k: "vague", v: "_" });
}

/** 連番の構造体（pass3 の `Struct(…)`）に、長さが同じ器がいつも来たか（添字ごとに合うか）。 */
function decidePositional(pos, P) {
  const n = P.pos.length;
  if (pos.lens.size !== 1 || [...pos.lens][0] !== n) return refuse("conflict", `観測は長さ ${[...pos.lens].join("・") || "?"} の器、pass3 は ${spell(P)}——器と連番の構造体は値で割れない`);
  for (let i = 0; i < n; i++) {
    const k = pos.tuple[i];
    if (!k) return refuse("unobserved", `${i} 番目のスロットに観測が無い`);
    const r = decide(k, P.pos[i]);
    if (r.refuse) return refuse(r.refuse.cls, `${i} 番目のスロット：${r.refuse.text}`);
  }
  return fact(P, true);
}

/** 位置1つ（観測の記録 `pos` と pass3 の綴り `text`）。 */
function decidePosition(pos, text) {
  const P = parseType(text);
  const K = pos ? pos.kind : { t: "Unit", key: "__" };
  if (K.t === "List" && P.k === "struct" && P.pos) return decidePositional(pos, P);
  return decide(K.t === "List" && pos ? { ...K, lens: [...pos.lens].join("・") } : K, P);
}

// ---------------------------------------------------------------------------------------------
// 1. 決める
// ---------------------------------------------------------------------------------------------

/** トップレベルの文から届く関数（selfhost_sn.test.js の graphOf と同じ辿り方）。 */
function reachedNames(nodes) {
  const defs = new Map();
  const roots = [];
  for (const t of nodes) {
    if (isDefineNode(t) && isIdentifierNode(t.left)) {
      const nm = bareName(t.left.value);
      if (!defs.has(nm)) defs.set(nm, t);
    } else roots.push(t);
  }
  const refs = (n) => {
    const out = new Set();
    const seen = new Set();
    const st = [n];
    while (st.length) {
      const x = st.pop();
      if (!x || typeof x !== "object" || seen.has(x)) continue;
      seen.add(x);
      if (Array.isArray(x)) {
        x.forEach((y) => st.push(y));
        continue;
      }
      if (isIdentifierNode(x) && defs.has(bareName(x.value))) out.add(bareName(x.value));
      for (const [k, v] of Object.entries(x)) if (k !== "binding" && k !== "valueNode" && k !== "scope" && k !== "parent" && v && typeof v === "object") st.push(v);
    }
    return out;
  };
  const reach = new Set();
  const q = [];
  for (const r of roots) for (const id of refs(r)) q.push(id);
  while (q.length) {
    const id = q.pop();
    if (reach.has(id)) continue;
    reach.add(id);
    for (const x of refs(defs.get(id).right)) q.push(x);
  }
  return { defs, reach };
}

const isLambda = (n) => !!n && n.type === "operation" && n.name === "lambda";
const EXPORTED_TEXT = "公開した関数（#）は外の呼び出しが観測にも pass3 にも見えないので、観測で型を決めない（.st の契約は多相のまま）";
const UNPLACED_TEXT = "観測の事実を置く名前が無い（rest の無い括りは器そのものを受ける名前を持たない）——置かない事実は周回が書き換える";

/**
 * 仮引数の位置ごとに、器そのものを受ける名前（裸の名前・括りの rest）。括りの頭（`[c ~rest]` の `c`）には事実を置かない
 * ——器の事実の要素型から pass3 が同じ頭を導く（頭にも置いていたときは、自己適用の束で1か所・輪の見本と生成器の 1111 本で
 * 3本にしか立たず、`.ist`・pass4・断りのどれも変えなかった）。
 */
function receiversOf(rhs) {
  const p = rhs.left;
  if (!p) return [];
  if (isIdentifierNode(p)) return [{ recv: p.value, whole: false }];
  if (p.type !== "params") return [];
  const restOf = (es) => (es.find((e) => e.rest && e.name) || {}).name || null;
  if (p.bracket) return [{ recv: restOf(p.entries || []), whole: true }];
  return (p.entries || []).map((e) => (e.pattern ? { recv: restOf(e.pattern), whole: false } : { recv: e.name, whole: false }));
}

/**
 * 観測と、観測を持たない compile（`base`）の pass3 の言い分を突き合わせて、届く関数ごとに位置の事実か断りを決める。
 * @returns {{ fns: Map<string, object>, stats: object }}
 */
function planObservedFacts(base, observed) {
  const sigs = signatureTextsOf(base.nodes);
  const { defs, reach } = reachedNames(base.nodes);
  const fns = new Map();
  const stats = { functions: 0, positions: 0, fixed: 0, echo: 0, refusedPositions: { unobserved: 0, several: 0, conflict: 0, exported: 0, unplaced: 0 } };
  for (const name of reach) {
    const d = defs.get(name);
    if (!d || !isLambda(d.right) || !sigs.has(name)) continue;
    const sig = sigs.get(name);
    // **公開した関数（`#`）は観測で型を決めない。** 外の呼び出しは観測にも pass3 にも見えない——pass3 は export された
    // 関数をジェネリックのまま置き（`annotateAll` の呼び出しサイトの集め方）、`.st` の契約は多相のまま。観測の走りに
    // 出た種類で位置を埋めると、契約が黙って狭まる（`#h : [~s] i ? s ' i` を文字列と 1 で呼ぶ走りだけで見ると、
    // 添字が Int に固まる）。事実は置かず、関数ごと名指しで断る。
    if (d.exported) {
      const n = sig.params.length + 1;
      stats.functions++;
      stats.positions += n;
      stats.refusedPositions.exported += n;
      fns.set(name, { name, exported: true, params: [], ret: refuse("exported", EXPORTED_TEXT) });
      continue;
    }
    const o = observed.get(name) || null;
    // **置けない事実は断る。** 事実は器そのものを受ける名前（裸の名前・括りの rest）に置く（`receiversOf`）。rest の無い
    // 括り（`[a b]`）にはその名前が無く、置かないまま数えると周回が自由に書く——事実と数えた位置が推論のまま通る
    const recv = receiversOf(d.right);
    const params = sig.params.map((text, i) => {
      const x = decidePosition(o && o.params[i], text);
      return x.fact && !(recv[i] && recv[i].recv) ? refuse("unplaced", UNPLACED_TEXT) : x;
    });
    const ret = decidePosition(o && o.ret, sig.ret);
    stats.functions++;
    for (const x of [...params, ret]) {
      stats.positions++;
      if (x.fact) {
        stats.fixed++;
        if (x.echo) stats.echo++;
      } else stats.refusedPositions[x.refuse.cls]++;
    }
    fns.set(name, { name, params, ret });
  }
  return { fns, stats };
}

// ---------------------------------------------------------------------------------------------
// 2. 置く：事実は束縛の欄。周回は読むだけで、書き換えようとした回数を数える
// ---------------------------------------------------------------------------------------------

function owningScope(scope, name) {
  for (let s = scope; s; s = s.parent) if (s.bindings && s.bindings.has(name)) return s;
  return null;
}

/**
 * 束縛を、事実の欄だけ書けない写しに替える。欄は束縛そのものにも書いておく（読む・列挙する・写す道はそのまま
 * 通る）。書く・消す道だけを止め、値が変わる書き込み・消しを数える（`guard.attempts`）。
 */
function fixBinding(scope, name, fields, guard) {
  const s = owningScope(scope, name);
  if (!s) return false;
  const target = s.bindings.get(name);
  if (!target || typeof target !== "object") return false;
  const raw = target.__observedTarget || target;
  const fixed = { ...(target.__observedFixed || {}), ...fields };
  Object.assign(raw, fixed);
  const proxy = new Proxy(raw, {
    get(t, p, r) {
      if (p === "__observedTarget") return t;
      if (p === "__observedFixed") return fixed;
      return Reflect.get(t, p, r);
    },
    set(t, p, v, r) {
      if (Object.prototype.hasOwnProperty.call(fixed, p)) {
        if (v !== fixed[p]) guard.attempts++;
        return true;
      }
      return Reflect.set(t, p, v, r);
    },
    deleteProperty(t, p) {
      if (Object.prototype.hasOwnProperty.call(fixed, p)) {
        guard.attempts++;
        return true;
      }
      return Reflect.deleteProperty(t, p);
    },
  });
  s.bindings.set(name, proxy);
  guard.fixedFields.push({ scope: s, name, fields });
  return true;
}

/** 呼び出しサイトからの型（`callsiteParamTypes`、`paramTypeOf` が先に読む）の事実の添字を止める。 */
function fixCallsiteTypes(rhs, fixedAt, guard) {
  let stored = rhs.callsiteParamTypes;
  const merge = () => {
    const a = Array.isArray(stored) ? [...stored] : [];
    for (const [i, t] of fixedAt) {
      while (a.length <= i) a.push(null);
      a[i] = t;
    }
    return a;
  };
  let view = merge();
  Object.defineProperty(rhs, "callsiteParamTypes", {
    configurable: true,
    enumerable: true,
    get: () => view,
    set: (v) => {
      for (const [i, t] of fixedAt) if (!Array.isArray(v) || v[i] !== t) guard.attempts++;
      stored = v;
      view = merge();
    },
  });
  guard.fixedCallsites.push({ rhs, fixedAt });
}

/**
 * 不動点を回す前に、計画の事実を置く（compile の2回目、`annotateAll` の直前）。
 * @returns 書き換えの試みを数える `guard`
 */
function installObservedFacts(nodes, env, plan) {
  // `missing`：事実があるのに置く束縛が見つからなかった位置。置けなかった事実は周回が自由に書くので、数えるだけでなく
  // その関数を断る（`missingAt`、確かめる段が類 unplaced で名指しする）。名前の無い括りは決める段が先に断ってあるので、
  // ここへ来るのはそれ以外の取りこぼしだけである
  const guard = { attempts: 0, fixedFields: [], fixedCallsites: [], missing: 0, missingAt: new Map() };
  const miss = (name, where) => {
    guard.missing++;
    if (!guard.missingAt.has(name)) guard.missingAt.set(name, []);
    guard.missingAt.get(name).push(where);
  };
  const done = new Set();
  for (const node of nodes) {
    if (!isDefineNode(node) || !isIdentifierNode(node.left) || !isLambda(node.right)) continue;
    const f = plan.fns.get(bareName(node.left.value));
    if (!f || done.has(f.name)) continue;
    done.add(f.name);
    const rhs = node.right;
    const scope = rhs.scope;
    const recv = receiversOf(rhs);
    const fixedAt = [];
    recv.forEach((r, i) => {
      const x = f.params[i];
      if (!x || !x.fact) return;
      const fields = { atomType: atomOf(x.fact) };
      if (elemOf(x.fact)) fields.elementType = elemOf(x.fact);
      if (!(scope && r.recv && fixBinding(scope, r.recv, fields, guard))) miss(f.name, `仮引数 ${i + 1}`);
      if (!r.whole) fixedAt.push([i, fields.atomType]);
    });
    if (fixedAt.length) fixCallsiteTypes(rhs, fixedAt, guard);
    if (f.ret.fact) {
      const fields = { returns: atomOf(f.ret.fact) };
      if (elemOf(f.ret.fact)) fields.returnsElementType = elemOf(f.ret.fact);
      if (!fixBinding(env, node.left.value, fields, guard)) miss(f.name, "返値");
    }
  }
  return guard;
}

// ---------------------------------------------------------------------------------------------
// 3. 確かめる：事実と推論が両立しない関数を断る
// ---------------------------------------------------------------------------------------------

const VAGUE_ATOMS = new Set(["Atom", "Scalar", "Container", "Unit"]);

/** 呼ぶ側が渡す型（pass3 の注釈）が、事実の型と両立するか。分からない・族は通す（呼ぶ側の断りに任せる）。 */
function argAgrees(fieldsAtom, fieldsElem, arg) {
  const t = arg && arg.atomType;
  if (!t || VAGUE_ATOMS.has(t) || typeof t !== "string") return true;
  if (t.includes(" | ")) return t.split(" | ").every((x) => VAGUE_ATOMS.has(x.trim()) || x.trim() === fieldsAtom);
  if (t !== fieldsAtom) return false;
  if (fieldsElem && arg.elementType && !VAGUE_ATOMS.has(arg.elementType) && arg.elementType !== fieldsElem) return false;
  return true;
}

/**
 * 返値の本体の推論（`atomType`・`elementType`）が、事実の型と同じか（呼ぶ側は事実を読み、本体は推論で組む——食い違えば
 * 2つの意味になる）。要素は、本体が言っていて違うときだけ食い違い（言わないのは知らないだけ——素通しの本体 `? ts` は
 * 要素を書かない）。
 */
function bodyAgrees(want, wantE, got, gotE) {
  return got === want && !(wantE && gotE && gotE !== wantE);
}

/** 適用の連なり（`f a b` → `{ base: f, args: [a, b] }`）。 */
function applyChain(node) {
  const args = [];
  let n = node;
  while (n && n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
    args.unshift(n.right);
    n = n.left;
  }
  return { base: n, args };
}

/**
 * 不動点の後で、事実を置いた関数を確かめて断りの印を付ける（compile の2回目、`annotateAll` の直後）。
 * 返すのは数え（`compile` の結果の `observation`）。
 */
function settleObservedFacts(nodes, env, plan, guard) {
  const refusals = new Map();
  const add = (name, cls, text) => {
    if (!refusals.has(name)) refusals.set(name, []);
    refusals.get(name).push({ cls, text });
  };
  const rhsOf = new Map();
  for (const node of nodes) if (isDefineNode(node) && isIdentifierNode(node.left) && isLambda(node.right) && !rhsOf.has(bareName(node.left.value))) rhsOf.set(bareName(node.left.value), node.right);
  for (const [name, f] of plan.fns) {
    const rhs = rhsOf.get(name);
    if (!rhs) continue;
    if (f.exported) {
      add(name, "exported", EXPORTED_TEXT);
      continue;
    }
    f.params.forEach((x, i) => x.refuse && add(name, x.refuse.cls, `仮引数 ${i + 1}：${x.refuse.text}`));
    if (f.ret.refuse) add(name, f.ret.refuse.cls, `返値：${f.ret.refuse.text}`);
    // 置く段で置けなかった事実（`installObservedFacts` の `missingAt`）
    for (const where of guard.missingAt.get(name) || []) add(name, "unplaced", `${where}：${UNPLACED_TEXT}`);
    // 返値：本体の推論が事実と同じ型か（`bodyAgrees`）
    if (f.ret.fact) {
      const body = rhs.right;
      const want = atomOf(f.ret.fact);
      const wantE = elemOf(f.ret.fact);
      const got = body && body.atomType;
      const gotE = body && body.elementType;
      if (!bodyAgrees(want, wantE, got, gotE)) add(name, "conflict", `返値：観測は ${spell(f.ret.fact)}、本体の推論は ${got === "List" && gotE ? `List(${gotE})` : got || "_"}`);
    }
  }
  // 呼ぶ側：事実を置いた仮引数へ、別の型を渡す呼び出しがあれば断る（その呼び出しは観測した走りに無かった型を渡す）
  const fixedParams = new Map();
  for (const [name, f] of plan.fns) {
    const rhs = rhsOf.get(name);
    if (!rhs) continue;
    const recv = receiversOf(rhs);
    const ps = f.params.map((x, i) => (x.fact && recv[i] ? { atom: atomOf(x.fact), elem: elemOf(x.fact), spelled: spell(x.fact) } : null));
    if (ps.some(Boolean)) fixedParams.set(name, { ps, binding: envLookup(env, `<${name}>`) });
  }
  const seen = new Set();
  const visit = (n, scope) => {
    if (!n || typeof n !== "object" || seen.has(n)) return;
    seen.add(n);
    if (Array.isArray(n)) {
      for (const x of n) visit(x, scope);
      return;
    }
    if (isLambda(n) && n.scope) scope = n.scope;
    if (n.type === "operation" && (n.name === "apply" || n.name === "partial_apply")) {
      const { base, args } = applyChain(n);
      if (isIdentifierNode(base)) {
        const fp = fixedParams.get(bareName(base.value));
        if (fp && envLookup(scope, base.value) === fp.binding)
          fp.ps.forEach((p, i) => {
            if (!p || i >= args.length || argAgrees(p.atom, p.elem, args[i])) return;
            const a = args[i];
            add(bareName(base.value), "conflict", `仮引数 ${i + 1}：観測は ${p.spelled}、呼び出しが渡すのは ${a.atomType === "List" && a.elementType ? `List(${a.elementType})` : a.atomType}`);
          });
      }
    }
    for (const k of ["left", "right", "operand", "middle"]) visit(n[k], scope);
    for (const l of n.lines || []) visit(l, scope);
    for (const e of n.entries || []) visit(e.default, scope);
  };
  for (const node of nodes) visit(node, env);
  // 呼ぶ側（pass3 の集め方）：周回が呼び出しサイトで見た実引数の型（関数の束縛の `instances`、位置ごとの具体型の全部）に
  // 事実と違う型があれば断る。上の歩きは呼び出しの木の注釈（`atomType`）で見るが、pass3 は別名越し（`g : f` の `g 5`）・
  // 部分適用の呼び出しも数え、実引数の型を `inferAtomType` で読む——どちらかの物差しで食い違えば、呼ぶ側と受ける側が別の
  // 型を思う（別名越しに String を渡す走らなかった枝を、pass4 が「幅が合いません」で止めるまで誰も名指ししていなかった）。
  // 持ち上げ（実引数の Int を器の事実へ）も通さない——同じ型だけを通すのが一番狭い
  for (const [name, f] of plan.fns) {
    if (f.exported || !rhsOf.has(name)) continue;
    const b = envLookup(env, `<${name}>`);
    const inst = b && Array.isArray(b.instances) ? b.instances : null;
    if (!inst) continue;
    f.params.forEach((x, i) => {
      if (!x.fact || !Array.isArray(inst[i])) return;
      const other = inst[i].filter((t) => t !== atomOf(x.fact));
      if (other.length) add(name, "conflict", `仮引数 ${i + 1}：観測は ${spell(x.fact)}、pass3 が呼び出しサイトで見た型に ${other.join("・")} がある`);
    });
  }
  // 印を付ける（pass4 と `.ist` が読む）。pass4 は観測をつないだ compile かどうかも見る（返す器の上界が見積もりなら
  // 断る——pass4.js の注）
  for (const [name, rs] of refusals) {
    const rhs = rhsOf.get(name);
    if (rhs) rhs.observedRefusal = rs;
  }
  env.observedCompile = true;
  // 事実が周回の後も置いたままか（書き換えを止められたか）
  let moved = 0;
  for (const { scope, name, fields } of guard.fixedFields) {
    const b = scope.bindings.get(name);
    for (const [k, v] of Object.entries(fields)) if (!b || b[k] !== v) moved++;
  }
  for (const { rhs, fixedAt } of guard.fixedCallsites) for (const [i, t] of fixedAt) if (!Array.isArray(rhs.callsiteParamTypes) || rhs.callsiteParamTypes[i] !== t) moved++;
  const byClass = { unobserved: 0, several: 0, conflict: 0, exported: 0, unplaced: 0 };
  for (const rs of refusals.values()) for (const c of new Set(rs.map((r) => r.cls))) byClass[c]++;
  return {
    ...plan.stats,
    attempts: guard.attempts,
    fixedFields: guard.fixedFields.reduce((a, x) => a + Object.keys(x.fields).length, 0) + guard.fixedCallsites.reduce((a, x) => a + x.fixedAt.length, 0),
    moved,
    missing: guard.missing,
    refused: refusals,
    refusedFunctions: refusals.size,
    refusedByClass: byClass,
  };
}

export { planObservedFacts, installObservedFacts, settleObservedFacts, parseType, decide, spell, argAgrees, bodyAgrees };
