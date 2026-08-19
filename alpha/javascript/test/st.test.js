/**
 * SignType（`.st` / `.ist`）生成の動作確認（type_system.md §6）。
 *
 * 型は「宣言」されるものではなく「コードから読み取って書き写す」だけの存在であり（§1）、
 * `.st` はその書き写しである。同時にこれは**型システムに対する最初の観測手段**でもある
 * ——消費者が居ないうちは、間違った型も欠けた型も観測されないままになる。
 *
 * ここで固定するのは**仕様が要求する形**だけである。実装がまだ仕様へ届いていない部分は
 * 何も表明しない（下の「返値型について」を参照）。壊れている挙動を期待値に書くと、
 * それが正しい仕様であるかのように見えてしまうためである。
 *
 * 実行: node test/st.test.js（`npm test` からも呼ばれる）
 */
import { compile } from "../compile.js";
import { generateSignType } from "../st.js";

let passed = 0;
let total = 0;

// 生成結果からコメント行と空行を除いた本文だけを取り出す。
function entries(source, scope = "ist") {
	const { nodes, env } = compile(source);
	const r = generateSignType(nodes, env, { scope });
	return r.text
		.split("\n")
		.filter((l) => l && !l.startsWith("`"))
		.map((l) => l.trim());
}

function check(note, got, want) {
	total++;
	const ok = JSON.stringify(got) === JSON.stringify(want);
	if (ok) {
		console.log(`OK   ${note}`);
		passed++;
	} else {
		console.log(`FAIL ${note}`);
		console.log(`     got:  ${JSON.stringify(got)}`);
		console.log(`     want: ${JSON.stringify(want)}`);
	}
}

// ---- 書き写せている型 ----
check("Atom はリテラルの Layer 2 型がそのまま出る", entries("pi : 3.14"), ["pi : Float"]);
check("String も同様", entries("greeting : `hello`"), ["greeting : String"]);
check("本体が式なら返値型が出る", entries("f : x ?\n\tx > 3 : 1\n\t2"), ["f : Int -> Int"]);
// §7.1 の表がそのまま述べている: `f : x y ? x + y` の `x`/`y` は `+` のシグネチャが
// 要求する `Scalar` であり、`f` は `Lambda<returns: Scalar>` になる。ここで言う `Scalar` は
// 「String を含まない Atom」という**族**（§4 の記法定義）であって Layer 2 の具体型では
// なく、呼び出しサイトで具体化されるまでの暫定形である。
check("仮引数の型を本体の演算子から逆算し、返値まで通る（§7.1）", entries("add : a b ? a + b"), [
	"add : Scalar Scalar -> Scalar",
]);
// 相手がリテラルなら、族（`Scalar`）ではなくその型まで決まる。Sign には型注釈の構文が
// 無いので（§1「型はコードの影」）、初期化時に型を決めたいときは**値を変えない演算**を
// 書く。リテラルは**左辺**に置く——域を選ぶのは左辺だからである（§3.2）。
// `0 +` は Int、`0x0 +` は Address、`0.0 +` は Float。実行時コストは無いが型は固定される。
check("相手が整数リテラルなら Int まで決まる", entries("f : x ? x + 1"), ["f : Int -> Int"]);
check("`0.0 +` は恒等演算だが型を Float に固定する（域を選ぶのは左辺、§3.2）", entries("f : x ? 0.0 + x"), ["f : Float -> Float"]);
check("比較演算子でも同じ", entries("f : x ? x > 3"), ["f : Int -> Int"]);
check("比較は同種同士なので String も決まる", entries("f : t ? t = `abc`"), ["f : String -> String"]);
check("相手もリテラルでなければ族までしか言えない", entries("add : a b ? a + b"), ["add : Scalar Scalar -> Scalar"]);
check(
	"`'` でアクセスしたフィールドを要求集合として集める（§6.2）",
	entries("distance : p1 p2 ? p1 ' x - p2 ' x").map((l) => l.split("->")[0].trim()),
	["distance : {x} {x}"]
);
check(
	"分岐で違うフィールドを見たら和集合になる（§6.2 の NOTE）",
	entries("f : p ?\n\tp ' x : p ' y\n\tp ' z").map((l) => l.split("->")[0].trim()),
	["f : {x, y, z}"]
);
check("ブラケット分割代入は形をそのまま書く", entries("f : [h ~t] ? h").map((l) => l.split("->")[0].trim()), [
	"f : [h t~]",
]);

