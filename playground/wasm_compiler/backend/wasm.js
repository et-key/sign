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
    this.funcDefaults = new Map(); // Track which parameters have defaults
    this.aliasEnv = new Map();

    this.out.push('(module');
    
    // I/O Import
    this.out.push('  (import "env" "print" (func $print (param i32)))');
    
    // Core Memory Architecture
    this.out.push('  (memory 1) ;; 1 page = 64KB');
    this.out.push('  (export "memory" (memory 0))');
    this.out.push('  (type $func_sig (func (param f64) (result f64)))');
    this.out.push('');

    this.stringPool = new Map(); // string literal -> offset
    this.dataOffset = 1024; // Start allocating strings at 1024

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
    this.out.push('  (func $main (export "main") (result f64)');
    const mainLocals = new Map();
    const mainParams = [];
    const mainTypeEnv = new Map();
    for (const expr of topLevelExpressions) {
      this.collectLocals(expr, mainParams, mainLocals, mainTypeEnv);
    }
    for (const [l, type] of mainLocals.entries()) {
      this.out.push(`    (local $${l} ${type})`);
    }
    
    const env = mainTypeEnv;
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
      this.out.push(`    f64.const 0`);
    } else {
      for (let i = 0; i < filteredExpressions.length; i++) {
        this.generateExpression(filteredExpressions[i], env);
        if (i < filteredExpressions.length - 1) {
          this.out.push(`    drop`); // Drop all but the last expression's result
        }
      }
    }
    this.out.push('  )');

    if (this.thunks && this.thunks.length > 0) {
      this.out.push('');
      for (const thunk of this.thunks) {
        this.out.push(thunk);
      }
    }

    // Output Data Section (Strings) at the end of the module
    for (const [str, offset] of this.stringPool.entries()) {
      // Encode string as f64 array (8 bytes per char)
      let bytes = [];
      for (let i = 0; i < str.length; i++) {
        const code = str.charCodeAt(i);
        // Little endian f64 encoding of the integer value
        const buffer = new ArrayBuffer(8);
        const view = new DataView(buffer);
        view.setFloat64(0, code, true); // true = little endian
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
    for (const p of params) typeEnv.set(p, 'f64'); // Functions params are currently f64
    this.collectLocals(node, params, locals, typeEnv);
    
    let funcDecl = `  (func $${name}`;
    if (params.length > 0) {
      for (const p of params) {
        funcDecl += ` (param $${p} f64)`;
      }
    } else {
      funcDecl += ` (param $__dummy f64)`;
    }
    // Return type inference: check the body of the function
    const returnType = node.body ? this.getType(node.body, typeEnv) : 'f64';
    funcDecl += ` (result ${returnType})`; 
    this.out.push(funcDecl);
    
    for (const [l, type] of locals.entries()) {
      this.out.push(`    (local $${l} ${type})`);
    }
    this.out.push(`    (local $__list_ptr f64)`); // Default

    const env = typeEnv;
    for (const p of params) env.set(p, 'f64');
    for (const l of locals.keys()) env.set(l, 'local');

    // Generate Body
    this.generateExpression(body, env);
    
    this.out.push('  )');
  }

  extractParams(node, params, defaults, hasDefault = false) {
    if (!node) return;
    if (node.type === 'block') {
      this.extractParams(node.content, params, defaults, hasDefault);
      return;
    }
    if (node.type === 'coproduct_block') {
      if (node.statements) {
        for (const stmt of node.statements) {
          this.extractParams(stmt, params, defaults, hasDefault);
        }
      }
      return;
    }
    if (node.type === 'operation' && node.operator === ':') {
      this.extractParams(node.left, params, defaults, true);
      return;
    }
    if (node.type === 'operation' && node.operator === '?') {
      this.extractParams(node.left, params, defaults, hasDefault);
      return;
    }
    if (typeof node === 'string') {
      params.push(this.getIdentName(node));
      defaults.push(hasDefault);
      return;
    }
    if (node.type === 'operation' && (node.operator === ' ' || node.operator === '\\n')) {
      this.extractParams(node.left, params, defaults, hasDefault);
      this.extractParams(node.right, params, defaults, hasDefault);
      return;
    }
    if (node.type === 'operation' && node.operator === '~' && node.position === 'prefix') {
      const baseName = this.getIdentName(node.operand);
      params.push(`${baseName}_current`); defaults.push(hasDefault);
      params.push(`${baseName}_step`); defaults.push(hasDefault);
      params.push(`${baseName}_limit`); defaults.push(hasDefault);
      return;
    }
  }

  collectLocals(node, params, locals, typeEnv = new Map()) {
    if (!node) return;
    
    if (typeof node === 'string') {
      return;
    }

    if (node.type === 'operation') {
      if (node.operator === ':') {
        const type = this.getType(node.right, typeEnv);
        if (typeof node.left === 'string') {
          locals.set(node.left, type);
          typeEnv.set(node.left, type);
        }
        this.collectLocals(node.right, params, locals, typeEnv);
        return;
      }
      if (node.operator === '#') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          const type = this.getType(node.left, typeEnv);
          locals.set(`__sink_ptr_${node.reduceId}`, type);
        }
      }
      if (node.operator === '~') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          const type = this.getType(node.left, typeEnv);
          locals.set(`__loop_val_${node.reduceId}`, type);
          locals.set(`__loop_step_${node.reduceId}`, type);
          locals.set(`__loop_limit_${node.reduceId}`, type);
        }
      }
      if (node.operator === '\\n') {
        if (node.reduceId === undefined) {
          node.reduceId = this.labelCounter++;
          const type = this.getType(node.left, typeEnv);
          locals.set(`__fallback_tmp_${node.reduceId}`, type);
        }
      }
      
      this.collectLocals(node.left, params, locals, typeEnv);
      this.collectLocals(node.right, params, locals, typeEnv);
      this.collectLocals(node.operand, params, locals, typeEnv);
    } else if (node.type === 'block') {
      if (node.kind === 'bracket' && node.reduceId === undefined) {
        node.reduceId = this.labelCounter++;
        locals.set(`__reduce_ptr_${node.reduceId}`, 'f64');
        locals.set(`__reduce_end_${node.reduceId}`, 'f64');
        locals.set(`__reduce_acc_${node.reduceId}`, 'f64');
        locals.set(`__map_start_${node.reduceId}`, 'f64');
      }
      this.collectLocals(node.content, params, locals, typeEnv);
    } else if (node.type === 'Lambda') {
      this.collectLocals(node.body, params, locals, typeEnv);
    } else if (node.type === 'coproduct_block') {
      if (node.statements) {
        for (const stmt of node.statements) {
          this.collectLocals(stmt, params, locals, typeEnv);
        }
      }
    }
  }

  getType(node, env) {
    if (!node) return 'f64';
    if (typeof node === 'string') {
      if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0u') || (node.startsWith('`') && node.endsWith('`')) || node.startsWith('\\')) return 'i64';
      if (!isNaN(node)) return 'f64';
      return env.get(node) || 'f64';
    }
    if (node.type === 'block') {
      if (node.kind === 'abs') return this.getType(node.content, env);
      return this.getType(node.content, env);
    }
    if (node.type === 'operation') {
      if ([':', '=', '+=', '-=', '*=', '/='].includes(node.operator)) return this.getType(node.right, env);
      if (['||', '&&', ';;', '<<', '>>'].includes(node.operator)) return 'i64';
      if (['<', '>', '==', '!=', '<=', '>=', '='].includes(node.operator)) return 'f64'; // Comparison ops are converted to f64 in generateExpression
      if (['+', '-', '*'].includes(node.operator)) {
        const leftType = this.getType(node.left, env);
        const rightType = this.getType(node.right, env);
        if (leftType === 'i64' && rightType === 'i64') return 'i64';
        return 'f64';
      }
      if (node.operator === '\\n') {
         return this.getType(node.left, env); // Fallback operator, assume left type dominates
      }
    }
    return 'f64'; // Default to f64 for MVP
  }

  generateExpression(node, env) {
    if (!node) return;

    if (typeof node === 'string') {
      if (node.startsWith('`') && node.endsWith('`')) {
        const strVal = node.slice(1, -1);
        if (!this.stringPool.has(strVal)) {
          this.stringPool.set(strVal, this.dataOffset);
          this.dataOffset += strVal.length * 8; // 8 bytes per char
        }
        this.out.push(`    i64.const ${this.stringPool.get(strVal)}`); // String pointer is Address (i64)
        return;
      }
      if (node.startsWith('\\')) {
        const char = node.slice(1);
        const code = char.length === 1 ? char.charCodeAt(0) : 0;
        this.out.push(`    i64.const ${code}`); // Char is i64
        return;
      }
      if (node.startsWith('0x') || node.startsWith('0r') || node.startsWith('0u')) {
        let valStr = node;
        if (node.startsWith('0r') || node.startsWith('0u')) {
          valStr = node.slice(2);
        }
        this.out.push(`    i64.const ${Number(valStr)}`); // Address/Register is i64
        return;
      }
      if (!isNaN(node)) {
        this.out.push(`    f64.const ${Number(node)}`); // Normal number is f64
        return;
      }

      const name = this.getIdentName(node);
      if (env.has(name)) {
        this.out.push(`    local.get $${name}`); // Local variable (could be i64 or f64)
      } else if (this.funcNames.includes(name)) {
        const idx = this.funcNames.indexOf(name);
        this.out.push(`    f64.const ${idx} ;; Function pointer to ${name}`); // Function pointer as f64 for now
      } else {
        this.out.push(`    ;; Unknown identifier: ${name}`);
        this.out.push(`    f64.const 0`);
      }
      return;
    }

    if (node.type === 'block') {
      if (node.kind === 'abs') {
        const type = this.getType(node.content, env);
        this.generateExpression(node.content, env);
        if (type === 'f64') {
           this.out.push(`    f64.abs`);
        } else {
           // i64 abs: (x ^ (x >> 63)) - (x >> 63)
           this.out.push(`    ;; i64 abs not natively supported in WASM, using generic fallback`);
           this.out.push(`    ;; Need local to do i64 abs cleanly, but for now we just mask sign bit if user expects bitwise abs`);
           this.out.push(`    i64.const 0x7FFFFFFFFFFFFFFF`);
           this.out.push(`    i64.and`);
        }
        return;
      }
      if (node.kind === 'bracket') {
        const content = node.content;
        if (content && content.type === 'operation' && (content.name === 'apply' || content.name === 'apply_partial' || content.name === 'compose')) {
          const { func, args } = this.flattenApply(content);
          if (func && func.operator === ',' && func.right && args.length > 0) {
            // Map syntax: [func,] list
            // Memory allocation for Map is disabled. 
            // In the future, Map will be compiled as a pure stream transformer connected to a Sink.
            this.out.push(`    ;; Map without Sink is not supported yet in zero-cost stream mode`);
            this.out.push(`    f64.const 0`);
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
      this.out.push(`    block $B${blockId} (result f64)`);
      
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
          const condType = this.getType(node.left, env);
          this.generateExpression(node.left, env);
          if (condType === 'f64') {
             this.out.push(`    i32.trunc_f64_s`); // convert f64 condition to i32 for if
          } else if (condType === 'i64') {
             this.out.push(`    i32.wrap_i64`); // convert i64 condition to i32 for if
          }
          const blockType = this.getType(node.right, env);
          this.out.push(`    if (result ${blockType})`);
          this.generateExpression(node.right, env);
          this.out.push(`    else`);
          if (blockType === 'f64') {
            this.out.push(`      f64.const nan ;; Unit`);
          } else {
            this.out.push(`      i64.const 0 ;; Unit for i64`);
          }
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
          switch (node.operator) {
            case '+': this.out.push(`    i64.add`); break;
            case '-': this.out.push(`    i64.sub`); break;
            case '*': this.out.push(`    i64.mul`); break;
          }
        } else {
          switch (node.operator) {
            case '+': this.out.push(`    f64.add`); break;
            case '-': this.out.push(`    f64.sub`); break;
            case '*': this.out.push(`    f64.mul`); break;
          }
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

        switch (node.operator) {
          case '||': this.out.push(`    i64.or`); break;
          case '&&': this.out.push(`    i64.and`); break;
          case ';;': this.out.push(`    i64.xor`); break;
          case '<<': this.out.push(`    i64.shl`); break;
          case '>>': this.out.push(`    i64.shr_s`); break;
        }
        // Result is kept as i64 (pure Register/Address)
        return;
      }
      
      if (node.operator === '!!' && node.position === 'prefix') {
        this.out.push(`    i64.const -1`);
        const opType = this.getType(node.operand, env);
        this.generateExpression(node.operand, env);
        if (opType === 'f64') this.out.push(`    i64.trunc_f64_s`);
        this.out.push(`    i64.xor`);
        // Keeps i64
        return;
      }

      if (node.operator === '\\n') {
        const tmpLocal = `__fallback_tmp_${node.reduceId}`;
        const type = this.getType(node.left, env); // Assume fallback block uses the same type
        this.generateExpression(node.left, env);
        this.out.push(`    local.set $${tmpLocal}`);
        this.out.push(`    local.get $${tmpLocal}`);
        
        if (type === 'f64') {
          this.out.push(`    local.get $${tmpLocal}`);
          this.out.push(`    f64.ne ;; Unit (NaN) check: x != x`);
          this.out.push(`    if (result f64)`); // If it IS NOT NaN
        } else {
          this.out.push(`    i64.eqz ;; Unit (0) check for i64`);
          this.out.push(`    if (result i64)`);
        }
        
        this.generateExpression(node.right, env); // Evaluate fallback
        this.out.push(`    else`);
        this.out.push(`      local.get $${tmpLocal}`);
        this.out.push(`    end`);
        return;
      }

      if (['<', '>', '==', '!=', '<=', '>=', '='].includes(node.operator)) {
        const isLambda = (n) => {
          if (typeof n === 'string') {
             const name = this.getIdentName(n);
             return this.funcNames.includes(name) && !env.has(name);
          }
          if (n && n.type === 'operation' && n.operator === '?') return true;
          return false;
        };

        if (isLambda(node.left) || isLambda(node.right)) {
           this.out.push(`    f64.const nan ;; Lambda comparison yields Unit`);
           return;
        }

        this.generateExpression(node.left, env);
        this.generateExpression(node.right, env);
        switch(node.operator) {
          case '==': this.out.push(`    f64.eq`); break;
          case '=':  this.out.push(`    f64.eq`); break;
          case '!=': this.out.push(`    f64.ne`); break;
          case '<':  this.out.push(`    f64.lt`); break;
          case '>':  this.out.push(`    f64.gt`); break;
          case '<=': this.out.push(`    f64.le`); break;
          case '>=': this.out.push(`    f64.ge`); break;
        }
        this.out.push(`    f64.convert_i32_s`);
        return;
      }
      
      if (node.operator === '@' && node.position === 'prefix') {
        const opType = this.getType(node.operand, env);
        this.generateExpression(node.operand, env);
        if (opType === 'f64') this.out.push(`    i32.trunc_f64_s`); 
        else if (opType === 'i64') this.out.push(`    i32.wrap_i64`);
        this.out.push(`    f64.load`); // MVP Load assumes reading an f64
        return;
      }
      
      if (node.operator === '~' && node.position === 'postfix') {
        const baseName = this.getIdentName(node.operand);
        this.out.push(`    local.get $${baseName}_current`);
        this.out.push(`    local.get $${baseName}_step`);
        this.out.push(`    f64.add`); // Extracted element (next value)
        
        this.out.push(`    local.get $${baseName}_current`);
        this.out.push(`    local.get $${baseName}_step`);
        this.out.push(`    f64.add`); // New stream current value
        
        this.out.push(`    local.get $${baseName}_step`);
        this.out.push(`    local.get $${baseName}_limit`);
        return;
      }

      if (node.operator === "'") {
        const leftType = this.getType(node.left, env);
        this.generateExpression(node.left, env); // pointer
        if (leftType === 'f64') this.out.push(`    i32.trunc_f64_s`);
        else if (leftType === 'i64') this.out.push(`    i32.wrap_i64`);
        
        const rightType = this.getType(node.right, env);
        this.generateExpression(node.right, env); // index
        if (rightType === 'f64') this.out.push(`    i32.trunc_f64_s`);
        else if (rightType === 'i64') this.out.push(`    i32.wrap_i64`);

        this.out.push(`    i32.const 3`); // scale index by 8 (2^3) for f64 size
        this.out.push(`    i32.shl`);
        this.out.push(`    i32.add`); // pointer + offset
        this.out.push(`    f64.load`); // get the value
        return;
      }

      if (node.operator === '#' && (!node.position || node.position === 'infix')) {
        // Stream Fusion Sink: Memory Store (Dynamic Runtime Pointer)
        if (node.reduceId === undefined) {
           node.reduceId = this.labelCounter++;
        }
        const ptrLocal = `__sink_ptr_${node.reduceId}`;
        const ptrType = this.getType(node.left, env);
        
        this.generateExpression(node.left, env);
        this.out.push(`    local.set $${ptrLocal}`);

        const streamContext = { isString: false };
        this.generateStream(node.right, env, streamContext, (valNode) => {
          this.out.push(`    local.get $${ptrLocal}`);
          if (ptrType === 'f64') this.out.push(`    i32.trunc_f64_s`);
          else if (ptrType === 'i64') this.out.push(`    i32.wrap_i64`);
          
          const valType = this.getType(valNode, env);
          this.generateExpression(valNode, env); 
          if (valType === 'i64') this.out.push(`    f64.convert_i64_s`); // Store expects f64 for MVP
          this.out.push(`    f64.store`);
          
          this.out.push(`    local.get $${ptrLocal}`);
          if (ptrType === 'f64') {
             this.out.push(`    f64.const 8`);
             this.out.push(`    f64.add`);
          } else {
             this.out.push(`    i64.const 8`);
             this.out.push(`    i64.add`);
          }
          this.out.push(`    local.set $${ptrLocal}`);
        });
        
        if (ptrType === 'f64') this.out.push(`    f64.const nan`);
        else this.out.push(`    i64.const 0`);
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
            const streamContext = { isString: false };
            this.generateStream(listNode, env, streamContext, (valNode) => {
              this.generateExpression(valNode, env);
              if (!isFirst) {
                if (opNode.operator === '+') this.out.push(`    f64.add`);
                else if (opNode.operator === '*') this.out.push(`    f64.mul`);
                else if (opNode.operator === '-') this.out.push(`    f64.sub`);
              }
              isFirst = false;
            });
            if (isFirst) {
              this.out.push(`    f64.const 0 ;; empty reduce`);
            }
          } else {
             this.out.push(`    f64.const 0 ;; empty reduce`);
          }
          return;
        }
        
        let actualArgs = [];
        if (args.length > 0) {
           const extractArgs = (node) => {
              if (!node) return;
              if (node.type === 'operation' && (node.operator === ' ' || node.name === 'concat' || node.operator === '\\n')) {
                 extractArgs(node.left);
                 extractArgs(node.right);
              } else {
                 actualArgs.push(node);
              }
           };
           for (const arg of args) {
              extractArgs(arg);
           }
        }
        
        let arity = 1;
        let defaults = [];
        let isDirectTopLevelCall = false;
        
        if (typeof func === 'string') {
          const funcName = this.getIdentName(func);
          if (this.funcArities.has(funcName) && !env.has(funcName)) {
            arity = this.funcArities.get(funcName);
            defaults = this.funcDefaults.get(funcName) || [];
            isDirectTopLevelCall = true;
          }
        }
        
        const providedArgs = [];
        let isPartial = false;
        
        let paramIdx = 0;
        let argIdx = 0;
        
        while (paramIdx < arity) {
           const isOmitted = argIdx >= actualArgs.length;
           let isPlaceholder = false;
           if (!isOmitted) {
              const argNode = actualArgs[argIdx];
              if (typeof argNode === 'string' && this.getIdentName(argNode) === '_') {
                 isPlaceholder = true;
              }
           }
           
           if (isDirectTopLevelCall) {
              const hasDefault = defaults[paramIdx] || false;
              if (isOmitted || isPlaceholder) {
                 if (hasDefault) {
                    providedArgs.push({ type: 'unit' });
                    paramIdx++;
                    if (isPlaceholder) argIdx++;
                 } else {
                    providedArgs.push({ type: 'unbound', originalParamIndex: paramIdx });
                    isPartial = true;
                    paramIdx++;
                    if (isPlaceholder) argIdx++;
                 }
              } else {
                 const argNode = actualArgs[argIdx];
                 if (argNode && argNode.type === 'operation' && argNode.operator === '~' && argNode.position === 'postfix') {
                    providedArgs.push({ type: 'node', node: argNode, count: 4 });
                    paramIdx += 4;
                    argIdx++;
                 } else {
                    providedArgs.push({ type: 'node', node: argNode, count: 1 });
                    paramIdx++;
                    argIdx++;
                 }
              }
           } else {
              // Dynamic call: everything omitted is Unit, _ is Unit. No static partial application!
              if (isOmitted || isPlaceholder) {
                 providedArgs.push({ type: 'unit' });
                 paramIdx++;
                 if (isPlaceholder) argIdx++;
              } else {
                 const argNode = actualArgs[argIdx];
                 if (argNode && argNode.type === 'operation' && argNode.operator === '~' && argNode.position === 'postfix') {
                    providedArgs.push({ type: 'node', node: argNode, count: 4 });
                    paramIdx += 4;
                    argIdx++;
                 } else {
                    providedArgs.push({ type: 'node', node: argNode, count: 1 });
                    paramIdx++;
                    argIdx++;
                 }
              }
           }
        }
        
        if (isPartial) {
           const funcName = this.getIdentName(func);
           const thunkName = `__partial_${funcName}_${this.labelCounter++}`;
           
           let thunkCode = `  (func $${thunkName}`;
           // Params
           for (const pArg of providedArgs) {
              if (pArg.type === 'unbound') {
                 thunkCode += ` (param $p${pArg.originalParamIndex} f64)`;
              }
           }
           thunkCode += ` (result f64)\n`;
           
           // Body
           for (const pArg of providedArgs) {
              if (pArg.type === 'unit') {
                 thunkCode += `    f64.const nan\n`;
              } else if (pArg.type === 'unbound') {
                 thunkCode += `    local.get $p${pArg.originalParamIndex}\n`;
              } else if (pArg.type === 'node') {
                 const node = pArg.node;
                 const val = Number(node);
                 if (!isNaN(val)) {
                    thunkCode += `    f64.const ${val}\n`;
                 } else {
                    throw new Error(`Dynamic closure capture is not supported in MVP. Captured argument must be a constant. Node: ${JSON.stringify(node)}`);
                 }
              }
           }
           thunkCode += `    call $${funcName}\n`;
           thunkCode += `  )`;
           
           if (!this.thunks) this.thunks = [];
           this.thunks.push(thunkCode);
           
           this.funcNames.push(thunkName);
           const thunkIndex = this.funcNames.length - 1;
           this.out.push(`    f64.const ${thunkIndex} ;; Partial application thunk`);
           return;
        }

        // Generate normal call arguments
        for (const pArg of providedArgs) {
           if (pArg.type === 'unit') {
              this.out.push(`    f64.const nan ;; Unit (default argument or omitted)`);
           } else {
              this.generateExpression(pArg.node, env);
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
            this.out.push(`    i32.trunc_f64_s`);
            this.out.push(`    call_indirect (type $func_sig)`);
          }
        } else if (func && func.type === 'operation' && ['+', '-', '*'].includes(func.operator)) {
          // Inline partial application (e.g. `* 2`)
          if (func.right) {
            this.generateExpression(func.right, env);
            if (func.operator === '+') this.out.push(`    f64.add`);
            else if (func.operator === '*') this.out.push(`    f64.mul`);
            else if (func.operator === '-') this.out.push(`    f64.sub`);
          } else {
            this.out.push(`    ;; Unhandled left-partial operator inline`);
          }
        } else {
          // Dynamic expression evaluating to a function pointer
          this.generateExpression(func, env);
          this.out.push(`    i32.trunc_f64_s`);
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
          this.out.push(`    f64.const 0`);
        }
        return;
      }

    }
    
    this.out.push(`    ;; Unhandled node: ${node.type} ${node.operator || node.name || ''}`);
    this.out.push(`    f64.const 0`);
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
        this.out.push(`    f64.add`);
        this.out.push(`    local.set $__loop_val_${loopId}`);

        // Check condition (le)
        this.out.push(`    local.get $__loop_val_${loopId}`);
        this.out.push(`    local.get $__loop_limit_${loopId}`);
        this.out.push(`    f64.le`);
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
