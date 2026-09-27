/**
 * **段1の答え合わせ用の中間語を、pass2 の木から作る。**
 *
 * `alpha/sign/lower.sn`（段1）は字面を parser.sn と同じ歩き方で割って後置の語を積む。ここは
 * 同じ語の列を **pass2 が組んだ木**から作る——字面の割り方を2通りで持ち、突き合わせることで、
 * 段2の出力が食い違ったときに故障が段1（割り方）にあるのか段2（命令）にあるのかが分かれる。
 *
 * **型の出どころも別にしてある。** 段1は仮引数と返値の型を `.ist` から引き、式の中の型を自分の
 * 規則で決める。ここは pass3 が木に付けた注釈（`atomType`、仮引数は pass4 と同じ `paramTypeOf`）
 * から決める。語が食い違えば、段1の `.ist` の読みか局所の規則のどちらかが壊れている。
 *
 * 部分集合の外に出たら投げる（`codegen_sn.test.js` は `same` のファイルでだけ呼ぶので、投げれば落ちる）。
 * 語の形は lower.sn と同じ：`F 幅の並び 名前` / `P 位置 幅` / `C スロットの合計 名前` / `B 中身` ほか。
 */
import { paramTypeOf } from "../pass1.js";

const bare = (v) => (typeof v === "string" && v.startsWith("<") && v.endsWith(">") ? v.slice(1, -1) : String(v));
const isDef = (n) => n && n.type === "operation" && n.name === "define";
// 1行だけの括り（丸括弧など）は剥ぐ。ノルムの括りは演算なので剥がない。
const unwrap = (n) => {
	while (n && Array.isArray(n.lines) && n.lines.length === 1 && !isDef(n.lines[0]) && n.kind !== "norm") n = n.lines[0];
	return n;
};
const ALU = new Set(["+", "-", "*", "/"]);
const COND = new Set(["<", "<=", "=", ">=", ">", "!="]);
const WIDTH = { Int: 1, Char: 1, String: 2 };
const out = (n) => {
	throw new Error("部分集合の外: " + JSON.stringify({ type: n && n.type, kind: n && n.kind, name: n && n.name, op: n && n.op, t: n && n.atomType }));
};
const widthOf = (t, n) => (Object.prototype.hasOwnProperty.call(WIDTH, t) ? WIDTH[t] : out(n || { atomType: t }));
const kindOf = (n0) => {
	const n = unwrap(n0);
	if (!n) return out(n0);
	if (Array.isArray(n.lines) && n.lines.some(isDef)) return "match";
	if (n.type === "block" && n.kind === "norm") return "norm";
	if (n.type === "atom" && n.kind === "number" && /^[0-9]+$/.test(n.value)) return "num";
	if (n.type === "atom" && n.kind === "char") return "char";
	if (n.type === "atom" && n.kind === "unicode" && /^0u[0-9A-Fa-f]+$/.test(n.value)) return "unicode";
	if (n.type === "atom" && n.kind === "string") return "string";
	if (n.type === "atom" && (n.value === "__" || n.value === "_")) return "unit";
	if (n.type === "atom" && n.kind === "identifier") return "ident";
	if (n.type === "operation" && n.position === "infix" && ALU.has(n.op) && n.name !== "equal") return "op";
	if (n.type === "operation" && n.position === "infix" && COND.has(n.op)) return "op";
	if (n.type === "operation" && n.name === "get_prop") return "get";
	if (n.type === "operation" && n.name === "apply") return "apply";
	return out(n);
};
const chain = (n) => {
	const args = [];
	n = unwrap(n);
	while (n && n.name === "apply") {
		args.unshift(n.right);
		n = unwrap(n.left);
	}
	return { f: bare(n.value), args };
};
// 仮引数の名前。裸の名前・[~名前]（全体でも混在でも）だけを通す。分解は部分集合の外。
const paramsOf = (p) => {
	const u = unwrap(p);
	if (u.type === "atom") return [{ name: u.value, key: u.value }];
	if (u.type === "params" && u.bracket && u.entries.length === 1 && u.entries[0].rest && !u.entries[0].default) {
		return [{ name: u.entries[0].name, key: u.entries[0].name }];
	}
	if (u.type === "params" && !u.bracket) {
		return u.entries.map((e) => {
			if (e.pattern && e.pattern.length === 1 && e.pattern[0].rest && e.pattern[0].name) return { name: e.pattern[0].name, key: e.pattern[0].name };
			if (!e.pattern && !e.rest && !e.default) return { name: e.name, key: e.name };
			return out(u);
		});
	}
	return out(u);
};
// 添字が字面の数か、字面の数へ束縛した定数（1段だけ辿る）なら均しは要らない（pass4 の constAddressOf）
const isNumLit = (n) => {
	const u = unwrap(n);
	return !!u && u.type === "atom" && u.kind === "number" && /^[0-9]+$/.test(u.value);
};
const isStatic = (n, cx) => {
	const u = unwrap(n);
	if (isNumLit(u)) return true;
	if (u && u.type === "atom" && u.kind === "identifier" && cx.params.every((p) => p.name !== u.value) && cx.consts.has(u.value)) return isNumLit(cx.consts.get(u.value));
	return false;
};
const typeOf = (n) => {
	const u = unwrap(n);
	return (u && u.atomType) || (n && n.atomType) || null;
};

