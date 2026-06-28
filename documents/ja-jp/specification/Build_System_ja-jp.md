# Sign ビルドシステム仕様：`option.son` とコンパイル階層

## 1. 概要

> [!IMPORTANT]
> **Sign のビルド設定は、コマンドライン引数ではなく `option.son`（Sign Object Notation）ファイルによって管理される。**
> これはSign言語自身のデータ記述能力を使ってコンパイラを設定するという、セルフホスト哲学の自然な帰結である。

Sign のコンパイラ設定は以下の原則に従う：

1. **設定はファイルで宣言する** — コマンドライン引数は緊急時のオーバーライドのみ
2. **フォルダ単位で有効** — 各フォルダの `option.son` はそのフォルダ以下に適用される
3. **レキシカルな継承** — 子フォルダは親の設定を暗黙的に継承し、必要な部分のみ上書きする
4. **動的追加は許可しない** — `option.son` の構造はスキーマで静的に決定される

---

## 2. `son` フォーマット（Sign Object Notation）

`son` は Sign の積型（Product）記法をそのままデータ記述に使ったフォーマットである。
JSON との比較：

| JSON | son |
|------|-----|
| `"key": value` | `key : value` |
| `"string"` 必須 | 識別子はそのまま、文字列はバッククォート |
| `null` / `false` | `__`（Unit に収束） |
| コメント不可（標準） | 行頭バッククォート `` ` `` でコメント記述 |
| 動的追加可能 | スキーマ固定・静的のみ |
| `[1, 2, 3]` | `1 2 3` または `1,2,3` など、Sign の積、余積の仕様に従う|

### 記法例

```son
` option.son — Sign Object Notation のサンプル

target  : `rust`
` std レイヤー
layer   : 2
optimize : 2
entry   : `main.sn`
output  : `app`

features :
    lto
    strip_debug
```

Sign のパーサがそのまま読める。コンパイラがセルフホストされれば、
`option.son` のパースはSign自身で行われる。

---

## 3. フォルダごとの `option.son` 継承モデル

### 3.1 ディレクトリ構造

```
project/
  option.son              ← ルート設定（全体のデフォルト）
  │
  ├── kernel/
  │     option.son        ← layer: 0 に変更あり → 要る
  │     ├── drivers/
  │     │    └── uart.sn   ← option.sonなし（kernel/の設定をそのまま継承）
  │     └── mm/
  │           option.son  ← allow_raw_alloc 追加あり → 要る
  │
  ├── userspace/
  │     option.son        ← layer: 2 に戻す変更あり → 要る
  │
  └── lib/
        option.son        ← target: wasm など別ターゲットへ変更あり → 要る
```

### 3.2 継承ルール

- コンパイラは対象ファイルのフォルダから **ルートに向かって `option.son` を探索し、スタックして適用する**
- **後から見つかったもの（近いフォルダ）が優先**（レキシカルスコープと同型）
- `inherit : false` を宣言した場合、そのフォルダ以上の設定を無視する

```son
` kernel/option.son
` bare metal layer
layer    : 0
optimize : 3
features :
` # / ## をコンパイルエラーとする
    no_alloc
```

```son
` kernel/mm/option.son
` アロケータ実装フォルダ — ここだけ生ポインタ操作を許可

features :
    raw_alloc   ` このフォルダのみ、アロケータ実装として許可
```

---

## 4. コンパイル階層（Layer）

Sign のビルドは `layer` キーによって3段階に分かれる。
**`layer` は数値で指定する。** 別名（bare / alloc / std）はドキュメント上の呼称であり、コンパイラは数値で解釈する。

| 数値 | 意味 | 使用可能なもの | 禁止されるもの | 対応Rustモデル |
|------|------|---------------|----------------|---------------|
| `0` | bare | `$`, `@`, `#`(store), `###` | `#`(Rc), `##`(Arc), クロージャ確保 | `#![no_std]` + `#![no_main]` |
| `1` | alloc | layer 0 の全て + `#`(Rc), `##`(Arc) | OS依存IO | `#![no_std]` + `extern crate alloc` |
| `2` | std | 全機能 | — | `std` |

> [!NOTE]
> `layer` を指定しない場合、デフォルトは `2`（std）となる。
> コンパイラは `layer >= 1` でアロケータ有効、`layer == 0` でvolatile自動適用、と数値で判断する。

### layer 0（bare）の用途

- カーネル起動ルーティン（スタックのみ、ヒープなし）
- デバイスドライバ（MMIOレジスタへの直接アクセス）
- アロケータ実装自体
- ファームウェア・ブートローダ

---

## 5. メモリモデルキー

`option.son` で宣言する `#` / `##` / `###` の Rust 対応：

| Sign 演算子 | Rust 対応型 | 意味 |
|-------------|------------|------|
| `#` | `Rc<RefCell<T>>` | シングルスレッドの参照カウント＋内部可変性 |
| `##` | `Arc<Mutex<T>>` | アトミック参照カウント（スレッド間共有） |
| `###` | `Pin<Box<T>>` | アドレス固定（DMA・MMIO・FFI境界） |

