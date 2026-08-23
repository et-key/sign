const fs = require("fs");
const target = process.argv[2];
const ids = process.argv.slice(3);
const R = (f) => fs.readFileSync("_pp/" + f, "utf8").replace(/\r\n/g, "\n").replace(/\n$/, "");
let s = fs.readFileSync(target, "utf8");
const crlf = s.includes("\r\n");
s = s.replace(/\r\n/g, "\n");
for (const i of ids) {
  const a = R("a" + i), b = R("b" + i);
  const n = s.split(a).length - 1;
  if (n !== 1) { console.error("count " + i + ": " + n + "\n---\n" + a.slice(0, 110)); process.exit(1); }
  s = s.replace(a, () => b);
}
fs.writeFileSync(target, crlf ? s.replace(/\n/g, "\r\n") : s);
console.log("patched " + target + " [" + ids.join(",") + "]");
