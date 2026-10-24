/**
 * **`_`（単位）の機構が、吐いた命令と走った命令のどれだけを占めるかを測る。**
 *
 *   cd alpha/javascript
 *   node test/tools/measure_unit.mjs [<題材名の一部> …] [--out <file>]
 *
 * 題材は下の `programs()`（lexer / parser / preprocess / emit とその入力）。名前の一部を渡すと
 * それだけ回す。qemu は**一本ずつ**順に回る（重い検査は同時に走らせない）。結果の JSON は
 * `--out` の先か、無ければ一時ディレクトリに置く（repo には書かない）。
 *
 * 静的：`generateAsm` が吐いた行を分類して数える。
 * 動的：`-g` で組み、qemu の `-d in_asm,exec,nochain` の記録を prog.s の行番号へ戻して、
 *       実行した命令のうち機構の行だったものを数える。機構の命令を物理的に剥いで走らせると、
 *       `_` が出ない入力でも値が壊れる形（csel の行き先）があるので、数える方が正確で、
 *       「ハードが肩代わりした時の上限」はこれで同じ。番地の対応は `llvm-objdump -d -l` で取る
 *       （`unmapped` と `missingTb` が 0 なら漏れ無し）。
 *
 * 分類（行ごと）：
 *   NICHE     検査用の `movz x12, #0x8000, lsl #48`（印ビットがあれば消える。x12 を niche 専用に
 *             固定して置き直さなければ、ハード無しでも消える）
 *   NICHE_VAL 値として `_` を作る movz（印を立てる一命令として残る）
 *   TEST      niche との cmp / `negs xzr` と、その直後の分岐・選択（印ビットなら cbtag 一命令に縮む＝半分）
 *   TEST_C    注記だけで機構と分かる構造の検査（len = 0、範囲外、最後まで見つからなければ）。印ビットの仕事ではない
 *   SEL       niche を選ぶ csel（印付きでも一命令なので残る）
 *   OTHER_U   注記に `__` / niche を含むその他
 * 「上限（unit）」は全部の合計、「控えめ（saved）」は NICHE ＋ TEST/2。どちらも命令数であって cycle ではない。
 *
 * 2026-10-24 の実測（動的・start.s を除く）：上限は parser・preprocess で 27%、lexer・emit で 45〜50%。
 * 控えめは 10〜24% で、うち NICHE（8〜13%）はハード無しでも消える分。ハードでしか消えないのは
 * TEST の半分（lexer 約 10%、emit 約 13%、parser・preprocess 約 5%）。
 */
import fs from "node:fs";
import os from "node:os";
import path from "node:path";
import readline from "node:readline";
import { execFileSync } from "node:child_process";
import { fileURLToPath, pathToFileURL } from "node:url";

const HERE = path.dirname(fileURLToPath(import.meta.url));
const JS = path.resolve(HERE, "..", "..");
const SIGN = path.resolve(JS, "..", "sign");
const { compile } = await import(pathToFileURL(path.join(JS, "compile.js")).href);
const { generateAsm } = await import(pathToFileURL(path.join(JS, "pass4.js")).href);
const { toolPath, DEFAULT_STACK, NICHE } = await import(pathToFileURL(path.join(JS, "qemu_run.js")).href);

const CLANG = toolPath("clang");
const LLD = toolPath("lld");
const QEMU = toolPath("qemu");
if (!CLANG || !LLD || !QEMU) {
	console.log("ツールチェーンがありません（clang / ld.lld / qemu-system-aarch64）");
	process.exit(1);
}
const OBJDUMP = path.join(path.dirname(CLANG), process.platform === "win32" ? "llvm-objdump.exe" : "llvm-objdump");
const ASSET = path.join(JS, "qemu");

const readImport = (p) => fs.readFileSync(path.join(SIGN, p), "utf8").replace(/\r\n/g, "\n");

function run(bin, args, opts = {}) {
	return execFileSync(bin, args, { stdio: "pipe", encoding: "utf8", maxBuffer: 1 << 30, ...opts });
}

