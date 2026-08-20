/**
 * 整数の幅・溢れ方・ビット演算（integer_overflow.md §1、type_system.md §3.6）。
 *
 * `Int` と `Address` を型として分けた根拠は**溢れ方**である——`Int` はラップアラウンド、
 * `Address` は `__` へ収束する（不正アドレスの伝播を止めるため）。分けただけでは帳簿の上の
 * 話に留まるので、評価器がそれを読んで初めて意味を持つ。
 *
 * JS の数値は f64 しか無いので、そのままでは 2^53 を超えた時点で整数が保てない。整数域の
 * 演算は BigInt で行い、安全な範囲なら Number へ戻す——丸めて返すと「もっともらしく見える
 * 間違った値」になるからである。
 *
 * 実行: node test/integer_width.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";
import { evaluate, newRuntimeEnv, isUnit, observe } from "../interpreter.js";

let passed = 0;
let total = 0;

function run(src) {
	const { nodes } = compile(src);
	const renv = newRuntimeEnv(null);
	let last;
	for (const n of nodes) last = observe(evaluate(n, renv));
	return isUnit(last) ? "__" : String(last);
}

function check(note, got, want) {
	total++;
	if (String(got) === String(want)) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got:  ${got}`);
		console.log(`     want: ${want}`);
	}
}

// ---- リテラルが壊れない ----
//
// f64 は 2^53 までしか整数を保てない。8 byte の値を扱う言語で、リテラルが読んだ時点で
// 壊れているのは通らないので、安全な範囲を超えるものは BigInt で読む。
check("2^53 + 1 が消えない", run("9007199254740993 + 0"), "9007199254740993");
check("Int の最大値", run("9223372036854775807 + 0"), "9223372036854775807");
check("Address の最大値", run("0xffffffffffffffff + 0"), "18446744073709551615");

// ---- `Int` はラップアラウンドする ----
//
// 算術演算の自然な挙動であり、システムに悪影響が無いため（integer_overflow.md §1）。
check("最大値 + 1 は最小値へ回る", run("9223372036854775807 + 1"), "-9223372036854775808");
check("最小値 - 1 は最大値へ回る", run("-9223372036854775808 - 1"), "9223372036854775807");

// ---- `Address` は `__` へ収束する ----
//
// 不正アドレスへのアクセスを防ぐため。ラップして別の番地を指すより、無くなる方が安全である。
check("幅を超えたアドレスは __", run("0xffffffffffffffff + 1"), "__");
check("0 未満のアドレスも __", run("0x0 - 1"), "__");

// ---- 通常の範囲は変わらない ----
check("小さな整数", run("1 + 2"), "3");
check("小さなアドレス", run("0x10 + 0x20"), "48");
check("実数は溢れの対象外", run("1.5 + 2.5"), "4");
// §3.2「除算だけは整数同士でも丸めが起きる」は BigInt の側でも同じ（0 から遠ざける）。
check("大きな整数の除算も四捨五入", run("9007199254740993 / 2"), "4503599627370497");

// ---- ビット演算は幅の中で閉じる ----
//
// ビット列はラップが前提である（integer_overflow.md §1「bit演算はラップが前提」）ため、
// 桁あふれを `__` にしてはいけない。
check("左シフト", run("1 << 4"), "16");
check("右シフト", run("16 >> 2"), "4");
check("論理積", run("0b1100 && 0b1010"), "8");
check("論理和", run("0b1100 || 0b1010"), "14");
check("排他的論理和", run("0b1100 ;; 0b1010"), "6");
check("補数", run("!!0"), "-1");
check("幅の外へ出た分は捨てる", run("1 << 63"), "-9223372036854775808");

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
