# Sign LLVM Compiler Prototype (proto/a3)

Sign言語のLLVMバックエンドコンパイラのプロトタイプ実装です。
ARM64 Windows等の環境制限に対応するため、標準の`llvmlite`インターフェースを模倣した純粋Python製のモックライブラリ（`llvm_mock`）を使用しています。

## ディレクトリ構成

```
proto/a3/
├── parser/
│   ├── parser.js          # Sign → JSON S式変換パーサー（a2からコピー）
│   └── prepare_lexer.js   # 字句解析前処理
├── src/
│   ├── llvm_mock.py       # LLVM IR生成モック（llvmlite互換）
│   ├── ir_builder.py      # ビルダー抽象化層
│   ├── codegen.py         # コード生成ロジック
│   └── compiler.py        # コンパイラドライバ
├── tests/
│   ├── test_mock.py       # モック自体のテスト
│   └── test_compiler.py   # コンパイラの単体・統合テスト
├── examples/              # テストコードとコンパイル結果
│   ├── test_minimal.sn    # 最小限の動作確認用Signコード ✓検証済み
│   ├── test_minimal.json  # パーサー出力（S式JSON）
│   ├── test_minimal.ll    # LLVM IR出力
│   └── test_minimal.s     # Compiler Explorerでのアセンブリ出力
└── README.md              # 本ファイル
```

## 現在の実装状況

### ✅ **動作確認済みの機能**

以下の機能は実際にLLVM IRに変換され、Compiler Explorerでアセンブリコンパイルが確認されています：

- **整数リテラル**: `42`, `-10`
- **四則演算**: `+`, `-`, `*`, `/`（演算子優先順位も正しく処理）
- **比較演算**: `<`, `>`, `=`, `!=`, `<=`, `>=`（結果はi64の0/1）
- **変数定義**: `変数名 : 値`
- **文字列リテラル**: `` `Hello, LLVM!` ``（C形式のヌル終端文字列としてグローバル定義）
- **コード生成**: 正しいSSA形式のLLVM IR生成（`%`プレフィックス、ユニークID）

### 🚧 **実装済みだが未検証の機能**

以下の機能はコード上実装されていますが、パーサーまたはコードジェネレータの制約により動作確認できていません：

- **関数定義**: `?` (lambda) - パーサーは対応済み
- **match式**: 条件分岐 (if/else相当) - コードジェネレータは対応済み
- **データ構造**: `cons`, `nil`, `car`/`head`, `cdr`/`tail`
- **パターンマッチ**: リスト分解パターン

### ❌ **未実装・残課題**

1. **空白演算子による関数適用** (`" "`)
   - 現在、関数呼び出しの構文がコードジェネレータで未実装
   - 例: `increment 10`, `add 3 5`
   
2. **括弧によるグループ化**
   - パーサーが`(2 + 3)`を余分な配列で囲んでしまう
   - 例: `(2 + 3) * 4`が正しく処理されない

3. **クロージャ (Closures)**
   - 自由変数のキャプチャ（Lambda Liftingまたは環境構造体渡し）が必要

4. **ガベージコレクション (GC)**
   - 現在は `malloc` で確保するのみで解放されない

5. **型システム**
   - 現在はすべて `i64` (ポインタも含む) として扱っている
   - 浮動小数点数、文字型などの対応が必要

## 使い方

### 1. 環境構築

Python 3.12+ と Node.js が必要です。

```powershell
cd proto/a3
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install pytest
```

### 2. テストの実行

実装された全機能のテストを行います。

```powershell
python -m pytest tests/test_compiler.py -v
```

### 3. Sign → LLVM IR の完全なワークフロー

#### 3.1. Sign → JSON S式変換

`parser.js`を使用してSignコードをJSON S式に変換します。

```powershell
# ルートディレクトリから実行
node proto/a3/parser/parser.js proto/a3/examples/test_minimal.sn proto/a3/examples/test_minimal.json
```

または、引数なしで実行すると`examples/test.sn`をデフォルトで処理します：

```powershell
cd proto/a3
node parser/parser.js
# 出力: examples/test.json
```

#### 3.2. JSON S式 → LLVM IR変換

生成されたJSON S式をLLVM IRに変換します。

```powershell
cd proto/a3
python src/compiler.py examples/test_minimal.json -o examples/test_minimal.ll
```

### 4. 生成されたIRの検証

生成された `.ll` ファイルは、[Compiler Explorer](https://godbolt.org/) (LLVM IRモード) でアセンブリに変換・実行確認が可能です。

#### 検証済みの例 (`test_minimal.ll`)

```llvm
define i64 @main() {
entry:
  %integer_test_ptr0 = alloca i64
  store i64 42, i64* %integer_test_ptr0
  %add_result_ptr2 = alloca i64
  %add_tmp3 = add i64 1, 2
  store i64 %add_tmp3, i64* %add_result_ptr2
  ...
  ret i64 %str_ptr20
}
```

Compiler Explorerでのアセンブリ出力（x86-64 clang with -O2）：
```asm
main:
        mov     qword ptr [rsp - 8], 42
        mov     qword ptr [rsp - 24], 3    # 1 + 2 = 3
        mov     qword ptr [rsp - 56], 14   # 2 + 3 * 4 = 14
        ...
        ret
```

## 次のステップ

実用的なコンパイラにするため、以下の実装が推奨されます：

1. **空白演算子の実装** (優先度: 高)
   - `codegen.py`に`" "`オペレーターの処理を追加
   - 関数呼び出しが可能になる

2. **括弧処理の修正** (優先度: 中)
   - パーサーの修正により`(2 + 3) * 4`が正しく処理されるようにする

3. **match式の検証** (優先度: 中)
   - 既存実装を使った動作確認用のテストケース作成

