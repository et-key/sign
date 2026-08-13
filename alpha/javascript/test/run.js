/**
 * テストランナー。test/ 配下の *.test.js をすべて実行する。
 *
 * 各テストファイルは独立したプロセスとして起動する。テストごとに peggy で
 * sign.pegjs を都度ビルドしており（ビルド済み parser.js には依存しない）、
 * グローバルな状態も持たないため、プロセスを分けても取りこぼしは無い。
 * 逆にプロセスを分けることで、1本が落ちても残りの結果が取れる。
 *
 * テストファイル側の規約:
 *   - 最終行に `N/M passed` を出力する
 *   - 全件通れば終了コード0、1件でも落ちれば非0
 * 新しいテストは test/ に `*.test.js` として置けば、ここへの登録は要らない。
 *
 * 実行: npm test
 */
import { spawnSync } from "child_process";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const files = fs.readdirSync(__dirname).filter((f) => f.endsWith(".test.js")).sort();

if (files.length === 0) {
	console.log("テストファイルが1つも見つかりません（test/*.test.js）");
	process.exit(1);
}

const width = Math.max(...files.map((f) => f.length));
let failedFiles = 0;
let passed = 0;
let total = 0;
let unsummarized = 0;

for (const file of files) {
	const started = Date.now();
	const result = spawnSync(process.execPath, [path.join(__dirname, file)], { encoding: "utf8" });
	const elapsed = Date.now() - started;
	const output = (result.stdout || "") + (result.stderr || "");
	// 規約の `N/M passed` を拾う。最後のものを採る（テスト本文が同じ形を出す場合に備えて）
	const summary = [...output.matchAll(/^(\d+)\/(\d+) passed$/gm)].pop();
	if (summary) {
		passed += Number(summary[1]);
		total += Number(summary[2]);
	} else {
		unsummarized++;
	}

	const ok = result.status === 0 && !result.error;
	if (!ok) failedFiles++;
	const count = summary ? `${summary[1]}/${summary[2]}` : "集計行なし";
	console.log(`${ok ? "OK  " : "FAIL"} ${file.padEnd(width)}  ${count.padStart(11)}  ${String(elapsed).padStart(5)}ms`);

	// 落ちたときだけ全出力を見せる。通ったテストの詳細は個別実行で見ればよい
	if (!ok) {
		if (result.error) console.log(`     起動に失敗: ${result.error.message}`);
		console.log(output.replace(/\r/g, "").replace(/^/gm, "     ").replace(/\s+$/, ""));
	}
}

console.log(`\n${files.length - failedFiles}/${files.length} ファイル / ${passed}/${total} ケース`);
if (unsummarized > 0) console.log(`（うち ${unsummarized} 本は \`N/M passed\` を出しておらず、ケース数に含まれていない）`);
process.exit(failedFiles === 0 ? 0 : 1);
