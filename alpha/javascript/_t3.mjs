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
console.log("本体が走ったかどうかで見分ける（本体は定数 1 を返す）");
console.log("  デフォルト無し  + __ :", run("f :\n\tn\n\tas\n ?\n\t1\n" + "f 3 __"));
console.log("  as : 0        + __ :", run("f :\n\tn\n\tas : 0\n ?\n\t1\n" + "f 3 __"));
console.log("  as : __       + __ :", run("f :\n\tn\n\tas : __\n ?\n\t1\n" + "f 3 __"));
console.log("  as : __       + 省略 :", run("f :\n\tn\n\tas : __\n ?\n\t1\n" + "f 3"));
console.log("\nデフォルトの型と呼び出しサイトの型が食い違うと");
console.log("  as : 0 / f 3 [1 2] のみ :", run("f :\n\tn\n\tas : 0\n ?\n\tas\n" + "f 3 [1 2]"));
console.log("  as : 0 / f 3 のみ       :", run("f :\n\tn\n\tas : 0\n ?\n\tas\n" + "f 3"));
