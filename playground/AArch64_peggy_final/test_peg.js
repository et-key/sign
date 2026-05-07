const peggy = require("peggy");
const fs = require("fs");

try {
  const grammar = fs.readFileSync("sign.pegjs", "utf8");
  const parser = peggy.generate(grammar, { trace: true });
  
  const lexer = require("./lexer.js");
  const source = fs.readFileSync("test_match.sn", "utf8");
  const lexed = lexer.lex(source);
  console.log("Parsing lexed string:");
  console.log(JSON.stringify(lexed));
  
  let traceOutput = [];
  try {
      parser.parse(lexed, { tracer: { trace: function(e) {
          traceOutput.push(`${e.type} ${e.rule} @ ${e.location.start.offset} - '${lexed.substring(e.location.start.offset, e.location.end.offset)}'`);
      }}});
      console.log("Success!");
  } catch (err) {
      console.error(err.message);
  }
  fs.writeFileSync("trace.txt", traceOutput.join("\n"));
} catch (e) {
  console.error(e.message);
  console.error("Location:", e.location);
}
