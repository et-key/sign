# Sign言語 手動変換・動作確認ガイド (proto/a5)

このガイドでは、`proto\a5` ディレクトリにある構文解析器を使用して、自作のSign言語ファイル（`.sn`）をCommon Lispコードに変換し、動作確認を行う手順を解説します。

## 前提条件

以下の環境が整っていることを確認してください。

1.  **Python 3.7以上**: 構文解析器の実行に必要です。
2.  **SBCL (Steel Bank Common Lisp)**: 変換後のLispコードの実行に必要です。
    *   インストール確認: コマンドプロンプトまたはPowerShellで `sbcl --version` を実行。

## 手順

### 1. 作業ディレクトリへの移動

PowerShellまたはコマンドプロンプトを開き、`proto\a5` ディレクトリに移動します。

```powershell
cd c:\Users\ym_st\Documents\Sign\sign\proto\a5
```

### 2. Sign言語ファイルの作成

任意のテキストエディタで `.sn` ファイルを作成します。
例として `mysample.sn` を作成し、以下の内容を保存してください。

**mysample.sn**
```text
x : 10
y : 20
x + y # _
```
*解説: `x`に10、`y`に20を代入し、`x + y` の結果を出力（`# _`）します。*

### 3. Common Lispコードへの変換

`main.py` を使用して `.sn` ファイルを `.lisp` ファイルに変換します。

**PowerShellの場合（重要）:**
PowerShellの標準のリダイレクト（`>`）を使用すると、文字コードの問題（BOM付きUTF-16など）でSBCLがエラーを起こすことがあります。以下のコマンドで **ASCIIエンコーディング** を指定して保存することをお勧めします。

```powershell
python main.py mysample.sn --format clisp | Out-File -Encoding ASCII mysample.lisp
```

**コマンドプロンプト (cmd.exe) の場合:**
```cmd
python main.py mysample.sn --format clisp > mysample.lisp
```

### 4. 変換結果の確認（オプション）

生成された `mysample.lisp` の中身を確認してみましょう。

```lisp
(defparameter x 10)
(defparameter y 20)
(print (+ x y))
```
のように変換されていれば成功です。

### 5. プログラムの実行

SBCLを使用して、変換されたLispコードを実行します。

```powershell
sbcl --script mysample.lisp
```

**実行結果:**
```text
30
```
と表示されれば動作確認完了です。

---

## トラブルシューティング

### SBCLで "UNBOUND-VARIABLE" などのエラーが出る場合
ファイルエンコーディングの問題の可能性が高いです。手順3の通り、`Out-File -Encoding ASCII` を使用して再変換してみてください。

### 構文エラーが出る場合
`main.py` は標準出力に変換結果を、標準エラー出力にエラーメッセージを表示します。リダイレクトせずに一度画面に表示させて確認してください。

```powershell
python main.py mysample.sn --format clisp
```

## その他のオプション

- **AST（抽象構文木）の確認**:
  ```powershell
  python main.py mysample.sn --format ast
  ```
- **S式（前置記法）の確認**:
  ```powershell
  python main.py mysample.sn --format sexp
  ```