// ---- 名前付きスロットと連番スロット（§2） ----
//
// 両者は同じ構造（固定オフセットで並ぶ連続ブロック）だが**関心事が違う**。
// 名前付きは「何が在るか」が関心事で、物理オフセットは名前でソートした正規順に
// 割り当てられる（stack_abi.md §7.1）——ただしその順序は言語から観測できない。
// `==` は Hom集合の一致で宣言順を問わず、位置アクセスも持たない。
// 連番は「どこに在るか」が関心事で、宣言順がそのまま物理配置になる。
// バイト並びを書くのはこちらであり、MMIO のようにハードウェアが配置を決める場面で使う。
// 名前付きスロットの型は、それ自体が名前付きスロットの形をしている（名前→連番の写像）。
// **並び＝物理配置**（名前ソートの正規順、stack_abi.md §7.1）、**各名前が持つ値＝宣言順**。
// 両方が明示され、どちらも導出に頼らない。
//
// 宣言順を型の側で保存することには実務上の必然がある——`point ' 0` のような連番アクセスは、
// 連番→名前→ソート済みオフセットと辿って初めてコンパイルできる。型が宣言順を捨てると
// この経路が失われ、位置アクセスが解決不能になる。
//
// `point` と `point2` は `==` では等しい（Hom集合の一致は宣言順を問わない）が、連番で
// 引けば違う値を返す。それは `==` が比較していない性質を測っているだけであり矛盾ではない。
// どちらのスロットも (型, 連番) を持つ。違いは連番の書き表し方だけである——連番スロットは
// 名前が無いので並べ替える鍵が無く、記法上の位置がそのまま連番になる（だから書かない）。
// 名前付きは名前でソートして並べるため、連番は明示するしかない（`型 , 連番` の直積）。
check("名前はソート順に並び、各名前が (型, 連番) を持つ", entries("p : [\n\tx : 1\n\ty : 2\n]"), [
	"p : Struct{x : Int , 0  y : Int , 1}",
]);
check("宣言順が違えば連番が入れ替わる（ねじれが型に保存される）", entries("p : [\n\ty : 2\n\tx : 1\n]"), [
	"p : Struct{x : Int , 1  y : Int , 0}",
]);
// 並びと連番が食い違う例。宣言は CR→SR→DR だが物理配置は CR→DR→SR になる
// ——名前付きスロットに位置の確約が無いこと（stack_abi.md §7.1）が型に現れている。
check("ねじれもスロット型も1行で読める", entries("uart : [\n\tCR : 0x40011000\n\tSR : 0\n\tDR : `d`\n]"), [
	"uart : Struct{CR : Address , 0  DR : String , 2  SR : Int , 1}",
]);
check("連番スロットは順序どおりにスロット型を並べる", entries("t : 1 , `abc` , 2.5"), [
	"t : Struct(Int String Float)",
]);
// List は要素型を伴って `List(T)` と書く。要素型を落とすと「整数のリスト」と「実数の
// リスト」が同じ `List` になり、単一の実数（`Float`）とも区別が付かなくなる。要素型は
// Pass 4 が `base + i × sizeof(T)` を出すのに要る情報であり、最も落としてはいけない。
check("List は要素型を伴う（整数のリスト）", entries("l : [1 2 3]"), ["l : List(Int)"]);
check("実数のリストは区別される", entries("l : [1.0 2.0]"), ["l : List(Float)"]);
check("単一の実数とも区別される", entries("r : 5.0"), ["r : Float"]);
// 前置 `~`（持ち上げ）は `Implicit(T)`（暗黙のアドレス＝場所）を作る。
// `$`/`@` が単体値に対する持ち上げ／持ち下げであるのと同じ段で、前置 `~`／後置 `~` が
// 列に対するそれを担う。行き先は `$` が返す「値としての Address」とは別物である（§2）。
//
// 持ち上げは**型が決まったものに対して行う**。`~@p + 0.0` は `(~@p) + 0.0` に切れて
// `List + Float` になり §3.2 で `__` へ潰れるので、`~(@p + 0.0)` と書く。`$` が
// `$[array ' 0]` のように確定した式へ適用されるのと同じ形。
check("前置 `~` はスカラーを場所へ持ち上げる", entries("p : 0x40011000\nlevel : ~(@p + 0.0)"), [
	"p : Address",
	"level : Implicit(Float)",
]);
check("列を持ち上げても同じ段（§4 の `List -> Implicit(List)`）", entries("l : ~[1 2 3]"), ["l : Implicit(List)"]);
check("持ち上げない読み出しは Address のまま", entries("p : 0x40011000\nraw : @p + 0"), [
	"p : Address",
	"raw : Address",
]);
// 持ち上げた結果への算術は成立しない。場所は Scalar ではないので射が無く、零射へ落ちる
// （§4）。前置 `~` は他の前置演算子と同じく最も内側で結合する（tier 23）ため、
// `~xs + 1` は `(~xs) + 1` になる——これが「持ち上げは型が決まったものに対して行う」を
// 構文の側から強制している。
check("持ち上げた結果への算術は __ へ落ちる", entries("xs : [1 2 3]\nbad : ~xs + 1"), [
	"xs : List(Int)",
	"bad : Unit",
]);

