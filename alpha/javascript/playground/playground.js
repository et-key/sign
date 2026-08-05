import { parse } from "../parser.js";
import { preprocess } from "../lexer.js";
import { reduceAll } from "../pass2.js";
import { buildEnv } from "../pass1.js";
import { evaluate, newRuntimeEnv, UNIT, isUnit } from "../interpreter.js";

const srcEl = document.getElementById("src");
const outEl = document.getElementById("out");
const astEl = document.getElementById("ast");
const runBtn = document.getElementById("runBtn");

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
