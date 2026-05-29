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
    this.aliasEnv = new Map(); // Stores compile-time aliases for streams and structs
  }

  generate(asts) {
    this.out = [];
    this.labelCounter = 0;
    this.funcNames = [];
    this.funcArities = new Map(); // Store arity for top-level functions
    this.aliasEnv = new Map();

    this.out.push('(module');
    
    // I/O Import
    this.out.push('  (import "env" "print" (func $print (param i32)))');
    
    // Core Memory Architecture
    this.out.push('  (memory 1) ;; 1 page = 64KB');
    this.out.push('  (export "memory" (memory 0))');
    this.out.push('  (type $func_sig (func (param i32) (result i32)))');
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
        const isLambda = node.left && node.left.type === 'operation' && node.left.operator === '?';
        const rightIsLambda = node.right && node.right.type === 'operation' && node.right.operator === '?';
        if (!isLambda && !rightIsLambda && this.isCompileTimeAlias(node.right)) {
          // Store as compile-time alias instead of top-level function
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

  isCompileTimeAlias(node) {
    if (!node) return false;
    if (typeof node === 'string') {
      const name = this.getIdentName(node);
      return this.aliasEnv.has(name);
    }
    if (node.type === 'operation') {
      if (['concat', 'short_circuit', 'newline'].includes(node.name)) return true; // Streams
      if (['apply', 'apply_partial', 'compose'].includes(node.name)) {
        return this.isCompileTimeAlias(node.right) || this.isCompileTimeAlias(node.left);
      }
    }
    if (node.type === 'block') {
      return this.isCompileTimeAlias(node.content);
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
    if (node.type === 'operation' && node.operator === '?') return this.getIdentName(node.left);
    if (node.name) return node.name;
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
    
    this.funcArities.set(name, params.length);
    
    let funcDecl = `  (func $${name}`;
    if (params.length > 0) {
      for (const p of params) {
        funcDecl += ` (param $${p} i32)`;
      }
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
    if (node.type === 'coproduct_block') {
      if (node.statements) {
        for (const stmt of node.statements) {
          this.extractParams(stmt, params);
        }
      }
      return;
    }
    if (node.type === 'operation' && node.operator === ':') {
      this.extractParams(node.left, params);
      return;
    }
    if (node.type === 'operation' && node.operator === '?') {
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
      if (node.operator === '#') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          locals.add(`__sink_ptr_${node.reduceId}`);
        }
      }
      if (node.operator === '~') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          locals.add(`__loop_val_${node.reduceId}`);
          locals.add(`__loop_step_${node.reduceId}`);
          locals.add(`__loop_limit_${node.reduceId}`);
        }
      }
      if (node.operator === '\\n') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          locals.add(`__fallback_tmp_${node.reduceId}`);
        }
      }
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
      if (this.aliasEnv.has(name)) {
        this.generateExpression(this.aliasEnv.get(name), env);
        return;
      }
      
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
          if (this.isCompileTimeAlias(node.right)) {
            this.aliasEnv.set(varName, node.right);
          } else {
            this.generateExpression(node.right, env);
            this.out.push(`    local.set $${varName}`);
            this.out.push(`    local.get $${varName}`);
          }
        } else {
          this.generateExpression(node.left, env);
          this.out.push(`    if (result i32)`);
          this.generateExpression(node.right, env);
          this.out.push(`    else`);
          this.out.push(`      i32.const -2147483648 ;; Unit`);
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
        const tmpLocal = `__fallback_tmp_${node.reduceId}`;
        this.generateExpression(node.left, env);
        this.out.push(`    local.set $${tmpLocal}`);
        this.out.push(`    local.get $${tmpLocal}`);
        this.out.push(`    i32.const -2147483648 ;; Unit check`);
        this.out.push(`    i32.ne`);
        this.out.push(`    if (result i32)`);
        this.out.push(`      local.get $${tmpLocal}`);
        this.out.push(`    else`);
        this.generateExpression(node.right, env);
        this.out.push(`    end`);
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
        // Stream Fusion Sink: Memory Store (Dynamic Runtime Pointer)
        if (node.reduceId === undefined) {
           node.reduceId = this.labelCounter++;
        }
        const ptrLocal = `__sink_ptr_${node.reduceId}`;
        
        this.generateExpression(node.left, env);
        this.out.push(`    local.set $${ptrLocal}`);

        const streamContext = { isString: false };
        this.generateStream(node.right, env, streamContext, (valNode) => {
          this.out.push(`    local.get $${ptrLocal}`);
          this.generateExpression(valNode, env); // Value
          if (streamContext.isString) {
             this.out.push(`    i32.store ;; string cast`);
          } else {
             this.out.push(`    i32.store`);
          }
          // Dynamic pointer increment (fixed width 4 bytes for MVP)
          this.out.push(`    local.get $${ptrLocal}`);
          this.out.push(`    i32.const 4`);
          this.out.push(`    i32.add`);
          this.out.push(`    local.set $${ptrLocal}`);
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
            this.generateStream(listNode, env, streamContext, (valNode) => {
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
        
        let arity = 1;
        if (typeof func === 'string') {
          const funcName = this.getIdentName(func);
          if (this.funcArities.has(funcName)) {
            arity = this.funcArities.get(funcName);
          }
        }
        
        for (let i = 0; i < arity; i++) {
          if (i < args.length) {
            this.generateExpression(args[i], env);
          } else {
            this.out.push(`    i32.const 0 ;; missing arg`);
          }
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
        this.generateStream(node, env, { isString: false }, (valNode) => {
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
  generateStream(node, env, streamContext, emitSink) {
    if (!node) return;
    
    if (typeof node === 'string') {
      if (node === '``') {
        streamContext.isString = true;
        return; // Empty string `_` evaluates to nothing
      }
      const name = this.getIdentName(node);
      if (this.aliasEnv.has(name)) {
        this.generateStream(this.aliasEnv.get(name), env, streamContext, emitSink);
        return;
      }
    }
    
    // 1. Transformer: Map (apply)
    if (node.type === 'operation' && node.name === 'apply') {
       const { func, args } = this.flattenApply(node);
       if (func && func.kind === 'bracket') {
         const opNode = func.content;
         if (opNode.operator === ',') {
           // Map syntax: [* 2,] list
           const transformerFunc = opNode.right; 
           const listNode = args[0];
           
           const mappedSink = (valNode) => {
             const applyNode = {
               type: 'operation',
               operator: ' ',
               name: 'apply',
               left: transformerFunc,
               right: valNode
             };
             emitSink(applyNode);
           };
           
           this.generateStream(listNode, env, streamContext, mappedSink);
           return;
         }
       }
    }

    // 2. Source: Concat (Static Unrolled List)
    if (node.type === 'operation' && (node.name === 'concat' || node.name === 'short_circuit' || node.name === 'newline' || node.operator === ' ')) {
       this.generateStream(node.left, env, streamContext, emitSink);
       this.generateStream(node.right, env, streamContext, emitSink);
       return;
    }
    
    // 3. Block Content Wrapper
    if (node.type === 'block' && (node.kind === 'paren' || node.kind === 'group')) {
       this.generateStream(node.content, env, streamContext, emitSink);
       return;
    }

    // 4. Dynamic Loops (e.g. [0 ~+ 1 ~ 5])
    if (node.type === 'block' && node.kind === 'bracket') {
      if (node.content && node.content.type === 'operation' && node.content.operator === '~') {
        const loopNode = node.content;
        const startNode = loopNode.left && loopNode.left.operator === '~+' ? loopNode.left.left : loopNode.left;
        const stepNode = loopNode.left && loopNode.left.operator === '~+' ? loopNode.left.right : '1';
        const limitNode = loopNode.right;
        const loopId = loopNode.reduceId;

        this.generateExpression(startNode, env);
        this.out.push(`    local.set $__loop_val_${loopId}`);
        this.generateExpression(stepNode, env);
        this.out.push(`    local.set $__loop_step_${loopId}`);
        this.generateExpression(limitNode, env);
        this.out.push(`    local.set $__loop_limit_${loopId}`);

        this.out.push(`    loop $L${loopId}`);
        
        // Emit current loop value
        emitSink(`__loop_val_${loopId}`);

        // Increment value
        this.out.push(`    local.get $__loop_val_${loopId}`);
        this.out.push(`    local.get $__loop_step_${loopId}`);
        this.out.push(`    i32.add`);
        this.out.push(`    local.set $__loop_val_${loopId}`);

        // Check condition (le_s)
        this.out.push(`    local.get $__loop_val_${loopId}`);
        this.out.push(`    local.get $__loop_limit_${loopId}`);
        this.out.push(`    i32.le_s`);
        this.out.push(`    br_if $L${loopId}`);
        this.out.push(`    end`);
        return;
      }
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
