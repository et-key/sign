import { compile } from "./compile.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "./interpreter.js";
for (const src of [
  "[x : 1 , y : 2]",
  "[x : 1 , 2]",
  "[x : (1 , 2)]",
  "[(x : 1) , (y : 2)]",
  "x : 1 , 2\nx",
  "[x : 1]",
  "[x : 1 , y : 2 , z : 3]",
  "[\n\tx : 1\n\ty : 2\n]",
]) {
  try {
    const { nodes } = compile(src, { charset: "ascii" }); const env = newRuntimeEnv(null, "ascii");
    let r = UNIT; for (const n of nodes) r = evaluate(n, env);
    console.log(JSON.stringify(src).padEnd(30), "→", isUnit(r) ? "__" : JSON.stringify(observe(r)));
  } catch (e) { console.log(JSON.stringify(src).padEnd(30), "→ 例外:", e.message.slice(0, 50)); }
}
