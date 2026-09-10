import { compile } from "./compile.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "./interpreter.js";
for (const src of [
  "1 , 2",
  "1 , (y : 2)",
  "(y : 2)",
  "1 , (y : 2) , 3",
  "[1 , (y : 2)]",
  "9 , (y : 2)",
  "`a` , (y : 2)",
]) {
  try {
    const { nodes } = compile(src, { charset: "ascii" }); const env = newRuntimeEnv(null, "ascii");
    let r = UNIT; for (const n of nodes) r = evaluate(n, env);
    console.log(JSON.stringify(src).padEnd(24), "→", isUnit(r) ? "__" : JSON.stringify(observe(r)));
  } catch (e) { console.log(JSON.stringify(src).padEnd(24), "→ 例外:", e.message.slice(0, 45)); }
}