> [!NOTE]
> `layer: 0`（bare）では `#`（Rc）と `##`（Arc）はコンパイルエラー。
> ヒープアロケータが存在しない環境では使用不可。
> `###`（Pin）はアドレスの安定性を表すため layer 0 でも有効。

---

## 6. Volatile 操作（bare レイヤーの自動適用）

`bare` 層を選ぶ時点で、プログラマは「ヒープなし・ハードウェアに向き合う」と宣言している。
したがって、**`bare` 層における `@`（load）と `#`（store）は暗黙的にvolatileとして扱われる。**
`@!` / `#!` のような専用演算子は不要であり、存在しない。

| layer | `@` / `#` の扱い | Rust対応 |
|-------|-----------------|----------|
| `0`（bare） | 暗黙的にvolatile | `ptr::read_volatile` / `ptr::write_volatile` |
| `1`（alloc） | 通常のメモリアクセス | `*ptr` / `*ptr = val` |
| `2`（std） | 通常のメモリアクセス | `*ptr` / `*ptr = val` |

```son
` kernel/option.son
layer : 0   ` これだけで以下の @/# が全て volatile になる
```

```sign
` 以下は layer: 0 環境で自動的に volatile read/write にコンパイルされる
0xFEA00000 # 0x01            ` → ptr::write_volatile(0xFEA00000, 0x01)
status : @ 0xFEA00004        ` → ptr::read_volatile(0xFEA00004)
```

> [!NOTE]
> layer 0 で「通常メモリアクセスがしたい」と思い始めた時点で、
> それは layer 1 に移るべきサインである。数値の境界が設計圧力として機能する。

---

## 7. `option.son` スキーマ全フィールド一覧

```son
` option.son — 完全フィールド一覧（すべてオプション）

` ─── ターゲット ───────────────────────────────────────────
target   : `rust`    ` rust | wasm | js | x86_64 | aarch64 | riscv64 | wasm32 | wasm64（デフォルト: rust）
layer    : 2         ` 0=bare | 1=alloc | 2=std（デフォルト: 2）

` ─── ビルド ────────────────────────────────────────────────
entry    : `main`    ` エントリポイント関数名
output   : `app`     ` 出力ファイル名（拡張子はtargetに応じて自動）
optimize : 2         ` 0〜3（デフォルト: 0）

` ─── 継承 ──────────────────────────────────────────────────
inherit  : true      ` false にすると親option.sonを無視

` ─── フィーチャーフラグ ─────────────────────────────────────
features :
    allow_raw_alloc  ` アロケータ実装フォルダ専用の特権フラグ（bare層のみ）
    lto              ` Link-Time Optimization
    strip_debug      ` デバッグ情報を除去
    emit_types       ` .d.ts / 型情報ファイルを出力

` ─── リンカ設定（bare / alloc レイヤー向け）────────────────
link :
    script   : `linker.ld`
    sections :
        text : 0x80000
        data : 0x100000
        bss  : 0x200000
```

---

## 8. ファイル名視定とエントリーポイント規約

### 拡張子

Signのソースファイルの正式拡張子は **`.sn`** である。
これは内部弧用のめに `.sign` も有効だが、正式な推奨拡張子は `.sn`。

### エントリーポイント

**`main.sn`** がエントリーポイントファイルの規約名である。
`sign build .` を実行すると、カレントディレクトリの `main.sn` が自動的にエントリーエントとして使用される。

```
project/
  option.son    ← ビルド設定
  main.sn       ← エントリーポイント（ファイル名規約）
  lib/
    utils.sn
    math.sn
```

> [!NOTE]
> `option.son` の `entry` フィールドは、`main.sn` 内のエントリー関数名を指定する。
> 省略時は `main.sn` のトップレベル式を実行する。

---

## 9. コンパイルコマンド

```sh
sign build .             ` カレントディレクトリから再帰的にビルド（main.snをエントリーに）
sign build kernel/       ` 指定フォルダ以下をビルド
sign build src/main.sn   ` 単一ファイル（最近傍 option.son を使用）
```

コマンドライン引数によるオーバーライド（緊急時のみ）：

```sh
sign build . --layer 0 --optimize 0
```

コマンドライン引数は `option.son` の値を一時的に上書きする。
プロジェクトの設定を変えるものではない。

---

## 9. セルフホスト時の挙動

コンパイラがセルフホスト（Sign → Rust → native）されると：

1. `option.son` のパースは Sign 自身が行う
2. スキーマ検証も Sign の型システムで行われる
3. `option.son` に未知のキーがあればコンパイルエラー（動的追加不可）
4. `option.son` は「型を持つ積型の値」として扱われる

この設計により、**ビルドシステムとコンパイラが同一の言語で記述・検証される**。