// 1要素のリストはスカラーと同型なので `List(T)` にならない（`[5]` は `Int`）。
// 設計上の同一視であり欠落ではない——1要素の連続ブロックとレジスタ上のスカラーは
// 同じビット列を持つ。
check("1要素のリストはスカラーと同型", entries("one : [5]"), ["one : Int"]);
// 入れ子でも要素型が保たれる。
check("連番スロットの中でも要素型が残る", entries("t : 1 , [1 2] , [1.0 2.0]"), [
	"t : Struct(Int List(Int) List(Float))",
]);


// **裸の仮引数は、証拠が何も無くても `Atom` まで書ける。**
//
// 裸の仮引数（rest でもブラケット分割代入でもない）は1個の値を受ける。集合を受け取るなら
// `[x ~xs]`（参照渡し）か `~xs`（stream）で宣言するので、宣言の形が既に「点である」ことを
// 語っている（原理3 の表）。さらにデフォルトが無ければ `__` を渡せない——完全性公理により
// 呼び出しごと潰れるので、本体に入った時点で非Unitが保証される。
//
// `Atom` は §4 の記法定義で「String を**含む**スカラー」＝ `Scalar | String` である。
// 多相に見えて下限が決まっている。具体的な型は呼び出しサイトで確定する（§5 Pass 1b）。
check("証拠が無くても裸の仮引数は Atom", entries("f : x ? x"), ["f : Atom -> Atom"]);
check("演算子から逆算できればそちらが優先", entries("f : x ? x + 1"), ["f : Int -> Int"]);
// rest は stream、ブラケットは構造であり、どちらも点ではないので `Atom` は付けない。
check("rest には付けない", entries("f : x ~xs ? x"), ["f : Atom _~ -> Atom"]);
check("ブラケットにも付けない", entries("f : [a ~b] ? a"), ["f : [a b~] -> Atom"]);
// **デフォルト式があれば、その型がその仮引数の型である。**
//
// デフォルトは「引数が省略されたときに実際にそこへ入る値」なので、型の根拠として本体の
// 使用箇所より強い。使用箇所は「その演算が要求する型」しか語らない——`y + 0.0` は y が
// Int でも昇格するので y が Float とは限らない。デフォルトは中身そのものを語る。
check("デフォルトが整数なら Int", entries("f :\n\tx\n\ty : 1\n ? y"), ["f : Atom Int -> Int"]);
check("デフォルトが実数なら Float", entries("f :\n\tx\n\ty : 1.0\n ? y"), ["f : Atom Float -> Float"]);
check("デフォルトが文字列なら String", entries("f :\n\tx\n\ty : `s`\n ? y"), ["f : Atom String -> String"]);
check("デフォルトがリストなら List", entries("f :\n\tx\n\ty : [1 2 3]\n ? y"), ["f : Atom List -> List"]);
check("デフォルトは使用箇所より優先する（値は Int、式が Float へ昇格）", entries("f :\n\ty : 1\n ? y + 0.0"), [
	"f : Int -> Float",
]);
// ---- 返値型（§7.1・§7.3・§8） ----
//
// 関数本体（match_case の並び）の型は各 arm の型の**直和**であり（§7.3）、apply の結果型は
// **呼び先の返値型**である（§7.1）。Lambda 自身は Layer 1 のカテゴリで Layer 2 型を持たない
// （§2）が、射の適用結果は場所を持つ値なので型を持つ——だから返値型は Layer 2 の型表では
// なく識別子テーブル側（binding.returns）に置く。
//
// 再帰関数の返値型は自分自身に依存するため一度の走査では決まらない。**`__` を束の底**
// として始める：零対象は直和の単位元なので、初回は再帰呼び出しの枝が何も寄与せず基底
// ケースだけが型を決める。次の周回でその型が再帰の枝へ伝わり、変化が止まったところが
// 返値型である。型変数も制約ソルビングも使っていない（§1）——束を単調に上がるだけ。
check("arm の型が割れたら直和になる（§7.3）", entries("f : n ?\n\tn = 0 : `zero`\n\tn"), [
	"f : Int -> Int | String",
]);
// `__` の arm は直和から落ちる。完全性公理により全ての関数が `__` を返しうるので
// `T | Unit` は情報を持たない。零対象は余積の単位元でもあり、代数的にも一貫している。
check("`__` の arm は直和から落ちる", entries("f : t ?\n\tt = `abc` : t\n\t__"), ["f : String -> String"]);
check("再帰が解ける（束の底から上がる）", entries("down : n ?\n\tn = 0 : 0\n\tdown (n - 1)"), [
	"down : Int -> Int",
]);
check("再帰でも基底ケースが型を決める", entries("s : n ?\n\tn = 0 : `end`\n\ts (n - 1)"), [
	"s : Int -> String",
]);
check("相互再帰も解ける", entries("ev : n ?\n\tn = 0 : 1\n\tod (n - 1)\nod : n ?\n\tn = 0 : 0\n\tev (n - 1)"), [
	"ev : Int -> Int",
	"od : Int -> Int",
]);
// **実引数の位置が仮引数の型を語る。**
//
// `h : y ? g y` の `y` は `g` が要求する型である。演算子から逆算するのと同じことを、
// 演算子の代わりに**呼び先のシグネチャ**でやっている——どちらも「その位置に置ける型は
// 何か」を読んでいるだけである。返値型と仮引数型は互いに依存するので、同じ不動点で回る。
check("呼び先の要求が実引数へ逆流し、返値も伝わる", entries("g : x ? x + 1\nh : y ? g y"), [
	"g : Int -> Int",
	"h : Int -> Int",
]);
// 多段でも周回のうちに伝わる。
check("多段の逆流", entries("g : x ? 0.0 + x\nh : y ? g y\nk : z ? h z"), [
	"g : Float -> Float",
	"h : Float -> Float",
	"k : Float -> Float",
]);
// ---- 静的・単相化・動的の3層が型に出る ----
//
// `$` は §4 の通り常に `Atom(Address)` を返す。凍結対象が関数でもデータへのパスでも、
// `$` 自身は「その式が指す場所のアドレスを取る」だけで場合分けを必要としない（§2）。
//
// `p : $f` のように「関数のアドレス」を束縛している場合、`@p` の呼び先は `f` である。
// §2 の IMPORTANT が「多くの場合は静的に一意に決まる（`@handler` で handler の定義が
// 既知なら構文から読める）」と述べている分を由来として辿る。
//
// この2つが入ると `_` が「本当に呼び先が静的に決まらない場所」だけに絞られる。
// `dyn` のようなキーワードを書かずに、3層が型として区別できる。
//
//   具体型      完全に静的。命令テンプレートが1つに決まる
//   Atom        定義側では決まらない。呼び出しサイトで具体化される（§5 Pass 1b、単相化）
//   `_`         呼び先が実行時にしか決まらない。**ここが本物の動的ディスパッチ**
check("`$` は常に Address（関数を指しても）", entries("f : x ? x + 1\np : $f"), [
	"f : Int -> Int",
	"p : Address",
]);
check("`p : $f` を経由した `@p x` も呼び先が静的に決まる", entries("f : x ? x + 1\np : $f\ncall : x ? @p x"), [
	"f : Int -> Int",
	"p : Address",
	"call : Atom -> Int",
]);
check("`@f x` も同じく解ける", entries("f : x ? x + 1\ncall : x ? @f x"), [
	"f : Int -> Int",
	"call : Atom -> Int",
]);
// 構造体フィールド経由の呼び出しは、呼び先が実行時にしか決まらない——手で書いた vtable
// である。返値は `_` になり、§6.2 の要求フィールド集合 `{h}` が「h というスロットを
// 要求する」ことを示す。両方あわせて vtable スロットのシグネチャになっている。
check("構造体フィールド経由の呼び出しは `_`（本物の dyn）", entries("f : x ? x + 1\nt : [\n\th : $f\n\tk : 0\n]\ncall : s ? @(s ' h) 5"), [
	"f : Int -> Int",
	"t : Struct{h : Address , 0  k : Int , 1}",
	"call : {h} -> _",
]);
// ---- 範囲: `.st` は export されたものだけ ----
check("`.st` は export されていない識別子を出さない", entries("a : 1\nb : 2", "st"), []);
check("`.st` は export 記号を保ったまま出す", entries("#a : 1\nb : 2", "st"), ["#a : Int"]);
check("`.ist` は全識別子を出す", entries("#a : 1\nb : 2", "ist"), ["#a : Int", "b : Int"]);

