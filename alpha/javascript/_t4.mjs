import { compile } from "./compile.js";
import { evaluate, newRuntimeEnv, UNIT, observe } from "./interpreter.js";
const run = (src) => {
  try {
    const { nodes } = compile(src);
    const env = newRuntimeEnv(null);
    let r = UNIT;
    for (const n of nodes) r = observe(evaluate(n, env));
    return JSON.stringify(r);
  } catch (e) { return "ERR " + String(e.message).slice(0, 40); }
};
const GO = "go :\n\tacc : 0\n\trest : __\n ?\n\t(rest) : go (acc + (rest ' 0)) (rest ' 1~)\n\tacc\n";
console.log("guide の go（acc : 0 / rest : __）");
console.log("  go __ [1 , 2 , 3 , 4] :", run(GO + "go __ [1 , 2 , 3 , 4]"));
console.log("  go 6 [4]              :", run(GO + "go 6 [4]"));
console.log("\n空のリストを関数へ渡せるか");
console.log("  f : x ? 1 に [] を渡す :", run("f : x ? 1\nf []"));
console.log("  [] は __ か            :", run("[] = __"), "／", run("[]"));
console.log("\n蓄積の種を「最初の要素」にする（n_queens の形）");
const SEED = "acc :\n\tn\n\tas\n ?\n\tn = 0 : as\n\tacc (n - 1) (n as~)\n";
console.log("  acc 3 3（種＝最初の要素）:", run(SEED + "acc 2 3"));
