import { Operators } from './operators.js';
import { getIdentName, extractParams } from './ast_utils.js';

export class IRBuilder {
    constructor(propertyRegistry) {
        this.functions = [
            {
                id: '__builtin_id',
                funcIndex: 0,
                freeVars: [],
                params: ['x'],
                body: { type: 'LocalGet', name: 'x', category: 'Atom' }
            }
        ];
        this.funcIdCounter = 1;
        this.projectEnv = new Map();
        this.globalBuiltins = new Set(['print', 'f64.eq', 'f64.ne', 'f64.lt', 'f64.gt', 'f64.add', 'f64.sub', 'f64.mul', 'f64.div']);
        this.propertyRegistry = propertyRegistry;
    }

    inferCategory(ir) {
        switch (ir.type) {
            case 'ClosureAlloc':
            case 'CallPartialAlloc':
            case 'PureFuncPtr':
                return 'Lambda';
            case 'ProjectGet':
                return this.projectEnv.has(ir.name) ? this.projectEnv.get(ir.name).category : 'Atom';
            case 'Sequence':
                return ir.right ? ir.right.category : 'Atom';
            case 'ProjectDef':
                return ir.value ? ir.value.category : 'Atom';
            default:
                return 'Atom';
        }
    }

    generateIR(node, env, currentFunc) {
        const ir = this.generateIRInner(node, env, currentFunc);
        if (!ir) return ir;
        if (!ir.category) {
            ir.category = this.inferCategory(ir);
        }
        return ir;
    }

    generateIRInner(node, env, currentFunc) {
        if (!node) return null;
        
        if (typeof node === 'string') {
            return this.buildPrimitiveString(getIdentName(node), env);
        }

        if (node.type === 'Variable' || node.type === 'Identifier') {
            return this.buildPrimitiveString(getIdentName(node), env);
        }

        if (node.type === 'block') {
            return this.buildBlock(node, env, currentFunc);
        }

        if (node.type === 'operation') {
            return this.buildOperation(node, env, currentFunc);
        }
        
        console.error("generateIR failed on node:", node);
        throw new Error(`SemanticError: Unhandled node type '${node.type}'`);
    }

    buildPrimitiveString(name, env) {
        if (!isNaN(parseFloat(name))) {
            return { type: 'NumberLiteral', value: parseFloat(name) };
        }
        if (env.has(name)) {
            const envVal = env.get(name);
            const mangledName = typeof envVal === 'string' ? envVal : envVal.mangledName;
            const category = typeof envVal === 'string' ? 'Atom' : envVal.category;
            return { type: 'LocalGet', name: mangledName, category: category };
        }
        if (this.projectEnv.has(name) || this.globalBuiltins.has(name)) {
            return { type: 'ProjectGet', name };
        }
        throw new Error(`SemanticError: Undefined variable '${name}'`);
    }

    buildBlock(node, env, currentFunc) {
        if (node.kind === 'paren' || node.kind === 'group') return this.generateIR(node.content, env, currentFunc);
        if (node.kind === 'bracket') return this.buildStructOrArrayAlloc(node.content, env, currentFunc);
        if (node.kind === 'indent') {
            let isPureStruct = true;
            function checkStruct(n) {
                if (!n) return;
                if (n.type === 'operation' && (n.operator === '\\n' || n.operator === ',')) {
                    checkStruct(n.left);
                    checkStruct(n.right);
                    return;
                }
                if (n.type === 'operation' && n.operator === ':') {
                    return;
                }
                isPureStruct = false;
            }
            checkStruct(node.content);

            if (isPureStruct) {
                return this.buildStructOrArrayAlloc(node.content, env, currentFunc);
            } else {
                return this.generateIR(node.content, env, currentFunc);
            }
        }
        throw new Error(`SemanticError: Unsupported block kind '${node.kind}'`);
    }

    buildOperation(node, env, currentFunc) {
        const op = node.operator;
        const name = node.name;

        if (op === '?') return this.buildLambda(node, env, currentFunc);
        if (op === ' ' || name === 'apply') return this.buildApply(node, env, currentFunc);
        if (name === 'concat') return this.buildSequence(node, env, currentFunc);
        if (op === "'") return this.buildStructLoad(node, env, currentFunc);
        if (op === ':') return this.generateIR(node.right, env, currentFunc);

        // Check Operator Registry for custom IR generation or standard binary/prefix fallback
        const actualOp = op || name;
        if (Operators[actualOp]) {
            const opDef = Operators[actualOp];
            if (opDef.generateIR) {
                return opDef.generateIR(node, env, currentFunc, this.generateIR.bind(this));
            } else if (opDef.type === 'binary' || (node.left && node.right)) {
                return {
                    type: 'BinOp',
                    operator: actualOp,
                    left: this.generateIR(node.left, env, currentFunc),
                    right: this.generateIR(node.right, env, currentFunc)
                };
            } else if (opDef.type === 'prefix' || node.left || node.operand) {
                return this.buildPrefix(actualOp, node, env, currentFunc);
            }
        }

        throw new Error(`SemanticError: Unhandled operator '${actualOp}'`);
    }

