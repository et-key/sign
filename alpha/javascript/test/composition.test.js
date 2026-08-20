/**
 * Pass 3b（`__` へ収束する理由の静的記録）のうち、合成の中間の型の検査。
 *
 * `h : f g` はスペースによる左→右のパイプライン（`f g` は `g(f(x))`）なので、**`f` の返値が
 * `g` の第1仮引数へ入る**。ここが噛み合っていなければ射が無く、適用しても零射（`__`）になる
 * ——値は静かに消え、型だけが `Int -> String` のように**通ったかのように**見えてしまう。
 *
 * 例外にはしない。射が無いことは「不正」ではなく「そこに射が無い」という事実であり、
 * 零対象を経由する射（零射）が常に存在する以上、結果は `__` である（原理4）。
 *
 * 実行: node test/composition.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";

let passed = 0;
let total = 0;

function check(note, got, want) {
	total++;
	if (JSON.stringify(got) === JSON.stringify(want)) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(want)}`);
	}
}

// 合成の型不整合の診断だけを数える。
function mismatches(source) {
	const { diagnostics } = compile(source);
	return diagnostics.filter((d) => d.reason === "composition-type-mismatch").length;
}

// ---- 噛み合っていない合成を捕まえる ----
check("Int を返す関数を String 要求へ繋ぐ", mismatches("f : x ? x + 1\ng : s ? s = `a`\nh : f g"), 1);
check("向きが逆でも同じ", mismatches("f : s ? s = `a`\ng : x ? x + 1\nh : f g"), 1);
// 多段合成では**どの区間で切れたか**を指す。
check("多段の途中で切れる", mismatches("f : x ? x + 1\ng : y ? y * 2\nk : s ? s = `a`\nc : f g k"), 1);

// ---- 正当な合成は黙る（偽陽性を出さない） ----
//
// 分からないものは通す。分からないことを「不正」と断じないのが原理4 の線引きである。
check("同じ型どうし", mismatches("f : x ? x + 1\ng : y ? y * 2\nh : f g"), 0);
// `Scalar` は族（String を含まない Atom）。その要素なら置ける。
check("族と要素", mismatches("f : x ? x + 1\ng : a b ? a + b\nh : f g"), 0);
// 数値同士は昇格格子で繋がっている（§3.2）ので射がある。
check("数値の昇格", mismatches("f : x ? x + 1\ng : y ? 0.0 + y\nh : f g"), 0);
// `Atom` は「どの Atom か分かっていない」という下限であり、制約ではない。
check("Atom 相手", mismatches("f : x ? x + 1\ng : y ? y\nh : f g"), 0);
// 直和はどれか1つでも置ければよい。
check("直和のどれかが合えば通る", mismatches("f : n ?\n\tn = 0 : `s`\n\t1\ng : y ? y + 1\nh : f g"), 0);
// ポイントフリーも演算子表からシグネチャが出るので同じ規則で検査できる。
check("ポイントフリーの端", mismatches("g : x ? x * 2\nh : [+ 1] g"), 0);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
