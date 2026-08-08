import { compile } from "../compile.js";
import { evaluate, newRuntimeEnv, UNIT, isUnit } from "../interpreter.js";

const srcEl = document.getElementById("src");
const outEl = document.getElementById("out");
const outPreEl = outEl.parentElement;
const astEl = document.getElementById("ast");
const lineNumbersEl = document.getElementById("lineNumbers");
const runBtn = document.getElementById("runBtn");
const exampleSelectEl = document.getElementById("exampleSelect");
const fontSelectEl = document.getElementById("fontSelect");
const fontSizeEl = document.getElementById("fontSize");
const fontSizeLabelEl = document.getElementById("fontSizeLabel");
const ligaturesEl = document.getElementById("ligatures");

// フォント表示（フォント種別・サイズ・合字の有無）を選べるようにする。Signは`~+`/`!=`/
// `<=`のような複合記号が多く、合字（ligature）でグリフが結合されると個々の記号が読み
// 取りにくくなる場合があるため、デフォルトは無効（`--code-ligatures: none`、playground.css）
// にしつつ、フォントによっては合字表示を見たい場合もあるためON/OFFを選べるようにした。
// 選択内容はlocalStorageへ保存し、リロードをまたいで保持する。
const FONT_PREF_KEY = "sign-playground-font-prefs";
function loadFontPrefs() {
  try {
    return JSON.parse(localStorage.getItem(FONT_PREF_KEY) || "{}");
  } catch {
    return {};
  }
}
function saveFontPrefs(prefs) {
  localStorage.setItem(FONT_PREF_KEY, JSON.stringify(prefs));
}
function applyFontPrefs() {
  const root = document.documentElement.style;
  root.setProperty("--code-font", fontSelectEl.value);
  root.setProperty("--code-size", `${fontSizeEl.value}px`);
  root.setProperty("--code-ligatures", ligaturesEl.checked ? "normal" : "none");
  fontSizeLabelEl.textContent = `${fontSizeEl.value}px`;
  saveFontPrefs({ font: fontSelectEl.value, size: fontSizeEl.value, ligatures: ligaturesEl.checked });
}
(function initFontPrefs() {
  const prefs = loadFontPrefs();
  if (prefs.font) fontSelectEl.value = prefs.font;
  if (prefs.size) fontSizeEl.value = prefs.size;
  if (prefs.ligatures) ligaturesEl.checked = true;
  applyFontPrefs();
})();
fontSelectEl.addEventListener("change", applyFontPrefs);
fontSizeEl.addEventListener("input", applyFontPrefs);
ligaturesEl.addEventListener("change", applyFontPrefs);

// ---- Template Loader（documents/ja-jp/guide/を踏まえた、alpha/javascriptで実際に
// 動く挙動だけを集めたサンプル集。pre-alpha版playgroundの構成に倣うが、$/@/#やWASM等
// alpha側の実装状況に合わせて中身は作り直した）。
const EXAMPLES = {
  composition: `\`関数合成（左→右パイプライン順、f gはg(f(x))）
f : x ? x + 1
g : x ? x * 2
h : f g
h 3`,
  currying: `\`自動カリー化（アリティ不足の適用は静的にpartial closureへ）
f : x y z ? x + y + z
g : f 1
g 2 3
(f 1) 2 3`,
  pointfree: `\`ポイントフリー記述（演算子を直接値として使う）
inc : [+ 1]
inc 3
add : [+]
add 1 2 3 4 5`,
  match_case: `\`match_case（&/|チェーンへ脱糖、上から順に短絡評価）
classify : x ?
	x < 0 : \`negative\`
	x = 0 : \`zero\`
	\`positive\`
classify -3
classify 0
classify 7`,
  rest_recursion: `\`裸のrestパラメータ（後置~で展開して渡す）
sum : x ~xs ? x + (sum xs~)
sum [1 2 3 4 5]~`,
  chain_compare: `\`三項連鎖比較（comparison.md §4、中央の項を返す）
x : 7
5 < x < 10
5 < 3 < 10`,
  manual_curry: `\`手動カリー（$で継続をアドレス化、@で呼び出す）
f : a ? $[b ? a + b]
@(f 1) 2`,
};

exampleSelectEl.addEventListener("change", () => {
  const example = EXAMPLES[exampleSelectEl.value];
  if (example) {
    srcEl.value = example;
    updateLineNumbers();
    run();
  }
});