// ---------- 静的な分類 ----------
// 返す category: NICHE / NICHE_VAL / TEST / TEST_C / SEL / OTHER_U / NONU / (directive・label は null)
const NICHE_RE = /^movz\s+(x\d+|xzr),\s*#0x8000,\s*lsl\s*#48/;
function classify(asmLines) {
	const cats = new Array(asmLines.length).fill(null);
	const nicheRegs = new Set();
	let pendingTest = 0; // 直後の分岐/選択を TEST に数える残り数
	const dest = (ins) => {
		const m = ins.match(/^[a-z.]+\s+(x\d+|w\d+|xzr|sp)\b/);
		return m ? m[1].replace(/^w/, "x") : null;
	};
	for (let i = 0; i < asmLines.length; i++) {
		const raw = asmLines[i];
		if (!raw.startsWith("\t")) continue; // label or blank
		const body = raw.slice(1);
		if (body.startsWith(".") || body.startsWith("//")) continue; // directive / pure comment
		const [insPart, ...rest] = body.split("//");
		const ins = insPart.trim();
		const comment = rest.join("//").trim();
		if (!/^[a-z]/.test(ins)) continue;
		const mn = ins.split(/\s+/)[0];
		let cat = "NONU";
		const isBranchOrSel = /^(b\.(vs|vc|eq|ne|hi|ls|ge|lt|gt|le)|csel|cset|csinc|cinc|cbz|cbnz|tbz|tbnz)$/.test(mn);
		if (NICHE_RE.test(ins)) {
			const reg = ins.match(NICHE_RE)[1];
			cat = reg === "x12" ? "NICHE" : "NICHE_VAL";
			nicheRegs.add(reg);
		} else if (/^negs\s+xzr,/.test(ins)) {
			cat = "TEST";
			pendingTest = 1;
		} else if (mn === "cmp" && [...nicheRegs].some((r) => new RegExp(`\\b${r}\\b`).test(ins))) {
			cat = "TEST";
			pendingTest = 1;
		} else if (pendingTest > 0 && isBranchOrSel) {
			cat = "TEST";
			pendingTest = 0;
		} else if (/^csel\b/.test(mn) && [...nicheRegs].some((r) => new RegExp(`\\b${r}\\b`).test(ins))) {
			cat = "SEL";
		} else if (/__|niche/.test(comment)) {
			cat = /^(cbz|cbnz|cmp|b\.|tbz|tbnz)/.test(mn) ? "TEST_C" : "OTHER_U";
		}
		if (cat !== "TEST" && pendingTest > 0 && !isBranchOrSel) pendingTest = 0;
		// レジスタが上書きされたら niche の印を消す（movz niche 以外）
		const d = dest(ins);
		if (d && nicheRegs.has(d) && cat !== "NICHE" && cat !== "NICHE_VAL" && !/^(cmp|cmn|tst|str|stp|b|bl|cbz|cbnz|negs)/.test(mn)) nicheRegs.delete(d);
		cats[i] = cat;
	}
	return cats;
}

function tally(cats, weights = null) {
	const t = { NICHE: 0, NICHE_VAL: 0, TEST: 0, TEST_C: 0, SEL: 0, OTHER_U: 0, NONU: 0 };
	cats.forEach((c, i) => {
		if (c) t[c] += weights ? weights[i] || 0 : 1;
	});
	const unit = t.NICHE + t.NICHE_VAL + t.TEST + t.TEST_C + t.SEL + t.OTHER_U;
	const all = unit + t.NONU;
	// 控えめな見積もり：検査用の niche 置きは消える、検査の対は cbtag 1 命令に縮む（半分）、csel と値の niche は残る
	const saved = t.NICHE + Math.ceil(t.TEST / 2);
	return { ...t, unit, all, share: all ? unit / all : 0, saved, savedShare: all ? saved / all : 0 };
}

