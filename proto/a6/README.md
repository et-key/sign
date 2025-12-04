# Sign言語インタープリタ - Phase 1実装

Sign言語のRacket `#lang`実装です。仕様書 `documents\ja-jp\specification\Interpreter_Specification_ja-jp.md` に基づいています。

## 実装済みの機能（Phase 1）

### コアファイル
- **info.rkt** - パッケージ情報とRacket依存関係
- **main.rkt** - `#lang sign` のエントリポイント
- **reader.rkt** - Sign構文リーダー（トークナイザ + 中置→前置変換）
- **runtime.rkt** - ランタイムライブラリ（演算、Stream操作）
- **repl.rkt** - 対話環境（REPL）

### 実装されている機能

#### 演算子
- **算術演算**: `+`, `-`, `*`, `/`, `%`, `^`, `!` (階乗)
- **比較演算**: `<`, `<=`, `=`, `>=`, `>`, `!=` （値返却型）
- **論理演算**: `&` (and), `|` (or), `;` (xor), `!` (not) （短絡評価対応）
- **定義演算**: `:` (定義)

#### リテラル
- 数値: `42`, `-3.14`
- 16進数: `0xAF`
- 8進数: `0o77`
- 2進数: `0b1010`
- 文字列: `` `文字列` ``
- Unit（空リスト）: `_`

#### Stream操作
- 範囲リスト: `[1 ~ 5]` (有限), `[1 ~ ]` (無限)
- MAP/FOLD操作のための基盤

#### パース機能
- 中置記法からS式（前置記法）への変換
- 演算子優先順位の処理
- 右結合/左結合の対応

## 使用方法

### 前提条件
Racketがインストールされている必要があります：
- [Racket公式サイト](https://racket-lang.org/) からダウンロード
- インストール後、`racket`コマンドが利用可能であることを確認

### テストの実行

#### プロジェクトルートから実行する場合

```powershell
# プロジェクトルート（sign ディレクトリ）に移動
cd C:\Users\ym_st\work_vscode\sign

# 基本テストの実行
racket proto\a6\tests\test-basic.rkt

# 関数機能テストの実行（Phase 2）
racket proto\a6\tests\test-functions.rkt

# Stream機能テストの実行（Phase 3）
racket proto\a6\tests\test-streams.rkt
```

#### `proto\a6` ディレクトリから実行する場合

```powershell
# proto\a6 ディレクトリに移動
cd C:\Users\ym_st\work_vscode\sign\proto\a6

# 基本テストの実行
racket tests\test-basic.rkt

# 関数機能テストの実行（Phase 2）
racket tests\test-functions.rkt

# Stream機能テストの実行（Phase 3）
racket tests\test-streams.rkt
```

### REPLの起動

#### プロジェクトルートから実行する場合

```powershell
# REPLを起動
racket proto\a6\repl.rkt
```

#### `proto\a6` ディレクトリから実行する場合

```powershell
# REPLを起動
racket repl.rkt
```

REPLコマンド：
- `:quit` - 終了
- `:help` - ヘルプ表示
- `Ctrl+C` - 強制終了

### Sign言語ファイルの実行

現在、`#lang sign`を使用するにはパッケージのインストールが必要です：

```powershell
cd proto\a6
raco pkg install
```

その後、Sign言語ファイル（例：`example.sn`）を以下のように記述：

```scheme
#lang sign

` 変数定義
x : 42
y : 10

` 演算
sum : x + y

` 関数定義（Phase 2）
add : x y ? x + y
inc : [+ 1]

` 関数適用
result : add 3 5
next : inc 10

` リスト操作とStream（Phase 3）
nums : 1, 2, 3, 4, 5
doubled : [* 2,] nums
total : [+] nums

` 無限リスト
naturals : [1 ~]
first-5 : naturals ~
```

## プロジェクト構造

```
proto/a6/
├── info.rkt              # パッケージ情報
├── main.rkt              # #lang エントリポイント
├── reader.rkt            # Sign構文リーダー
├── runtime.rkt           # ランタイムライブラリ
├── repl.rkt              # REPL実装
├── example.sn            # サンプルファイル
└── tests/
    ├── test-basic.rkt    # 基本テスト
    ├── test-functions.rkt # 関数機能テスト（Phase 2）
    └── test-streams.rkt   # Stream機能テスト（Phase 3）
```

## 今後の実装予定（Phase 4以降）

- **Phase 4**: パターンマッチと代数的データ型
  - `match` 式の実装
  - データ型定義構文
  
- **Phase 4**: 制御構造
  - 条件分岐（match_case）
  - ブロック構文（インデント）
  
- **Phase 5**: モジュールシステム
  - Export/Import演算子

## テスト内容

`tests/test-basic.rkt`では以下をテスト：
- 数値リテラルのパース
- Unit（空リスト）
- 算術演算と優先順位
- 比較演算（値返却型）
- 論理演算（短絡評価）
- Stream操作（範囲リスト）
- 階乗計算

## 注意事項

このPhase 1実装は基本的な機能のみを含みます。ラムダ式、関数定義、高度なリスト操作は今後のフェーズで実装予定です。

## 参考資料

- 仕様書: `documents\ja-jp\specification\Interpreter_Specification_ja-jp.md`
- [Racket公式ドキュメント](https://docs.racket-lang.org/)
- [Beautiful Racket](https://beautifulracket.com/) - `#lang`実装チュートリアル
