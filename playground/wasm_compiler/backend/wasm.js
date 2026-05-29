/**
 * wasm.js
 * Sign Language WebAssembly (WAT) Code Generator
 * Pure JS implementation with no Node.js specific modules (fs, path).
 */

export class WasmGenerator {
  constructor() {
    this.out = [];
    this.labelCounter = 0;
    this.funcNames = [];
  }

  generate(asts) {
    this.out.push('(module');
    
    // I/O Import
    this.out.push('  (import "env" "print" (func $print (param i32)))');
    
    // Core Memory Architecture
    this.out.push('  (memory 1) ;; 1 page = 64KB');
    this.out.push('  (export "memory" (memory 0))');
    this.out.push('');

    // Separate top-level bindings (functions) and expressions
    const topLevelBindings = [];
    const topLevelExpressions = [];

    for (const node of asts) {
      if (!node || typeof node !== 'object') continue;
      if (node.type === 'operation' && node.operator === ':') {
        topLevelBindings.push(node);
        const name = this.getIdentName(node.left);
        if (name && !this.funcNames.includes(name)) {
          this.funcNames.push(name);
        }
      } else {
        topLevelExpressions.push(node);
      }
    }

    if (this.funcNames.length > 0) {
      this.out.push(`  (type $func_sig (func (param i32) (result i32)))`);
      this.out.push(`  (table ${this.funcNames.length} funcref)`);
      let elemStr = `  (elem (i32.const 0)`;
      for (const fn of this.funcNames) {
        elemStr += ` $${fn}`;
      }
      elemStr += `)`;
      this.out.push(elemStr);
      this.out.push('');
    }

    // Process all top-level bindings
    for (const node of topLevelBindings) {
      this.generateFunction(node);
    }

    // Generate implicit main function for top-level expressions
    this.out.push('  (func $main (export "main") (result i32)');
    const mainLocals = new Set();
    const mainParams = [];
    for (const expr of topLevelExpressions) {
      this.collectLocals(expr, mainParams, mainLocals);
    }
    for (const l of mainLocals) {
      this.out.push(`    (local $${l} i32)`);
    }
    
    const env = new Map();
    for (const l of mainLocals) env.set(l, 'local');

    if (topLevelExpressions.length === 0) {
      this.out.push(`    i32.const 0`);
    } else {
      for (let i = 0; i < topLevelExpressions.length; i++) {
        this.generateExpression(topLevelExpressions[i], env);
        if (i < topLevelExpressions.length - 1) {
          this.out.push(`    drop`); // Drop all but the last expression's result
        }
      }
    }
    this.out.push('  )');

    this.out.push(')');
    return this.out.join('\n') + '\n';
  }

  getIdentName(node) {
    if (!node) return '';
    if (typeof node === 'string') {
      if (node.startsWith('<') && node.endsWith('>')) {
        return node.slice(1, -1);
      }
      return node;
    }
    if (node.name) return node.name;
    if (node.type === 'operation' && node.operator === '?') return 'lambda';
    return String(node);
  }

  generateFunction(node) {
    const name = this.getIdentName(node.left);
    let body = node.right;
    
    const params = [];
    const locals = new Set();
    
    if (body && body.type === 'operation' && body.operator === '?') {
      this.extractParams(body.left, params);
      body = body.right;
    } else {
      this.extractParams(node.left, params);
    }
    
    // First pass to collect locals
    this.collectLocals(body, params, locals);
    
    let funcDecl = `  (func $${name}`;
    if (params.length > 0) {
      funcDecl += ` (param $${params[0]} i32)`;
    } else {
      funcDecl += ` (param $__dummy i32)`;
    }
    funcDecl += ` (result i32)`; // Assume every function returns i32 for MVP
    this.out.push(funcDecl);
    
    for (const l of locals) {
      this.out.push(`    (local $${l} i32)`);
    }
    this.out.push(`    (local $__list_ptr i32)`);

    const env = new Map();
    for (const p of params) env.set(p, 'param');
    for (const l of locals) env.set(l, 'local');

    // Generate Body
    this.generateExpression(body, env);
    
    this.out.push('  )');
  }

