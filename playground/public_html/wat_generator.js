export class WatGenerator {
  constructor(locals) {
    this.locals = locals;
    this.code = [];
  }

  emit(line) {
    this.code.push(line);
  }

  generate(ast) {
    this.emit('(module');
    this.emit('  (import "env" "math_pow" (func $math_pow (param f64 f64) (result f64)))');

    this.emit('  (memory $mem 1)');
    this.emit('  (export "memory" (memory $mem))');
    this.emit('  (global $hp (mut i32) (i32.const 8))');

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
    this.emit('  )');
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
          this.emit(`    local.get $${varName}`);
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
    this.visit(operand);
    switch (op) {
      case '-': this.emit(`    f64.neg`); break;
      case '+': break;
      case '|': this.emit(`    f64.abs`); break;
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

    if (op === ',') {
      this.visit(left);
      this.emit(`    local.set $tmp_l`);
      this.visit(right);
      this.emit(`    local.set $tmp_r`);
      this.emit(`    i32.const 16`);
      this.emit(`    call $alloc`);
      this.emit(`    local.set $tmp_ptr`);
      this.emit(`    local.get $tmp_ptr`);
      this.emit(`    local.get $tmp_l`);
      this.emit(`    f64.store offset=0`);
      this.emit(`    local.get $tmp_ptr`);
      this.emit(`    local.get $tmp_r`);
      this.emit(`    f64.store offset=8`);
      this.emit(`    local.get $tmp_ptr`);
      this.emit(`    call $ptr_to_f64`);
      return;
    }

    if (op === ':' && left && (left.type === 'identifier' || left.type === 'variable')) {
      this.visit(right);
      const lName = left.name || left.value || left.text;
      this.emit(`    local.set $${lName}`);
      this.emit(`    local.get $${lName}`);
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
}