# Sign言語プリプロセッサ～コンパイラ

Sign言語コードの前処理からARM64アセンブリコンパイルまでを行う統合開発環境です。

## 🌟 特徴

- **段階的プリプロセッシング**: フォーマット → 引数書き換え → matchcase変換
- **モジュール化設計**: 各処理段階が独立したPEGモジュール
- **完全な構文解析**: Sign言語専用の高速パーサー (16段階→6段階優先順位)
- **ARM64ネイティブコンパイル**: スタックマシンベースのコンパイラ
- **デバッグ支援**: 各段階の中間結果を保存・確認可能

## 📂 ディレクトリ構造

```
sign-preprocessor/
├── sign-preprocessor.js       # メイン統合処理 (プリプロセス + 構文解析)
├── modules/                   # PEGモジュール群
│   ├── formatter.pegjs        # フォーマット整形
│   ├── arg-rewriter.pegjs     # 引数名→位置ベース変換 
│   ├── matchcase-rewriter.pegjs # matchcase→短絡評価変換
│   └── sign-parser.pegjs      # Sign言語構文解析器
├── compiler/                  # コンパイラ部分
│   ├── run-test.js           # メイン実行スクリプト
│   ├── sign-stack-compiler.js # AArch64コンパイラ本体
│   ├── test-input.json       # テスト用JSON入力
│   ├── output.s              # 生成されたアセンブリファイル
│   └── asm_compile.bat       # 最終コンパイルバッチ
├── example/                   # サンプルコードと変換結果
├── test/                      # 単体テスト
└── README.md
```

## 🚀 使用方法

### 1. プリプロセッシング + 構文解析

Sign言語ソースコードをプリプロセスしてJSON ASTに変換：

```bash
# 基本的な変換 (JSON出力)
node sign-preprocessor.js input.sn output.json

# プリプロセス結果も保存
node sign-preprocessor.js input.sn output.json preprocessed.sn

# プリプロセッサのみ実行
node sign-preprocessor.js input.sn null preprocessed.sn

# デバッグモード
node sign-preprocessor.js input.sn output.json preprocessed.sn --debug
```

### 2. アセンブリコード生成

JSON ASTからARM64アセンブリコードを生成：

```bash
cd compiler
node run-test.js
```

**前提条件**: `test-input.json` に有効なSign言語ASTが必要
**出力**: `output.s` (ARM64アセンブリファイル)

### 3. 最終コンパイル

WSLを使用してARM64実行ファイルを生成：

```bash
cd compiler
asm_compile.bat
```

**前提条件**: 
- WSL環境
- ARM64クロスコンパイラ (`aarch64-linux-gnu-as`, `aarch64-linux-gnu-ld`)

**出力**: `output` (ARM64実行ファイル)

## 🔄 完全なワークフロー例

```bash
# 1. Sign言語コードをプリプロセス + JSON変換(compiler直下に直接出力Ver)
node sign-preprocessor.js .\example\test-input.sn .\compiler\test-input.json .\example\test-input_preprocessed.sn 

# 2. アセンブリ生成
node .\compiler\run-test.js  

# 3. 最終コンパイル
.\compiler\asm_compile.bat

```

## 📋 プリプロセッシング処理段階

### 1. フォーマッター (`formatter.pegjs`)
演算子の前後に適切な空白を自動挿入
```sign
// 入力
add:x y?x+y

// 出力  
add : x y ? x + y
```

### 2. 引数書き換え (`arg-rewriter.pegjs`)
引数名を位置ベース(`_0`, `_1`)に変換
```sign
// 入力
add : x y ? x + y

// 出力
add : _0 _1 ? _0 + _1
```

### 3. matchcase書き換え (`matchcase-rewriter.pegjs`)
条件分岐を短絡評価チェーンに変換
```sign
// 入力
classify : _0 ?
    _0 = 0 : 'zero'
    _0 > 0 : 'positive'
    _0 < 0 : 'negative'

// 出力
classify : _0 ?
    _0 = 0 & 'zero' |
    _0 > 0 & 'positive' |
    _0 < 0 & 'negative'
```

### 4. 構文解析 (`sign-parser.pegjs`)
プリプロセス済みコードをJSONのASTに変換

## 🧪 テスト

```bash
# 全テスト実行
npm test

# 個別モジュールテスト
npm run test:arg-rewriter
npm run test:matchcase

# 統合デモ
npm run demo
```

## ⚙️ コンパイラ詳細

### Sign Stack Compiler

**アーキテクチャ**: ARM64 (AArch64)
**設計**: データスタック + コールスタック分離
- データスタック: X8-X15レジスタ
- コールスタック: 標準SPベーススタック
- Unit値処理: XZRレジスタ使用

**対応機能**:
- ✅ 基本算術演算 (`+`, `-`, `*`, `/`, `%`)
- ✅ 関数定義・呼び出し
- ✅ Unit値処理
- ✅ 安全除算 (ゼロ除算対策)
- 🚧 ポイントレス記法 (Phase 4予定)
- 🚧 高階関数 (Phase 5予定)

## 🔧 環境要件

### 開発環境
- Node.js 12+
- npm

### コンパイル環境 (Windows)
- WSL (Windows Subsystem for Linux)
- ARM64クロスコンパイラ:
  ```bash
  sudo apt-get install gcc-aarch64-linux-gnu
  ```

## 🐛 トラブルシューティング

### よくある問題

1. **WSLコンパイルエラー**
   ```
   aarch64-linux-gnu-as: command not found
   ```
   **解決**: ARM64クロスコンパイラをインストール

2. **プリプロセッシングエラー**
   ```
   構文解析エラー: Unexpected character
   ```
   **解決**: Sign言語の構文を確認、文字列リテラルは`` ` ``で囲む

3. **アセンブリ生成エラー**
   ```
   test-input.json not found
   ```
   **解決**: 有効なJSONファイルが必要

## 📚 関連リンク

- [Sign言語仕様書](./reference/Sign_reference_ja-jp.md)
- [コンパイラ設計資料](./reference/Hint/)
- [PEG.js公式ドキュメント](https://pegjs.org/documentation)

