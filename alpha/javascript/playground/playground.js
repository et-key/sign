import { parse } from "../parser.js";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { evaluate, newRuntimeEnv, UNIT, isUnit } from "../interpreter.js";

const srcEl = document.getElementById("src");
const outEl = document.getElementById("out");
const astEl = document.getElementById("ast");
const runBtn = document.getElementById("runBtn");
const fontSelectEl = document.getElementById("fontSelect");
const fontSizeEl = document.getElementById("fontSize");
const fontSizeLabelEl = document.getElementById("fontSizeLabel");
const ligaturesEl = document.getElementById("ligatures");

// フォント表示（フォント種別・サイズ・合字の有無）を選べるようにする。Signは`~+`/`!=`/
// `<=`のような複合記号が多く、合字（ligature）でグリフが結合されると個々の記号が読み
// 取りにくくなる場合があるため、デフォルトは無効（`--code-ligatures: none`、index.html）
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

function showValue(v) {
  if (isUnit(v)) return "__ (Unit)";
  if (Array.isArray(v)) return "[" + v.map(showValue).join(" ") + "]";
  if (v && v.__lambda__) return "<Lambda>";
  return JSON.stringify(v);
}

function showAst(node) {
  if (node === null || node === undefined) return "null";
  if (node.type === "atom") return `${node.kind}(${node.value})`;
  if (node.type === "operation") {
    if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${showAst(node.operand)})`;
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
  try {
    const pre = preprocess(source);
    const lines = parse(pre);
    const staticEnv = buildEnv(lines);
    const runtimeEnv = newRuntimeEnv(null);
    let last = UNIT;
    for (const line of lines) {
      const node = reduceAll(line, staticEnv);
      astLines.push(showAst(node));
      last = evaluate(node, runtimeEnv);
      outLines.push(showValue(last));
    }
    outEl.textContent = outLines.join("\n");
    outEl.classList.remove("err");
  } catch (e) {
    outEl.textContent = "エラー: " + e.message;
    outEl.classList.add("err");
  }
  astEl.textContent = astLines.join("\n\n");
}

runBtn.addEventListener("click", run);
srcEl.addEventListener("keydown", (e) => {
  if (e.ctrlKey && e.key === "Enter") run();
  // Signのインデントは厳密にタブ文字のみ（lexer.jsのmarkBlockは/^\t*/でタブしか見ない、
  // スペースは意味を持たない）。素のtextareaはTabキーでフォーカス移動してしまい
  // タブ文字を入力できないため、ここで明示的にタブ文字を挿入する。
  if (e.key === "Tab") {
    e.preventDefault();
    const start = srcEl.selectionStart;
    const end = srcEl.selectionEnd;
    srcEl.value = srcEl.value.slice(0, start) + "\t" + srcEl.value.slice(end);
    srcEl.selectionStart = srcEl.selectionEnd = start + 1;
  }
});

run();