// ---------- 動的 ----------
async function dynamicCount(asmText, { stack = DEFAULT_STACK, timeout = 1200000 } = {}) {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), "sign-measure-"));
	try {
		const sPath = path.join(dir, "prog.s");
		fs.writeFileSync(sPath, asmText);
		run(CLANG, ["--target=aarch64-unknown-none", "-g", "-c", sPath, "-o", path.join(dir, "prog.o")]);
		run(CLANG, ["--target=aarch64-unknown-none", "-g", "-c", path.join(ASSET, "start.s"), "-o", path.join(dir, "start.o")]);
		run(LLD, ["-T", path.join(ASSET, "link.ld"), `--defsym=__stack_size=${stack}`, path.join(dir, "start.o"), path.join(dir, "prog.o"), "-o", path.join(dir, "prog.elf")]);
		// 番地 → (file, line)
		const dump = run(OBJDUMP, ["-d", "-l", "--no-show-raw-insn", path.join(dir, "prog.elf")]);
		const addrLine = new Map();
		let cur = null;
		for (const ln of dump.split(/\r?\n/)) {
			const m = ln.match(/^;\s*(.*?):(\d+)\s*$/);
			if (m) { cur = { file: path.basename(m[1]), line: Number(m[2]) }; continue; }
			const a = ln.match(/^\s*([0-9a-f]+):\s+\S/);
			if (a && cur) addrLine.set(BigInt("0x" + a[1]), cur);
		}
		// 走らせる（記録は一時ファイルへ。大きくなるので流し読みする）
		const log = path.join(dir, "trace.log");
		const out = run(QEMU, ["-M", "virt", "-cpu", "cortex-a57", "-nographic", "-semihosting", "-kernel", path.join(dir, "prog.elf"), "-d", "in_asm,exec,nochain", "-D", log], { timeout });
		const words = out.trim().split(/\s+/).filter((w) => /^[0-9a-f]{16}$/.test(w));
		// TB → 命令の番地列、TB → 実行回数
		const tbs = new Map();
		const execCounts = new Map();
		let curTb = null;
		const rl = readline.createInterface({ input: fs.createReadStream(log, { encoding: "utf8" }), crlfDelay: Infinity });
		for await (const ln of rl) {
			if (ln.startsWith("IN:")) { curTb = null; continue; }
			const a = ln.match(/^0x([0-9a-f]+):\s/);
			if (a) {
				const addr = BigInt("0x" + a[1]);
				if (curTb === null) { curTb = addr; if (!tbs.has(addr)) tbs.set(addr, []); }
				const list = tbs.get(curTb);
				if (list && (list.length === 0 || list[list.length - 1] !== addr)) list.push(addr);
				continue;
			}
			const t = ln.match(/^Trace \d+: \S+ \[[0-9a-f]+\/([0-9a-f]+)\//);
			if (t) { const pc = BigInt("0x" + t[1]); execCounts.set(pc, (execCounts.get(pc) || 0) + 1); curTb = null; }
		}
		// 行ごとの実行回数（prog.s）と start.s の合計
		const perLine = new Map();
		let startInsns = 0, unmapped = 0, missingTb = 0, total = 0;
		for (const [pc, n] of execCounts) {
			const list = tbs.get(pc);
			if (!list) { missingTb += n; continue; }
			for (const addr of list) {
				total += n;
				const l = addrLine.get(addr);
				if (!l) { unmapped += n; continue; }
				if (l.file === "start.s") { startInsns += n; continue; }
				perLine.set(l.line, (perLine.get(l.line) || 0) + n);
			}
		}
		return { words, perLine, startInsns, unmapped, missingTb, total, tbCount: tbs.size, execLines: [...execCounts.values()].reduce((a, b) => a + b, 0) };
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// ---------- 題材 ----------
function programs(only) {
	const file = (name) => fs.readFileSync(path.join(SIGN, name), "utf8").replace(/\r\n/g, "\n");
	const withLast = (name, lastLine) => {
		const body = file(name).split("\n").filter((l) => l.trim() !== "");
		body[body.length - 1] = lastLine;
		return body.join("\n") + "\n";
	};
	const list = [
		{ name: "tiny: f 41", src: "f : n ? n + 1\nf 41\n" },
		{ name: "lexer.sn（既定の最終行）", src: file("lexer.sn") },
		{ name: "lexer.sn: tokens（40語ほどの入力）", src: withLast("lexer.sn", "tokens `alpha beta 12 + gamma42 * delta ( eps zeta ) 7 - eta theta iota kappa lambda mu nu xi omicron pi rho sigma tau upsilon phi chi psi omega 1 2 3 4 5 6 7 8 9 10`") },
		{ name: "parser.sn（既定の最終行）", src: file("parser.sn") },
		{ name: "parser.sn: 中くらいの入力（21 語）", src: withLast("parser.sn", "expr [`1` , `+` , `2` , `*` , `3` , `-` , `4` , `/` , `5` , `+` , `6` , `*` , `7` , `-` , `8` , `+` , `9` , `*` , `10` , `-` , `11`]") },
		{ name: "emit.sn（既定の最終行）", src: file("emit.sn") },
		{ name: "preprocess.sn（既定の最終行）", src: file("preprocess.sn") },
		{ name: "preprocess.sn: 中くらいの入力", src: withLast("preprocess.sn", "preprocess `f : x y ? x + y * 2 , g [3 4] ' 0 , h 5 | 1 , a+b*c-d/e , (p q) r , xs ' 1~`") },
	];
	return only.length ? list.filter((p) => only.some((o) => p.name.includes(o))) : list;
}

const argv = process.argv.slice(2);
const outIdx = argv.indexOf("--out");
const outPath = outIdx >= 0 ? argv[outIdx + 1] : path.join(os.tmpdir(), "measure_unit.result.json");
const only = argv.filter((a, i) => a !== "--out" && argv[i - 1] !== "--out");

const fmt = (n) => n.toLocaleString("en-US");
const pct = (x) => (100 * x).toFixed(1) + "%";
const results = [];
for (const p of programs(only)) {
	console.log(`\n==== ${p.name} ====`);
	let nodes, env, r;
	try {
		({ nodes, env } = compile(p.src, { charset: "ascii", readImport }));
		r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
	} catch (e) {
		console.log("compile failed:", e.message.slice(0, 200));
		continue;
	}
	const blocking = r.diagnostics.filter((d) => d.severity === "error");
	if (blocking.length) { console.log("blocked:", blocking[0].message.slice(0, 200)); continue; }
	const lines = r.text.split("\n");
	const cats = classify(lines);
	const st = tally(cats);
	console.log(`static : all ${fmt(st.all)}  unit ${fmt(st.unit)} (${pct(st.share)})  saved ${fmt(st.saved)} (${pct(st.savedShare)})  [NICHEtest ${st.NICHE} NICHEval ${st.NICHE_VAL} TEST ${st.TEST} TESTc ${st.TEST_C} SEL ${st.SEL} OTHER ${st.OTHER_U}]`);
	let dyn = null;
	try {
		const d = await dynamicCount(r.text);
		const weights = new Array(lines.length).fill(0);
		for (const [line, n] of d.perLine) weights[line - 1] = n;
		const dt = tally(cats, weights);
		dyn = { ...dt, startInsns: d.startInsns, unmapped: d.unmapped, missingTb: d.missingTb, total: d.total, tbCount: d.tbCount, execLines: d.execLines, words: d.words };
		const x0 = d.words[0] ? BigInt("0x" + d.words[0]) : null;
		console.log(`dynamic: prog ${fmt(dt.all)}  unit ${fmt(dt.unit)} (${pct(dt.share)})  saved ${fmt(dt.saved)} (${pct(dt.savedShare)})  [NICHEtest ${fmt(dt.NICHE)} NICHEval ${fmt(dt.NICHE_VAL)} TEST ${fmt(dt.TEST)} TESTc ${fmt(dt.TEST_C)} SEL ${fmt(dt.SEL)} OTHER ${fmt(dt.OTHER_U)}]  start.s ${fmt(d.startInsns)}  unmapped ${d.unmapped}  missingTb ${d.missingTb}  TBs ${d.tbCount}  x0=${x0 === NICHE ? "__" : x0}`);
		// 機構の中で一番走った行（上位8）
		const top = [...d.perLine].filter(([l]) => cats[l - 1] && cats[l - 1] !== "NONU").sort((a, b) => b[1] - a[1]).slice(0, 8);
		for (const [l, n] of top) console.log(`   ${fmt(n).padStart(10)}  ${cats[l - 1].padEnd(9)} ${lines[l - 1].trim().slice(0, 90)}`);
	} catch (e) {
		console.log("dynamic failed:", e.message.slice(0, 300));
	}
	results.push({ name: p.name, static: st, dynamic: dyn });
}
fs.writeFileSync(outPath, JSON.stringify(results, (k, v) => (typeof v === "bigint" ? v.toString() : v), 2));
console.log(`\n(saved ${outPath})`);
