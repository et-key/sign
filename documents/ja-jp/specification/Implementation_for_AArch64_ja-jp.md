# Sign言語 AArch64実装仕様

## 1. 概要
本仕様書は、Sign言語の演算子をAArch64アセンブリ命令にマッピングするための**変換定義書**です。

Sign言語のバックエンド実装における最も重要な原則は、**「コンパイラ（トランスレータ）はメモリ管理ポリシーを持たない」**という点です。
メモリの確保、解放、GC、ARCといった機能は、Sign言語が提供する**3つのメモリアクセスプリミティブ（`$`, `@`, `#`）**を使用して、**標準ライブラリ（ユーザーランド）**として実装されます。

したがって、本仕様書では**「演算子がどの機械語に変換されるか」**のみを厳密に規定します。

## 2. ハードウェアインターフェース

Sign言語はAArch64の標準ABI（Procedure Call Standard for the Arm 64-bit Architecture）に完全準拠します。これによりC言語等の他言語との透過的な相互運用性を保証します。

### 2.1 レジスタ使用規約
| レジスタ | 役割 | 備考 |
|---|---|---|
| **X0 - X7** | 引数 / 戻り値 | Signの関数引数はこの順序で格納される |
| **X8** | 間接結果アドレス | 大きな構造体を返す場合に使用 |
| **X9 - X15** | 一時レジスタ | 関数呼び出し間で保持されない（Caller-saved） |
| **X16, X17** | プロシージャ内スクラッチ | リンカ/ベニアが使用 |
| **X18** | プラットフォーム予約 | 特定のOSで使用 |
| **X19 - X28** | 保持レジスタ | 関数呼び出し間で保持される（Callee-saved） |
| **FP (X29)** | フレームポインタ | スタックフレームの管理 |
| **LR (X30)** | リンクレジスタ | 戻りアドレス |
| **SP** | スタックポインタ | 現在のスタックトップ |

### 2.2 データ表現
Sign言語の全ての値は64bit幅です。
- **整数 / ポインタ**: 64bit整数
- **浮動小数点**: IEEE 754 double (64bit)
- **Unit (`_`)**: **Identity関数 (`id`) のアドレス**
  - `_` は「何もしない関数（恒等関数）」の実体であり、そのまま `call` 可能です（`_ 1` → `1`）。
  - **False** として扱われます（論理演算の単位元）。
  - **Empty List** として扱われます（リスト構築の単位元 `1 _` → `1`、リスト終端）。

## 3. 演算子マッピング定義

コンパイラは以下の変換テーブルに従い、Sign演算子を機械的にアセンブリ命令へ置換します。最適化は原則としてアセンブリレベル（マクロ展開後）で行われます。

### 3.1 算術演算子 (Arithmetic)

| Sign演算子 | AArch64命令テンプレート | 説明 |
|---|---|---|
| `x + y` | `add x0, x0, x1` | 整数加算 |
| `x - y` | `sub x0, x0, x1` | 整数減算 |
| `x * y` | `mul x0, x0, x1` | 整数乗算 |
| `x / y` | `sdiv x0, x0, x1` | 整数除算（符号付き） |
| `x % y` | `sdiv x2, x0, x1`<br>`msub x0, x2, x1, x0` | 剰余算 |

※ 浮動小数点演算が必要な場合は、型情報または専用演算子定義に基づき `fadd`, `fsub` 等を使用する（Signは型推論を行わないため、文脈により決定される）。

### 3.2 メモリ操作プリミティブ (Memory Primitives)

これらがSign言語における「メモリ管理」の全てです。アロケータ等はこれらを組み合わせて実装されます。

| Sign演算子 | AArch64命令テンプレート | 説明 |
|---|---|---|
| `$x` (Address) | `adrp x0, label_x`<br>`add x0, x0, :lo12:label_x` | ラベルのアドレス取得（PC相対） |
| `@ptr` (Load) | `ldr x0, [x0]` | アドレス `ptr` から64bit値を読み込み |
| `ptr # val` (Store) | `str x1, [x0]` | アドレス `ptr` に値 `val` を書き込み |

### 3.3 論理・比較演算子 (Logic & Comparison)

Signの真偽値（Truthy/Falsy）に基づき、条件付き命令を使用します。
- **Truthy**: `_` (Identity関数のアドレス) **以外**
- **Falsy**: `_` (Identity関数のアドレス)

| Sign演算子 | AArch64命令テンプレート | 説明 |
|---|---|---|
| `x = y` | `cmp x0, x1`<br>`cset x0, eq` (※) | 比較（等価）。※結果はSignの真偽値（真=数値, 偽=_）に変換が必要 |
| `x < y` | `cmp x0, x1`<br>`cset x0, lt` | 比較（未満） |

**補足: Unitの実装**
```assembly
; _ (Unit) の実体 = Identity関数
sign_id:
    ret
```
`_` を値として使う場合は `adr x0, sign_id` (またはリンク時定数) を使用します。
条件分岐は `cmp x0, addr_of_sign_id` で判定します。

### 3.4 制御構造・関数

Signの関数適用は `blr` (Branch with Link to Register) または `bl` (Branch with Link) に変換されます。

```assembly
; 関数呼び出し: f x y
; fが _ の場合、blr label_id となり、x0は変更されず戻る (id x = x)
bl label_f
```

## 4.【実装例】Signによるメモリ管理

コンパイラがメモリ管理を行わない代わりに、Signの標準ライブラリ（またはスタートアップコード）は以下のようにメモリ管理を実装します。

### バンプアロケータの実装イメージ（概念コード）

```sign
```sign
; グローバル変数（定義時は初期値）
#heap_ptr : 0x0

; アロケート関数 (size -> ptr)
alloc : size ?
    current : heap_ptr         ; 現在のヒープポインタ値を取得 (Load)
    next : current + size      ; 次のポインタを計算 (Add)
    $heap_ptr # next           ; ポインタ変数の場所($)に更新値を書き込む (Store)
    current                    ; 古いポインタを返す
```

このSignコードは、本仕様書の定義に従えば以下の効率的なアセンブリに直訳されます。

```assembly
alloc:
    ; X0 = size (arg1)
    stp x29, x30, [sp, #-16]!   ; Prologue
    mov x29, sp

    ; current : heap_ptr
    adr x9, heap_ptr            ; Get Address of heap_ptr
    ldr x10, [x9]               ; Load Value of heap_ptr -> x10 (current)

    ; next : current + size
    add x11, x10, x0            ; x10 + x0 -> x11 (next)

    ; $heap_ptr # next
    adr x9, heap_ptr            ; Get Address of heap_ptr
    str x11, [x9]               ; Store next (x11) into address (x9)

    mov x0, x10                 ; Return current
    
    ldp x29, x30, [sp], #16     ; Epilogue
    ret
```

## 5. 結論
## 5. 結論
AArch64バックエンドの実装は、**「Sign演算子からAArch64命令への1対1の機械的マッピング」**に徹します。
「値のロード」と「アドレスへのストア」の区別は、コンパイラの推論ではなく、Sign言語の実装者（システムプログラマ）が `$` や `#` を用いて明示的に制御します。
これにより、コンパイラを肥大化させることなく、柔軟かつ効率的なメモリ管理をユーザーランド（標準ライブラリ）で実装可能にします。
