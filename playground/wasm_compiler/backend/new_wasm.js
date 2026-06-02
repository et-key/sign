/**
 * new_wasm.js
 * Redesigned Sign Language WebAssembly (WAT) Code Generator
 */

import { evaluateType } from '../semanticize/type_evaluator.js';

export class WasmGenerator {
  constructor() {
    this.out = [];
    this.labelCounter = 0;
    this.funcNames = [];
    this.aliasEnv = new Map();
    this.funcArities = new Map();
    this.funcDefaults = new Map();
    this.stringPool = new Map();
    this.dataOffset = 1024;
  }

  generate(asts) {
    this.out = [];
    this.labelCounter = 0;
    this.funcNames = [];
    this.aliasEnv = new Map();
    this.funcArities = new Map();
    this.funcDefaults = new Map();
    this.stringPool = new Map();
    this.dataOffset = 1024;

    this.out.push('(module');
    this.out.push('  (import "env" "print" (func $print (param i32)))');
    this.out.push('  (memory 1)');
    this.out.push('  (export "memory" (memory 0))');
    this.out.push('  (type $func_sig (func (param f64) (result f64)))');
    this.out.push('');

    const topLevelBindings = [];
    const topLevelExpressions = [];

    for (const node of asts) {
      if (!node) continue;
      if (typeof node === 'object' && node.type === 'operation' && node.operator === ':') {
        const isLambda = node.left && node.left.type === 'operation' && node.left.operator === '?';
        const rightIsLambda = node.right && node.right.type === 'operation' && node.right.operator === '?';
        if (!isLambda && !rightIsLambda && this.isCompileTimeAlias(node.right)) {
          this.aliasEnv.set(this.getIdentName(node.left), node.right);
        } else {
          topLevelBindings.push(node);
          const name = this.getIdentName(node.left);
          if (name && !this.funcNames.includes(name)) {
            this.funcNames.push(name);
          }
        }
      } else {
        topLevelExpressions.push(node);
      }
    }

    if (this.funcNames.length > 0) {
      this.out.push(`  (table ${this.funcNames.length} funcref)`);
      let elemStr = `  (elem (i32.const 0)`;
      for (const fn of this.funcNames) elemStr += ` $${fn}`;
      elemStr += `)`;
      this.out.push(elemStr);
      this.out.push('');
    }

    for (const node of topLevelBindings) {
      this.generateFunction(node);
    }

    this.out.push('  (func $main (export "main") (result f64)');
    const mainLocals = new Map();
    const mainParams = [];
    const mainTypeEnv = new Map();
    for (const expr of topLevelExpressions) {
      this.collectLocals(expr, mainLocals, mainTypeEnv);
    }
    for (const [l, type] of mainLocals.entries()) {
      this.out.push(`    (local $${l} ${type})`);
    }

    const env = mainTypeEnv;
    for (const l of mainLocals.keys()) env.set(l, mainLocals.get(l));

    const filteredExpressions = [];
    for (let i = 0; i < topLevelExpressions.length; i++) {
      const expr = topLevelExpressions[i];
      if (i === topLevelExpressions.length - 1 || this.hasSideEffects(expr)) {
        filteredExpressions.push(expr);
      }
    }

    if (filteredExpressions.length === 0) {
      this.out.push(`    f64.const 0`);
    } else {
      for (let i = 0; i < filteredExpressions.length; i++) {
        const type = this.getType(filteredExpressions[i], env);
        this.generateExpression(filteredExpressions[i], env);
        if (i < filteredExpressions.length - 1) {
           this.out.push(`    drop`);
        } else {
           if (type === 'i64') this.out.push(`    f64.convert_i64_s`);
        }
      }
    }
    this.out.push('  )');

    if (this.thunks && this.thunks.length > 0) {
      this.out.push('');
      for (const thunk of this.thunks) this.out.push(thunk);
    }

    for (const [str, offset] of this.stringPool.entries()) {
      let bytes = [];
      for (let i = 0; i < str.length; i++) {
        const buffer = new ArrayBuffer(8);
        const view = new DataView(buffer);
        view.setFloat64(0, str.charCodeAt(i), true);
        for (let j = 0; j < 8; j++) {
          let hex = view.getUint8(j).toString(16);
          if (hex.length === 1) hex = '0' + hex;
          bytes.push('\\' + hex);
        }
      }
      this.out.push(`  (data (i32.const ${offset}) "${bytes.join('')}")`);
    }
    if (this.stringPool.size > 0) this.out.push('');
    this.out.push(')');
    return this.out.join('\n') + '\n';
  }

