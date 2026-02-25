# Sign言語 実装者向けクイックスタート

## 読めるVM

現に、「レジスタマシン」と「スタックマシン」を組み合わせた「ハイブリッドマシン」を単純に言語化したものである。
そのため、前置記法への変換を行って、スタックの中にレジスタマシン（IO）を閉じ込めていくと手法を取る。

この時、カッコとインデントは、同じブロックという概念で取り扱えることも保証する。

## まず読むべき3つの文書

### 1. [演算子表](../ja-jp/specification/A_Operator_Table.md) 【必読】
全ての演算子の優先順位と意味。これが言語の骨格。

### 2. [リスト操作チートシート](../ja-jp/List_Operation_Cheat_Sheet_ja-jp.md) 【必読】
よく使う操作の一覧。実例で理解する。

### 3. [実行例](../ja-jp/example.ja-jp.sn) 【必読】
実際に動くSignコード。これを読めば書ける。

---

## 核心理解：5つの定義

理解に困ったら、この5つに戻る：

| 記号 | 意味 | 例 |
|------|------|-----|
| `_` | 恒等関数（Unit） | `_ 5 = 5` |
| 空白 | 余積（関数合成・適用） | `f g x = g(f(x))` |
| `,` | 積（リスト構築） | `1, 2, 3` |
| `?` | ラムダ（関数定義） | `x ? x + 1` |
| `:` | 定義（束縛） | `add : x y ? x + y` |

**これら5つはオーバーロード不可**（型推論規則そのもの）

---

## データフロー：filter → map → fold

```sign
[> 0,] [* 2,] [+] data
 ↓      ↓      ↓
filter  map   fold
入力   変換   出力
```

関数合成は**左から右へデータが流れる**：
```
f g x = g(f(x))
```

---

## 疑問が出たら読む文書

### 型システムについて
→ [Type_System_ja-jp.md](../ja-jp/specification/Type_System_ja-jp.md)
- 「構文＝型」とは
- 比較演算の値返却
- 型変換の規則

### Unit（`_`）の詳細
→ [Unit_Specification_ja-jp.md](../ja-jp/specification/Unit_Specification_ja-jp.md)
- 双代数の単位元
- 演算子との相互作用
- 部分適用の基礎

### 純粋関数型設計
→ [Pure_Functional_Guidelines_ja-jp.md](../ja-jp/specification/Pure_Functional_Guidelines_ja-jp.md)
- 関数内定義の禁止
- ブロック構文の規則
- 「一つの関数は一つの動詞」原則

### プリプロセッサ
→ [Impl_Preprocessor_ja-jp.md](../ja-jp/specification/Impl_Preprocessor_ja-jp.md)
- 引数名の位置ベース変換
- 比較演算の変換
- match_case変換

### コメント規則
→ [Commenting_Strategy_ja-jp.md](../ja-jp/specification/Commenting_Strategy_ja-jp.md)
- 何がコメントになるか
- IOされないコードとは

### 圏論的基盤（理論）
→ [Categorical_Truth_Values_in_Sign_ja-jp.md](../ja-jp/specification/Categorical_Truth_Values_in_Sign_ja-jp.md)
- 論理値の設計
- 0 と _ の違い

---

## 実装戦略

### JavaScript トランスパイル
→ [Transpile_Strategy.md](../ja-jp/specification/Transpile_Strategy.md)
- 段階的テキスト置換
- S式への変換

### 構文解析
→ [Parse_Strategy_ja-jp.md](../ja-jp/specification/Parse_Strategy_ja-jp.md)
- 三段階処理モデル
- adjacency と型推論

### Racket インタープリタ
→ [Interpreter_Specification_ja-jp.md](../ja-jp/specification/Interpreter_Specification_ja-jp.md)
- #lang 実装
- Pull-based evaluation

### AArch64 ネイティブ実装
→ [Implementation_for_AArch64_ja-jp.md](../ja-jp/specification/Implementation_for_AArch64_ja-jp.md)
- 二重スタック構造
- SIMD最適化

---

## 言語哲学（必要に応じて）

### Zero Cost Domain Abstraction
→ [Zero_Cost_Domain_Abstraction_ja-jp.md](../ja-jp/specification/Zero_Cost_Domain_Abstraction_ja-jp.md)

### データフローアーキテクチャ
→ [Data_Flow_Strategy_ja-jp.md](../ja-jp/specification/Data_Flow_Strategy_ja-jp.md)

### モジュール設計
→ [Link_Strategy_ja-jp.md](../ja-jp/specification/Link_Strategy_ja-jp.md)

---

## 実装の開始手順

### Step 1: 演算子表を読む
どの記号がどの優先順位か把握する。

### Step 2: チートシートで動作確認
リスト操作の実例を見る。

### Step 3: example.sn を実行してみる
実際のコードを動かす。

### Step 4: 簡単な関数を書いてみる
```sign
add : x y ? x + y
double : [* 2,]
sum : [+]
```

### Step 5: データフローを試す
```sign
result : [> 0,] [* 2,] [+] [1, -2, 3, -4, 5]~
# 期待値: 18 = 1 * 2 + 3 * 2 + 5 * 2
```

### Step 6: 疑問が出たら理論文書へ
「なぜこうなる？」が出たら、上記リンクから該当文書を読む。

---

## トラブルシューティング

### 「関数合成の順序がわからない」
```sign
f g x = g(f(x))  # 左から右へデータが流れる
```
→ [Pure_Functional_Guidelines](../ja-jp/specification/Pure_Functional_Guidelines_ja-jp.md)

### 「空白の意味が複数あって混乱」
型で決まる：
- 関数 + 関数 → 合成
- 関数 + 値 → 適用
- リスト + リスト → 結合
- 値 + 値 → 構築

→ [Parse_Strategy](../ja-jp/specification/Parse_Strategy_ja-jp.md)

### 「Unitの使い方がわからない」
```sign
`恒等関数
_ x = x

`部分適用
_ + 3 = [+ 3]

`双代数の単位元として
_ f = f _ = f
```

→ [Unit_Specification](../ja-jp/specification/Unit_Specification_ja-jp.md)

### 「ブロック構文がエラーになる」
条件式と一般処理を同一階層で混在させない。
→ [Pure_Functional_Guidelines](../ja-jp/specification/Pure_Functional_Guidelines_ja-jp.md)

---

## 重要な原則

1. **疑うな、まず試せ** - 演算子表とチートシートに従う
2. **データフロー思考** - 入力→処理→出力の順序で考える
3. **型が決める** - 空白の意味は意味解析で決まる
4. **5つの核心** - `_`, 空白, `,`, `?`, `:` 以外はオーバーロード可能
5. **理論は後** - 動かしてから、必要なら理論を読む

---

**まずは動かす。疑問は後で解決する。**
