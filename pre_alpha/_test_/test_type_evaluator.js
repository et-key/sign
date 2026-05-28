import { evaluateType } from '../semanticize/type_evaluator.js';

// AST for `[x, y] ? x + y`
const ast = {
  type: 'operation',
  operator: '?',
  position: 'infix',
  left: {
    type: 'block',
    kind: 'bracket',
    content: {
      type: 'operation',
      operator: ',',
      position: 'infix',
      left: 'x',
      right: 'y'
    }
  },
  right: {
    type: 'operation',
    operator: '+',
    position: 'infix',
    left: 'x',
    right: 'y'
  }
};

const type = evaluateType(ast);
console.log("AST type evaluation result:", JSON.stringify(type, null, 2));

