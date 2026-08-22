import { compile } from "./compile.js";
const show = (l, src, charset) => {
  try { compile(src, { charset }); console.log("  " + l.padEnd(30) + "通る"); }
  catch (e) { console.log("  " + l.padEnd(30) + "ERR " + e.message.slice(0, 50)); }
};
show("ascii に ASCII", "s : `hello`", "ascii");
show("ascii に 日本語", "s : `あ`", "ascii");
show("ascii に 0u3042", "s : 0u3042", "ascii");
show("utf32 に 日本語", "s : `あ`", "utf32");
show("charset を渡さなければ検査しない", "s : `あ`", undefined);
