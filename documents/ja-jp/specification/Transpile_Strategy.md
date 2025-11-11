# Sign言語 JavaScript トランスパイル戦略

## 1. 概要

Sign言語からJavaScriptへの変換は、ASTを経由せず**段階的なテキスト置換**によって実現されます。この手法は「Zero Cost Domain Abstraction」の具体的な実装例であり、理論的美しさと実装効率を両立します。

### 1.1 基本方針

- **段階的変換**: Sign記法 → 中間Sign記法 → JavaScript
- **テキストベース**: 正規表現とパターンマッチングによる置換
- **保護戦略**: 文字列・文字リテラルを事前に保護
- **順序制御**: 優先順位の高い構文から順に処理

### 1.2 変換の利点

| 特徴 | 説明 |
|------|------|
| 実装の単純さ | 複雑なASTパーサー不要 |
| デバッグの容易さ | 各段階の出力を直接確認可能 |
| 拡張性 | 新しい変換ルールを追加しやすい |
| プロトタイピング | 即座に動作確認が可能 |

## 2. 変換プロセスの全体像

```
Sign源コード
  ↓
[1] 前処理（Lexer処理）
  ↓
[2] リテラル保護
  ↓
[3] ブロック構造変換
  ↓
[4] match_case検出と変換
  ↓
[5] 演算子変換
  ↓
[6] 関数定義変換
  ↓
[7] リスト操作変換
  ↓
[8] 特殊構文変換
  ↓
[9] 識別子変換
  ↓
[10] 最終整形
  ↓
JavaScript コード
```

## 3. 基本変換テーブル

### 3.1 リテラルの変換

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `42` | `42` | 数値はそのまま |
| `-3.14` | `-3.14` | 浮動小数点も同様 |
| `0xAF` | `0xAF` | 16進数はそのまま |
| `0o77` | `0o77` | 8進数（ES6以降） |
| `0b1010` | `0b1010` | 2進数（ES6以降） |
| `` `文字列` `` | `"文字列"` | バッククォートをダブルクォートに |
| `\n` | `"\\n"` | 文字を文字列に変換 |
| `_` | `undefined` | Unit を undefined に |

### 3.2 算術演算子

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `x + y` | `x + y` | そのまま |
| `x - y` | `x - y` | そのまま |
| `x * y` | `x * y` | そのまま |
| `x / y` | `x / y` | そのまま |
| `x % y` | `x % y` | そのまま |
| `x ^ y` | `Math.pow(x, y)` | 累乗は関数呼び出しに |
| `x!` | `factorial(x)` | 階乗は関数呼び出しに |
| `\|x\|` | `Math.abs(x)` | 絶対値は関数呼び出しに |

### 3.3 比較演算子

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `x < y` | `(x < y ? x : undefined)` | 値返却型に変換 |
| `x <= y` | `(x <= y ? x : undefined)` | 値返却型に変換 |
| `x = y` | `(x === y ? x : undefined)` | 等価比較は === |
| `x == y` | `(x === y ? x : undefined)` | 同上 |
| `x >= y` | `(x >= y ? x : undefined)` | 値返却型に変換 |
| `x > y` | `(x > y ? x : undefined)` | 値返却型に変換 |
| `x != y` | `(x !== y ? x : undefined)` | 不等価は !== |

### 3.4 論理演算子

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `x & y` | `(x && y)` | 短絡評価そのまま |
| `x \| y` | `(x \|\| y)` | 短絡評価そのまま |
| `x ; y` | `((x \|\| y) && !(x && y))` | XORは式で表現 |
| `!x` | `(!x)` | そのまま |

### 3.5 関数定義

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `x ? x + 1` | `x => x + 1` | アロー関数に |
| `x y ? x + y` | `x => y => x + y` | カリー化 |
| `[+ 1]` | `x => x + 1` | 部分適用 |
| `[+]` | `x => y => x + y` | 演算子の関数化 |

### 3.6 条件分岐（match_case）

| Sign記法 | JavaScript | 備考 |
|----------|-----------|------|
| `x ?<br>  cond1 : val1<br>  cond2 : val2` | `x => {<br>  switch (true) {<br>    case cond1: return val1;<br>    case cond2: return val2;<br>  }<br>}` | ブロック内の条件分岐 |
| `x ?<br>  cond : val<br>  default` | `x => {<br>  switch (true) {<br>    case cond: return val;<br>    default: return default;<br>  }<br>}` | デフォルト値あり |

## 4. 段階的変換の詳細

