import peggy from "peggy";
import fs from "fs";
import { preprocess } from "./lexer.js";

const grammar = fs.readFileSync("./sign.pegjs", "utf8");
const parser = peggy.generate(grammar);

const source = "f :\n\tx\n\ty : x + 1\n\tz : y + 1\n\t~rest\n ? x y z rest~";
console.log("RAW:", JSON.stringify(source));
const pre = preprocess(source);
console.log("PRE:", JSON.stringify(pre));
const flat = parser.parse(pre);
console.log("FLAT:", JSON.stringify(flat, null, 1));
