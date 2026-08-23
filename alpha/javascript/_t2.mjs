import { compile } from "./compile.js";
import { envLookup } from "./pass1.js";
import { evaluate, newRuntimeEnv, UNIT, observe } from "./interpreter.js";
// 複数行のパラメータブロック形式（ACC と同じ書き方）
const F = (def) => "f :\n\tn\n\tas : " + def + "\n ?\n\tas\n";
const probe = (label, src) => {
  let t = "-", v = "-";
  try {
    const { nodes } = compile(src);
    for (const n of nodes) {
      if (n.type === "operation" && n.name === "define" && n.right && n.right.name === "lambda") {
        const b = n.right.scope ? envLookup(n.right.scope, "<as>") : null;
        t = b ? String(b.atomType) : "-";
        break;
      }
    }
    const renv = newRuntimeEnv(null);
    let r = UNIT;
    for (const x of nodes) r = observe(evaluate(x, renv));
    v = JSON.stringify(r);
  } catch (e) { v = "ERR " + String(e.message).slice(0, 40); }
  console.log("  " + label.padEnd(32) + "値:" + String(v).padEnd(12) + "as の型:" + t);
};
console.log("デフォルトを省略したときの値と、宣言された型");
probe("as : 0 / f 3（省略）",        F("0") + "f 3");
probe("as : 0 / f 3 [1 2] と f 3",  F("0") + "f 3 [1 2]\nf 3");
probe("as : __ / f 3（省略）",       F("__") + "f 3");
probe("as : __ / f 3 [1 2] と f 3", F("__") + "f 3 [1 2]\nf 3");
console.log("\n完全性公理との関係");
probe("as : __ に __ を渡す",        F("__") + "f 3 __");
probe("デフォルト無しに __ を渡す",     "f :\n\tn\n\tas\n ?\n\tas\n" + "f 3 __");
