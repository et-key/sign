import { compile } from "./compile.js";
import { generateAsm } from "./pass4.js";
import { evaluate, newRuntimeEnv, UNIT, observe, isUnit } from "./interpreter.js";
for (const [note, src] of [
  ["トップレベル 1 : 2", "1 : 2"],
  ["ブロック内 1 : 2", "p :\n\t1 : 2\np"],
  ["トップレベル (1,y) : 2", "(1 , y) : 2"],
  ["ブロック内 (1,y) : 2", "p :\n\t(1 , 2) : 3\np"],
  ["ブロック内 `a` : 2", "p :\n\t`a` : 2\np"],
  ["ブロック内 (x y) : 2", "p :\n\t(x y) : 2\np"],
  ["ブロック内 名前", "p :\n\ta : 1\np"],
]) {
  let a = "", dm = "";
  try { const { nodes } = compile(src, { charset: "ascii" }); const env = newRuntimeEnv(null, "ascii");
    let r = UNIT; for (const n of nodes) r = evaluate(n, env); a = isUnit(r) ? "__" : JSON.stringify(observe(r));
  } catch (e) { a = "解釈で例外:" + e.message.slice(0, 30); }
  try { const { nodes, env } = compile(src, { charset: "ascii" }); const r = generateAsm(nodes, env, { target: "aarch64_qemu", charset: "ascii", layer: 1 });
    dm = r.diagnostics.length ? "診断: " + r.diagnostics[0].message.slice(0, 40) : "診断0件";
  } catch (e) { dm = "例外:" + e.message.slice(0, 30); }
  console.log(note.padEnd(24), String(a).padEnd(20), dm);
}
