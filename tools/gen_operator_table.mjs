/**
 * **演算子表を Sign で書いた形へ落とす。**
 *
 * 同じ表がリポジトリに4本ある——仕様の md、その隣の .js、実装の手写し、そして Sign 側。
 * 手で写すと必ずズレる（実際、`===` の廃止と `||` の除外で2件ズレていた）ので、Sign 側は
 * **実装が実際に使っている表**（alpha/javascript/operator_table.js）から生成する。
 *
 * documents 側の写しとは**56件中42件で食い違っている**——前置 `~` を tier 10 へ移した差で
 * 10 以降の段番号が1ずつズレており、右結合（`assoc`）を持つのも実装側だけである。
 * コード生成が引くのは実装側なので、Sign 側もそちらへ揃える。
 *
 * **鍵は演算子の綴りそのものである。** 綴りが静的に書けるなら 0 命令で引け、実行時に
 * 決まるなら名前を探す——同じ表が構造体にも連想配列にもなる。
 *
 * ## なぜ .js と字面が同じ形（段の配列・入れ子）にしないのか
 *
 * .js は `OPERATOR_BY_PRECEDENCE`（段で引く配列）と `OPERATOR_DICT`（綴りで引き、多義は
 * 定義の配列）の2本を持つ。同じ字面を Sign へ写すと**実機に降りない**——実測すると：
 *
 *     綴り鍵 → [position / name]（静的な鍵）   解釈 ○ ／ 機械 ○
 *     実行時の鍵で引いてさらに ' name（二段）   解釈 ○ ／ 機械 ✗「まだ出せない識別子」
 *     構造体のリスト（段の配列）                解釈 ○ ／ 機械 ✗「枝の幅が揃いません」
 *
 * **パーサはトークン（実行時の値）を鍵にする**ので、二段引きが要る。だから入れ子でも
 * 配列でもなく、**位置ごとの平らな表**にする——同じ内容（position・name・precedence を
 * 全綴りぶん）を、実機に降りる形で持つ。
 *
 * 多義（`#` は前置の段1と中置の段4）は**位置で分ければ鍵が衝突しない**。.js が
 * `OPERATOR_DICT` で定義の配列にしているのと同じ情報を、表を分けることで表している。
 *
 * 走らせ方: node tools/gen_operator_table.mjs
 */
import fs from "fs";
import { OPERATOR_BY_PRECEDENCE, getStrictInfixOperators } from "../alpha/javascript/operator_table.js";

const BQ = String.fromCharCode(96), BS = String.fromCharCode(92), T = "\t";
const s = (x) => BQ + x + BQ;

// **書けるかどうかは「バッククォートで囲めるか」である。**
//
// 空白（段10 の余積）は綴りが1文字の空白であって、`` ` ` `` と書けば長さ1の String に
// なる——0x20 を弾いていたので表から落ちていた。落とすべきなのは**文字列に書けないもの**
// だけ、つまり改行とタブである（文字列は同一行で閉じる必要がある）。
const writable = (sym) => /^[ -~]+$/.test(sym) && sym !== BS + "n";

// 位置ごとに集める。**廃止されたものは別扱いにする**——`===` は意味を持たないが、
// 字句としては1つの綴りなので、表から消すと `==` + `=` に割れて別の意味へ黙って化ける。
// 段と名前の表からは外し、`#removed` に残して「字句としては在る」ことだけを言う。
//
// **生成するコメントの中にバッククォートを書いてはいけない。** Sign のコメントは
// バッククォート文字列そのものなので、中に閉じ引用符が現れると、そこで文字列が閉じて
// 残りが式として読まれる（行頭バッククォートの判別規則——閉じの直後が空白なら式）。
// 実際 `===` を引用したせいで表全体が「未対応の演算 'same'」で落ちた。
const POSITIONS = ["infix", "prefix", "postfix", "enclosure"];
const byPos = Object.fromEntries(POSITIONS.map((p) => [p, []]));
const removed = [];
for (let i = 0; i < OPERATOR_BY_PRECEDENCE.length; i++)
	for (const [sym, def] of Object.entries(OPERATOR_BY_PRECEDENCE[i] || {})) {
		if (!writable(sym)) continue;
		if (def.removed) { removed.push(sym); continue; }
		if (!byPos[def.position]) continue;
		byPos[def.position].push({ sym, tier: i + 1, name: def.name, assoc: def.assoc || null });
	}

// **右結合は表が言う。** 以前はここに手書きの集合を持っていたが、それは表とは別の
// 3つ目の意見であり、片方だけ直る形だった——実際 `:` と `?` は集合に入っているのに
// 表には無く、どちらが正しいかは書かれたものからは決まらなかった。表がデータとして
// 持つようになったので、集合は要らない。
const strict = getStrictInfixOperators().filter(writable);

const table = (title, name, rows, valueOf) => [
	s(title),
	"",
	"#" + name + " :",
	...rows.map((r) => T + s(r.sym) + " : " + valueOf(r)),
	"",
];

const L = [
	s("Sign の演算子表。仕様から生成している——手で写さない"),
	s("生成もと alpha/javascript/operator_table.js / 生成器 tools/gen_operator_table.mjs"),
	"",
	s("鍵は演算子の綴りそのものである。綴りが静的に書けるなら 0 命令で引け、実行時に決まる"),
	s("なら名前を探す——同じ表が構造体にも連想配列にもなる"),
	"",
	s("段番号は仕様の段番号そのものであって、配列の添字ではない"),
	"",
		s("位置ごとに表を分けてある。多義な綴り（＃ は前置の段1と中置の段4）が鍵として"),
	s("衝突しないのと、実行時に決まる鍵で引けるのが理由——入れ子にすると二段目が実機で"),
	s("引けない（生成器の注記）"),
	"",
];

for (const p of POSITIONS) {
	const rows = byPos[p];
	if (!rows.length) continue;
	L.push(...table("--- " + p + "：段 ---", p + "_tier", rows, (r) => r.tier));
	L.push(...table("--- " + p + "：演算の名前 ---", p + "_name", rows, (r) => s(r.name)));
}

L.push(...table("--- 右結合か（表の assoc がそう言うもの）---", "right", byPos.infix, (r) => (r.assoc === "right" ? 1 : 0)));

L.push(
	s("--- 曖昧でない中置：前後に空白を入れてよいもの ---"),
	s("前置・後置・囲みにもなる綴りは入っていない"),
	s("| と || は囲みの区切りでもあるので入れない——空白を入れるとノルムが壊れる"),
	s("所属の問いなので綴りを鍵にした集合で持つ。無ければ __ が返る"),
	"",
	"#strict_infix :",
	...strict.map((x) => T + s(x) + " : 1"),
	""
);

if (removed.length)
	L.push(
		s("--- 廃止された綴り ---"),
		s("意味は持たないが、字句としては1つの綴りである。表から消すと 三連の等号が 二連 ＋ 単独 に"),
		s("割れて別の意味へ黙って化けるので、ここに残す（.js の注記と同じ理由）"),
		"",
		"#removed :",
		...[...new Set(removed)].map((x) => T + s(x) + " : 1"),
		""
	);

fs.writeFileSync(new URL("../alpha/sign/operator_table.sn", import.meta.url), L.join("\n") + "\n");
const counts = POSITIONS.map((p) => p + " " + byPos[p].length).join(" / ");
console.log("書いた: " + counts + " / 曖昧でない中置 " + strict.length + " / 廃止 " + new Set(removed).size);
