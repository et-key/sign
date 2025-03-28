'use strict';

import signRuntime from './runtime/signRuntime';

const x = 10;
const y = 5;
const sum = (x + y);
const diff = (x - y);
const product = (x * y);
const quotient = (x / y);
const add = a((b) => return (a + b));
const square = (n) => return Math.pow(n, 2);
const greet = (name) => return `Hello, `(name, `!`);
const result1 = add(7, 3);
const result2 = square(4);
const result3 = greet(`World`);
export { sum };
export { product };
export { result1 };
export { result3 };