  extractParams(node, params) {
    if (!node) return;
    if (node.type === 'block') {
      this.extractParams(node.content, params);
      return;
    }
    if (node.type === 'operation' && node.operator === ':') {
      this.extractParams(node.left, params);
      return;
    }
    if (typeof node === 'string') {
      params.push(this.getIdentName(node));
      return;
    }
    if (node.type === 'operation' && (node.operator === ' ' || node.operator === '\\n')) {
      this.extractParams(node.left, params);
      this.extractParams(node.right, params);
      return;
    }
    if (node.type === 'operation' && node.operator === '~' && node.position === 'prefix') {
      const baseName = this.getIdentName(node.operand);
      params.push(`${baseName}_current`);
      params.push(`${baseName}_step`);
      params.push(`${baseName}_limit`);
      return;
    }
  }

  collectLocals(node, params, locals) {
    if (!node) return;
    
    if (typeof node === 'string') return;
    
    if (node.type === 'block') {
      if (node.kind === 'bracket' && node.reduceId === undefined) {
        node.reduceId = this.labelCounter++;
        locals.add(`__reduce_ptr_${node.reduceId}`);
        locals.add(`__reduce_end_${node.reduceId}`);
        locals.add(`__reduce_acc_${node.reduceId}`);
        locals.add(`__map_start_${node.reduceId}`);
      }
      this.collectLocals(node.content, params, locals);
      return;
    }
    
    if (node.type === 'coproduct_block') {
      if (node.statements) {
        for (const stmt of node.statements) {
          this.collectLocals(stmt, params, locals);
        }
      }
      return;
    }
    
    if (node.type === 'operation') {
      if (node.operator === ':') {
        if (typeof node.left === 'string' || (node.left && node.left.type === 'operation' && node.left.operator === '#')) {
          const varName = this.getIdentName(node.left);
          if (!params.includes(varName)) {
            locals.add(varName);
          }
          this.collectLocals(node.right, params, locals);
        } else {
          this.collectLocals(node.left, params, locals);
          this.collectLocals(node.right, params, locals);
        }
        return;
      }
      
      this.collectLocals(node.left, params, locals);
      this.collectLocals(node.right, params, locals);
      if (node.operand) this.collectLocals(node.operand, params, locals);
    }
  }

