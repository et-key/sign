# Sign言語におけるUnit演算の仕様

## 1. イントロダクション

Sign言語におけるUnit値 (`_`) は言語設計の中核をなす概念であり、数学的に一貫した特性を持ちます。本ドキュメントでは、Unitを含む演算の振る舞いを定義し、論理的一貫性と実用性を両立させる方法を示します。

## 2. Unitの基本性質

- **値としての性質**: `_ = []` (空リストと等価)
- **左単位元**: `_ X = X` (Unitを左から適用すると引数がそのまま返る)
- **関数単位元**: `F _ = F` (算術と論理の範疇ではUnitを引数として渡すと関数自体が返る)
- **二重性**: 値であると同時に関数でもある
- **論理評価**: `_` はfalseと評価される
- **アドレス**: `$_`…つまり`_`のアドレス値は`0x0`…つまり`0`である
- **Input**: `@_ = _`である。これは吸収元の挙動である
- **Output**: `$_ # X`は、/dev/null へのファイルの移動のようなイメージ


## 3. 論理演算子とUnitの相互作用

論理演算子は短絡評価を基本とし、Unitとの相互作用は次のように定義されます：

### 3.1 論理積 (`&`)

```
_ & X → _  // Unitが左辺ならUnit（短絡評価）
X & _ → _  // Unitが右辺ならUnit（右辺まで評価）
true値 & X → X  // 左辺がtrueなら右辺の値を返す
```

### 3.2 論理和 (`|`)

```
_ | X → X  // Unitが左辺なら右辺を評価
X | _ → X  // 左辺がtrueなら左辺を返す（短絡評価）
false値 | X → X  // 左辺がfalseなら右辺を評価
```

### 3.3 排他的論理和 (`;`)

```
_ ; X → X  // Unitとの排他的論理和は常に相手の値
X ; _ → X  // Unitとの排他的論理和は常に相手の値
```

### 3.4 否定 (`!`)

```
!_  // Unitの否定は真（ただし、Unitと未評価のラムダ以外は真とする）
```

## 4. その他の演算子とUnitの相互作用

Unit以外の演算子との相互作用では、「解なし」または部分適用されたラムダ式を返します：

### 4.1 算術演算子 (`+`, `-`, `*`, `/`, `%`, `^`)

```
_ + X → [y ? y + X]  // 「Unitが置き換わったら+Xする」というラムダを返す
X + _ → [y ? X + y]  // 「Unitが置き換わったらX+する」というラムダを返す
```

同様に：
```
_ - X → [y ? y - X]
X - _ → [y ? X - y]
_ * X → [y ? y * X]
X * _ → [y ? X * y]
_ / X → [y ? y / X]
X / _ → [y ? X / y]
_ % X → [y ? y % X]
X % _ → [y ? X % y]
_ ^ X → [y ? y ^ X]
X ^ _ → [y ? X ^ y]
```

### 4.2 比較演算子 (`<`, `<=`, `=`, `>=`, `>`, `!=`)

```
_ < X → [y ? y < X]  // 「Unitが置き換わったら<Xと比較する」というラムダを返す
X < _ → [y ? X < y]  // 「Unitが置き換わったらX<と比較する」というラムダを返す
```

同様に：
```
_ <= X → [y ? y <= X]
X <= _ → [y ? X <= y]
_ = X → [y ? y = X]
X = _ → [y ? X = y]
_ >= X → [y ? y >= X]
X >= _ → [y ? X >= y]
_ > X → [y ? y > X]
X > _ → [y ? X > y]
_ != X → [y ? y != X]
X != _ → [y ? X != y]
```

### 4.3 関数適用（空白演算子）

```
_ X → X  // Unitは左単位元として挙動
F _ → F  // 関数にUnitを適用すると関数自体が返る
```

### 4.4 定義演算子 (`:`)

```
_ : X → X  // 定義演算子の左辺がUnitの場合、右辺をそのまま返す
X : _ → X  // 定義演算子の右辺がUnitの場合、左辺をそのまま返す
```

## 5. 具体的な例と応用

### 5.1 Unitを用いた条件分岐

```
isPositive : x ?
    x > 0 & x    // xが正ならxを返し、そうでなければUnitを返す

// 使用例
result : isPositive -5 | `負またはゼロ`  // 「負またはゼロ」が返る
result : isPositive 10 | `負またはゼロ`  // 10が返る
```

### 5.2 Unitを用いた部分適用

```
add : x y ? x + y
addSomething : add _  // yに何かが入るまで待機するラムダ

// 使用例
addFive : addSomething 5  // 結果は「5を加える」関数
addFive 3  // 結果は8
```

## 6. 設計原則

Sign言語のUnit演算設計は以下の原則に基づいています：

1. **一貫性**: Unitは「まだ値がない」または「無効な値」を表現する一貫した方法
2. **自然な短絡評価**: 論理演算では意味的に正しい短絡評価を提供
3. **部分適用の拡張**: 算術演算子や比較演算子でもラムダを返すことで部分適用のメカニズムを拡張
4. **エラー回避**: 実行時エラーを発生させるよりも、Unitやラムダを返すことで柔軟なプログラミングを可能に

## 7. 未評価ラムダの扱い

未評価のラムダについては、論理評価のコンテキストでのみ以下の規則を適用します：

1. **論理コンテキストでの評価**:
   - 未実行のラムダ項はfalseとして評価
   - それ以外のコンテキストでは通常のラムダとして扱われる

2. **関数の存在確認**:
   - 関数の存在確認には`$`演算子を使用
   ```
   $func & `存在します` | `存在しません`
   ```

3. **型チェック**:
   - 関数型の確認には型チェックを使用
   ```
   "f" = "?" & `関数です` | `関数ではありません`
   ```

この設計により、Sign言語は「見えない強い型付け」の原則を保ちながら、Unitを含む演算に対して一貫した挙動を提供します
