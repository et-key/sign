import { compile } from "./compile.js";
import { generateAsm } from "./pass4.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "./interpreter.js";
for (const src of ["(1 , y) : 2", "1 : 2", "`a` : 2", "(x y) : 2", "x : 2"]) {
  let a = "", d = 0, dm = "";
  try { const { nodes } = compile(src, { charset: "ascii" }); const env = newRuntimeEnv(null, "ascii");
    let r = UNIT; for (const n of nodes) r = evaluate(n, env); a = isUnit(r) ? "__" : JSON.stringify(observe(r));
  } catch (e) { a = "解釈で例外:" + e.message.slice(0, 35); }
  try { const { nodes, env } = compile(src, { charset: "ascii" }); const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
    d = r.diagnostics.length; dm = d ? r.diagnostics[0].message.slice(0, 45) : "";
  } catch (e) { dm = "例外:" + e.message.slice(0, 35); }
  console.log(JSON.stringify(src).padEnd(16), "解釈=" + String(a).padEnd(22), d ? "診断: " + dm : (dm || "診断0件"));
}
