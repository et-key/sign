/**
 * Sign言語トランスパイラ テスト実行
 */

const fs = require('fs');
const { transpile } = require('./sign_transpiler_infix.js');

// テスト用のJSONファイルを読み込み
const tokensJson = JSON.parse(fs.readFileSync('./input/test_tokens_infix.json', 'utf8'));

console.log('=== Sign言語 → JavaScript トランスパイラ テスト ===\n');

// トランスパイル実行
const jsCode = transpile(tokensJson);

console.log('【変換結果】\n');
console.log(jsCode);
console.log('\n=== 変換完了 ===');

// 結果をファイルに保存
fs.writeFileSync('./output/transpiled.js', jsCode, 'utf8');
console.log('\n結果を output/transpiled.js に保存しました');