### 4.1 [1] 前処理（Lexer処理）

既存のlexer.jsで処理済み：
- 制御文字の除去
- 改行の正規化
- コメントの除去
- 単項演算子のマーキング
- ブロック構造のマーキング

### 4.2 [2] リテラル保護

文字列と文字を一時的なプレースホルダーに置換：

```javascript
// 文字列の保護
const strings = [];
code = code.replace(/`([^`]*)`/g, (match, content) => {
  strings.push(content);
  return `__STRING_${strings.length - 1}__`;
});

// 文字の保護
const chars = [];
code = code.replace(/\\(.)/g, (match, char) => {
  chars.push(char);
  return `__CHAR_${chars.length - 1}__`;
});
```

### 4.3 [3] ブロック構造変換

#### インデントブロック → 波括弧

```javascript
// タブインデント検出（lexerで既にマーク済み）
code = code.replace(/\x1D(.+?)\x1D/g, '{ $1 }');
```

#### カッコの統一

```javascript
// 全てのカッコを丸カッコに統一（lexerで既に処理済み）
// [, {, ( → (
// ], }, ) → )
```

### 4.4 [4] match_case検出と変換

#### match_case構文の検出

関数定義のブロック内に `条件 : 返値` パターンが存在する場合、それをswitch文に変換：

```javascript
// パターン検出
const matchCasePattern = /(\w+(?:\s+\w+)*)\s*\?\s*\{([^}]+)\}/g;

function convertMatchCase(code) {
  return code.replace(matchCasePattern, (match, params, body) => {
    // ブロック内の各行を解析
    const lines = body.trim().split('\n').map(l => l.trim()).filter(l => l);
    
    // 条件分岐行（: を含む）と通常の式を分離
    const cases = [];
    let defaultCase = null;
    
    lines.forEach(line => {
      if (line.includes(':')) {
        // 条件 : 返値 のパターン
        const [condition, returnValue] = line.split(':').map(s => s.trim());
        cases.push({ condition, returnValue });
      } else {
        // : がない行はデフォルトケース
        defaultCase = line;
      }
    });
    
    // switch文の構築
    const paramList = params.split(/\s+/);
    const arrowFn = paramList.join(' => ');
    
    let switchBody = '  switch (true) {\n';
    cases.forEach(c => {
      switchBody += `    case ${c.condition}: return ${c.returnValue};\n`;
    });
    if (defaultCase) {
      switchBody += `    default: return ${defaultCase};\n`;
    }
    switchBody += '  }';
    
    return `${arrowFn} => {\n${switchBody}\n}`;
  });
}
```

#### 変換例

**入力:**
```sign
classify : x ?
  x < 0 : `negative`
  x = 0 : `zero`
  x > 0 : `positive`
```

**出力:**
```javascript
const classify = x => {
  switch (true) {
    case x < 0: return "negative";
    case x === 0: return "zero";
    case x > 0: return "positive";
  }
}
```

#### 複数引数の場合

**入力:**
```sign
mySc : x y ?
  x < 0 : x * -1
  x = 0 : y
  x > 0 : x
```

**出力:**
```javascript
const mySc = x => y => {
  switch (true) {
    case x < 0: return x * -1;
    case x === 0: return y;
    case x > 0: return x;
  }
}
```

#### デフォルトケース付き

**入力:**
```sign
grade : score ?
  score >= 90 : `A`
  score >= 80 : `B`
  score >= 70 : `C`
  score >= 60 : `D`
  `F`
