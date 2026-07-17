# match_case 式仕様

## 概要

Sign の条件分岐は `&`/`|` の短絡評価で表現できるが、
複数の分岐を持つ場合に可読性を高めるため、**インデントブロック構文（match_case 式）** が使える。

match_case 式は純粋な**糖衣構文**であり、コンパイラは `&`/`|` チェーンに変換する。
TCO も `&`/`|` の変換後に適用されるため、自動で有効になる。

> [!IMPORTANT]
> **`?` 直後のブロック種別による意味の違い**
>
> | `?` の直後 | 解釈 | 用途 |
> |---|---|---|
> | **インデントブロック**（TABで字下げ） | `match_case` 式 | 条件分岐 |
> | **`[...]` ブロック** | struct/list リテラル | 複数フィールドを返すコンストラクタ等 |
>
> ```sign
> ` match_case（インデントブロック）
> f : x ?
>   x < 0 : `negative`
>   `non-negative`
>
> ` struct コンストラクタ（[...]ブロック）
> Point : x y ? [
>   x : x
>   y : y
> ]
> ```
>
> コンパイラは `?` 直後のトークンが `\x02`（Indent仮想トークン）か `[` かで
> どちらの構文かを一意に判定する。曖昧さは存在しない。

---


## 1. 構文

```
function_def ?
TAB   condition1 : result1
TAB   condition2 : result2
TAB   ...
TAB   default_result
```

- `?` の直後からインデント（**TABのみ・空白インデントはNG**）されたブロックが match_case 式
- 各 arm は `condition : result` の形（`: ` がセパレータ）
- **最終行は条件なしの `result` のみ** → デフォルトケース

---

## 2. デシュガー規則

```
condition1 : result1    →  condition1 & result1 |
condition2 : result2    →  condition2 & result2 |
...                        ...
default_result          →  default_result
```

最終行（条件なし）は `|` チェーンの末端にそのまま置かれる。

---

## 3. 比較演算子の使い分け

arm の条件式では演算子表（`A_Operator_Table.md`）の比較演算子を使う：

| 演算子 | 優先度 | 種別 | 意味 |
|--------|--------|------|------|
| `=`    | 12 | 算術比較 | 算術的等値 |
| `!=`   | 12 | 算術比較 | 算術的不等 |
| `<`    | 12 | 算術比較 | より小さい |
| `<=`   | 12 | 算術比較 | 以下 |
| `>`    | 12 | 算術比較 | より大きい |
| `>=`   | 12 | 算術比較 | 以上 |
| `==`   | 8  | 構造比較 | 構造的等値（同型性） |
| `!==`  | 8  | 構造比較 | 構造的不等 |

arm の `:` （優先度2）は arm セパレータとして使われるが、
条件式の `=`（優先度12）は `:` より先に評価されるため、構文的に曖昧にならない。

---

## 4. 例

### 基本的な数値比較

```sign
compare : x y ?
	x = y : `equal`
	x < y : `less`
	`greater`           ` デフォルト（x > y の場合）
```

デシュガー後：

```sign
compare : x y ?
    x = y & `equal` |
    x < y & `less`  |
    `greater`
```

### 構造比較を含む場合

```sign
check : a b ?
	a == b : `same structure`
	`different`
```

デシュガー後：

```sign
check : a b ?
    a == b & `same structure` |
    `different`
```

### 再帰 + match_case（TCO 自動適用）

```sign
collatz : n steps ?
	n = 1        : steps
	n % 2 = 0   : collatz (n / 2)      (steps + 1)
	               collatz (n * 3 + 1) (steps + 1)
```

デシュガー後（末尾呼び出し → TCO）：

```sign
collatz : n steps ?
    n = 1       & steps |
    n % 2 = 0   & collatz (n / 2)      (steps + 1) |
                  collatz (n * 3 + 1)  (steps + 1)
```

各 arm の再帰呼び出しが末尾位置にあるため、すべて `JMP` に変換される。

### 相互再帰 + match_case

```sign
is_even : n ?
	n = 0 : 1
	is_odd (n - 1)

is_odd : n ?
	n = 0 : __
	is_even (n - 1)
```

デシュガー後：

```sign
is_even : n ? n = 0 & 1  | is_odd  (n - 1)
is_odd  : n ? n = 0 & __ | is_even (n - 1)
```

---

## 5. 構文の制約

- **最終行は必ず存在する**：空のブロックはエラー
- **最終行には `:` を書かない**（条件なし）
- **インデントは TAB のみ**：Sign の大原則として空白によるインデントは NG。
- **条件式内の辞書リテラルは型エラー**：arm の条件式内に `[key : val]` のような辞書リテラルを直接記述すると、内側の `:` が arm セパレータと競合するため型エラーとなる。変数に束縛してから比較すること。
- **条件なし arm は最終行のみ**：途中に条件なし行は置けない

```sign
` エラー例
f : x ?
	`default`   ` ← 最初にデフォルトを置くと後の arm が unreachable
	x = 0 : `zero`
```

---

## 6. TCO との関係

TCO 仕様（`TCO_ja-jp.md`）により、match_case の各 arm の末尾にある
再帰呼び出しは**自動的に TCO が適用される**。

アノテーションや特別な構文は不要。デシュガーされた `&`/`|` チェーンに対して
TCO が適用されるだけであり、match_case 固有の最適化は存在しない。
