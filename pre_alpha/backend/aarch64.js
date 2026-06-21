/**
 * aarch64.js
 * Sign Language AArch64 Code Generator
 */

export class AArch64Generator {
  constructor() {
    this.asm = [];
    this.labelCounter = 0;
  }

  generate(asts) {
    this.asm.push('.text');
    this.asm.push('.global _start');
    this.asm.push('');

    // Generate _start
    this.asm.push('_start:');
    // For now, _start just exits cleanly
    this.asm.push('  MOV X8, #93 // sys_exit');
    this.asm.push('  MOV X0, #0');
    this.asm.push('  SVC #0');
    this.asm.push('');

    // Process all top-level AST nodes
    for (const node of asts) {
      if (!node || typeof node !== 'object') continue;
      if (node.type === 'operation' && node.operator === ':') {
        this.generateFunction(node);
      }
    }

    return this.asm.join('\n') + '\n';
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

  nextReg(reg) {
    if (reg.startsWith('X')) {
      return `X${parseInt(reg.slice(1)) + 1}`;
    }
    return reg;
  }

  generateFunction(node) {
    const name = this.getIdentName(node.left);
    this.asm.push(`${name}:`);

    // We assume arguments are in X0, X1, etc.
    // The body is node.right
    // If node.right is a lambda (?), the body is node.right.right, and param is node.right.left

    let body = node.right;
    let paramNodes = [];

    let didTailCall = false;
    if (body.type === 'operation' && body.operator === '?') {
      const varEnv = new Map();
      this.extractParams(body.left, varEnv, 0);
      didTailCall = this.generateExpression(body.right, varEnv, 'X0', name, true);
    } else {
      const varEnv = new Map();
      didTailCall = this.generateExpression(body, varEnv, 'X0', name, true);
    }

    if (!didTailCall) {
      this.asm.push('  RET');
    }
    this.asm.push('');
  }

  extractParams(node, env, regIndex) {
    if (!node) return regIndex;
    if (typeof node === 'string') {
      env.set(node, `X${regIndex}`);
      return regIndex + 1;
    }
    if (node.type === 'operation' && node.operator === ' ') {
      let nextIdx = this.extractParams(node.left, env, regIndex);
      return this.extractParams(node.right, env, nextIdx);
    }
    // Simplification for ~y etc
    if (node.type === 'operation' && node.operator === '~' && node.position === 'prefix') {
      env.set(this.getIdentName(node.operand), `X${regIndex}`);
      return regIndex + 3; // Generator takes 3 registers (current, step, limit)
    }
    return regIndex;
  }

  generateExpression(node, env, targetReg, currentFuncName = null, isTail = false) {
    if (!node) return false;
    let didTailCall = false;

    if (node.type === 'inline_code') {
      const val = node.value.trim();
      if (val.startsWith('aarch64:')) {
        this.asm.push(`  ${val.slice(8).trim()}`);
      } else if (val.startsWith('asm:')) {
        this.asm.push(`  ${val.slice(4).trim()}`);
      }
      return false;
    }

    if (typeof node === 'string') {
      if (!isNaN(node) || node.startsWith('0x')) {
        if (node.startsWith('0x') || Number(node) > 65535 || Number(node) < 0) {
          this.asm.push(`  LDR ${targetReg}, =${node}`);
        } else {
          this.asm.push(`  MOV ${targetReg}, #${node}`);
        }
        return;
      }

      const name = this.getIdentName(node);
      if (env.has(name)) {
        const srcReg = env.get(name);
        if (srcReg !== targetReg) {
          this.asm.push(`  MOV ${targetReg}, ${srcReg}`);
        }
      } else {
        // Unknown variable or external label
        this.asm.push(`  // Unknown identifier: ${name}`);
      }
      return;
    }


    if (node.type === 'block') {
      return this.generateExpression(node.content, env, targetReg, currentFuncName, isTail);
    }

    if (node.type === 'operation') {
      if (node.operator === ':') {
        const varName = this.getIdentName(node.left);
        this.generateExpression(node.right, env, targetReg, currentFuncName, false);
        env.set(varName, targetReg);
        return;
      }

      if (node.operator === '$') {
        const funcName = this.getIdentName(node.operand);
        this.asm.push(`  ADRP ${targetReg}, ${funcName}`);
        this.asm.push(`  ADD ${targetReg}, ${targetReg}, :lo12:${funcName}`);
        return;
      }

      if (node.operator === '@' && node.position === 'prefix') {
        // Input: Load from address
        this.generateExpression(node.operand, env, 'X9');
        this.asm.push(`  LDR ${targetReg}, [X9]`);
        return;
      }

      if (node.operator === '#' && (!node.position || node.position === 'infix')) {
        // Output: Store value to address
        this.generateExpression(node.left, env, 'X11'); // Address
        this.generateExpression(node.right, env, 'X12'); // Value
        this.asm.push(`  STR X12, [X11]`);
        return;
      }

      if (['+', '-', '*'].includes(node.operator)) {
        // We need scratch registers. X9 and X10
        this.generateExpression(node.left, env, 'X9');
        this.generateExpression(node.right, env, 'X10');

        switch (node.operator) {
          case '+': this.asm.push(`  ADD ${targetReg}, X9, X10`); break;
          case '-': this.asm.push(`  SUB ${targetReg}, X9, X10`); break;
          case '*': this.asm.push(`  MUL ${targetReg}, X9, X10`); break;
        }
        return;
      }

      // Generator Expressions
      if (['~', '~+', '~-', '~*', '~/'].includes(node.operator) && (!node.position || node.position === 'infix')) {
        let startNode, stepNode, limitNode;
        if (node.operator === '~') {
          if (node.left && node.left.type === 'operation' && node.left.operator === '~+') {
            startNode = node.left.left;
            stepNode = node.left.right;
            limitNode = node.right;
          } else {
            startNode = node.left;
            stepNode = '1';
            limitNode = node.right;
          }
        }
        
        const reg1 = targetReg;
        const reg2 = this.nextReg(reg1);
        const reg3 = this.nextReg(reg2);
        
        this.generateExpression(startNode, env, reg1);
        this.generateExpression(stepNode, env, reg2);
        this.generateExpression(limitNode, env, reg3);
        return;
      }

      if (node.name === 'compose') {
        // f g 3 => apply(compose(f, g), 3) -> handled in apply.
        // But what if it's just compose?
        // Let's assume we handle compose inside apply or as chained BLs.
        // For simple result : f g 3, the AST is actually apply(compose(f, g), 3)
      }

      const isApply = node.name === 'apply' || node.name === 'apply_partial' || 
                      (node.name === 'concat' && node.left && (node.left.name === 'apply' || node.left.name === 'apply_partial'));

      if (isApply) {
        const { func, args } = this.flattenApply(node);

        // Evaluate arguments into X0, X1, etc.
        let regIdx = 0;
        for (let i = 0; i < args.length; i++) {
          const arg = args[i];
          if (arg && arg.type === 'operation' && arg.operator === '~' && arg.position === 'postfix') {
            // Expand generator (y~)
            let genBaseReg = env.get(this.getIdentName(arg.operand));
            
            if (!genBaseReg) {
              // It's an inline generator expression [0 ~+ 1 ~ 10]~
              this.generateExpression(arg.operand, env, `X${regIdx}`);
              regIdx += 3; // It takes 3 registers (start, step, limit)
            } else {
              const genStepReg = this.nextReg(genBaseReg);
              const genLimitReg = this.nextReg(genStepReg);
              
              const targetCurrent = `X${regIdx}`;
              const targetNextCurrent = `X${regIdx + 1}`;
              const targetNextStep = `X${regIdx + 2}`;
              const targetNextLimit = `X${regIdx + 3}`;
              
              this.asm.push(`  ADD X9, ${genBaseReg}, ${genStepReg} // new current`);
              this.asm.push(`  MOV ${targetCurrent}, ${genBaseReg} // yield current`);
              this.asm.push(`  MOV ${targetNextCurrent}, X9 // next state`);
              if (targetNextStep !== genStepReg) this.asm.push(`  MOV ${targetNextStep}, ${genStepReg}`);
              if (targetNextLimit !== genLimitReg) this.asm.push(`  MOV ${targetNextLimit}, ${genLimitReg}`);
              
              regIdx += 4;
            }
          } else {
            this.generateExpression(arg, env, `X${regIdx}`);
            regIdx++;
          }
        }

        // Call the function
        if (typeof func === 'string') {
          const funcName = this.getIdentName(func);
          if (isTail && funcName === currentFuncName) {
            this.asm.push(`  B ${funcName}`);
            didTailCall = true;
          } else if (env.has(funcName)) {
            // Function pointer in register (higher-order function argument)
            const reg = env.get(funcName);
            this.asm.push(`  BLR ${reg}`);
          } else {
            // Direct function call
            this.asm.push(`  BL ${funcName}`);
          }
        } else if (func.name === 'compose') {
          // Inline compose: f g 3 -> call f, then call g (left-to-right data flow)
          // Args are already in X0..
          const composedFns = this.flattenCompose(func);
          for (const fn of composedFns) {
            const fnName = this.getIdentName(fn);
            this.asm.push(`  BL ${fnName}`);
          }
        } else if (func.name === 'apply_or_concat') {
          // Complex apply not yet implemented
          this.asm.push(`  // Complex apply not yet implemented`);
        } else {
          this.asm.push(`  // Unknown apply target`);
        }

        if (targetReg !== 'X0') {
          this.asm.push(`  MOV ${targetReg}, X0`);
        }
        return;
      }

      if (!isApply && (node.name === 'concat' || node.name === 'short_circuit')) {
        // For a block/tuple/sequence, the last element is in tail position
        this.generateExpression(node.left, env, targetReg, currentFuncName, false);
        const rightTail = this.generateExpression(node.right, env, targetReg, currentFuncName, isTail);
        if (rightTail) didTailCall = true;
        return didTailCall;
      }
    }
    return didTailCall;
  }

  flattenCompose(node) {
    if (node && node.type === 'operation' && node.name === 'compose') {
      return [...this.flattenCompose(node.left), ...this.flattenCompose(node.right)];
    }
    return [node];
  }

  flattenApply(node) {
    let args = [];
    let curr = node;
    while (curr && curr.type === 'operation' && 
          (curr.name === 'apply' || curr.name === 'apply_partial' || 
          (curr.name === 'concat' && curr.left && (curr.left.name === 'apply' || curr.left.name === 'apply_partial')))) {
      args.unshift(curr.right);
      curr = curr.left;
    }
    return { func: curr, args };
  }
}

export function generateAArch64(asts) {
  const gen = new AArch64Generator();
  return gen.generate(asts);
}