  isCompileTimeAlias(node) {
    if (!node) return false;
    if (typeof node === 'string') return this.aliasEnv.has(this.getIdentName(node));
    if (node.type === 'operation') {
      if (['concat', 'short_circuit', 'newline'].includes(node.name)) return true;
      if (['apply', 'apply_partial', 'compose'].includes(node.name)) {
        return this.isCompileTimeAlias(node.right) || this.isCompileTimeAlias(node.left);
      }
    }
    if (node.type === 'block') return this.isCompileTimeAlias(node.content);
    return false;
  }

  hasSideEffects(node) {
    if (!node || typeof node === 'string') return false;
    if (node.type === 'operation') {
      if (node.operator === '#') return true;
      if (['apply', 'apply_partial', 'compose'].includes(node.name)) return true; // Function calls may have side effects
      if (node.operator === ':') return true;
      return this.hasSideEffects(node.left) || this.hasSideEffects(node.right) || this.hasSideEffects(node.operand);
    }
    if (node.type === 'block') return this.hasSideEffects(node.content);
    if (node.type === 'coproduct_block') return node.statements?.some(s => this.hasSideEffects(s));
    return false;
  }

  getIdentName(node) {
    if (!node) return '';
    if (typeof node === 'string') {
      if (node.startsWith('<') && node.endsWith('>')) return node.slice(1, -1);
      return node;
    }
    if (node.type === 'operation' && node.operator === '?') return this.getIdentName(node.left);
    if (node.name) return node.name;
    if (node.type === 'block') {
       if (node.content && node.content.operator) {
          return `block_${node.kind}_${this.getIdentName(node.content.operator)}`;
       }
       return `block_${node.kind}`;
    }
    return 'unknown_ident';
  }

  extractParams(node, params, defaults) {
    if (!node) return;
    if (node.type === 'block') return this.extractParams(node.content, params, defaults);
    if (node.type === 'coproduct_block') {
      node.statements?.forEach(s => this.extractParams(s, params, defaults));
      return;
    }
    if (node.type === 'operation' && node.operator === ':') return this.extractParams(node.left, params, defaults);
    if (node.type === 'operation' && node.operator === '?') return this.extractParams(node.left, params, defaults);
    if (typeof node === 'string') {
      params.push(this.getIdentName(node));
      defaults.push(false);
      return;
    }
    if (node.type === 'operation' && (node.operator === ' ' || node.operator === '\\n')) {
      this.extractParams(node.left, params, defaults);
      this.extractParams(node.right, params, defaults);
      return;
    }
  }

  getType(node, env) {
    if (!node) return 'f64';
    if (typeof node === 'string') {
      if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0u') || (node.startsWith('`') && node.endsWith('`')) || node.startsWith('\\')) return 'i64';
      if (!isNaN(node)) return 'f64';
      return env.has(node) ? env.get(node) : 'f64';
    }
    
    const semanticType = evaluateType(node, env);
    return this.mapTypeToWasm(semanticType);
  }

  mapTypeToWasm(semanticType) {
    const typeName = typeof semanticType === 'string' ? semanticType : (semanticType && semanticType.type) ? semanticType.type : 'Unknown';
    if (['Address', 'Register', 'String', 'Char', 'List', 'Dictionary', 'Deref', 'Implicit'].includes(typeName)) return 'i64';
    if (typeName === 'Union') {
       if (semanticType.types && semanticType.types.some(t => this.mapTypeToWasm(t) === 'i64')) return 'i64';
    }
    return 'f64';
  }

