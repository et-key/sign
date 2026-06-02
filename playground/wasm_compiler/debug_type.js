import { evaluateType } from './semanticize/type_evaluator.js';

const ast = {
  type: 'operation',
  operator: ':',
  left: {
    type: 'operation',
    operator: '<',
    left: '<x>',
    right: '1'
  },
  right: '`result1`'
};

const t = evaluateType(ast, new Map());
console.log("evaluateType result:", t);