    buildLambda(node, env, currentFunc) {
        const paramNames = extractParams(node.left).filter(Boolean);
        const funcId = this.funcIdCounter++;
        const funcName = `__func_${funcId}`;
        const funcEnv = new Set(paramNames);
        const freeVars = new Set();
        
        const proxyEnv = {
            has: (name) => {
                if (funcEnv.has(name)) return true;
                if (env.has(name)) {
                    freeVars.add(name);
                    return true;
                }
                return false;
            },
            get: (name) => {
                if (funcEnv.has(name)) return name;
                if (freeVars.has(name)) return `__free_${name}`;
                return null;
            }
        };

        const bodyIR = this.generateIR(node.right, proxyEnv, { id: funcName, locals: new Set() });
        
        const funcDef = {
            id: funcName,
            funcIndex: funcId,
            params: paramNames,
            paramPropertyIndex: paramNames.length > 0 ? this.propertyRegistry.getPropertyIndex(paramNames[0]) : -1,
            locals: [],
            freeVars: Array.from(freeVars).map(v => ({ name: v, outerName: env.get(v) })),
            body: bodyIR
        };
        this.functions.push(funcDef);

        return { type: 'PureFuncPtr', funcIndex: funcId, freeVars: funcDef.freeVars };
    }

    buildApply(node, env, currentFunc) {
        const leftIR = this.generateIR(node.left, env, currentFunc);
        const rightIR = this.generateIR(node.right, env, currentFunc);

        if (leftIR.type === 'PureFuncPtr' || leftIR.category === 'Lambda') {
            return { type: 'CallDynamicUnpack', funcPtr: leftIR, args: [rightIR] };
        }
        
        if (leftIR.type === 'ProjectGet' && this.projectEnv.get(leftIR.name)?.category === 'Lambda') {
            return { type: 'CallDynamicUnpack', funcPtr: leftIR, args: [rightIR] };
        }

        return { type: 'Coproduct', left: leftIR, right: rightIR };
    }

    buildSequence(node, env, currentFunc) {
        return {
            type: 'Sequence',
            left: this.generateIR(node.left, env, currentFunc),
            right: this.generateIR(node.right, env, currentFunc)
        };
    }

    buildStructLoad(node, env, currentFunc) {
        const ptrIR = this.generateIR(node.left, env, currentFunc);
        const key = getIdentName(node.right);
        let index;
        if (!isNaN(key)) {
            index = parseInt(key, 10);
        } else {
            index = this.propertyRegistry.getPropertyIndex(key);
        }
        return { type: 'StructLoad', ptr: ptrIR, index: index };
    }

    buildPrefix(actualOp, node, env, currentFunc) {
        const opd = node.left || node.operand;
        const operandIR = this.generateIR(opd, env, currentFunc);
        
        if (actualOp === '$') {
            let targetIR = operandIR;
            if ((targetIR.type === 'StructAlloc' || targetIR.type === 'ArrayAlloc') && targetIR.elements.length === 1 && (!targetIR.properties || targetIR.properties.length === 0)) {
                targetIR = targetIR.elements[0];
            }
            if (targetIR.type !== 'PureFuncPtr') {
                console.error("Prefix '$' targetIR:", targetIR);
                throw new Error(`SemanticError: Prefix '$' can only be applied to a lambda '?'`);
            }
            return { type: 'ClosureAlloc', funcIndex: targetIR.funcIndex, freeVars: targetIR.freeVars };
        }
        if (actualOp === '@') {
            return operandIR;
        }
        if (actualOp === '~') {
            return { type: 'Expand', target: operandIR };
        }

        return {
            type: 'PrefixOp',
            operator: actualOp,
            operand: operandIR
        };
    }

    buildStructOrArrayAlloc(contentNode, env, currentFunc) {
        const elements = [];
        const properties = [];
        
        const extract = (n) => {
            if (!n) return;
            if (n.type === 'operation' && (n.operator === '\\n' || n.operator === ',')) {
                extract(n.left);
                extract(n.right);
                return;
            }
            if (n.type === 'operation' && n.operator === ':') {
                const key = getIdentName(n.left);
                const index = this.propertyRegistry.getPropertyIndex(key);
                const valIR = this.generateIR(n.right, env, currentFunc);
                properties.push({ index, value: valIR });
                return;
            }
            elements.push(this.generateIR(n, env, currentFunc));
        };
        extract(contentNode);
        
        if (properties.length === 0) {
            return {
                type: 'ArrayAlloc',
                elements
            };
        }

        return {
            type: 'StructAlloc',
            elements,
            properties,
            maxIndex: properties.length > 0 ? Math.max(...properties.map(p => p.index)) : -1
        };
    }
}
