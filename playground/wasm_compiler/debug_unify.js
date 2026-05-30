import fs from 'fs';
import { preprocess } from './lexisize/lexer.js';
import * as parser from './parse/minimal.js';
import { buildAST } from './semanticize/shunting_yard.js';
import { annotateContextualOperators, liftLambdas, infer, generateST, Substitution, resetTVarCounter, createChildEnv } from './semanticize/analyzer/index.js';
import util from 'util';

const source = `f : x ? x * 2
map : g x ~y ? [@g x] [map g y~]
result_map1 : map $f 1 2 3 4 5`;

resetTVarCounter();
const tokens = preprocess(source);
const cst = parser.parse(tokens);
const astLines = cst.filter(line => line !== null && line !== undefined);

let typeEnv = new Map();
const subst = new Substitution();
const lambdaState = { lambdas: [], counter: 0 };

const astTrees = astLines.map(astLine => {
  let astTree = buildAST(Array.isArray(astLine) && astLine.length === 1 && Array.isArray(astLine[0]) ? astLine[0] : astLine);
  astTree = annotateContextualOperators(astTree);
  infer(astTree, typeEnv, subst);
  return liftLambdas(astTree, lambdaState);
});

if (lambdaState.lambdas.length > 0) {
  for (const lambda of lambdaState.lambdas) {
    infer(lambda, typeEnv, subst);
  }
  astTrees.push(...lambdaState.lambdas);
}

function resolveTypeDetails(node, subst) {
  if (!node || typeof node !== 'object') return;
  if (node.type_detail) {
    node.type_detail = subst.apply(node.type_detail);
  }
  for (const key of Object.keys(node)) {
    if (key !== 'type_detail') {
      if (Array.isArray(node[key])) {
        node[key].forEach(c => resolveTypeDetails(c, subst));
      } else if (typeof node[key] === 'object') {
        resolveTypeDetails(node[key], subst);
      }
    }
  }
}

for (const tree of astTrees) {
  resolveTypeDetails(tree, subst);
}

const fNode = astTrees.find(n => n.left === '<f>');
const mapNode = astTrees.find(n => n.left === '<map>');
const resultNode = astTrees.find(n => n.left === '<result_map1>');

console.log('f type:', util.inspect(fNode.right.type_detail, {depth: null, colors: true}));
console.log('map type:', util.inspect(mapNode.right.type_detail, {depth: null, colors: true}));
console.log('result_map1 type:', util.inspect(resultNode.right.type_detail, {depth: null, colors: true}));
