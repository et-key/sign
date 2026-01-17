# Sign LLVM Compiler Prototype (proto/a3)

Sign言語のLLVMバックエンドコンパイラのプロトタイプ実装です。
ARM64 Windows等の環境制限に対応するため、標準の`llvmlite`インターフェースを模倣した純粋Python製のモックライブラリ（`llvm_mock`）を使用しています。

## ディレクトリ構成

```
proto/a3/
├── src/
│   ├── llvm_mock.py      # LLVM IR生成モック（llvmlite互換）
│   ├── ir_builder.py     # ビルダー抽象化層
│   ├── codegen.py        # コード生成ロジック
│   └── compiler.py       # コンパイラドライバ
├── tests/
│   ├── test_mock.py      # モック自体のテスト
│   └── test_compiler.py  # コンパイラの単体・統合テスト
├── examples/             # コンパイル結果の確認用
└── README.md             # 本ファイル
```

## 現在の実装状況

Phase 5まで完了しており、以下の機能が実装されています。

- **基本的な計算**: 整数演算、比較演算
- **制御構文**: `match` 式 (if/else相当)
- **関数**:
    - 関数定義 (`?` / lambda)
    - 関数呼び出し
    - 再帰呼び出し（末尾再帰最適化は未実装）
- **データ構造**:
    - リスト (`cons`, `nil`)
    - リストアクセサ (`car`/`head`, `cdr`/`tail`)
    - 文字列リテラル（C形式のヌル終端文字列としてグローバル定義）
- **パターンマッチ**:
    - リスト分解パターン (`(match ls ((cons h t) ...) (_ ...))`)
- **FFI**:
    - 外部関数宣言と呼び出し (`declare` / `call`)
- **コード生成**:
    - 正しいSSA形式のLLVM IR生成（`%`プレフィックス、ユニークID）
    - 生成されたIRは外部のLLVMコンパイラ（`clang` / `llc`）でコンパイル可能

### 未実装・残課題

1.  **クロージャ (Closures)**
    - 現在はローカル変数のみアクセス可能。自由変数のキャプチャ（Lambda Liftingまたは環境等の構造体渡し）が必要。
2.  **ガベージコレクション (GC)**
    - 現在は `malloc` で確保するのみで解放されない。簡易GC（参照カウントなど）の実装が必要。
3.  **型システム**
    - 現在はすべて `i64` (ポインタも含む) として扱っている。浮動小数点数やより厳密な型管理が必要。

## 使い方

### 1. 環境構築

Python 3.12+ が必要です。

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

### 3. コンパイルの実行（JSONからの変換）

S式（JSON形式）を受け取り、標準出力にLLVM IRを出力します。

```powershell
# Windows (PowerShell)
$env:PYTHONPATH="src"; python src/compiler.py examples/test_output.json > output.ll
```

### 4. 生成されたIRの検証

生成された `.ll` ファイルは、LLVMのツールチェーンや [Compiler Explorer](https://godbolt.org/) (LLVM IRモード) でアセンブリに変換・実行確認が可能です。

Example (Fibonacci):
```llvm
define i64 @fib(i64 %a) {
  ...
  %call_tmp1 = call i64 @fib(i64 %sub_tmp0)
  ...
}
```