  generateExpression(node, env) {
    if (!node) return;

    if (typeof node === 'string') {
      if (!isNaN(node) || node.startsWith('0x')) {
        this.out.push(`    i32.const ${Number(node)}`);
        return;
      }

      const name = this.getIdentName(node);
      if (env.has(name)) {
        this.out.push(`    local.get $${name}`);
      } else if (this.funcNames.includes(name)) {
        const idx = this.funcNames.indexOf(name);
        this.out.push(`    i32.const ${idx} ;; Function pointer to ${name}`);
      } else {
        this.out.push(`    ;; Unknown identifier: ${name}`);
        this.out.push(`    i32.const 0`); // Fallback
      }
      return;
    }

    if (node.type === 'block') {
      if (node.kind === 'bracket') {
        const content = node.content;
        if (content && content.type === 'operation' && (content.name === 'apply' || content.name === 'apply_partial' || content.name === 'compose')) {
          const { func, args } = this.flattenApply(content);
          if (func && func.operator === ',' && func.right && args.length > 0) {
            // Map syntax: [func,] list
            // Memory allocation for Map is disabled. 
            // In the future, Map will be compiled as a pure stream transformer connected to a Sink.
            this.out.push(`    ;; Map without Sink is not supported yet in zero-cost stream mode`);
            this.out.push(`    i32.const 0`);
            return;
          }
        }
      }
      this.generateExpression(node.content, env);
      return;
    }

    if (node.type === 'coproduct_block') {
      const cases = node.statements || [];
      if (cases.length === 0) return;
      
      const blockId = this.labelCounter++;
      this.out.push(`    block $B${blockId} (result i32)`);
      
      for (let i = 0; i < cases.length; i++) {
        this.generateExpression(cases[i], env);
        if (i < cases.length - 1) {
          this.out.push(`    ;; TODO: Coproduct branching`);
        }
      }
      this.out.push(`    end`);
      return;
    }

    if (node.type === 'operation') {
      if (node.operator === ':') {
        if (typeof node.left === 'string' || (node.left && node.left.type === 'operation' && node.left.operator === '#')) {
          const varName = this.getIdentName(node.left);
          this.generateExpression(node.right, env);
          this.out.push(`    local.set $${varName}`);
          this.out.push(`    local.get $${varName}`);
        } else {
          this.generateExpression(node.left, env);
          this.out.push(`    if (result i32)`);
          this.generateExpression(node.right, env);
          this.out.push(`    else`);
          this.out.push(`      i32.const 0`);
          this.out.push(`    end`);
        }
        return;
      }

      if (['+', '-', '*'].includes(node.operator)) {
        this.generateExpression(node.left, env);
        this.generateExpression(node.right, env);
        switch (node.operator) {
          case '+': this.out.push(`    i32.add`); break;
          case '-': this.out.push(`    i32.sub`); break;
          case '*': this.out.push(`    i32.mul`); break;
        }
        return;
      }

      if (['||', '&&', ';;'].includes(node.operator)) {
        this.generateExpression(node.left, env);
        this.generateExpression(node.right, env);
        switch (node.operator) {
          case '||': this.out.push(`    i32.or`); break;
          case '&&': this.out.push(`    i32.and`); break;
          case ';;': this.out.push(`    i32.xor`); break;
        }
        return;
      }
      
      if (node.operator === '!!' && node.position === 'prefix') {
        this.out.push(`    i32.const -1`);
        this.generateExpression(node.operand, env);
        this.out.push(`    i32.xor`);
        return;
      }

      if (node.operator === '\\n') {
        const fallback = node.right && node.right.operator === ' ' && node.right.left === '``';
        if (fallback && node.left && node.left.operator === ':') {
          // Translate pattern match fallback to if/else
          this.generateExpression(node.left.left, env); // Condition
          this.out.push(`    if (result i32)`);
          this.generateExpression(node.left.right, env); // True branch
          this.out.push(`    else`);
          this.generateExpression(node.right.right, env); // Fallback branch
          this.out.push(`    end`);
          return;
        }
        
        // Normal sequence
        this.generateExpression(node.left, env);
        this.out.push(`    drop`);
        this.generateExpression(node.right, env);
        return;
      }

      if (['<', '>', '==', '!=', '<=', '>=', '='].includes(node.operator)) {
        this.generateExpression(node.left, env);
        this.generateExpression(node.right, env);
        switch(node.operator) {
          case '==': this.out.push(`    i32.eq`); break;
          case '=':  this.out.push(`    i32.eq`); break;
          case '!=': this.out.push(`    i32.ne`); break;
          case '<':  this.out.push(`    i32.lt_s`); break;
          case '>':  this.out.push(`    i32.gt_s`); break;
          case '<=': this.out.push(`    i32.le_s`); break;
          case '>=': this.out.push(`    i32.ge_s`); break;
        }
        return;
      }
      
      if (node.operator === '@' && node.position === 'prefix') {
        this.generateExpression(node.operand, env);
        this.out.push(`    i32.load`);
        return;
      }
      
      if (node.operator === "'") {
        this.generateExpression(node.left, env); // pointer
        this.generateExpression(node.right, env); // index
        this.out.push(`    i32.const 2`); // scale index
        this.out.push(`    i32.shl`);
        this.out.push(`    i32.add`); // pointer + offset
        this.out.push(`    i32.load`); // get the value
        return;
      }

      if (node.operator === '#' && (!node.position || node.position === 'infix')) {
        this.generateExpression(node.left, env);
        this.generateExpression(node.right, env);
        this.out.push(`    i32.store`);
        this.out.push(`    i32.const 0 ;; store returns unit`);
        return;
      }

      let isApply = node.name === 'apply' || node.name === 'apply_partial' || node.name === 'compose';
      
      if (node.name === 'concat') {
        if (this.isCallableBase(node, env)) {
          isApply = true;
        }
      }

      if (isApply) {
        const { func, args } = this.flattenApply(node);

        if (func.kind === 'bracket') {
          // Reduce syntax: [+] (10 20 30)
          const listNode = args[0];
          
          let listLength = 0;
          let content = listNode;
          if (content && content.kind === 'paren') content = content.content;
          const elements = this.flattenConcat(content);
          
          if (elements.length > 0) {
            // First element is the initial accumulator
            this.generateExpression(elements[0], env);
            
            // Loop over remaining elements and apply operator
            for (let i = 1; i < elements.length; i++) {
              this.generateExpression(elements[i], env);
              const opNode = func.content;
              if (opNode.operator === '+') {
                this.out.push(`    i32.add`);
              } else if (opNode.operator === '*') {
                this.out.push(`    i32.mul`);
              } else if (opNode.operator === '-') {
                this.out.push(`    i32.sub`);
              }
            }
          } else {
            this.out.push(`    i32.const 0 ;; empty reduce`);
          }
          return;
        }
        
        if (args.length > 0) {
           this.generateExpression(args[0], env);
        } else {
           this.out.push(`    i32.const 0 ;; dummy arg for MVP`);
        }
        
        if (typeof func === 'string') {
          const funcName = this.getIdentName(func);
          if (!env.has(funcName)) {
            // Direct call to top-level function
            this.out.push(`    call $${funcName}`);
          } else {
            // Local variable holding a function pointer
            this.out.push(`    local.get $${funcName}`);
            this.out.push(`    call_indirect (type $func_sig)`);
          }
        } else {
          // Dynamic expression evaluating to a function pointer
          this.generateExpression(func, env);
          this.out.push(`    call_indirect (type $func_sig)`);
        }
        return;
      }

      if (node.name === 'concat' || node.name === 'short_circuit') {
        const elements = this.flattenConcat(node);
        
        if (elements.length === 0) {
          this.out.push(`    i32.const 0`);
          return;
        }

        for (let i = 0; i < elements.length; i++) {
          this.generateExpression(elements[i], env);
          if (i < elements.length - 1) {
            // Drop intermediate values for MVP if concat is used directly
            this.out.push(`    drop`);
          }
        }
        
        return;
      }

    }
    
    this.out.push(`    ;; Unhandled node: ${node.type} ${node.operator || node.name || ''}`);
    this.out.push(`    i32.const 0`);
  }

