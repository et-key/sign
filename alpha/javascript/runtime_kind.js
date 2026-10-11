/**
 * **実行時の種類**（RTTI の裁定 2026-09-27）。
 *
 * 「動的な側は RTTI に頼り、静的な側は動的な側が付けた型を信じて RTTI なしで走る」。解釈器が値の種類を知る
 * 窓口をここ1か所に置く——判断のコードに新しい `typeof` や `=== UNIT` を書かず、ここの関数を通す。値の表し方を
 * 後で替えるとき（箱を足す・タグ付きの直和にする）、書き換えるのがこのファイルだけで済むようにである。
 * interpreter.js にはまだ JS の型を直に見る判断が多く残っていて、箱を1つ入れるたびにここへ寄せていく。
 *
 * **いまは値の JS の姿から読めるだけを答える**（`kindOf`）。JS の値で区別できない種類がまだ1組ある:
 *
 *   `Num`   JS の数（`number` / `bigint`）。`Int` `Address` `Float` のどれか——`0x10` も `16` も同じ 16、
 *           `16.0` も 16 である。
 *
 * 箱（`Address` `Float` と、域ごとの `__`）はこの組を割るために入る。それまで `kindOf` は分からない
 * ことを分かったと言わない（原理4）。**ほかの名前は pass3 の型の名前と同じにしてある**——layout.js の
 * `arithDomain` を、解釈器が同じ鍵で引けるように（表は1つ、読む側は3つ）。
 *
 * **文字は箱である**（R6、下の `chr`）。以前は `Char` も長さ1の `String` も符号位置1つの JS の文字列で、`\a` と
 * `` `a` `` を値で割れなかった（`Chr1`）——解釈器は pass3 の型（`node.atomType`）を借りて割っていた。いまは文字が
 * 箱、文字列は長さによらず JS の文字列なので、値だけで割れる。
 *
 * このファイルは何も import しない。interpreter.js と試験のハーネスが引き、コンパイラの段は引かない。
 */

// Unit（__）の実行時における一意な番人（sentinel）。Symbolなので他のどんな値とも衝突しない。
const UNIT = Symbol("Sign.Unit");

// unit.md 103行目「`__ = []`（空リストと等価）」: 空配列はUnitと同型として扱う。
// これが無いと、`[h ~t]`型の再帰でリストを完全に消費し尽くした終端（restが正しく[]に
// なった状態）が`!placed`/`placed & ...`のようなUnit判定で検出できず、範囲外アクセスが
// 静かにUNITへ吸収されたまま再帰が終端しないまま数値の偶然の一致に頼って停止する、
// といった見た目上は動くが誤った挙動を招く（8-Queens監査で発見、2026-08-08）。
// string_and_comment.md §1「空文字列は`__`（Unit）と同型」: 同じ理屈をStringドメインにも
// 適用する——空文字列は文字列連結の単位元（`"" + s = s`）であり、空リストが余積の単位元
// であるのと同じ位置づけ。
function isUnit(v) {
  return v === UNIT || v === undefined || (Array.isArray(v) && v.length === 0) || v === "";
}

// `!__` が返す Id射（categorical_truth.md §6、guide/operator_table.md 141行目）。
// SKIのKコンビネータ（λx.λy.x、引数をそのまま返す恒等射）がSignにおける「真」であり、
// `__`（K*、引数を吸収する void 関数）が「偽」である。
// 【重要】ここで `1` や `true` のような具体的な値を返してはいけない——それは Boolean 型を
// 暗黙に再導入することであり、「Signに真偽値型は存在しない」という設計原則と矛盾する
// （categorical_truth.md の IMPORTANT ブロックが明示的に禁じている）。返すのは
// 「Unitでない何か」＝副作用を持たないことが静的に確定している恒等射そのもの。
// 未評価のラムダはUnitと同型（副作用の可能性があり評価予定が確定しない）だが、この
// Id射だけはその例外——純粋な恒等関数なので評価予定が静的に確定し、非Unitとして扱える。
const IDENTITY = { __lambda__: true, __identity__: true };

/**
 * **恒等射（`!__`）か。** `__` の「射としての顔」である（unit.md §2.1）。
 *
 * 零対象は初対象と終対象が一致した対象なので、`__` と `!__` は同じものを対象として見るか
 * 射として見るかの違いでしかなく、`!` はその視点を入れ替える対合である（`!!__` は `__`）。
 *
 * **だから演算子の片側に置いたとき、返るものも顔で決まる。** 対象を置けば値が返り
 * （`__ + x = x`、単位元）、射を置けば射が返る（`!__ + x = [+ x]`、穴の開いた演算）。
 * 置いた位置がそのまま穴の位置になるので、`!__ - 1` は `[- 1]`、`1 - !__` は `[1 -]` で、
 * 非可換な演算子でも向きが保たれる。
 */
