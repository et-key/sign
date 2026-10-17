# alpha1

alpha を作り直すための、2本目の実装である。利用者の決定（2026-10-17）：

- `__` を言語から追放し、単位は `_` だけで書く。
- alpha の JavaScript のうち、演算子の表と、前処理・lexer・構文は役に立つので持ってくる。
  その先の意味解析に入る前に、利用者に確かめる。

## 今あるもの

`javascript/` の下：

| ファイル | 中身 |
|---|---|
| `lexer.js` | 前処理（`separateInfix`・`classifyNewlines`・`preprocess`）。alpha から変更なし |
| `sign.pegjs` | 構文。単位は `_` だけで、`__` はただの識別子 |
| `operator_table.js` | 演算子の表のうち、構文が使う欄だけ（段・位置・名前・結合の向き・廃止の印） |
| `errors.js` | 前処理が使う `OperationError` だけ |
| `test/` | `parser.test.js`、`comment_discriminator.test.js`、`editor_char.test.js` |

## alpha（c3b203fc）との違い

- **文法**：`unit = "_"`。alpha は `unit = "__" / "\x00"` と `hole = "_"` の2つだった。
  - `_` は字面を1つの形（`"_"`）で返す。穴になるかどうかは書いた位置で決まり、それは意味解析が見る。
  - `__` は識別子（`<__>`）として読む。
  - 単位の2つ目の綴り `\x00` も外した。alpha の `.js` を探した範囲では、これを作る側はどこにも無く、
    ソースに生の NUL を書くと黙って単位に読む穴になっていた。alpha1 では構文エラーになる。
- **演算子の表**：命令の綴り（`asm` 欄）と、`NOT_YET`・`NOT_AN_INSTRUCTION` の名簿は持ってこなかった。
  どれも機械の側の話で、意味解析より後で要る。構文の欄は alpha の表と 56 行とも同じである。
- **文書との食い違い**：`documents/{ja-jp,en-us}/impl/syntax/grammar.pegjs` はまだ `__` を単位に持っている。
  演算子表・穴の脱糖・match_case の文書にも `__` が残っている。

## まだ無いもの

意味解析（識別子の表・余積の解決・型・解釈器）、機械（pass4）、自己ホストの `.sn`。

## 試験

```bash
cd alpha1/javascript && npm test
```
