import peggy from "peggy";
import fs from "fs";
import { preprocess } from "./lexer.js";
import { reduceAll } from "./pass2.js";
import { buildEnv } from "./pass1.js";

const grammar = fs.readFileSync("./sign.pegjs", "utf8");
const parser = peggy.generate(grammar);

function show(node) {
  if (node.type === "atom") return `${node.kind}(${node.value})`;
  if (node.type === "operation") {
    if (node.position === "prefix" || node.position === "postfix") return `${node.name}(${show(node.operand)})`;
    return `${node.name}[${show(node.left)}, ${show(node.right)}]`;
  }
  if (node.type === "block") return `${node.kind}{${node.lines.map(show).join("; ")}}`;
  if (node.type === "unresolved") return `UNRESOLVED[${node.items.map((x) => (typeof x === "string" ? x : show(x))).join(", ")}]`;
  return JSON.stringify(node);
}

// 高階関数の仮引数 g が、本体内で g x として直接呼ばれるケース
const source = "apply : g x ? g x";
const pre = preprocess(source);
const lines = parser.parse(pre);
const env = buildEnv(lines);
const got = lines.map((line) => show(reduceAll(line, env)));
console.log(JSON.stringify(got, null, 1));
