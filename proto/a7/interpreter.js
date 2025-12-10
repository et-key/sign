const { NodeType } = require('./parser');
const { Runtime, Unit } = require('./runtime');

class Environment {
    constructor(parent = null) {
        this.vars = new Map();
        this.parent = parent;
    }

    define(name, value) {
        this.vars.set(name, value);
    }

    get(name) {
        if (this.vars.has(name)) return this.vars.get(name);
        if (this.parent) return this.parent.get(name);
        return Unit; // Unknown identifier returns Unit (undefined) in strict Sign? Or Error?
        // For now, return Unit or maybe throw for debug.
        // console.warn(`Undefined variable: ${name}`);
        return Unit;
    }
}

class Interpreter {
    constructor() {
        this.globalEnv = new Environment();
        // Register standard library or external definitions here if needed
    }

    evaluate(node, env = this.globalEnv) {
        if (!node) return Unit;

        switch (node.type) {
            case NodeType.PROGRAM:
                let lastVal = Unit;
                for (const stmt of node.body) {
                    lastVal = this.evaluate(stmt, env);
                }
                return lastVal;

            case NodeType.LITERAL:
                return node.value;

            case NodeType.IDENTIFIER:
                return env.get(node.name);

            case NodeType.BINARY_EXPRESSION:
                const op = node.operator;

                // Special handling for Definition ':'
                if (op === ':') {
                    // If Left is Identifier: Definition
                    if (node.left.type === NodeType.IDENTIFIER) {
                        const val = this.evaluate(node.right, env);
                        env.define(node.left.name, val);
                        return val;
                    }
                    // If Left is Not Identifier: Treat as Conditional (Guard)
                    // x > 0 : 1  ==> if (x>0) 1 else Unit
                    const condition = this.evaluate(node.left, env);
                    if (Runtime.isTruthy(condition)) {
                        return this.evaluate(node.right, env);
                    }
                    return Unit;
                }

                // Special handling for Function definition '?'
                if (op === '?') {
                    // Left is param(s), Right is body
                    // Return a function structure
                    // For simply: x ? body
                    const paramNode = node.left;
                    const bodyNode = node.right;

                    return {
                        type: 'FUNCTION',
                        param: paramNode.name, // Assume single param for now
                        body: bodyNode,
                        closure: env
                    };
                }

                // Standard Operators
                if (Runtime.ops[op]) {
                    const leftVal = this.evaluate(node.left, env);
                    const rightVal = this.evaluate(node.right, env);
                    return Runtime.ops[op](leftVal, rightVal);
                }

                console.warn(`Unknown operator: ${op}`);
                return Unit;

            case NodeType.APPLY:
                // Function Application
                // left is function, right is argument
                const func = this.evaluate(node.left, env);
                const arg = this.evaluate(node.right, env);

                if (typeof func === 'object' && func.type === 'FUNCTION') {
                    // Call it
                    const newEnv = new Environment(func.closure);
                    newEnv.define(func.param, arg);
                    return this.evaluate(func.body, newEnv);
                }

                // If func is not a function (e.g. Operator as identifier?)
                // TODO: Handle operators passed as values

                return Unit; // Or error

            case NodeType.LIST:
                // List construction
                // items: [ ... ]
                // Evaluate all items
                return node.items.map(item => this.evaluate(item, env));

            case NodeType.BLOCK:
                // Block scope? Or just list of statements returning last?
                // Usually returns last.
                let blockVal = Unit;
                // const blockEnv = new Environment(env); // Blocks might scope?
                // Sign says: "Block structure... definition is local"
                // So yes, new scope.
                const blockEnv = new Environment(env);
                for (const stmt of node.body) {
                    blockVal = this.evaluate(stmt, blockEnv);
                }
                return blockVal;

            default:
                console.warn(`Unknown node type: ${node.type}`);
                return Unit;
        }
    }
}

module.exports = { Interpreter, Environment };