// ---- 残っている `_` について ----
//
// 返値型そのものは解けるようになった。まだ `_` が出るのは、そもそも**仮引数の型が
// 決まっていない**場合である——型は演算子から逆算するので、算術にも比較にも渡されない
// 引数（リストを受け取って分解するだけ、等）には手掛かりが無い。
//
// これは欠落というより、まだ書いていない規則の裏返しである。`'`（フィールドアクセス）や
// ブラケット分割代入の形からの逆算はまだ実装していない（§6.2 の要求フィールド集合は
// `.st` に出しているが、仮引数の atomType へは反映していない）。

// ---- 合成のシグネチャ（`h : f g`） ----
//
// 合成は Lambda なので Layer 2 の Atom 内部型を持たない。それでも `.st` には型が出る
// ——スペースによる合成は左→右のパイプライン（`f g` は `g(f(x))`、coproduct_resolver.md
// §3.1）なので、**仮引数は左端の関数が、返値は右端の関数が**決めるからである。
check("合成のシグネチャは両端から決まる", entries("f : x ? x + 1\ng : x ? x * 2\nh : f g"), [
	"f : Int -> Int",
	"g : Int -> Int",
	"h : Int -> Int",
]);
check("両端の型が違えば、そのまま左端の仮引数と右端の返値になる", entries("f : x ? 0.0 + x\ng : x ? x > 3\nm : f g"), [
	"f : Float -> Float",
	"g : Int -> Int",
	"m : Float -> Int",
]);
// 多段合成でも決めるのは両端だけである（間の関数は型の受け渡しにしか関与しない）。
check("多段合成でも両端が決める", entries("f : x ? 0.0 + x\ng : x ? x * 2\nk : x ? x = `s`\nc : f g k"), [
	"f : Float -> Float",
	"g : Int -> Int",
	"k : String -> String",
	"c : Float -> String",
]);
// その場に書かれた無名ラムダは端としてそのまま使える。
check("合成の端が無名ラムダでも解ける", entries("f : x ? x + 1\nh : (x ? 0.0 + x) f"), [
	"f : Int -> Int",
	"h : Float -> Int",
]);
// ポイントフリーのブロック（`[+ 1]`）は演算子表からシグネチャが出るので端として辿れる
// ——`operator_table.md` の基本原則が言う通り、演算子表はそれ自体が型の表である。
check("ポイントフリーの端も解ける", entries("g : x ? x * 2\nh : [+ 1] g"), [
	"g : Int -> Int",
	"h : Int -> Int",
]);
// `@p`（アドレス経由の間接呼び出し）は呼び先が静的に決まらないので辿れない。
// 分からないことを「分かった」と書かないのが `.st` の原則なので `_` のままにする。
check("辿れない端を持つ合成は `_` のまま", entries("f : x ? x + 1\np : $f\nh : f @p"), [
	"f : Int -> Int",
	"p : Address",
	"h : _",
]);


