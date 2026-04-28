// test_aarch64.js
import fs from 'fs';
import { execSync } from 'child_process';
import * as parser from './sign.js';
import { SemanticAnalyzer } from './semantic_analyzer.js';
import { preprocess } from './preprocessor.js';
import { AArch64Generator } from './compiler_aarch64.js';

const TEST_FILE = 'test_aarch64.sn';

try {
	// 1. 外部ファイルからSignコードを読み込み
	if (!fs.existsSync(TEST_FILE)) {
		fs.writeFileSync(TEST_FILE, '10 + 20'); // 初回のみ作成
	}
	const code = fs.readFileSync(TEST_FILE, 'utf8');
	console.log(`📖 Reading from ${TEST_FILE}:\n${code.trim()}`);

	// 2. パース & 意味解析
	const preprocessed = preprocess(code);
	const rawAst = parser.parse(preprocessed);
	const analyzer = new SemanticAnalyzer();
	const ast = analyzer.analyze(rawAst);

	// 3. アセンブリ生成
	const generator = new AArch64Generator();
	const assembly = generator.generate(ast);

	// 4. ファイル出力
	fs.writeFileSync('output.s', assembly);
	console.log("=== Generated AArch64 Assembly ===");
	console.log(assembly);

	// 5. ビルド＆実行プロセス
	console.log("=== Auto Build & Run ===");
	execSync('as -o output.o output.s');
	execSync('ld -o a.out output.o');

	try {
		execSync('./a.out');
		console.log("✨ Exit Code: 0");
	} catch (runErr) {
		console.log(`✨ Exit Code: ${runErr.status}`);
	}

} catch (e) {
	console.error("❌ Error:", e.message);
}