  isCallableBase(node, env) {
    if (!node) return false;
    if (typeof node === 'string') {
      const name = this.getIdentName(node);
      return env.has(name) || this.funcNames.includes(name);
    }
    if (node.type === 'operation' && (node.name === 'apply' || node.name === 'apply_partial' || node.name === 'compose' || node.name === 'concat' || node.name === 'newline')) {
      return this.isCallableBase(node.left, env);
    }
    return false;
  }

  flattenConcat(node) {
    let elements = [];
    if (node && node.type === 'operation') {
      if (node.name === 'concat' || node.name === 'short_circuit' || node.name === 'newline') {
        elements = elements.concat(this.flattenConcat(node.left));
        elements = elements.concat(this.flattenConcat(node.right));
        return elements;
      }
      if (node.operator === ' ' && !node.name) {
        // Fallback for unresolved spaces that are meant to be concat
        elements = elements.concat(this.flattenConcat(node.left));
        elements = elements.concat(this.flattenConcat(node.right));
        return elements;
      }
    }
    if (node) elements.push(node);
    return elements;
  }

  flattenApply(node) {
    let args = [];
    let curr = node;
    while (curr && curr.type === 'operation' && 
          (curr.name === 'apply' || curr.name === 'apply_partial' || curr.name === 'compose' || 
          curr.name === 'concat' || curr.name === 'newline')) {
      args.unshift(curr.right);
      curr = curr.left;
    }
    return { func: curr, args };
  }
}

export function generateWasm(asts) {
  const gen = new WasmGenerator();
  return gen.generate(asts);
}