// ---- 部分適用のシグネチャ（`g : f 1`） ----
//
// 部分適用も Lambda なので Layer 2 型を持たないが、シグネチャは呼び先から決まる
// ——**渡した分だけ仮引数が減り、返値は変わらない**。Pass 2 が静的にアリティ不足を
// 判定して `partial_apply` を立てているので（§5）、残りの仮引数を数え直すだけでよい。
check("部分適用は渡した分だけ仮引数が減る", entries("f : x y z ? x + y + z\ng : f 1"), [
	"f : Scalar Scalar Scalar -> Scalar",
	"g : Scalar Scalar -> Scalar",
]);
check("2個渡せば2個減る", entries("f : x y z ? x + y + z\ng : f 1 2"), [
	"f : Scalar Scalar Scalar -> Scalar",
	"g : Scalar -> Scalar",
]);
// 部分適用の結果をさらに部分適用しても辿れる（Lambda を作る式は積み重なる）。
check("部分適用の部分適用も辿れる", entries("add3 : a b c ? a + b + c\ninc : add3 1\nboth : inc 2"), [
	"add3 : Scalar Scalar Scalar -> Scalar",
	"inc : Scalar Scalar -> Scalar",
	"both : Scalar -> Scalar",
]);
// 返値型は呼び先のまま変わらない——減るのは仮引数だけである。
check("返値は呼び先のまま", entries("f : x y ? 0.0 + x + y\ng : f 1.5"), [
	"f : Float Scalar -> Float",
	"g : Scalar -> Float",
]);
// 別名（`alias : f`）も同じシグネチャになる。
check("別名は同じシグネチャになる", entries("f : x ? 0.0 + x\nalias : f"), [
	"f : Float -> Float",
	"alias : Float -> Float",
]);