```

**出力:**
```javascript
const grade = score => {
  switch (true) {
    case score >= 90: return "A";
    case score >= 80: return "B";
    case score >= 70: return "C";
    case score >= 60: return "D";
    default: return "F";
  }
}
```

### 4.5 [5] 演算子変換

#### 累乗演算子

```javascript
code = code.replace(/(\w+)\s*\^\s*(\w+)/g, 'Math.pow($1, $2)');
```

#### 階乗演算子

```javascript
code = code.replace(/(\w+)!/g, 'factorial($1)');
```

#### 絶対値

```javascript
code = code.replace(/\|([^|]+)\|/g, 'Math.abs($1)');
```

#### 比較演算子（値返却型）

```javascript
// x < y → (x < y ? x : undefined)
code = code.replace(/(\w+)\s*<\s*(\w+)/g, '($1 < $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*<=\s*(\w+)/g, '($1 <= $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*=\s*(\w+)/g, '($1 === $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*>=\s*(\w+)/g, '($1 >= $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*>\s*(\w+)/g, '($1 > $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*!=\s*(\w+)/g, '($1 !== $2 ? $1 : undefined)');
```

#### XOR演算子

```javascript
code = code.replace(/(\w+)\s*;\s*(\w+)/g, '(($1 || $2) && !($1 && $2))');
```

### 4.6 [6] 関数定義変換

#### ラムダ式の基本変換

```javascript
// x ? x + 1 → x => x + 1
code = code.replace(/(\w+)\s*\?\s*(.+)/g, '$1 => $2');

// x y ? x + y → x => y => x + y (カリー化)
code = code.replace(/(\w+)\s+(\w+)\s*\?\s*(.+)/g, '$1 => $2 => $3');

// x y z ? ... → x => y => z => ... (複数引数)
code = code.replace(/(\w+(?:\s+\w+)*)\s*\?\s*(.+)/g, (match, params, body) => {
  const paramList = params.split(/\s+/);
  return paramList.reduceRight((acc, p) => `${p} => ${acc}`, body);
});
```

#### 連続引数リスト（~前置）

```javascript
// ~rest ? ... → ...rest (ES6スプレッド構文)
code = code.replace(/~(\w+)\s*\?/g, '...$1 =>');
```

#### ポイントフリー記法

```javascript
// [+ 1] → x => x + 1
code = code.replace(/\[\s*\+\s*(\w+)\s*\]/g, 'x => x + $1');

// [* 2] → x => x * 2
code = code.replace(/\[\s*\*\s*(\w+)\s*\]/g, 'x => x * $1');

// [+] → (x, y) => x + y
code = code.replace(/\[\s*\+\s*\]/g, '(x, y) => x + y');
code = code.replace(/\[\s*\*\s*\]/g, '(x, y) => x * y');
```

### 4.7 [7] リスト操作変換

#### リスト構築

```javascript
// 1, 2, 3 → [1, 2, 3]
code = code.replace(/(\w+)\s*,\s*(\w+)/g, '[$1, $2]');

// 既存リストへの追加統合
code = code.replace(/\[([^\]]+)\]\s*,\s*(\w+)/g, '[$1, $2]');
code = code.replace(/(\w+)\s*,\s*\[([^\]]+)\]/g, '[$1, $2]');
```

#### リスト結合（余積）

```javascript
// [1, 2] [3, 4] → [1, 2].concat([3, 4])
code = code.replace(/\[([^\]]+)\]\s+\[([^\]]+)\]/g, '[$1].concat([$2])');
```

#### 範囲リスト

```javascript
// [1 ~ 5] → range(1, 5) (ヘルパー関数)
code = code.replace(/\[\s*(\w+)\s*~\s*(\w+)\s*\]/g, 'range($1, $2)');
```

#### MAP演算

```javascript
// [* 2,] list → list.map(x => x * 2)
code = code.replace(/\[\s*\*\s*(\w+)\s*,\s*\]\s*(\w+)/g, '$2.map(x => x * $1)');
code = code.replace(/\[\s*\+\s*(\w+)\s*,\s*\]\s*(\w+)/g, '$2.map(x => x + $1)');
```

#### FOLD演算

```javascript
// [+] list → list.reduce((acc, x) => acc + x)
code = code.replace(/\[\s*\+\s*\]\s*(\w+)/g, '$1.reduce((acc, x) => acc + x)');
code = code.replace(/\[\s*\*\s*\]\s*(\w+)/g, '$1.reduce((acc, x) => acc * x)');
```

#### 展開（~後置）

```javascript
// list~ → ...list (スプレッド構文)
code = code.replace(/(\w+)~/g, '...$1');
```

### 4.8 [8] 特殊構文変換

#### 定義演算子（:）

```javascript
// x : 42 → const x = 42
code = code.replace(/(\w+)\s*:\s*(.+)/g, 'const $1 = $2');