function il(n, cx, tail) {
	const u = unwrap(n);
	switch (kindOf(u)) {
		case "num":
			return [`N ${u.value}`];
		case "char":
			return [`N ${String(u.value).codePointAt(1)}`];
		case "unicode": {
			const v = parseInt(u.value.slice(2), 16);
			return v === 0 ? ["U"] : [`N ${v}`];
		}
		case "string": {
			const body = String(u.value).slice(1, -1);
			return [body === "" ? "B" : `B ${body}`];
		}
		case "unit":
			return ["U"];
		case "ident": {
			const i = cx.params.findIndex((p) => p.name === u.value);
			if (i >= 0) return [`P ${cx.params.slice(0, i).reduce((a, p) => a + p.w, 0)} ${cx.params[i].w}`];
			// 定数は中身を撒き、「__ になり得る」の印を付ける。
			return [...il(cx.consts.get(u.value) ?? out(u), cx, false), "X"];
		}
		case "norm": {
			const inner = u.lines[0];
			if (typeOf(inner) !== "String") out(u);
			return [...il(inner, cx, false), "L"];
		}
		case "op": {
			const lt = typeOf(u.left);
			const rt = typeOf(u.right);
			const ch = COND.has(u.op) && lt === "Char" && rt === "Char";
			return [...il(u.left, cx, false), ...il(u.right, cx, false), `${ch ? "K" : "O"} ${u.op}`];
		}
		case "get": {
			if (typeOf(u.left) !== "String") out(u);
			const idx = unwrap(u.right);
			const L = il(u.left, cx, false);
			if (idx && idx.type === "operation" && idx.name === "range_arithmetic" && idx.desugaredFrom === "index-rest") {
				const st = unwrap(idx.left);
				if (st && st.type === "atom" && st.kind === "number" && Number(st.value) === 0) return L;
				return [...L, ...il(idx.left, cx, false), isStatic(idx.left, cx) ? "H" : "H d"];
			}
			if (idx && idx.type === "operation" && (idx.name === "range_arithmetic" || idx.name === "range" || idx.name === "input")) out(u);
			if (typeOf(idx) !== "Int") out(u);
			return [...L, ...il(idx, cx, false), isStatic(idx, cx) ? "I" : "I d"];
		}
		case "apply": {
			const { f, args } = chain(u);
			const slots = args.reduce((a, x) => a + widthOf(typeOf(x) === "Unit" ? "Int" : typeOf(x), x), 0);
			if (slots > 8) out(u);
			return [...args.flatMap((a) => il(a, cx, false)), `${tail ? "J" : "C"} ${slots} ${f}`];
		}
		case "match": {
			const L = ["M"];
			const val = (v) => (kindOf(v) === "unit" ? ["V"] : il(v, cx, tail));
			for (const l of u.lines) {
				if (!isDef(l)) {
					L.push("W", ...val(l));
					break;
				}
				L.push("A", ...il(l.left, cx, false), "T", "W", ...val(l.right), "E");
			}
			return [...L, "Z"];
		}
	}
	return out(u);
}

export function lowerReference(nodes) {
	const consts = new Map();
	for (const n of nodes) if (isDef(n) && !(n.right && n.right.name === "lambda")) consts.set(n.left.value, n.right);
	const fns = [];
	const main = [];
	for (const n of nodes) {
		if (n.type === "atom" && n.kind === "string") continue;
		if (!(isDef(n) && n.right && n.right.name === "lambda")) {
			main.push(isDef(n) ? n.right : n);
			continue;
		}
		const name = bare(n.left.value);
		const lam = n.right;
		const params = paramsOf(lam.left).map((p, i) => ({ ...p, w: widthOf(paramTypeOf(lam, i, p.key).atomType, lam) }));
		const body = lam.right;
		if (typeOf(body) === "String") out(body);
		fns.push(`F ${params.map((p) => p.w).join("")} ${name}`, ...il(body, { params, consts }, true), kindOf(body) === "apply" ? "Q" : "R");
	}
	return [...fns, "G", ...main.flatMap((e) => [...il(e, { params: [], consts }, false), "S"]), "D"];
}
