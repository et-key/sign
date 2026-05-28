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

    // Check if result is defined
    const hasResult = asts.some(node => node && node.type === 'operation' && node.operator === ':' && this.getIdentName(node.left) === 'result');

    // Generate _start
    this.asm.push('_start:');
    if (hasResult) {
      this.asm.push('  BL result'); // Call result to get exit code in X0
    } else {
      this.asm.push('  MOV X0, #0');
    }
    this.asm.push('  MOV X8, #93 // sys_exit');
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
    
    // プロローグ: リンクレジスタ(LR=X30)とフレームポインタ(FP=X29)を退避
    this.asm.push(`  STP X29, X30, [SP, #-16]!`);
    this.asm.push(`  MOV X29, SP`);

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
      // エピローグ: 復元してリターン
      this.asm.push(`  LDP X29, X30, [SP], #16`);
      this.asm.push('  RET');
    }
    this.asm.push('');
  }

  extractParams(node, env, regIndex) {
    if (!node) return regIndex;
    if (typeof node === 'string') {
      env.set(this.getIdentName(node), `X${regIndex}`);
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

  generateExpression(node, env, targetReg, currentFuncName = null, isTail = false, failLabel = null, blockEndLabel = null) {
    if (!node) return false;
    let didTailCall = false;

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
      return this.generateExpression(node.content, env, targetReg, currentFuncName, isTail, failLabel, blockEndLabel);
    }

    if (node.type === 'coproduct_block') {
      const cases = node.statements || [];
      if (cases.length === 0) return;

      const endLabel = `L_end_${this.labelCounter++}`;
      
      for (let i = 0; i < cases.length; i++) {
        const isLast = i === cases.length - 1;
        const nextLabel = isLast ? failLabel : `L_case_${this.labelCounter++}`;
        
        // Evaluate this case. If it yields Unit, it jumps to nextLabel.
        this.generateExpression(cases[i], env, targetReg, currentFuncName, isTail && isLast, nextLabel);
        
        if (!isLast) {
          // If it succeeds (didn't jump to nextLabel), jump to end!
          this.asm.push(`  B ${endLabel}`);
          this.asm.push(`${nextLabel}:`);
        }
      }
      
      if (cases.length > 1) {
        this.asm.push(`${endLabel}:`);
      }
      return;
    }

    if (node.type === 'operation') {
      if (node.operator === ':') {
        if (typeof node.left === 'string' || (node.left && node.left.type === 'operation' && node.left.operator === '#')) {
          // Assignment or Export
          const varName = this.getIdentName(node.left);
          this.generateExpression(node.right, env, targetReg, currentFuncName, false, failLabel, blockEndLabel);
          env.set(varName, targetReg);
        } else {
          // Match Case (left side is a condition expression)
          const nextCaseLabel = `L_next_case_${this.labelCounter++}`;
          this.generateExpression(node.left, env, 'X9', currentFuncName, false, nextCaseLabel, blockEndLabel);
          
          // Condition succeeded, evaluate result
          const rightTail = this.generateExpression(node.right, env, targetReg, currentFuncName, isTail, failLabel, blockEndLabel);
          if (rightTail) didTailCall = true;
          
          if (blockEndLabel) {
            this.asm.push(`  B ${blockEndLabel}`);
          } else if (!isTail && !rightTail) {
            // Top level match case without block end? Unlikely, but just in case
          }
          
          this.asm.push(`${nextCaseLabel}:`);
        }
        return didTailCall;
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
        this.generateExpression(node.left, env, 'X9', currentFuncName, false, failLabel);
        this.generateExpression(node.right, env, 'X10', currentFuncName, false, failLabel);

        switch (node.operator) {
          case '+': this.asm.push(`  ADD ${targetReg}, X9, X10`); break;
          case '-': this.asm.push(`  SUB ${targetReg}, X9, X10`); break;
          case '*': this.asm.push(`  MUL ${targetReg}, X9, X10`); break;
        }
        return;
      }

      if (['||', '&&', ';;'].includes(node.operator)) {
        this.generateExpression(node.left, env, 'X9', currentFuncName, false, failLabel);
        this.generateExpression(node.right, env, 'X10', currentFuncName, false, failLabel);
        switch (node.operator) {
          case '||': this.asm.push(`  ORR ${targetReg}, X9, X10`); break;
          case '&&': this.asm.push(`  AND ${targetReg}, X9, X10`); break;
          case ';;': this.asm.push(`  EOR ${targetReg}, X9, X10`); break;
        }
        return;
      }

      if (node.operator === '!!' && node.position === 'prefix') {
        this.generateExpression(node.operand, env, 'X9', currentFuncName, false, failLabel);
        this.asm.push(`  MVN ${targetReg}, X9`);
        return;
      }

      if (['<', '>', '==', '!=', '<=', '>='].includes(node.operator)) {
        this.generateExpression(node.left, env, 'X9', currentFuncName, false, failLabel);
        this.generateExpression(node.right, env, 'X10', currentFuncName, false, failLabel);
        this.asm.push(`  CMP X9, X10`);
        if (failLabel) {
          switch (node.operator) {
            case '<': this.asm.push(`  B.GE ${failLabel}`); break;
            case '>': this.asm.push(`  B.LE ${failLabel}`); break;
            case '==': this.asm.push(`  B.NE ${failLabel}`); break;
            case '!=': this.asm.push(`  B.EQ ${failLabel}`); break;
            case '<=': this.asm.push(`  B.GT ${failLabel}`); break;
            case '>=': this.asm.push(`  B.LT ${failLabel}`); break;
          }
        } else {
          this.asm.push(`  // No failLabel provided for Unit fallback`);
        }
        if (targetReg !== 'X9') {
           this.asm.push(`  MOV ${targetReg}, X9`);
        }
        return;
      }

      if (node.operator === '|') {
        const cases = this.flattenCoproduct(node);
        if (cases.length === 0) return;

        const endLabel = `L_end_${this.labelCounter++}`;
        
        for (let i = 0; i < cases.length; i++) {
          const isLast = i === cases.length - 1;
          const nextLabel = isLast ? failLabel : `L_case_${this.labelCounter++}`;
          
          this.generateExpression(cases[i], env, targetReg, currentFuncName, isTail && isLast, nextLabel);
          
          if (!isLast) {
            this.asm.push(`  B ${endLabel}`);
            this.asm.push(`${nextLabel}:`);
          }
        }
        
        if (cases.length > 1) {
          this.asm.push(`${endLabel}:`);
        }
        return;
      }

      if (node.operator === '&') {
        this.generateExpression(node.left, env, targetReg, currentFuncName, false, failLabel);
        this.generateExpression(node.right, env, targetReg, currentFuncName, isTail, failLabel);
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

        if (func && func.type === 'operation' && func.operator === '?') {
          // Inline Lambda Application
          const params = this.flattenParams(func.left);
          const localEnv = new Map(env);
          let regIdx = 0;
          
          for (let i = 0; i < params.length; i++) {
            const p = params[i];
            const arg = i < args.length ? args[i] : null;
            const targetParamReg = `X${regIdx}`;
            
            const isExplicitHole = typeof arg === 'string' && arg === '_';
            const isCompileTimeUnit = arg && (arg.type === 'Unit' || (arg.type === 'block' && arg.content && arg.content.type === 'Unit'));
            
            if (arg && !isExplicitHole && !isCompileTimeUnit) {
              const argFailLabel = `L_arg_fail_${this.labelCounter++}`;
              const argSuccessLabel = `L_arg_success_${this.labelCounter++}`;
              
              // Evaluate argument with argFailLabel
              this.generateExpression(arg, localEnv, targetParamReg, currentFuncName, false, argFailLabel, blockEndLabel);
              this.asm.push(`  B ${argSuccessLabel}`);
              
              this.asm.push(`${argFailLabel}:`);
              if (p.defaultNode) {
                this.generateExpression(p.defaultNode, localEnv, targetParamReg, currentFuncName, false, failLabel, blockEndLabel);
              } else {
                if (failLabel) {
                  this.asm.push(`  B ${failLabel} // Implicit Unit short-circuit`);
                } else {
                  this.asm.push(`  // Implicit Unit short-circuit (no failLabel)`);
                }
              }
              this.asm.push(`${argSuccessLabel}:`);
            } else {
              // Missing argument, explicit _, or compile-time Unit
              if (p.defaultNode) {
                this.generateExpression(p.defaultNode, localEnv, targetParamReg, currentFuncName, false, failLabel, blockEndLabel);
              } else if (isCompileTimeUnit) {
                if (failLabel) {
                  this.asm.push(`  B ${failLabel} // Compile-time Unit short-circuit`);
                } else {
                  this.asm.push(`  // Compile-time Unit short-circuit (no failLabel)`);
                }
              } else {
                this.asm.push(`  // Partial application of ${p.name} not dynamically supported yet`);
              }
            }
            
            localEnv.set(p.name, targetParamReg);
            if (p.isGenerator) regIdx += 3; else regIdx++;
          }
          
          // Evaluate the body
          const rightTail = this.generateExpression(func.right, localEnv, targetReg, currentFuncName, isTail, failLabel, blockEndLabel);
          if (rightTail) didTailCall = true;
          return didTailCall;
        }

        // Call the function (normal global BL or pointer)
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
            this.generateExpression(arg, env, `X${regIdx}`, currentFuncName, false, failLabel, blockEndLabel);
            regIdx++;
          }
        }

        if (typeof func === 'string') {
          const funcName = this.getIdentName(func);
          if (isTail && funcName === currentFuncName) {
            // 末尾再帰の直前にエピローグを実行（スタックを戻す）
            this.asm.push(`  LDP X29, X30, [SP], #16`);
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
          const fName = this.getIdentName(func.left);
          const gName = this.getIdentName(func.right);
          this.asm.push(`  BL ${gName}`);
          this.asm.push(`  BL ${fName}`);
        } else if (func.name === 'apply_or_concat') {
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
        // A block or tuple is a chain of concats. We generate a blockEndLabel if we don't have one.
        const myBlockEnd = blockEndLabel || `L_block_end_${this.labelCounter++}`;
        
        this.generateExpression(node.left, env, targetReg, currentFuncName, false, failLabel, myBlockEnd);
        const rightTail = this.generateExpression(node.right, env, targetReg, currentFuncName, isTail, failLabel, myBlockEnd);
        
        if (!blockEndLabel) {
          this.asm.push(`${myBlockEnd}:`);
        }
        
        if (rightTail) didTailCall = true;
        return didTailCall;
      }
    }
    return didTailCall;
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

  flattenCoproduct(node) {
    let cases = [];
    if (node && node.type === 'operation' && node.operator === '|') {
      cases = cases.concat(this.flattenCoproduct(node.left));
      cases = cases.concat(this.flattenCoproduct(node.right));
    } else {
      cases.push(node);
    }
    return cases;
  }

  flattenParams(node) {
    let params = [];
    if (!node) return params;
    
    if (typeof node === 'string') {
      params.push({ name: this.getIdentName(node), defaultNode: null });
      return params;
    }
    
    if (node.type === 'operation') {
      if (node.operator === ':') {
        params.push({ name: this.getIdentName(node.left), defaultNode: node.right });
        return params;
      }
      if (node.operator === ' ' || node.name === 'concat') {
        params = params.concat(this.flattenParams(node.left));
        params = params.concat(this.flattenParams(node.right));
        return params;
      }
      if (node.operator === '~' && node.position === 'prefix') {
        params.push({ name: this.getIdentName(node.operand), defaultNode: null, isGenerator: true });
        return params;
      }
    }
    return params;
  }
}

export function generateAArch64(asts) {
  const gen = new AArch64Generator();
  return gen.generate(asts);
}