// 関数定義の場合は特別処理
// f : x ? x + 1 → const f = x => x + 1
// (既に ? が変換済みと仮定)
```

#### Export演算子（#前置）

```javascript
// #x : 42 → export const x = 42
code = code.replace(/#(\w+)\s*:\s*(.+)/g, 'export const $1 = $2');
```

#### Get演算子（'中置）

```javascript
// obj ' key → obj.key または obj[key]
code = code.replace(/(\w+)\s*'\s*(\w+)/g, '$1.$2');
code = code.replace(/(\w+)\s*'\s*(\d+)/g, '$1[$2]');
code = code.replace(/(\w+)\s*'\s*__STRING_(\d+)__/g, '$1[__STRING_$2__]');
```

#### Get演算子（@中置）

```javascript
// key @ obj → obj.key または obj[key]
code = code.replace(/(\w+)\s*@\s*(\w+)/g, '$2.$1');
code = code.replace(/(\d+)\s*@\s*(\w+)/g, '$2[$1]');
```

#### アドレス取得（$前置）

```javascript
// $x → (() => x) (クロージャでシミュレート)
code = code.replace(/\$(\w+)/g, '(() => $1)');
```

#### Input演算子（@前置）

```javascript
// @address → readMemory(address) (ヘルパー関数)
code = code.replace(/@(0x[0-9A-Fa-f]+)/g, 'readMemory($1)');
code = code.replace(/@(\w+)/g, 'readMemory($1)');
```

#### Output演算子（#中置）

```javascript
// address # data → writeMemory(address, data)
code = code.replace(/(0x[0-9A-Fa-f]+)\s*#\s*(\w+)/g, 'writeMemory($1, $2)');
code = code.replace(/(\w+)\s*#\s*(\w+)/g, 'writeMemory($1, $2)');
```

#### Import演算子（@後置）

```javascript
// module@ → require('module') または import
code = code.replace(/(\w+)@/g, "require('$1')");
```

### 4.9 [9] 識別子変換

#### Unit（_）の変換

```javascript
// _ → undefined
code = code.replace(/\b_\b/g, 'undefined');
```

#### 予約語の回避

JavaScriptの予約語と衝突する場合：

```javascript
const jsReserved = ['class', 'const', 'let', 'var', 'function', 'return', 'if', 'else', 'for', 'while'];
jsReserved.forEach(word => {
  code = code.replace(new RegExp(`\\b${word}\\b`, 'g'), `${word}_`);
});
```

### 4.10 [10] 最終整形

#### リテラルの復元

```javascript
// 文字列の復元
code = code.replace(/__STRING_(\d+)__/g, (match, index) => {
  return `"${strings[index]}"`;
});

// 文字の復元
code = code.replace(/__CHAR_(\d+)__/g, (match, index) => {
  return `"${chars[index]}"`;
});
```

#### フォーマット整形

```javascript
// セミコロンの挿入
code = code.replace(/\n/g, ';\n');

// インデントの整形
code = formatIndentation(code);
```

## 5. ヘルパー関数の実装

トランスパイル後のコードで必要となるヘルパー関数：

### 5.1 範囲生成

```javascript
function range(start, end, step = 1) {
  const result = [];
  if (step > 0) {
    for (let i = start; i <= end; i += step) {
      result.push(i);
    }
  } else {
    for (let i = start; i >= end; i += step) {
      result.push(i);
    }
  }
  return result;
}
```

### 5.2 階乗

```javascript
function factorial(n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}
```

### 5.3 メモリアクセス（シミュレーション）

```javascript
const memory = new Map();

function readMemory(address) {
  return memory.get(address);
}

function writeMemory(address, data) {
  memory.set(address, data);
  return address;
}
```

## 6. 変換例

### 6.1 基本的な算術

**Sign:**
```sign
x : 10
y : 20
result : x + y * 2
```

**JavaScript:**
```javascript
const x = 10;
const y = 20;
const result = x + y * 2;
```

### 6.2 関数定義と適用

**Sign:**
```sign
add : x y ? x + y
result : add 3 5
```

**JavaScript:**
```javascript
const add = x => y => x + y;
const result = add(3)(5);
```

### 6.3 リスト操作

**Sign:**
```sign
numbers : 1, 2, 3, 4, 5
doubled : [* 2,] numbers
sum : [+] doubled
```

**JavaScript:**
```javascript
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(x => x * 2);
const sum = doubled.reduce((acc, x) => acc + x);
```

### 6.4 条件分岐（match_case）

**Sign:**
```sign
classify : x ?
  x < 0 : `negative`
  x = 0 : `zero`
  x > 0 : `positive`
```

**JavaScript:**
```javascript
const classify = x => {
  switch (true) {
    case x < 0: return "negative";
    case x === 0: return "zero";
    case x > 0: return "positive";
  }
};
```

**Sign（複数引数）:**
```sign
mySc : x y ?
  x < 0 : x * -1
  x = 0 : y
  x > 0 : x
```

**JavaScript:**
```javascript
const mySc = x => y => {
  switch (true) {
    case x < 0: return x * -1;
    case x === 0: return y;
    case x > 0: return x;
  }
};
```

**Sign（デフォルトケース）:**
```sign
grade : score ?
  score >= 90 : `A`
  score >= 80 : `B`
  score >= 70 : `C`
  score >= 60 : `D`
  `F`
```

**JavaScript:**
```javascript
const grade = score => {
  switch (true) {
    case score >= 90: return "A";
    case score >= 80: return "B";
    case score >= 70: return "C";
    case score >= 60: return "D";
    default: return "F";
  }
};
```

### 6.6 高階関数

**Sign:**
```sign
map : f x ~y ? @f x, map f y~
result : map $[* 2] 1 2 3 4
```

**JavaScript:**
```javascript
const map = f => x => (...y) => {
  return [f()(x), ...map(f)(...y)];
};
const result = map(() => x => x * 2)(1, 2, 3, 4);
```

## 7. 制限事項と回避策

### 7.1 現状の制限

| 制限 | 理由 | 回避策 |
|------|------|--------|
| 完全な型推論なし | JavaScriptの動的型付け | TypeScriptへ変換する別ルート |
| メモリ直接操作不可 | JavaScript仕様 | シミュレーション層を挟む |
| 真の末尾再帰最適化なし | JS実装依存 | トランポリン変換を追加 |
| マルチスレッド限定的 | Worker APIのみ | 別戦略が必要 |

### 7.2 最適化の余地

1. **インライン展開**: 単純な関数呼び出しを直接展開
2. **定数畳み込み**: コンパイル時計算可能な式を事前評価
3. **デッドコード削除**: 未使用の定義を除去
4. **ループ展開**: 固定回数ループを展開

## 8. 実装ロードマップ

### Phase 1: 基本変換（現在）
- ✅ Lexer実装済み
- ✅ リテラル変換
- ✅ 基本演算子変換
- ✅ match_case変換（switch文）
- 🔄 関数定義変換（進行中）

### Phase 2: 高度な機能
- ⏳ リスト操作の完全サポート
- ⏳ 高階関数の最適化
- ⏳ パターンマッチング変換

### Phase 3: 最適化
- ⏳ インライン展開
- ⏳ 定数畳み込み
- ⏳ デッドコード削除

### Phase 4: 拡張
- ⏳ TypeScript出力サポート
- ⏳ SourceMap生成
- ⏳ エラーメッセージの改善

## 9. テスト戦略

### 9.1 ユニットテスト

各変換ルールに対して：
```javascript
describe('算術演算子変換', () => {
  it('累乗を Math.pow に変換', () => {
    const input = 'x ^ 2';
    const output = transpile(input);
    expect(output).toBe('Math.pow(x, 2)');
  });
});
```

### 9.2 統合テスト

実際のSignコードを完全に変換：
```javascript
describe('完全な関数定義', () => {
  it('カリー化された関数を正しく変換', () => {
    const input = 'add : x y ? x + y';
    const output = transpile(input);
    expect(output).toBe('const add = x => y => x + y;');
  });
});
```

### 9.3 実行テスト

変換後のコードを実際に実行：
```javascript
describe('実行結果の検証', () => {
  it('変換後のコードが正しく動作', () => {
    const signCode = 'add : x y ? x + y\nresult : add 3 5';
    const jsCode = transpile(signCode);
    const result = eval(jsCode);
    expect(result).toBe(8);
  });
});
```

## 10. まとめ

### 10.1 この手法の強み

1. **実装の単純さ**: ASTパーサー不要で迅速な開発
2. **デバッグの容易さ**: 各段階を可視化可能
3. **拡張性**: 新ルール追加が容易
4. **プロトタイピング**: 即座に動作確認

### 10.2 将来の展望

- **ネイティブコンパイラ**: C/AArch64への直接変換
- **LLVM IR**: より高度な最適化
- **自己ホスティング**: Sign言語でSign言語を実装
- **複数ターゲット**: WebAssembly, FPGA等

### 10.3 設計哲学の実現

このトランスパイル戦略は、Sign言語の核心的な設計哲学を体現しています：

- **Zero Cost Domain Abstraction**: 理論的美しさと実装効率の両立
- **構文=型**: テキスト変換だけで型安全性を保証
- **段階的変換**: Sign → Sign → ターゲット言語
- **見えない強さ**: 複雑な変換をプログラマから隠蔽

このJavaScriptトランスパイル実装は、Sign言語の実用性を証明する最初のステップであり、将来のより高度な実装への橋渡しとなります。