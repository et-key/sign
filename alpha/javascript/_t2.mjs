import { compile } from "./compile.js";
const ty = (src) => {
  try {
    const { nodes } = compile(src);
    const last = nodes[nodes.length - 1];
    const n = last.type === "operation" && last.name === "define" ? last.right : last;
    return String(n.atomType) + (n.elementType ? "(" + n.elementType + ")" : "");
  } catch (e) { return "ERR " + String(e.message).slice(0, 40); }
};
for (const s of ["s : `abcd`\ns ' 1~", "l : [1 2 3]\nl ' 1~", "s : `abcd`\ns ' 1", "1~", "[2 3]~"]) {
  console.log(JSON.stringify(s).padEnd(24), "->", ty(s));
}
