import { compile } from "./compile.js";
const show = (n, d = 0) => {
  if (!n || typeof n !== "object") return;
  const pad = "  ".repeat(d);
  const label = n.type === "atom" ? `${n.kind}:${n.value}` : `${n.type}/${n.name || ""}${n.position ? "(" + n.position + ")" : ""}`;
  console.log(pad + label);
  for (const k of ["left", "right", "operand", "middle"]) if (n[k]) show(n[k], d + 1);
  for (const l of n.lines || []) show(l, d + 1);
};
for (const src of ["[x : 1 , y : 2]", "[x : 1 , 2]"]) {
  console.log("=== " + JSON.stringify(src));
  const { nodes } = compile(src, { charset: "ascii" });
  for (const n of nodes) show(n, 1);
}