function isIdentityMorphism(v) {
  return !!(v && typeof v === "object" && v.__identity__);
}

function isIterator(v) {
  return !!(v && typeof v === "object" && v.__iterator__);
}

/**
 * **文字の箱**（RTTI の計画 R6、裁定 2026-09-27「動的な側は RTTI に頼る」）。`Char` の値は符号位置1つを持つ箱で、
 * 長さ1の `String` は JS の文字列のまま——`\a` と `` `a` `` が値で割れる。箱は符号位置ごとに1つだけ作って使い回す
 * （同じ文字は同じ物なので、比べるのは `===` で足り、作るのも ASCII なら表を引くだけ）。凍らせてあるので、誰かが
 * 中身を書き換えて別の文字に化けることも無い。`s` は同じ文字の1文字の文字列（連結・鍵・観測へ渡すときの姿）。
 *
 * 文字列の要素は文字である（`String ≅ List(Char)`）——添字・分解の頭・撒いた要素・写した要素は箱で、範囲で
 * 切った残りや繋いだ物は文字列に戻る。U+0000 は文字の値域から外した niche で `__` そのものなので、箱にしない
 * （`evalLiteral` の `0u0000`）。
 */
const ASCII_CHARS = [];
const OTHER_CHARS = new Map();
function makeChar(cp) {
  return Object.freeze({ __char__: true, cp, s: String.fromCodePoint(cp) });
}
for (let cp = 0; cp < 128; cp++) ASCII_CHARS.push(makeChar(cp));
/** 符号位置 `cp` の文字（箱）。 */
function chr(cp) {
  if (cp < 128 && cp >= 0) return ASCII_CHARS[cp];
  let c = OTHER_CHARS.get(cp);
  if (c === undefined) {
    c = makeChar(cp);
    OTHER_CHARS.set(cp, c);
  }
  return c;
}
/** 1文字の JS 文字列（符号位置1つ）の先頭の文字（箱）。 */
function chrOf(s) {
  return chr(s.codePointAt(0));
}
/** 文字（箱）か。 */
function isChr(v) {
  return v !== null && typeof v === "object" && v.__char__ === true;
}
/** 文字か文字列か（並べると文字列になるもの）。 */
function isText(v) {
  return typeof v === "string" || isChr(v);
}
/** 文字は1文字の文字列へ、それ以外はそのまま（連結・鍵・観測の姿）。 */
function textOf(v) {
  return isChr(v) ? v.s : v;
}

// 名前付きスロット（プレーンオブジェクト）か。List・String・スカラーと区別する。
function isNamedSlots(v) {
  // イテレータもプレーンオブジェクトなので明示的に除く——`{start, step, end}` の
  // フィールドは**規則の内訳**であって名前付きスロットではない。文字の箱も同じ（`cp` は鍵ではない）。
  return v !== null && typeof v === "object" && !Array.isArray(v) && !v.__lambda__ && !v.__address__ && !v.__iterator__ && !v.__char__;
}

/**
 * **値の実行時の種類**（頭の注記）。答えは pass3 の型の名前か、まだ割れていない1組（`Num`）で、
 * 読めない値には `null` を返す（JS の `null` や真偽値は Sign の値として出てこない）。文字の箱は `Char`、JS の
 * 文字列は長さによらず `String` である。
 *
 * **域を答え、その域の `__` かどうかは答えない。** 空の文字列は `String` の `__`、空の配列は `List` の `__` で、
 * どちらも `isUnit` が真である——`kindOf` はその域（`String` / `List`）を返す。域の無い `__`（`UNIT`・
 * `undefined`）だけが `Unit` である。
 *
 * `$` の参照セルは `Address`（pass3 が `$x` に付ける型）、恒等射 `!__` は `Identity`（pass3 の `IDENTITY`）、
 * 閉包・合成・部分適用・点なし・組み込み関数は `Lambda`（Layer 1）、規則と撒いた並びは `Iterator` である。
 */
function kindOf(v) {
  if (v === UNIT || v === undefined) return "Unit";
  if (typeof v === "number" || typeof v === "bigint") return "Num";
  if (typeof v === "string") return "String";
  if (Array.isArray(v)) return "List";
  if (typeof v === "function") return "Lambda";
  if (isIdentityMorphism(v)) return "Identity";
  if (v && typeof v === "object") {
    if (v.__char__ === true) return "Char";
    if (v.__lambda__) return "Lambda";
    if (isIterator(v)) return "Iterator";
    if (v.__address__) return "Address";
    if (isNamedSlots(v)) return "Struct";
  }
  return null;
}

export { UNIT, isUnit, IDENTITY, isIdentityMorphism, isIterator, isNamedSlots, kindOf, chr, chrOf, isChr, isText, textOf };
