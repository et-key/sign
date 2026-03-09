export class WatGenerator {
  constructor(locals) {
    this.locals = locals;
    this.code = [];
  }

  emit(line) {
    this.code.push(line);
  }

  generate(ast) {
    // ★ 仮想型スタックなどの初期化を追加
    this.typeStack = [];
    this.functions = [];
    this.elemFuncs = [];
    this.lambdaCount = 0;

    this.emit('(module');
    this.emit('  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))');

    this.emit('  (memory $mem 1)');
    this.emit('  (export "memory" (memory $mem))');
    this.emit('  (global $hp (mut i32) (i32.const 8))');
    // ★追加: 高階関数のためのテーブルと、クロージャ呼び出しの型シグネチャ
    this.emit('  (table $func_table 100 funcref)');
    this.emit('  (type $closure_sig (func (param f64 f64) (result f64)))');
    // wat_generator.js の emit("module...") の後あたりに追加
    this.emit(`
  (func $is_ptr (param $val f64) (result i32)
    local.get $val
    i64.reinterpret_f64
    i64.const 0x7FFC000000000000
    i64.and
    i64.const 0x7FFC000000000000
    i64.eq
  )`);

    this.emit(`
  (func $f64_to_ptr (param $val f64) (result i32)
    local.get $val
    i64.reinterpret_f64
    i32.wrap_i64
  )`);

    // ★ , (積) の実体となるConsセル生成関数
    this.emit(`
  (func $cons (param $car f64) (param $cdr f64) (result f64)
    (local $ptr i32)
    i32.const 16
    call $alloc
    local.set $ptr
    local.get $ptr
    local.get $car
    f64.store offset=0
    local.get $ptr
    local.get $cdr
    f64.store offset=8
    local.get $ptr
    call $ptr_to_f64
  )`);


    this.emit(`
  (func $alloc (param $size i32) (result i32)
    (local $ptr i32)
    global.get $hp
    local.set $ptr
    global.get $hp
    local.get $size
    i32.add
    global.set $hp
    local.get $ptr
  )`);

    this.emit(`
  (func $ptr_to_f64 (param $ptr i32) (result f64)
    local.get $ptr
    i64.extend_i32_u
    i64.const 0x7FFC000000000000
    i64.or
    f64.reinterpret_i64
  )`);

    // ★ 鉄壁のTruthy判定（0やポインタは真、純粋なNaNだけ偽）
    this.emit(`
  (func $is_truthy (param $val f64) (result i32)
    local.get $val
    local.get $val
    f64.eq
    if (result i32)
      i32.const 1
    else
      local.get $val
      i64.reinterpret_f64
      i64.const 0xFFFF000000000000
      i64.and
      i64.const 0x7FFC000000000000
      i64.eq
    end
  )`);

    this.emit(`
  (func $fact (param $n f64) (result f64)
    (local $res f64)
    (local $i f64)
    local.get $n
    f64.const 0.0
    f64.lt
    if f64.const nan return end
    local.get $n
    f64.const 0.5
    f64.lt
    if f64.const 1.0 return end
    f64.const 1.0
    local.set $res
    local.get $n
    f64.trunc
    local.set $i
    block $break
      loop $loop
        local.get $i
        f64.const 1.0
        f64.lt
        br_if $break
        local.get $res
        local.get $i
        f64.mul
        local.set $res
        local.get $i
        f64.const 1.0
        f64.sub
        local.set $i
        br $loop
      end
    end
    local.get $res
  )`);

    this.emit('  (func $main (export "main") (result f64)');
    this.emit('    (local $tmp_ptr i32)');
    this.emit('    (local $final_res f64)'); // ★ 0番地メールボックス用レジスタ

    for (let l of this.locals) {
      this.emit(`    (local $${l} f64)`);
    }

    this.visit(ast);

    // ★ JSエンジンの破壊から守る0番地メールボックス
    this.emit('    local.set $final_res');
    this.emit('    i32.const 0');
    this.emit('    local.get $final_res');
    this.emit('    f64.store offset=0');
    this.emit('    local.get $final_res');
    this.emit('  )'); // ★ $mainの終わり

    // ★ ここに追加: 見つけたラムダ関数をモジュール末尾に出力
    if (this.functions.length > 0) {
      this.functions.forEach(line => this.emit(line));
      const funcList = this.elemFuncs.join(' ');
      this.emit(`  (elem (i32.const 1) ${funcList})`);
    }

    this.emit(')');

    return this.code.join('\n');
  }

  visit(node) {
    if (!node) { this.emit('    f64.const nan'); return; }

    if (Array.isArray(node)) {
      if (node.length === 0) { this.emit('    f64.const nan'); return; }
      for (let i = 0; i < node.length; i++) {
        this.visit(node[i]);
        if (i < node.length - 1) this.emit('    drop');
      }
      return;
    }

    if (node.type === 'block') {
      const body = node.body || [];
      if (body.length === 0) { this.emit('    f64.const nan'); return; }
      for (let i = 0; i < body.length; i++) {
        this.visit(body[i]);
        if (i < body.length - 1) this.emit('    drop');
      }
      return;
    }

    switch (node.type) {
      case 'number':
        let numVal = Number(node.value);
        if (Number.isNaN(numVal)) {
          this.emit(`    f64.const nan`);
        } else {
          this.emit(`    f64.const ${numVal}`);
        }
        break;
      case 'identifier':
      case 'variable':
        const varName = node.name || node.value || node.text;
        if (varName === '_' || varName === 'nan') {
          this.emit(`    f64.const nan`);
        } else {
          // ★ 修正：すでに '$' で始まっているかチェックし、二重になるのを防ぐ
          const wasmVarName = varName.startsWith('$') ? varName : '$' + varName;
          this.emit(`    local.get ${wasmVarName}`);
        }
        break;
      case 'absolute':
      case 'abs':
      case 'math_abs': {
        let absInner = node.expr || node.argument || node.operand || node.left || node.right || node.base || node.body || node.content || node.value;
        this.visit(absInner);
        this.emit(`    f64.abs`);
        break;
      }
      case 'group':
      case 'surround':
      case 'enclosure':
      case 'paren': {
        let isAbs = (node.surround === '|' || node.bracket === '|' || node.op === '|' || node.value === '|' || node.name === '|');
        let inner = node.body || node.content || node.expr || node.value || node.operand || node.argument || node.left || node.right;
        this.visit(inner);
        if (isAbs) {
          this.emit(`    f64.abs`);
        }
        break;
      }
      case 'prefix':
        this.compilePrefix(node);
        break;
      case 'postfix':
        this.compilePostfix(node);
        break;
      case 'infix':
        this.compileInfix(node);
        break;
      default:
        // ★ 未知のノードタイプが来たらエラー
        throw new Error(`[WASM Compiler] Unsupported node type: "${node.type}"`);
    }
  }

  compilePrefix(node) {
    const op = node.op || node.value;
    const operand = node.right || node.left || node.expr || node.argument || node.operand || node.base || node.value;

    this.visit(operand); // オペランドを評価してスタックに積む

    switch (op) {
      case '-': this.emit(`    f64.neg`); break;
      case '+': break;
      case '|': this.emit(`    f64.abs`); break;

      // ★ 単体値の Lift (ポインタ化)
      case '$':
        this.emit(`    local.set $tmp_l`);      // スタックの値を一時退避
        this.emit(`    i32.const 8`);           // f64一つ分(8バイト)のメモリを要求
        this.emit(`    call $alloc`);
        this.emit(`    local.set $tmp_ptr`);    // 確保したアドレスを退避
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    local.get $tmp_l`);
        this.emit(`    f64.store offset=0`);    // ヒープへ持ち上げ（保存）
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    call $ptr_to_f64`);      // アドレスをNaN-Box化してスタックへ
        break;

      // ★ 単体値の Flat (値の取り出し)
      case '@':
        this.emit(`    call $f64_to_ptr`);      // NaN-Box化されたアドレスをi32に戻す
        this.emit(`    f64.load offset=0`);     // ヒープからスタックへ持ち下げ（読み出し）
        break;

      case '!':
        this.emit(`    local.set $tmp_cond`);
        this.emit(`    local.get $tmp_cond`);
        this.emit(`    call $is_truthy`);
        this.emit(`    if (result f64)`);
        this.emit(`      f64.const nan`);
        this.emit(`    else`);
        this.emit(`      f64.const inf`);
        this.emit(`    end`);
        break;
      case '!!':
        this.emit(`    i32.trunc_f64_s`);
        this.emit(`    i32.const -1`);
        this.emit(`    i32.xor`);
        this.emit(`    f64.convert_i32_s`);
        break;
      default:
        throw new Error(`[WASM Compiler] Unsupported prefix operator: "${op}"`);
    }
  }

  compilePostfix(node) {
    const op = node.op || node.value;
    const operand = node.left || node.right || node.expr || node.argument || node.operand || node.base || node.value;
    this.visit(operand);
    switch (op) {
      case '!': this.emit(`    call $fact`); break;
      case '|': break;
      default: throw new Error(`[WASM Compiler] Unsupported postfix operator: "${op}"`);
    }
  }

  compileInfix(node) {
    const { op, left, right } = node;

    // ★ 追加: ラムダ関数 (?) のコンパイル
    if (op === '?') {
      this.compileLambda(node);
      return;
    }

    // ★ 変更: 空白 (余積) の静的ディスパッチ
    if (op === ' ') {
      this.compileSpace(node);
      return;
    }

    if (op === ',') {
      this.visit(left);
      this.visit(right);
      this.emit(`    call $cons`);
      return;
    }

    if (op === ':' && left && (left.type === 'identifier' || left.type === 'variable')) {
      this.visit(right);
      const lName = left.name || left.value || left.text;
      // ★ 修正：代入時も '$' の二重付与を防ぐ
      const wasmVarName = lName.startsWith('$') ? lName : '$' + lName;
      this.emit(`    local.set ${wasmVarName}`);
      this.emit(`    local.get ${wasmVarName}`);
      return;
    }

    // ★ フラットなif文による安定した論理評価
    if (op === '|') {
      this.visit(left);
      this.emit(`    local.set $tmp_l`);
      this.emit(`    local.get $tmp_l`);
      this.emit(`    call $is_truthy`);
      this.emit(`    if (result f64)`);
      this.emit(`      local.get $tmp_l`);
      this.emit(`    else`);
      this.visit(right);
      this.emit(`    end`);
      return;
    }
    if (op === '&') {
      this.visit(left);
      this.emit(`    local.set $tmp_l`);
      this.emit(`    local.get $tmp_l`);
      this.emit(`    call $is_truthy`);
      this.emit(`    if (result f64)`);
      this.visit(right);
      this.emit(`    else`);
      this.emit(`      f64.const nan`);
      this.emit(`    end`);
      return;
    }

    this.visit(left);
    this.visit(right);

    switch (op) {
      case '+': this.emit(`    f64.add`); break;
      case '-': this.emit(`    f64.sub`); break;
      case '*': this.emit(`    f64.mul`); break;
      case '/': this.emit(`    f64.div`); break;
      case '^':
      case '**': this.emit(`    call $math_pow`); break;
      case '%':
        this.emit(`    local.set $tmp_r`);
        this.emit(`    local.set $tmp_l`);
        this.emit(`    local.get $tmp_l`);
        this.emit(`    local.get $tmp_l`);
        this.emit(`    local.get $tmp_r`);
        this.emit(`    f64.div`);
        this.emit(`    f64.floor`);
        this.emit(`    local.get $tmp_r`);
        this.emit(`    f64.mul`);
        this.emit(`    f64.sub`);
        break;
      case '!':
        this.emit(`    drop`);
        this.emit(`    call $fact`);
        break;
      case '||':
      case '&&':
      case ';;':
      case '<<':
      case '>>':
        this.emit(`    local.set $tmp_r`);
        this.emit(`    local.set $tmp_l`);
        this.emit(`    local.get $tmp_l`);
        this.emit(`    i32.trunc_f64_s`);
        this.emit(`    local.get $tmp_r`);
        this.emit(`    i32.trunc_f64_s`);
        if (op === '||') this.emit(`    i32.or`);
        if (op === '&&') this.emit(`    i32.and`);
        if (op === ';;') this.emit(`    i32.xor`);
        if (op === '<<') this.emit(`    i32.shl`);
        if (op === '>>') this.emit(`    i32.shr_s`);
        this.emit(`    f64.convert_i32_s`);
        break;
      case '<':
      case '>':
      case '=':
      case '!=':
      case '<=':
      case '>=':
        this.compileComparison(op);
        break;

      // ★ 防犯ブザー：知らない演算子が来たらエラーで止める！
      default:
        throw new Error(`[WASM Compiler] Unsupported infix operator: "${op}"`);
    }
  }

  compileComparison(op) {
    this.emit(`    local.set $tmp_r`);
    this.emit(`    local.set $tmp_l`);
    this.emit(`    local.get $tmp_l`);
    this.emit(`    local.get $tmp_r`);
    switch (op) {
      case '<': this.emit(`    f64.lt`); break;
      case '>': this.emit(`    f64.gt`); break;
      case '=': this.emit(`    f64.eq`); break;
      case '!=': this.emit(`    f64.ne`); break;
      case '<=': this.emit(`    f64.le`); break;
      case '>=': this.emit(`    f64.ge`); break;
    }
    this.emit(`    if (result f64)`);
    this.emit(`      local.get $tmp_l`);
    this.emit(`    else`);
    this.emit(`      f64.const nan`);
    this.emit(`    end`);
  }

  compileLambda(node) {
    this.lambdaCount++;
    const funcName = `$lambda_${this.lambdaCount}`;

    const paramName = node.left.value.startsWith('$') ? node.left.value : '$' + node.left.value;

    const prevCode = this.code;
    const prevLocals = this.locals;
    this.code = [];
    this.locals = [paramName];

    this.emit(`  (func ${funcName} (param $env f64) (param ${paramName} f64) (result f64)`);

    this.visit(node.right);

    this.emit(`  )`);

    this.functions.push(...this.code);
    this.elemFuncs.push(funcName);
    this.code = prevCode;
    this.locals = prevLocals;

    this.emit(`    ;; ⚡ Lambda ${funcName} generated -> index ${this.lambdaCount}`);
    this.emit(`    f64.const ${this.lambdaCount}`);

    if (this.typeStack) {
      this.typeStack.push({ type: 'Function', id: this.lambdaCount });
    }
  }

  compileSpace(node) {
    this.visit(node.left);
    let leftType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    this.visit(node.right);
    let rightType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    if (leftType.type === 'Function') {
      this.emit(`    ;; ⚡ [静的型解決] 左辺は関数なので、直接 call_indirect を発行`);
      this.emit(`    local.set $tmp_r  ;; 引数`);
      this.emit(`    local.set $tmp_l  ;; 関数ポインタ`);
      this.emit(`    f64.const 0       ;; ダミーの環境ポインタ`);
      this.emit(`    local.get $tmp_r`);
      this.emit(`    local.get $tmp_l`);
      this.emit(`    i32.trunc_f64_s   ;; ポインタをi32に変換`);
      this.emit(`    call_indirect (type $closure_sig)`);

      if (this.typeStack) this.typeStack.push({ type: 'Float' });
    } else {
      this.emit(`    ;; ⚡ [静的型解決] 左辺はデータなので、リスト結合(cons)を発行`);
      this.emit(`    call $cons`);

      if (this.typeStack) this.typeStack.push({ type: 'List' });
    }
  }
}