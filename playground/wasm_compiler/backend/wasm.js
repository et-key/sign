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
      if (node === null || node === undefined) continue;
      if (typeof node !== 'object') {
        topLevelExpressions.push(node);
        continue;
      }
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

    // Filter top-level expressions for Dead Code Elimination (DCE)
    // Keep the last expression (for implicit return) and any expressions with side effects
    const filteredExpressions = [];
    for (let i = 0; i < topLevelExpressions.length; i++) {
      const expr = topLevelExpressions[i];
      if (i === topLevelExpressions.length - 1 || this.hasSideEffects(expr, env)) {
        filteredExpressions.push(expr);
      }
    }

    if (filteredExpressions.length === 0) {
      this.out.push(`    i32.const 0`);
    } else {
      for (let i = 0; i < filteredExpressions.length; i++) {
        this.generateExpression(filteredExpressions[i], env);
        if (i < filteredExpressions.length - 1) {
          this.out.push(`    drop`); // Drop all but the last expression's result
        }
      }
    }
    this.out.push('  )');

    this.out.push(')');
    return this.out.join('\n') + '\n';
  }

  hasSideEffects(node, env) {
    if (!node) return false;
    if (typeof node === 'string') return false;
    
    if (node.type === 'operation') {
      if (node.operator === '#') return true; // IO Store
      if (node.name === 'apply' || node.name === 'apply_partial' || node.name === 'compose') {
        // Function calls might have side effects, but we must check if it's a Map operation 
        // A pure map without a Sink has no side effects!
        const { func, args } = this.flattenApply(node);
        if (func && func.kind === 'bracket') {
          const opNode = func.content;
          if (opNode && opNode.operator === ',') {
            return false; // Map has no side effects unless piped to a Sink!
          }
        }
        return true; 
      }
      if (node.operator === ':') return true; // Bindings
      
      return this.hasSideEffects(node.left, env) || 
             this.hasSideEffects(node.right, env) || 
             this.hasSideEffects(node.operand, env);
    }
    if (node.type === 'block') {
      return this.hasSideEffects(node.content, env);
    }
    if (node.type === 'coproduct_block') {
      return node.statements && node.statements.some(stmt => this.hasSideEffects(stmt, env));
    }
    return false;
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
        // Stream Fusion Sink: Memory Store
        // ptr # stream -> Stores values sequentially starting at ptr
        
        // Ensure ptr is evaluated and kept in a local for sequential writing
        const ptrLocalId = this.labelCounter++;
        const ptrLocal = `__stream_ptr_${ptrLocalId}`;
        
        // Define local dynamically if we need it (using a hack for MVP or pre-allocated locals)
        // Since collectLocals doesn't know about ptrLocal dynamically, we should allocate it.
        // Wait, collectLocals can do it! For now, we reuse the generic generator approach or pre-allocate in main.
        // Actually, we can generate a loop using the stack if we are careful, but using a local is safer.
        // For zero-cost stream fusion, we provide a callback:
        const sinkCallback = (valueNode, envInner) => {
          this.out.push(`    ;; Sink # store element`);
          // Evaluate pointer
          this.generateExpression(node.left, envInner); // Note: For static loops we re-evaluate ptr, but we should add offset!
          // We need a loop index! 
          // Since our current generateStream unrolls statically, we can just use an offset.
        };
        // Let's implement static unrolling first for simple streams.
        let offset = 0;
        this.generateStream(node.right, env, (valNode) => {
          this.generateExpression(node.left, env); // Base ptr
          if (offset > 0) {
            this.out.push(`    i32.const ${offset * 4}`);
            this.out.push(`    i32.add`);
          }
          this.generateExpression(valNode, env); // Value
          this.out.push(`    i32.store`);
          offset++;
        });
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
          const opNode = func.content;
          
          if (args.length > 0) {
            const listNode = args[0];
            let isFirst = true;
            this.generateStream(listNode, env, (valNode) => {
              this.generateExpression(valNode, env);
              if (!isFirst) {
                if (opNode.operator === '+') this.out.push(`    i32.add`);
                else if (opNode.operator === '*') this.out.push(`    i32.mul`);
                else if (opNode.operator === '-') this.out.push(`    i32.sub`);
              }
              isFirst = false;
            });
            if (isFirst) {
              this.out.push(`    i32.const 0 ;; empty reduce`);
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
        } else if (func && func.type === 'operation' && ['+', '-', '*'].includes(func.operator)) {
          // Inline partial application (e.g. `* 2`)
          if (func.right) {
            this.generateExpression(func.right, env);
            if (func.operator === '+') this.out.push(`    i32.add`);
            else if (func.operator === '*') this.out.push(`    i32.mul`);
            else if (func.operator === '-') this.out.push(`    i32.sub`);
          } else {
            this.out.push(`    ;; Unhandled left-partial operator inline`);
          }
        } else {
          // Dynamic expression evaluating to a function pointer
          this.generateExpression(func, env);
          this.out.push(`    call_indirect (type $func_sig)`);
        }
        return;
      }

      if (node.name === 'concat' || node.name === 'short_circuit') {
        // Standalone concat (not fused into a Sink)
        // Just evaluate and drop intermediate values
        let lastNode = null;
        this.generateStream(node, env, (valNode) => {
          if (lastNode !== null) {
            this.generateExpression(lastNode, env);
            this.out.push(`    drop`);
          }
          lastNode = valNode;
        });
        if (lastNode !== null) {
          this.generateExpression(lastNode, env);
        } else {
          this.out.push(`    i32.const 0`);
        }
        return;
      }

    }
    
    this.out.push(`    ;; Unhandled node: ${node.type} ${node.operator || node.name || ''}`);
    this.out.push(`    i32.const 0`);
  }

  /**
   * generateStream: Implements Stream Fusion (CPS style)
   * Instead of pushing values to the stack or memory, this iterates over a stream source 
   * and passes each element to emitSink.
   */
  generateStream(node, env, emitSink) {
    if (!node) return;
    
    // 1. Transformer: Map (apply)
    if (node.type === 'operation' && node.name === 'apply') {
       const { func, args } = this.flattenApply(node);
       if (func && func.kind === 'bracket') {
         const opNode = func.content;
         if (opNode.operator === ',') {
           // Map syntax: [* 2,] list
           const transformerFunc = opNode.right; // e.g. `* 2` (partial application)
           const listNode = args[0];
           
           // We create a Mapped Sink that applies the function before calling the original Sink
           const mappedSink = (valNode) => {
             // For now, since Map applies a function, we construct an AST node for the application 
             // and pass it to emitSink. This allows inline evaluation!
             const applyNode = {
               type: 'operation',
               operator: ' ',
               name: 'apply',
               left: transformerFunc,
               right: valNode
             };
             emitSink(applyNode);
           };
           
           // Delegate back to the source stream
           this.generateStream(listNode, env, mappedSink);
           return;
         }
       }
    }

    // 2. Source: Concat (Static Unrolled List)
    if (node.type === 'operation' && (node.name === 'concat' || node.name === 'short_circuit' || node.name === 'newline' || node.operator === ' ')) {
       this.generateStream(node.left, env, emitSink);
       this.generateStream(node.right, env, emitSink);
       return;
    }
    
    // 3. Block Content Wrapper
    if (node.type === 'block' && (node.kind === 'paren' || node.kind === 'group')) {
       this.generateStream(node.content, env, emitSink);
       return;
    }

    // Default: Single Element Source
    emitSink(node);
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
