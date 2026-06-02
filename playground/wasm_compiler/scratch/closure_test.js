import { parse } from '../parse/minimal.js';
const ast = parse("map : f x ~y ? @f x , map f y~\\nmap $[* 2] 1 2 3 4 5\\n");
console.log(JSON.stringify(ast, null, 2));
