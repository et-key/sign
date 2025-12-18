class Codegen {
    constructor(sexpr) {
        this.sexpr = sexpr;
        this.output = [];
        this.tempCounter = 0;
        this.globals = new Map();
    }

    generate() {
        this.emit('; ModuleID = \'sign_module\'');
        this.emit('source_filename = "sign_module"');
        this.emit('target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"');
        this.emit('target triple = "x86_64-pc-windows-msvc"'); // Assuming Windows based on user env
        this.emit('');

        // Define printf for testing
        this.emit('declare i32 @printf(i8*, ...)')
        this.emit('@formatStr = private constant [4 x i8] c"%d\\0A\\00"');
        this.emit('');

        this.emit('define i32 @main() {');
        this.emit('entry:');

        // Initial naive codegen: treat top-level expressions as main body
        const scope = new Map(); // Shared scope for main block
        let lastRes = null;
        for (const expr of this.sexpr) {
            const res = this.compileExpr(expr, scope);
            if (res.type !== 'void') {
                lastRes = res;
            }
        }

        if (lastRes && lastRes.type === 'i32') {
            const tmpPtr = this.newTemp();
            this.emit(`  ${tmpPtr} = getelementptr [4 x i8], [4 x i8]* @formatStr, i64 0, i64 0`);
            this.emit(`  call i32 (i8*, ...) @printf(i8* ${tmpPtr}, i32 ${lastRes.value})`);
        }

        this.emit('  ret i32 0');
        this.emit('}');

        return this.output.join('\n');
    }

    compileExpr(expr, scope) {
        if (!expr) return { type: 'void' };

        if (typeof expr === 'number') {
            return { type: 'i32', value: expr.toString(), isConst: true };
        }
        if (typeof expr === 'string') {
            // Variable lookup
            if (scope.has(expr)) {
                const varInfo = scope.get(expr);
                if (varInfo.isPtr) {
                    const loadedTmp = this.newTemp();
                    this.emit(`  ${loadedTmp} = load i32, i32* ${varInfo.reg}`);
                    return { type: 'i32', value: loadedTmp, isConst: false };
                }
                return varInfo;
            }
            console.warn(`Undefined variable: ${expr}`);
            return { type: 'i32', value: '0', isConst: true };
        }

        if (Array.isArray(expr)) {
            const head = expr[0];
            if (typeof head === 'string' && head.startsWith('[')) {
                // Handle operators
                return this.compileOp(head, expr.slice(1), scope);
            }
        }

        return { type: 'i32', value: '0', isConst: true };
    }

    compileOp(op, args, scope) {
        const opName = op.replace(/^\[|\]$/g, '');

        switch (opName) {
            case '+': return this.compileBinOp('add', args, scope);
            case '-': return this.compileBinOp('sub', args, scope);
            case '*': return this.compileBinOp('mul', args, scope);
            case '/': return this.compileBinOp('sdiv', args, scope);
            case ':': return this.compileDef(args, scope);
            default:
                console.warn(`Unknown op: ${opName}`);
                return { type: 'i32', value: '0', isConst: true };
        }
    }

    compileBinOp(instr, args, scope) {
        // Evaluate operands
        let left = this.compileExpr(args[0], scope);
        let right = this.compileExpr(args[1], scope);

        const tmp = this.newTemp();
        this.emit(`  ${tmp} = ${instr} i32 ${left.value}, ${right.value}`);
        return { type: 'i32', value: tmp, isConst: false };
    }

    compileDef(args, scope) {
        // args[0] is name (string)
        // args[1] is value
        const name = args[0];
        const valExpr = args[1];

        // Compile value first
        const valRes = this.compileExpr(valExpr, scope);

        // Allocate stack slot
        // In LLVM, allocas should ideally be at the entry block, but for naive implementation, doing it here is legal but less efficient?
        // Actually, placing alloca anywhere is valid LLVM, just not "canonical" for optimization.
        const ptrVar = `%${name}`;
        this.emit(`  ${ptrVar} = alloca i32`);
        this.emit(`  store i32 ${valRes.value}, i32* ${ptrVar}`);

        // Store in scope
        scope.set(name, { type: 'i32', reg: ptrVar, isPtr: true });

        return { type: 'void' };
    }

    newTemp() {
        return `%t${this.tempCounter++}`;
    }

    emit(line) {
        this.output.push(line);
    }
}

module.exports = { Codegen };