// ---- ポイントフリー（演算子を直接値として使う） ----
//
// `operator_table.md` の基本原則が「持ち上げる／持ち下げる演算子の関係性が包括的に型を
// 決定する」と言う通り、**演算子表はそれ自体が型の表**である。`[+ 1]` は「`+` の左辺が
// まだ来ていない」形なので、シグネチャは `+` のシグネチャから穴の数を数えるだけで出る。
//
// 規則は `f : x ? x + 1` を逆算するのと**同一**である——相手がリテラルならその型まで決まり、
// 両方とも空なら演算子が要求する族までしか言えない。同じ結論を2通りの書き方から得ている
// のであって、ポイントフリーのために別の規則を足しているわけではない。
check("片側が埋まっていれば穴は1つ", entries("inc : [+ 1]"), ["inc : Int -> Int"]);
check("両側が空なら穴は2つで族まで", entries("add : [+]"), ["add : Scalar Scalar -> Scalar"]);
check("相手のリテラルが型を決める（実数）", entries("fl : [+ 1.0]"), ["fl : Float -> Float"]);
check("アドレスでも同じ", entries("off : [+ 0x10]"), ["off : Address -> Address"]);
check("比較演算子も同じ規則（値返却型比較）", entries("gt : [> 3]"), ["gt : Int -> Int"]);
check("比較は同種同士なので String も決まる", entries("eq : [= `a`]"), ["eq : String -> String"]);
// 構造比較（`==` / `!==`）はリストや構造体にも効くので族が `Scalar` に定まらない。
// 分からないことを「分かった」と書かないのが `.st` の原則なので `_` のままにする。
check("構造比較は族が決まらないので `_`", entries("st : [==]"), ["st : _"]);


