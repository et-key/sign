# UDP: Sign to WebAssembly Compiler (Prototype 1)

現在の `proto/wa1` ディレクトリにおける実装状況と手順のまとめです。

## 現状できること (Current Capabilities)

1.  **Signコードのパース (Sign -> JSON)**
    *   `parser.js` を使用して、Sign言語のソースコードをS式 (JSON形式) に変換できます。
    *   CLI引数 (`--input`, `--output`) に対応しています。

2.  **WebAssemblyへのコンパイル (JSON -> Wasm)**
    *   `compiler.js` を使用して、S式をWebAssemblyバイナリ (`.wasm`) に変換できます。
    *   **サポートされている機能**:
        *   **基本データ型**: 32ビット整数 (`i32`)、64ビット浮動小数点数 (`f64`)。
        *   **算術演算**: 加算 (`+`)、減算 (`-`)、乗算 (`*`)、除算 (`/`)。
        *   **型昇格 (Coercion)**: 演算の中に浮動小数点数が含まれる場合、整数は自動的に浮動小数点数に変換されます (例: `10 + 2.5` -> `12.5` as f64)。
        *   **グローバル定数**: `name : value` 形式のトップレベル定義。
        *   **関数と呼び出し**:
            *   関数の定義: `add : x y ? x + y`
            *   関数呼び出し: `add 10 20`
            *   再帰呼び出しとネストされた呼び出しのサポート。
        *   **論理と制御フロー**:
            *   比較演算: `<`, `>`, `=`, `!=`, `<=`, `>=` (結果は `1` または `0`)。
            *   論理演算: `!` (Not)。
            *   条件分岐: `cond : result` (条件が真なら実行、偽なら`0`を返す)。
            *   単項マイナス (`-5`)、剰余演算 (`%`) のサポート。
        *   **メモリ管理とデータ構造**:
            *   **線形メモリ**: 1ページ (64KB) のメモリを確保し、Bump Allocator (`alloc`) で管理。
            *   **リスト操作**: `cons` (構築), `head` (先頭取得), `tail` (残りの取得) の組み込み関数。
            *   **再帰的データ処理**: メモリ上のリストを再帰関数でトラバース可能。
        *   **文字列リテラル**:
            *   **静的配置**: ソースコード内の文字列 (` ` `) をWasmのデータセクションに配置。
            *   **参照**: プログラム中ではメモリアドレス (`f64`) として扱い、ポインタとして利用可能。

## 今後の残件 (Future Tasks)
## 今後の残件 (Future Tasks)
1.  **動的な文字列操作**: 文字列の連結、スライス、動的生成などの実装（現在はリテラルのみ）。
2.  **標準ライブラリ拡充**: `print` 関数などのホスト連携機能の実装（今回は除外）。
3.  **高度なメモリ管理**: ガベージコレクション (GC) または参照カウントの実装（現在は確保のみで解放なし）。

3.  **Wasmの実行**
    *   `run_wasm.js` を使用して、生成されたWasmファイルをNode.js環境でロードし、結果を表示できます。

## 実行手順 (Usage)

作業ディレクトリ: `proto/wa1`

### 1. 自動ビルドと実行 (推奨)
`build.js` を使うと、パース・コンパイル・実行を一括で行えます。

```bash
# デフォルト (test_minimal.sn を実行)
node proto/wa1/build.js

# 任意のファイルを指定する場合
node proto/wa1/build.js proto/wa1/your_file.sn
```

### 2. 個別実行
各ステップを個別に実行する場合の手順です。

```bash
# 1. パース
node proto/wa1/parser.js --input proto/wa1/test_minimal.sn --output proto/wa1/test_minimal.json

# 2. コンパイル
node proto/wa1/compiler.js --input proto/wa1/test_minimal.json --output proto/wa1/test_minimal.wasm

# 3. 実行
node proto/wa1/run_wasm.js proto/wa1/test_minimal.wasm
```

## ファイル構成
*   `parser.js`: Signパーサー (CLI対応改修版)
*   `compiler.js`: Wasmコンパイラ本体
*   `run_wasm.js`: Wasmテストランナー
*   `build.js`: 一括実行スクリプト
*   `test_minimal.sn`: 動作確認用の最小限のSignコード
*   `test_functions.sn`: 関数定義と呼び出しのテスト
*   `test_logic.sn`: 比較演算子と条件分岐のテスト
*   `test_recursion.sn`: 再帰関数 (階乗, GCD) のテスト
*   `test_memory.sn`: メモリ管理とリスト操作のテスト
*   `test_string.sn`: 文字列リテラルの配置確認テスト
