// index.js
/**
 * Sign言語プリプロセッサと式木生成のメインモジュール
 * 
 * 機能:
 * - コマンドライン引数の処理
 * - ファイル入出力
 * - 各処理ステップの統合と実行
 * - 結果の出力とエラー処理
 * 
 * 使い方:
 *   node index.js <入力ファイル> [--out]
 *   --out: 結果をファイルに保存 (入力ファイル名.json)
 * CreateBy: Claude3.7Sonnet
 * ver_20250427_0
 */

// Node.js標準モジュール
const fs = require('fs');
const path = require('path');

// プロジェクトモジュール
const { normalizeSourceCode } = require('./preprocessor');
const { extractAndProcessBlocks } = require('./block-extractor');
const { tokenizeBlock } = require('./tokenizer');
const { insertParentheses } = require('./parenthesis-inserter');
const { buildExpressionTree, formatExpressionTree } = require('./expression-tree-builder');
const { generateLispCode } = require('./lisp-translator');

/**
 * ファイルを読み込む
 * 
 * @param {string} filePath - 読み込むファイルのパス
 * @returns {Promise<string>} ファイルの内容
 */
async function readFile(filePath) {
  try {
    return await fs.promises.readFile(filePath, 'utf8');
  } catch (error) {
    throw new Error(`ファイルの読み込みに失敗しました: ${error.message}`);
  }
}

/**
 * ファイルに書き込む
 * 
 * @param {string} filePath - 書き込むファイルのパス
 * @param {string} content - 書き込む内容
 * @returns {Promise<void>}
 */
async function writeFile(filePath, content) {
  try {
    await fs.promises.writeFile(filePath, content, 'utf8');
  } catch (error) {
    throw new Error(`ファイルの書き込みに失敗しました: ${error.message}`);
  }
}

/**
 * メイン処理関数
 */
async function main() {
  try {
    // コマンドライン引数の解析
    const args = process.argv.slice(2);

    if (args.length === 0) {
      console.error('使い方: node index.js <入力ファイル> [--out <出力ファイル>]');
      process.exit(1);
    }

    // 入力ファイルパスの取得
    const inputFile = args[0];

    // 出力ファイルパスの取得（指定がなければ入力ファイル名 + .json）
    let outputFile = null;
    let lispOutputFile = null;
    const outFlagIndex = args.indexOf('--out');
    if (outFlagIndex !== -1 && args.length > outFlagIndex + 1) {
      outputFile = args[outFlagIndex + 1];
      // LISP出力ファイルのパスを生成
      lispOutputFile = outputFile.replace(/\.json$/, '.lisp');
      if (lispOutputFile === outputFile) {
        lispOutputFile = `${outputFile}.lisp`;
      }
    } else {
      outputFile = `${inputFile}.json`;
      lispOutputFile = `${inputFile}.lisp`;
    }

    console.log(`入力ファイル: ${inputFile}`);
    console.log(`出力ファイル: ${outputFile}`);
    console.log(`LISP出力ファイル: ${lispOutputFile}`);

    // ファイルの読み込み
    console.log('ファイルを読み込んでいます...');
    const sourceCode = await readFile(inputFile);

    // ステップ1: コメント削除と空白の正規化
    console.log('ステップ1: コメント削除と空白の正規化');
    const normalizedCode = normalizeSourceCode(sourceCode);

    // ステップ2: コードブロックの抽出
    console.log('ステップ2: コードブロックの抽出');
    const codeBlocks = extractAndProcessBlocks(normalizedCode);
    console.log(`${codeBlocks.length}個のコードブロックを抽出しました`);

    // ステップ3: トークン化とカッコ挿入
    console.log('ステップ3: トークン化とカッコ挿入');
    const processedBlocks = [];

    for (let i = 0; i < codeBlocks.length; i++) {
      console.log(`ブロック${i + 1}を処理しています...`);

      // トークナイザーを使用
      const tokens = tokenizeBlock(codeBlocks[i]);

      // カッコを挿入
      const withParentheses = insertParentheses(tokens);

      processedBlocks.push({
        originalBlock: codeBlocks[i],
        tokens: tokens,
        withParentheses: withParentheses
      });
    }

    // ステップ4: 式木生成
    console.log('ステップ4: 式木生成');
    const expressionTrees = [];

    for (let i = 0; i < processedBlocks.length; i++) {
      console.log(`ブロック${i + 1}の式木を生成しています...`);

      try {
        // カッコ付きトークンから式木を構築
        const expressionTree = buildExpressionTree(processedBlocks[i].withParentheses);

        // 生成された式木を保存
        expressionTrees.push(expressionTree);

        // ブロックの情報に式木を追加
        processedBlocks[i].expressionTree = expressionTree;
      } catch (error) {
        console.error(`ブロック${i + 1}の式木生成中にエラーが発生しました:`, error.message);
        // エラーが発生しても処理を続行
        expressionTrees.push(null);
        processedBlocks[i].expressionTree = null;
        processedBlocks[i].expressionTreeError = error.message;
      }
    }

    // ステップ5: LISP変換を追加
    console.log('ステップ5: LISP変換');
    const lispTranslations = [];

    for (let i = 0; i < expressionTrees.length; i++) {
      console.log(`ブロック${i + 1}をLISPに変換しています...`);

      try {
        const lispCode = generateLispCode(expressionTrees[i]);
        lispTranslations.push(lispCode);
        processedBlocks[i].lispCode = lispCode;
      } catch (error) {
        console.error(`ブロック${i + 1}のLISP変換中にエラーが発生しました:`, error.message);
        lispTranslations.push(null);
        processedBlocks[i].lispCode = null;
        processedBlocks[i].lispCodeError = error.message;
      }
    }

    // LISPコードをファイルに保存
    if (lispTranslations.length > 0) {
      console.log(`LISPコードを${lispOutputFile}に保存しています...`);

      // 全てのLISPコードを結合
      const combinedLispCode = lispTranslations
        .filter(code => code) // nullや空文字列を除外
        .join("\n\n");

      // LISPコードにコメントヘッダーを追加
      const lispContent = `;;; Generated LISP code from Sign language source: ${inputFile}
;;; Generated on: ${new Date().toISOString()}
;;; Processor version: 0.1.0

${combinedLispCode}`;

      // ファイルに保存
      await writeFile(lispOutputFile, lispContent);
      console.log('LISPコードの保存が完了しました');
    }

    // 結果の生成
    const result = {
      sourceFile: inputFile,
      processorVersion: "0.1.0",
      processDate: new Date().toISOString(),
      blockCount: codeBlocks.length,
      blocks: processedBlocks.map((block, index) => ({
        blockId: index + 1,
        originalText: block.originalBlock,
        //tokenCount: block.tokens.length,
        //tokens: block.tokens, // トークンが多すぎる場合はコメントアウトを検討
        withParentheses: block.withParentheses,
        // 式木情報を追加
        expressionTree: block.expressionTree,
        expressionTreeError: block.expressionTreeError
      }))
      // expressionTrees: expressionTrees // 将来的に追加
    };

    // 結果の出力
    const jsonResult = JSON.stringify(result, null, 2);

    // ファイルに保存
    console.log(`結果を${outputFile}に保存しています...`);
    await writeFile(outputFile, jsonResult);

    console.log('処理が完了しました');
  } catch (error) {
    console.error('エラーが発生しました:', error.message);
    process.exit(1);
  }
}

// プログラム実行
main().catch(err => {
  console.error('予期せぬエラーが発生しました:', err);
  process.exit(1);
});