// ---- ブラケット分割代入の rest は器そのものである ----
//
// `[c ~rest]` は渡された単一の集合をその場で分解する（list_model.md §2.4）。`c` が要素で
// `rest` は**残りの集合**——つまり `rest` の型は器の型と同じである。したがって要素の型が
// 分かれば器の型も決まり、それがスロットの型になる。
//
// 要素が文字（`String`）なら器は `String` である。**`List(String)` という型は存在しない**
// ——文字列同士をスペース（余積）で並べると String の吸収則で1本に連結されるため
// （`` [`ab` `cd`] `` は `"abcd"`）、複数の文字列を保つには `Struct`（カンマ）が要る。
// だから「要素が String な List」と「String」は同じものであり、迷う余地が無い。
check("要素が文字なら器は String", entries("hd : [c ~rest] ?\n\tc = `a` : __\n\tc (hd rest)"), [
	"hd : String -> String",
]);
check("残りを返す形でも同じ", entries("tl : [c ~rest] ?\n\tc = `a` : rest\n\ttl rest"), ["tl : String -> String"]);
check("要素が数値なら器は List(T)", entries("sum : [x ~xs] ? xs & x + (sum xs) | x"), [
	"sum : List(Scalar) -> Scalar",
]);
check("実数なら List(Float)", entries("g : [x ~xs] ? 0.0 + x"), ["g : List(Float) -> Float"]);
// 要素の型が分からなければ形のまま書く。形は「まだ型が分かっていない」ときの記述であって、
// 裸の仮引数における `Atom` と同じ位置にある。
check("証拠が無ければ形のまま", entries("f : [c ~rest] ? c"), ["f : [c rest~] -> Atom"]);
// rest が無いブラケット（`[a b]`）は器の型を決める手掛かりが無い——`rest` こそが器だから。
check("rest が無ければ器は決まらない", entries("f : [a b] ? a + b"), ["f : [a b] -> Scalar"]);

// **添字で書くと返値型を取り違える。**
//
// `(s ' 0) (f (s ' 1~))` は `s` が裸の仮引数（`Atom`）だと `s ' 0` の型が分からず、余積の
// join が `List` に落ちる——文字列を返す関数なのに `List` と書かれてしまう。分割代入なら
// `c` が要素だと分かるので String の吸収則が効いて正しく `String` になる。
check("添字スタイルは List と誤る", entries("hd : s ?\n\t(s ' 0) = `a` : __\n\t(s ' 0) (hd (s ' 1~))"), [
	"hd : Atom -> List",
]);


// ---- 実引数の位置が仮引数の型を語る ----
//
// `h : y ? g y` の `y` は `g` が要求する型である。演算子から逆算するのと同じことを、
// 演算子の代わりに**呼び先のシグネチャ**でやっている——どちらも「その位置に置ける型は
// 何か」を読んでいるだけである。返値型と仮引数型は互いに依存するので同じ不動点で回る。
check("2番目の引数でも逆流する", entries("g : a b ? 0.0 + b\nh : y ? g 1 y"), [
	"g : Atom Float -> Float",
	"h : Float -> Float",
]);
// 仮引数のデフォルト式も使用箇所である。デフォルトは**他の仮引数を使って書ける**ので、
// 本体だけを見ていると仮引数リストの中でしか使われない引数が `Atom` のまま残る。
check("デフォルト式の中の使用も拾う", entries("g : s ? 0.0 + s\nh :\n\tx\n\ty : g x\n ?\n\ty"), [
	"g : Float -> Float",
	"h : Float Float -> Float",
]);
// 逆算した型はラムダのスコープへ書き戻す。書き戻さないと本体でその仮引数を読んだときに
// Pass 1a が置いた下限（`Atom`）しか見えず、返値型が実際より緩くなる。
check("デフォルトが式でも本体まで型が届く", entries("id : s ? s = `a`\nc :\n\traw\n\tb : id raw\n ?\n\tb"), [
	"id : String -> String",
	"c : String String -> String",
]);

// ---- 直和は平らにする ----
//
// arm の型が既に直和（再帰呼び出しの返値など）だと、それを1個の要素として数えてしまい、
// 周回のたびに `String | List | String | List | …` と伸び続ける。直和は冪等（`A | A = A`）
// であり結合的でもあるのだから、入れ子を保つ理由が無い。
check("入れ子の直和は展開して重複を落とす", entries("f : n ?\n\tn = 0 : `s`\n\tn = 1 : 1.0\n\tf (n - 1)"), [
	"f : Int -> Float | String",
]);

console.log(`\n${passed}/${total} passed`);
process.exit(passed === total ? 0 : 1);