  collectLocals(node, locals, env) {
    if (!node || typeof node === 'string') return;
    
    if (node.type === 'operation') {
      if (node.operator === ':') {
        const type = this.getType(node.right, env);
        if (typeof node.left === 'string') {
          locals.set(this.getIdentName(node.left), type);
          env.set(this.getIdentName(node.left), type);
        }
      } else if (node.operator === '\\n') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          const type = this.getType(node.right, env); // Fallback right hand side dominates type if left is Unit
          locals.set(`__fallback_tmp_${node.reduceId}`, type);
        }
      } else if (node.operator === '#') {
        if (node.reduceId === undefined) {
           node.reduceId = this.labelCounter++;
           locals.set(`__sink_ptr_${node.reduceId}`, this.getType(node.left, env));
        }
      }
      this.collectLocals(node.left, locals, env);
      this.collectLocals(node.right, locals, env);
      this.collectLocals(node.operand, locals, env);
    } else if (node.type === 'block' || node.type === 'Lambda') {
      this.collectLocals(node.content || node.body, locals, env);
    } else if (node.type === 'coproduct_block') {
      node.statements?.forEach(s => this.collectLocals(s, locals, env));
    }
  }

  generateFunction(node) {
    const name = this.getIdentName(node.left);
    let body = node.right;
    const params = [];
    const defaults = [];
    const locals = new Map();

    if (body && body.type === 'operation' && body.operator === '?') {
      this.extractParams(body.left, params, defaults);
      body = body.right;
    } else {
      this.extractParams(node.left, params, defaults);
    }
    
    this.funcDefaults.set(name, defaults);
    this.funcArities.set(name, params.length);
    
    const typeEnv = new Map();
    for (const p of params) typeEnv.set(p, 'f64');
    this.collectLocals(node, locals, typeEnv);
    
    let funcDecl = `  (func $${name}`;
    if (params.length > 0) {
      for (const p of params) funcDecl += ` (param $${p} f64)`;
    } else {
      funcDecl += ` (param $__dummy f64)`;
    }
    
    // Functions always return f64 in MVP compiler to match call_indirect signatures
    funcDecl += ` (result f64)`; 
    this.out.push(funcDecl);
    
    for (const [l, type] of locals.entries()) {
      this.out.push(`    (local $${l} ${type})`);
    }

    const env = typeEnv;
    for (const [l, type] of locals.entries()) env.set(l, type);

    const retType = this.getType(body, env);
    this.generateExpression(body, env);
    if (retType === 'i64') {
       this.out.push(`    f64.convert_i64_s`);
    }
    this.out.push('  )');
  }

  generateExpression(node, env) {
    if (!node) {
       this.out.push(`    f64.const nan`);
       return;
    }

    if (typeof node === 'string') {
      if (node.startsWith('`') && node.endsWith('`')) {
        const strVal = node.slice(1, -1);
        if (!this.stringPool.has(strVal)) {
          this.stringPool.set(strVal, this.dataOffset);
          this.dataOffset += strVal.length * 8;
        }
        this.out.push(`    i64.const ${this.stringPool.get(strVal)}`);
        return;
      }
      if (node.startsWith('\\')) {
        const code = node.length > 1 ? node.charCodeAt(1) : 0;
        this.out.push(`    i64.const ${code}`);
        return;
      }
      if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0u')) {
        let valStr = node;
        if (node.startsWith('0r') || node.startsWith('0u')) valStr = node.slice(2);
        this.out.push(`    i64.const ${Number(valStr)}`);
        return;
      }
      if (!isNaN(node)) {
        this.out.push(`    f64.const ${Number(node)}`);
        return;
      }

      const name = this.getIdentName(node);
      if (env.has(name)) {
        this.out.push(`    local.get $${name}`);
      } else if (this.funcNames.includes(name)) {
        const idx = this.funcNames.indexOf(name);
        this.out.push(`    f64.const ${idx} ;; Func ptr`);
      } else {
        this.out.push(`    ;; Unknown var: ${name}`);
        this.out.push(`    f64.const nan`);
      }
      return;
    }

    if (node.type === 'block') {
      if (node.kind === 'abs') {
        const type = this.getType(node.content, env);
        this.generateExpression(node.content, env);
        if (type === 'f64') this.out.push(`    f64.abs`);
        else {
           this.out.push(`    i64.const 0x7FFFFFFFFFFFFFFF`);
           this.out.push(`    i64.and`);
        }
        return;
      }
      this.generateExpression(node.content, env);
      return;
    }

    if (node.type === 'coproduct_block') {
      const cases = node.statements || [];
      if (cases.length === 0) {
         this.out.push(`    f64.const nan`);
         return;
      }
      const blockId = this.labelCounter++;
      this.out.push(`    block $B${blockId} (result f64)`);
      for (let i = 0; i < cases.length; i++) {
        const type = this.getType(cases[i], env);
        this.generateExpression(cases[i], env);
        if (type === 'i64') this.out.push(`    f64.convert_i64_s`);
        if (i < cases.length - 1) this.out.push(`    drop ;; drop unused branches for now`);
      }
      this.out.push(`    end`);
      return;
    }

    if (node.type === 'operation') {
      if (node.operator === ':') {
        const varName = this.getIdentName(node.left);
        if (this.isCompileTimeAlias(node.right)) {
          this.aliasEnv.set(varName, node.right);
          this.out.push(`    f64.const nan`); // Bindings return unit
        } else if (env.has(varName)) {
          this.generateExpression(node.right, env);
          this.out.push(`    local.set $${varName}`);
          this.out.push(`    local.get $${varName}`); // Return assigned value
        } else {
           // Pattern matching condition
           const condType = this.getType(node.left, env);
           this.generateExpression(node.left, env);
           if (condType === 'f64') this.out.push(`    i32.trunc_f64_s`);
           else if (condType === 'i64') this.out.push(`    i32.wrap_i64`);
           
           const blockType = this.getType(node.right, env);
           this.out.push(`    if (result ${blockType})`);
           this.generateExpression(node.right, env);
           this.out.push(`    else`);
           if (blockType === 'f64') this.out.push(`      f64.const nan`);
           else this.out.push(`      i64.const 0`);
           this.out.push(`    end`);
        }
        return;
      }

      if (['+', '-', '*'].includes(node.operator)) {
        const leftType = this.getType(node.left, env);
        const rightType = this.getType(node.right, env);
        this.generateExpression(node.left, env);
        if (leftType === 'i64' && rightType === 'f64') this.out.push(`    f64.convert_i64_s`);
        
        this.generateExpression(node.right, env);
        if (leftType === 'f64' && rightType === 'i64') this.out.push(`    f64.convert_i64_s`);

        if (leftType === 'i64' && rightType === 'i64') {
          if (node.operator === '+') this.out.push(`    i64.add`);
          if (node.operator === '-') this.out.push(`    i64.sub`);
          if (node.operator === '*') this.out.push(`    i64.mul`);
        } else {
          if (node.operator === '+') this.out.push(`    f64.add`);
          if (node.operator === '-') this.out.push(`    f64.sub`);
          if (node.operator === '*') this.out.push(`    f64.mul`);
        }
        return;
      }

      if (['||', '&&', ';;', '<<', '>>'].includes(node.operator)) {
        const leftType = this.getType(node.left, env);
        this.generateExpression(node.left, env);
        if (leftType === 'f64') this.out.push(`    i64.trunc_f64_s`);

        const rightType = this.getType(node.right, env);
        this.generateExpression(node.right, env);
        if (rightType === 'f64') this.out.push(`    i64.trunc_f64_s`);

        if (node.operator === '||') this.out.push(`    i64.or`);
        if (node.operator === '&&') this.out.push(`    i64.and`);
        if (node.operator === ';;') this.out.push(`    i64.xor`);
        if (node.operator === '<<') this.out.push(`    i64.shl`);
        if (node.operator === '>>') this.out.push(`    i64.shr_s`);
        return;
      }

      if (node.operator === '\\n') {
        const tmpLocal = `__fallback_tmp_${node.reduceId}`;
        const rightType = this.getType(node.right, env);
        
        this.generateExpression(node.left, env);
        
        // Ensure left evaluates to rightType so we can store it in tmpLocal
        const leftType = this.getType(node.left, env);
        if (leftType === 'f64' && rightType === 'i64') this.out.push(`    i64.trunc_f64_s`);
        if (leftType === 'i64' && rightType === 'f64') this.out.push(`    f64.convert_i64_s`);
        
        this.out.push(`    local.set $${tmpLocal}`);
        this.out.push(`    local.get $${tmpLocal}`);
        
        if (rightType === 'f64') {
          this.out.push(`    local.get $${tmpLocal}`);
          this.out.push(`    f64.ne`);
          this.out.push(`    if (result f64)`); // IS NOT NaN
        } else {
          this.out.push(`    i64.eqz`);
          this.out.push(`    if (result i64)`);
        }
        
        this.generateExpression(node.right, env);
        this.out.push(`    else`);
        this.out.push(`      local.get $${tmpLocal}`);
        this.out.push(`    end`);
        return;
      }

      if (['<', '>', '==', '!=', '<=', '>=', '='].includes(node.operator)) {
        this.generateExpression(node.left, env);
        const lType = this.getType(node.left, env);
        if (lType === 'i64') this.out.push(`    f64.convert_i64_s`);
        
        this.generateExpression(node.right, env);
        const rType = this.getType(node.right, env);
        if (rType === 'i64') this.out.push(`    f64.convert_i64_s`);
        
        if (node.operator === '==') this.out.push(`    f64.eq`);
        if (node.operator === '=')  this.out.push(`    f64.eq`);
        if (node.operator === '!=') this.out.push(`    f64.ne`);
        if (node.operator === '<')  this.out.push(`    f64.lt`);
        if (node.operator === '>')  this.out.push(`    f64.gt`);
        if (node.operator === '<=') this.out.push(`    f64.le`);
        if (node.operator === '>=') this.out.push(`    f64.ge`);
        
        this.out.push(`    f64.convert_i32_s`);
        return;
      }

      if (node.operator === '@' && node.position === 'prefix') {
        const opType = this.getType(node.operand, env);
        this.generateExpression(node.operand, env);
        if (opType === 'f64') this.out.push(`    i32.trunc_f64_s`);
        else if (opType === 'i64') this.out.push(`    i32.wrap_i64`);
        this.out.push(`    f64.load`);
        return;
      }

      if (node.operator === "'") {
        const leftType = this.getType(node.left, env);
        this.generateExpression(node.left, env);
        if (leftType === 'f64') this.out.push(`    i32.trunc_f64_s`);
        else if (leftType === 'i64') this.out.push(`    i32.wrap_i64`);
        
        const rightType = this.getType(node.right, env);
        this.generateExpression(node.right, env);
        if (rightType === 'f64') this.out.push(`    i32.trunc_f64_s`);
        else if (rightType === 'i64') this.out.push(`    i32.wrap_i64`);

        this.out.push(`    i32.const 3`);
        this.out.push(`    i32.shl`);
        this.out.push(`    i32.add`);
        this.out.push(`    f64.load`);
        return;
      }

      let isApply = node.name === 'apply' || node.name === 'apply_partial' || node.name === 'compose';
      if (node.name === 'concat' && this.isCallableBase(node, env)) isApply = true;

      if (isApply) {
        let func = node;
        let args = [];
        let curr = node;
        while (curr && curr.type === 'operation' && (curr.name === 'apply' || curr.name === 'apply_partial' || curr.name === 'compose' || curr.name === 'concat' || curr.name === 'newline')) {
          args.unshift(curr.right);
          curr = curr.left;
        }
        func = curr;

        // Skip partial application logic for simplicity in this rewrite, assume full evaluation
        let actualArgs = [];
        const extractArgs = (n) => {
          if (!n) return;
          if (n.type === 'operation' && (n.operator === ' ' || n.name === 'concat' || n.operator === '\\n')) {
             extractArgs(n.left); extractArgs(n.right);
          } else {
             actualArgs.push(n);
          }
        };
        for (const arg of args) extractArgs(arg);

        for (const arg of actualArgs) {
          const t = this.getType(arg, env);
          this.generateExpression(arg, env);
          if (t === 'i64') this.out.push(`    f64.convert_i64_s`);
        }

        // Fill remaining params with NaN
        const funcName = this.getIdentName(func);
        let arity = this.funcArities.get(funcName) || 1;
        while (actualArgs.length < arity) {
           this.out.push(`    f64.const nan`);
           actualArgs.push(null);
        }

        if (typeof func === 'string') {
          if (!env.has(funcName)) {
            this.out.push(`    call $${funcName}`);
          } else {
            this.out.push(`    local.get $${funcName}`);
            this.out.push(`    i32.trunc_f64_s`);
            this.out.push(`    call_indirect (type $func_sig)`);
          }
        } else {
          this.generateExpression(func, env);
          this.out.push(`    i32.trunc_f64_s`);
          this.out.push(`    call_indirect (type $func_sig)`);
        }
        return;
      }

      if (node.name === 'concat' || node.name === 'short_circuit') {
         this.generateExpression(node.left, env);
         this.out.push(`    drop`);
         this.generateExpression(node.right, env);
         return;
      }
    }
    
    this.out.push(`    ;; Unhandled: ${node.type} ${node.operator||node.name||''}`);
    this.out.push(`    f64.const nan`);
  }

  isCallableBase(node, env) {
    if (!node) return false;
    if (typeof node === 'string') {
      const name = this.getIdentName(node);
      return env.has(name) || this.funcNames.includes(name);
    }
    if (node.type === 'operation' && ['apply', 'apply_partial', 'compose', 'concat', 'newline'].includes(node.name)) {
      return this.isCallableBase(node.left, env);
    }
    return false;
  }
}

export function generateWasm(asts) {
  const gen = new WasmGenerator();
  return gen.generate(asts);
}
