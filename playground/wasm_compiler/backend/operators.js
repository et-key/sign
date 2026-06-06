/**
 * Operator Registry for Sign Language WASM Compiler
 * Maps AST operator symbols to their Intermediate Representation (IR) generation logic
 * and WebAssembly (WAT) emission macros.
 * 
 * Separation of Concerns: 
 * - semantic_analyzer.js only walks the AST and calls `generateIR` or falls back to standard `BinOp`/`PrefixOp`.
 * - wasm_emitter.js looks up the operator here to generate the final S-expression.
 */

export const Operators = {
    // === Arithmetic ===
    '+': {
        type: 'binary',
        emit: (left, right) => `(f64.add ${left} ${right})`
    },
    '-': {
        type: 'binary',
        emit: (left, right) => `(f64.sub ${left} ${right})`
    },
    '*': {
        type: 'binary',
        emit: (left, right) => `(f64.mul ${left} ${right})`
    },
    '/': {
        type: 'binary',
        emit: (left, right) => `(f64.div ${left} ${right})`
    },
    // Missing '%' in MVP natively for f64, we might need to implement a macro later, 
    // but for now we map it to a call or leave it unsupported/placeholder.
    '%': {
        type: 'binary',
        emit: (left, right) => `(f64.const 0) ;; Unimplemented f64.mod`
    },

    // === Comparison ===
    // Comparisons return the LEFT operand if true, and NaN (Unit) if false.
    // Done elegantly using WASM 'select'.
    '=': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.eq (local.get $__tmp_f64) ${right})))`
    },
    '!=': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.ne (local.get $__tmp_f64) ${right})))`
    },
    '<': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.lt (local.get $__tmp_f64) ${right})))`
    },
    '>': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.gt (local.get $__tmp_f64) ${right})))`
    },
    '<=': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.le (local.get $__tmp_f64) ${right})))`
    },
    '>=': {
        type: 'binary',
        emit: (left, right) => `(block (result f64) (local.set $__tmp_f64 ${left}) (select (local.get $__tmp_f64) (f64.const nan) (f64.ge (local.get $__tmp_f64) ${right})))`
    },

    // === Short-Circuit Logic ===
    // If a node's statically inferred category is 'Lambda' or 'Unit', it evaluates to false (NaN).
    // Truthiness is checked by (f64.eq v v) which is true for numbers and false for NaN.
    '|': {
        type: 'binary',
        emit: (left, right, leftNode, rightNode) => {
            if (leftNode && (leftNode.category === 'Lambda' || leftNode.category === 'Unit')) {
                return `(block (result f64) (drop ${left}) ${right})`;
            }
            return `(block (result f64)
                (local.set $__tmp_f64 ${left})
                (if (result f64)
                    (f64.eq (local.get $__tmp_f64) (local.get $__tmp_f64)) ;; true if not NaN
                    (then (local.get $__tmp_f64))
                    (else ${right})
                )
            )`;
        }
    },
    '&': {
        type: 'binary',
        emit: (left, right, leftNode, rightNode) => {
            if (leftNode && (leftNode.category === 'Lambda' || leftNode.category === 'Unit')) {
                return `(block (result f64) (drop ${left}) (f64.const nan))`;
            }
            return `(block (result f64)
                (local.set $__tmp_f64 ${left})
                (if (result f64)
                    (f64.ne (local.get $__tmp_f64) (local.get $__tmp_f64)) ;; true if NaN
                    (then (local.get $__tmp_f64))
                    (else ${right})
                )
            )`;
        }
    },
    ';': { // XOR (Logical)
        type: 'binary',
        emit: (left, right, leftNode, rightNode) => {
            const isLeftFalsy = leftNode && (leftNode.category === 'Lambda' || leftNode.category === 'Unit');
            const isRightFalsy = rightNode && (rightNode.category === 'Lambda' || rightNode.category === 'Unit');
            
            const leftExpr = isLeftFalsy ? `(block (result i32) (drop ${left}) (i32.const 0))` : `(f64.eq ${left} ${left})`;
            const rightExpr = isRightFalsy ? `(block (result i32) (drop ${right}) (i32.const 0))` : `(f64.eq ${right} ${right})`;
            
            return `(f64.convert_i32_u (i32.xor ${leftExpr} ${rightExpr}))`;
        }
    },

    // === Bitwise ===
    '||': {
        type: 'binary',
        emit: (left, right) => `(f64.convert_i64_s (i64.or (i64.trunc_f64_s ${left}) (i64.trunc_f64_s ${right})))`
    },
    '&&': {
        type: 'binary',
        emit: (left, right) => `(f64.convert_i64_s (i64.and (i64.trunc_f64_s ${left}) (i64.trunc_f64_s ${right})))`
    },
    ';;': {
        type: 'binary',
        emit: (left, right) => `(f64.convert_i64_s (i64.xor (i64.trunc_f64_s ${left}) (i64.trunc_f64_s ${right})))`
    },
    '<<': {
        type: 'binary',
        emit: (left, right) => `(f64.convert_i64_s (i64.shl (i64.trunc_f64_s ${left}) (i64.trunc_f64_s ${right})))`
    },
    '>>': {
        type: 'binary',
        emit: (left, right) => `(f64.convert_i64_s (i64.shr_s (i64.trunc_f64_s ${left}) (i64.trunc_f64_s ${right})))`
    },
    '!!': {
        type: 'prefix',
        emit: (operand) => `(f64.convert_i64_s (i64.xor (i64.trunc_f64_s ${operand}) (i64.const -1)))`
    },

    // === Core Language Constructs ===
    // These generate custom IR nodes or are handled directly in analyzer.
    '\\n': {
        type: 'sequence',
        generateIR: (node, env, currentFunc, walker) => {
            return {
                type: 'Sequence',
                left: walker(node.left, env, currentFunc),
                right: walker(node.right, env, currentFunc)
            };
        }
    },
    '$': {
        type: 'prefix'
    },
    '@': {
        type: 'prefix'
    },
    '~': {
        // Technically ~ is postfix (expand) or prefix (continuous) or infix (range).
        // Since operators.js doesn't distinguish by position yet, we mark it as prefix/unary so it passes the check.
        // The AST will provide node.operand for postfix.
        type: 'prefix'
    },
    '-': {
        // Unary minus (negation) is handled if left is undefined
        type: 'prefix',
        emit: (operand) => `(f64.neg ${operand})`
    },
    '!': {
        type: 'prefix', // logical NOT
        emit: (operand, dummy, operandNode) => {
            if (operandNode && (operandNode.category === 'Lambda' || operandNode.category === 'Unit')) {
                // If it's falsy, NOT should return true fallback (!_)
                // We use -1 to represent !_ internally.
                return `(block (result f64) (drop ${operand}) (f64.const 500000))`;
            }
            // If operand is truthy (not NaN), NOT returns NaN (Unit).
            // If operand is falsy (NaN), NOT returns -1 (!_)
            return `(block (result f64)
                (local.set $__tmp_f64 ${operand})
                (select
                    (f64.const 500000)      ;; True (!_) is the 'id' function
                    (f64.const nan)         ;; False (_)
                    (f64.ne (local.get $__tmp_f64) (local.get $__tmp_f64)) ;; Cond (is NaN?)
                )
            )`;
        }
    }
};
