# pre-alpha 実装の記録

pre-alpha（`pre_alpha/`）は alpha より前の実装であり、アーカイブとして
`pre_alpha_archive.zip` に退避した。本文書はその構成と、alpha との差異、そして**なぜ続かなかったか**を記録する。

> [!IMPORTANT]
> **pre-alpha のコードを設計の参考にしないこと。** 下記の通り、型層を持たないまま
> コード生成へ進んだ実装であり、その形をなぞると同じところで止まる。
> 残す目的は「何を試して何が起きたか」の記録であって、再利用ではない。

---

## 1. 構成の比較

### pre-alpha

```text
lexisize/lexer.js          前処理（separateInfix + markBlock）
parse/minimal.pegjs        構文
parse/st_grammar.pegjs     .st（シンボルテーブル）用の別文法
semanticize/
  coproduct_resolver.js    393行  空白演算子の解決
  ast_helpers.js           373行
  operator_table.js        194行
  operator_types.js        118行  ← 型の知識はここだけ
backend/
  wasm_codegen.js         2924行
  js_codegen.js            995行
  runtime_helpers.js       584行
  aarch64.js               328行
  ts_codegen.js            171行
```

### alpha

```text
lexer.js       前処理（pre-alpha から無改変で移植）
sign.pegjs     構文（peggy）
pass1.js       識別子テーブル
pass2.js       余積解決（Layer 1 カテゴリ）
pass1b.js      ジェネリック具体化
pass3.js       Layer 2 型注釈
interpreter.js 評価器
（コード生成は無い）
```

---

## 2. 差異

| | pre-alpha | alpha |
|---|---|---|
| 前処理 | `lexisize/lexer.js` | **同一物を移植**（唯一そのまま引き継いだ資産） |
| 構文 | `minimal.pegjs` ＋ `.st` 用の別文法 | `sign.pegjs` 一本 |
| 型 | `operator_types.js` 118行のみ | Layer 1／Layer 2 の2層、pass3 が全ノードへ注釈 |
| 出力 | WASM／JS／TS／AArch64 の4ターゲット | 評価器のみ（Pass 4 は未着手） |
| 検証 | `.sn` → `.s` → 外部アセンブラ → `.out`(ELF) | 単体テスト（現在 245 件）＋ 実プログラム（8-Queens） |

**引き継いだのは前処理だけである。** それ以外は作り直しており、共有コードは無い
（`alpha/` から `pre_alpha/` への import は 0 件。pre-alpha を隠した状態で
alpha の全テストが通ることを確認済み）。

---

## 3. なぜ続かなかったか

### 3.1 型層を持たないままコード生成を4つ書いた

意味解析は「空白演算子を apply／compose／concat のどれに解決するか」（`coproduct_resolver`）
までで止まっており、値の内部型を決める層が無い。`operator_types.js` の 118 行が型に関する
知識のすべてだった。

コード生成は型を要求する。命令を選ぶには、その値が GPR に載るのか FPU に載るのか、
即値が何ビットなのか、スロットのオフセットが幾つなのかが決まっていなければならない。
決まらないまま4つのバックエンドを書いたため、進めば進むほど各バックエンドが独自に
推測することになった。

### 3.2 完成度の高いバックエンドほど、型を消すターゲットだった

行数の大きい2本（WASM 2924 行、JS 995 行）は、どちらも**型の区別を消すランタイム**を狙って
いる。数値型が事実上ひとつで、レジスタファイルの別も無く、参照は GC が管理する。
型層が無くても動いてしまうため、**欠けていることに気づけない**。

一方 AArch64（328 行）の出力は雛形で止まっている。テストの `.s` を見ると `_start` で
`sys_exit` を呼ぶだけで、式のコンパイルに到達していない。型が無いと命令が選べないという
事実が、ここに素直に現れている。

### 3.3 `.st` が空だった

`.st`（シンボルテーブル）は専用の文法（`st_grammar.pegjs`）まで用意されていたが、
生成物はほとんど空である（`_test_/abs/abs.st` は 0 バイト、最大でも 783 バイト）。
出力すべき内容——識別子の型と、関数が要求するフィールド——が型層の不在によって
決まらなかったためと考えられる。

### 3.4 `.out` はコンパイラの成果ではない

`_test_/*/*.out` は ELF バイナリだが、これは `.s` を外部アセンブラへ渡した結果である。
`.s` 自体が雛形である以上、これらは「動いた証拠」にはならない。

---

## 4. alpha が取った順序

alpha は逆順にした。**コード生成を後回しにして、先に型を決める。**

- `type_system.md` が Layer 1（構造型）と Layer 2（Atom 内部型）を定義し、
  `Address` は GPR 幅、`Float` は FPU の最高精度、というように**型がレジスタファイルと
  幅を名指しする**
- `List` と `Struct` を分ける基準は「要素の型が揃っているか」ではなく
  「**Pass 4 が1つの命令テンプレートで済むか**」
- 評価器は `node.atomType` を読んで、値だけでは決まらない判断を行う
  （`5 / 2` は 3、`5.0 / 2` は 2.5。`|xs|` が 0 か零射かもオペランド型で決まる）

Pass 4 はまだ無いが、**何を出すべきかは型が既に決めている**。pre-alpha はその逆で、
出す側から書き始めた。

---

## 5. アーカイブの取り扱い

- `pre_alpha_archive.zip` にまとめてある（`node_modules` は含まない）。
  リポジトリには含めず、`.gitignore` で除外している
- ルートにあった `playground/`・`run_debug.js`・`run_transpile.js`・`run_playground.js` は
  pre-alpha のフロントエンドであり、同じアーカイブに含む
- 履歴は git に残っているため、必要になれば当該コミットから取り出せる