// ---- 行番号ガター（ソースの行数・スクロール位置に追従） ----
function updateLineNumbers() {
  const count = srcEl.value.split("\n").length;
  let html = "";
  for (let i = 1; i <= count; i++) html += `<div>${i}</div>`;
  lineNumbersEl.innerHTML = html;
}
srcEl.addEventListener("input", updateLineNumbers);
srcEl.addEventListener("scroll", () => {
  lineNumbersEl.scrollTop = srcEl.scrollTop;
});

function showValue(v) {
  if (isUnit(v)) return "__ (Unit)";
  if (Array.isArray(v)) return "[" + v.map(showValue).join(" ") + "]";
  if (v && v.__address__) return `<Address → ${showValue(v.get())}>`;
  if (v && v.__lambda__) return "<Lambda>";
  if (v && typeof v === "object") return JSON.stringify(v);
  return String(v);
}

function showAst(node) {
  if (node === null || node === undefined) return "null";
  if (node.type === "atom") return `${node.kind}(${node.value})`;
  if (node.type === "operation") {
    if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${showAst(node.operand)})`;
    if (node.name === "chain_compare") return `chain_compare[${showAst(node.left)}, ${node.compareName}, ${showAst(node.middle)}, ${showAst(node.right)}]`;
    return `${node.name}[${showAst(node.left)}, ${showAst(node.right)}]`;
  }
  if (node.type === "block") return `${node.kind}{${node.lines.map(showAst).join("; ")}}`;
  if (node.type === "params") {
    return `params[${node.entries.map((e) => (e.rest ? `~${e.name}` : e.default ? `${e.name}:${showAst(e.default)}` : e.name)).join(", ")}]`;
  }
  if (node.type === "unresolved") return `UNRESOLVED[${node.items.map((x) => (typeof x === "string" ? x : showAst(x))).join(", ")}]`;
  return JSON.stringify(node);
}

function run() {
  const source = srcEl.value;
  const outLines = [];
  const astLines = [];
  let hadError = false;
  try {
    // 静的解決は compile()（Pass 1〜3 の単一ドライバ）に一本化。
    // 各ノードには pass3 が Layer 2 型（atomType）を注釈済みなので、AST表示にも出す。
    const { nodes } = compile(source);
    const runtimeEnv = newRuntimeEnv(null);
    let last = UNIT;
    for (const node of nodes) {
      astLines.push(`${showAst(node)}\n  :: ${node.atomType ?? "?"}`);
      last = evaluate(node, runtimeEnv);
      outLines.push(showValue(last));
    }
  } catch (e) {
    outLines.push("エラー: " + e.message);
    hadError = true;
  }
  outEl.textContent = outLines.join("\n");
  outPreEl.classList.toggle("err", hadError);
  astEl.textContent = astLines.join("\n\n");
}

// ボタンのローディング表示（評価自体は同期処理のため一瞬だが、クリックへ視覚的な
// フィードバックを返すため1ティックだけ挟む）。
// 【requestAnimationFrameを使わない理由】rAFはタブが非表示・非コンポジット状態だと
// 発火しないため、「実行を押しても何も起きない」という状態になる（実際に踏んだ）。
// setTimeoutはその状態でも発火するので、描画の間引きに巻き込まれない。
function runWithFeedback() {
  runBtn.classList.add("loading");
  setTimeout(() => {
    try {
      run();
    } finally {
      runBtn.classList.remove("loading");
    }
  }, 0);
}

runBtn.addEventListener("click", runWithFeedback);
srcEl.addEventListener("keydown", (e) => {
  if (e.ctrlKey && e.key === "Enter") runWithFeedback();
  // Signのインデントは厳密にタブ文字のみ（lexer.jsのmarkBlockは/^\t*/でタブしか見ない、
  // スペースは意味を持たない）。素のtextareaはTabキーでフォーカス移動してしまい
  // タブ文字を入力できないため、ここで明示的にタブ文字を挿入する。
  if (e.key === "Tab") {
    e.preventDefault();
    const start = srcEl.selectionStart;
    const end = srcEl.selectionEnd;
    srcEl.value = srcEl.value.slice(0, start) + "\t" + srcEl.value.slice(end);
    srcEl.selectionStart = srcEl.selectionEnd = start + 1;
    updateLineNumbers();
  }
});

srcEl.value = EXAMPLES.composition;
updateLineNumbers();
run();
