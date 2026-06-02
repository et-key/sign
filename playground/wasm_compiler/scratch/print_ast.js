import fs from 'fs';
import { parse } from '../parse/minimal.js';
import { buildAST } from '../semanticize/shunting_yard.js';

const rawAST = parse("map : f x ~y ? @f x , map f y~\n");
const astTrees = rawAST.filter(l => l != null).map(astLine => {
    return buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
});
console.log(JSON.stringify(astTrees, null, 2));
