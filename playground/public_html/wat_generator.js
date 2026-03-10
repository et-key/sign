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
    this.typeEnv = {};   // ★ 追加：変数の型を記憶するノート（シンボルテーブル）
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

    // ⚡ 1. Composed Caller (Dispatcher)
    this.emit(`
  (func $composed_caller (param $env f64) (param $arg f64) (result f64)
    (local $env_ptr i32)
    (local $f f64)
    (local $g f64)
    (local $g_res f64)
    
    local.get $env
    i32.trunc_f64_u
    local.set $env_ptr
    
    local.get $env_ptr
    f64.load offset=0
    local.set $f
    local.get $env_ptr
    f64.load offset=8
    local.set $g
    
    local.get $g
    i64.reinterpret_f64
    i64.const 0xFFFFFFFF
    i64.and
    f64.convert_i64_u
    local.get $arg
    local.get $g
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    call_indirect (type $closure_sig)
    local.set $g_res
    
    local.get $f
    i64.reinterpret_f64
    i64.const 0xFFFFFFFF
    i64.and
    f64.convert_i64_u
    local.get $g_res
    local.get $f
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    call_indirect (type $closure_sig)
  )`);

    // ⚡ 2. Compose function
    this.emit(`
  (func $compose (param $f f64) (param $g f64) (result f64)
    (local $env_ptr i32)
    local.get $f
    local.get $g
    call $cons
    i64.reinterpret_f64
    i32.wrap_i64
    local.set $env_ptr
    
    i64.const 99
    i64.const 32
    i64.shl
    local.get $env_ptr
    i64.extend_i32_u
    i64.or
    f64.reinterpret_i64
  )`);

    // ⚡ 3. List Concat
    this.emit(`
  (func $list_concat (param $l1 f64) (param $l2 f64) (result f64)
    (local $curr_ptr i32)
    (local $cdr_val f64)
    (local $new_cell f64)

    local.get $l1
    i64.reinterpret_f64
    i32.wrap_i64
    local.set $curr_ptr

    (loop $find_end
      local.get $curr_ptr
      f64.load offset=8
      local.set $cdr_val

      local.get $cdr_val
      call $is_ptr
      if
        local.get $cdr_val
        i64.reinterpret_f64
        i32.wrap_i64
        local.set $curr_ptr
        br $find_end
      end
    )

    local.get $cdr_val
    local.get $l2
    call $cons
    local.set $new_cell

    local.get $curr_ptr
    local.get $new_cell
    f64.store offset=8

    local.get $l1
  )`);

    // ⚡ 4. List Push
    this.emit(`
  (func $list_push (param $list f64) (param $val f64) (result f64)
    (local $curr_ptr i32)
    (local $cdr_val f64)
    (local $new_cell f64)

    local.get $list
    i64.reinterpret_f64
    i32.wrap_i64
    local.set $curr_ptr

    (loop $find_end
      local.get $curr_ptr
      f64.load offset=8
      local.set $cdr_val

      local.get $cdr_val
      call $is_ptr
      if
        local.get $cdr_val
        i64.reinterpret_f64
        i32.wrap_i64
        local.set $curr_ptr
        br $find_end
      end
    )

    local.get $cdr_val
    local.get $val
    call $cons
    local.set $new_cell

    local.get $curr_ptr
    local.get $new_cell
    f64.store offset=8

    local.get $list
  )`);

    // ⚡ 5. List Unshift
    this.emit(`
  (func $list_unshift (param $val f64) (param $list f64) (result f64)
    local.get $val
    local.get $list
    call $cons
  )`);

    this.emit('  (func $main (export "main") (result f64)');

    // ★ 追加：変数の二重宣言を絶対に防ぐガード
    const declaredLocals = new Set();

    this.emit('    (local $tmp_ptr i32)');
    declaredLocals.add('tmp_ptr');

    this.emit('    (local $final_res f64)');
    declaredLocals.add('final_res');

    // this.locals の中身を展開（すでに tmp_l などが含まれていればここで一回だけ出力される）
    for (let l of this.locals) {
      if (!declaredLocals.has(l)) {
        this.emit(`    (local $${l} f64)`);
        declaredLocals.add(l);
      }
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

      // ⚡ IDの順番通りにテーブルのリストを作成する
      const funcList = [];
      for (let i = 1; i <= this.lambdaCount; i++) {
        funcList.push(this.elemFuncs[i]);
      }
      this.emit(`  (elem (i32.const 1) ${funcList.join(' ')})`);
    }

    // ★ ここに追加：関数合成用のディスパッチャを 99番地 に登録する
    this.emit(`  (elem (i32.const 99) $composed_caller)`);

    this.emit(')'); // ★ $mainの終わりじゃなくてモジュールの終わり

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
        if (i < body.length - 1) {
          this.emit('    drop');
          if (this.typeStack) this.typeStack.pop(); // ★ 追加：捨てた値の型も忘れる
        }
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
        if (this.typeStack) this.typeStack.push({ type: 'Float' }); // ★ 追加：数値の型を記憶
        break;
      case 'identifier':
      case 'variable':
        const varName = node.name || node.value || node.text;
        if (varName === '_' || varName === 'nan') {
          this.emit(`    f64.const nan`);
          if (this.typeStack) this.typeStack.push({ type: 'Unit' }); // ★ 追加
        } else {
          const wasmVarName = varName.startsWith('$') ? varName : '$' + varName;
          this.emit(`    local.get ${wasmVarName}`);

          // ★ 追加：ノート（typeEnv）から変数の型を引いてきてスタックに積む！
          let savedType = this.typeEnv[varName] || { type: 'Unknown' };
          if (this.typeStack) this.typeStack.push(savedType);
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

      // ★ 追加：スタックから左右の型を取り除き、結果が「List型」であることを記憶させる
      if (this.typeStack) {
        this.typeStack.pop(); // rightの型を捨てる
        this.typeStack.pop(); // leftの型を捨てる
        this.typeStack.push({ type: 'List' });
      }
      return;
    }

    if (op === ':' && left && (left.type === 'identifier' || left.type === 'variable')) {
      this.visit(right);
      const lName = left.name || left.value || left.text;

      // ★ 追加：右辺を評価して確定した型を、変数名をキーにしてノートに書き込む！
      if (this.typeStack && this.typeStack.length > 0) {
        this.typeEnv[lName] = this.typeStack[this.typeStack.length - 1]; // popせずに覗き見
      }

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
        // opだけでなく、leftとrightのノード情報も渡す
        this.compileComparison(op, left, right);
        break;

      // ★ 防犯ブザー：知らない演算子が来たらエラーで止める！
      default:
        throw new Error(`[WASM Compiler] Unsupported infix operator: "${op}"`);
    }
  }

  compileComparison(op, leftNode, rightNode) {
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

    // ★追加：どちらの値を「意味のある値」として返すか静的に判定
    let returnRight = false;
    if (leftNode && rightNode) {
      // 左辺が純粋なリテラル（数値や文字列）であれば、右辺（変数や式）を返す
      if (leftNode.type === 'number' || leftNode.type === 'string') {
        returnRight = true;
      }
    }

    this.emit(`    if (result f64)`);
    if (returnRight) {
      this.emit(`      local.get $tmp_r`);
    } else {
      this.emit(`      local.get $tmp_l`);
    }
    this.emit(`    else`);
    this.emit(`      f64.const nan`);
    this.emit(`    end`);
  }

  getFreeVariables(node, argName) {
    let freeVars = new Set();

    // 探索用の内部関数（bound: そのスコープで自前で持っている変数のリスト）
    const traverse = (n, bound) => {
      if (!n) return;
      if (n.type === 'identifier' || n.type === 'variable') {
        const vName = n.name || n.value || n.text;
        const normalizedName = vName.startsWith('$') ? vName : '$' + vName;

        // 自分が持っていない変数（boundに含まれていない）なら、自由変数として記録！
        if (!bound.has(normalizedName) && normalizedName !== '$_' && normalizedName !== '$nan') {
          freeVars.add(normalizedName);
        }
      } else if (n.type === 'infix') {
        if (n.op === '?') {
          // ⚡ 重要: 内側のラムダ式に入るときは、その引数を「自前で持つ変数」として追加する
          const newBound = new Set(bound);
          const pName = n.left.name || n.left.value || n.left.text;
          newBound.add(pName.startsWith('$') ? pName : '$' + pName);
          traverse(n.right, newBound); // 新しいスコープで中身を探索
        } else {
          traverse(n.left, bound);
          traverse(n.right, bound);
        }
      } else if (n.type === 'block') {
        (n.body || []).forEach(stmt => traverse(stmt, bound));
      } else if (n.type === 'apply' || n.type === 'call') {
        traverse(n.func || n.fn || n.callee || n.left, bound);
        traverse(n.arg || n.args || n.right, bound);
      }
    };

    // 一番最初は「自分自身の引数(argName)」だけを持っている状態で探索スタート
    traverse(node, new Set([argName]));

    return Array.from(freeVars);
  }

  compileLambda(node) {
    this.lambdaCount++;
    const funcId = this.lambdaCount;
    const funcName = `$lambda_${funcId}`;

    const paramName = node.left.value.startsWith('$') ? node.left.value : '$' + node.left.value;

    // ユーザー様が完璧に修正してくださったキャプチャ解析を使います
    const freeVars = this.getFreeVariables(node.right, paramName);

    const envSize = freeVars.length * 8;
    if (envSize > 0) {
      this.emit(`    ;; ⚡ クロージャ環境の確保 (${envSize} bytes)`);
      this.emit(`    i32.const ${envSize}`);
      this.emit(`    call $alloc`);
      this.emit(`    local.set $tmp_ptr`);

      freeVars.forEach((v, idx) => {
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    local.get ${v}`);
        this.emit(`    f64.store offset=${idx * 8}`);
      });
    } else {
      this.emit(`    i32.const 0`);
      this.emit(`    local.set $tmp_ptr`);
    }

    this.emit(`    ;; ⚡ Fat Pointer の作成`);
    this.emit(`    i64.const ${funcId}`);
    this.emit(`    i64.const 32`);
    this.emit(`    i64.shl`);
    this.emit(`    local.get $tmp_ptr`);
    this.emit(`    i64.extend_i32_u`);
    this.emit(`    i64.or`);
    this.emit(`    f64.reinterpret_i64`);

    // --- ここから【内側の関数】の定義 ---
    const prevCode = this.code;
    const prevLocals = this.locals;

    // ★ 追加: ラムダの中身をコンパイルする前に、外側の「型スタック」を安全な場所に退避させる
    const prevTypeStack = this.typeStack;

    this.code = [];
    this.locals = [paramName, ...freeVars];
    this.typeStack = []; // ★ ラムダ内部のコンパイル用に空のスタックを用意

    this.emit(`  (func ${funcName} (param $env f64) (param ${paramName} f64) (result f64)`);
    this.emit(`    (local $tmp_l f64)`);
    this.emit(`    (local $tmp_r f64)`);
    this.emit(`    (local $tmp_cond f64)`);
    this.emit(`    (local $tmp_ptr i32)`);

    freeVars.forEach(v => {
      this.emit(`    (local ${v} f64)`);
    });

    if (freeVars.length > 0) {
      this.emit(`    ;; ⚡ 環境の復元`);
      this.emit(`    local.get $env`);
      this.emit(`    i32.trunc_f64_s`);
      this.emit(`    local.set $tmp_ptr`);

      freeVars.forEach((v, idx) => {
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    f64.load offset=${idx * 8}`);
        this.emit(`    local.set ${v}`);
      });
    }

    // ラムダの本体をコンパイル
    this.visit(node.right);

    // ★ 追加: 本体をコンパイルし終えた時点のトップの型が「この関数の戻り値の型」になる！
    let returnType = this.typeStack.length > 0 ? this.typeStack.pop() : { type: 'Float' };

    this.emit(`  )`);

    this.functions.push(...this.code);
    this.elemFuncs[funcId] = funcName; // ⚡ PushではなくIDを指定して絶対的な位置に配置！
    this.code = prevCode;
    this.locals = prevLocals;

    // コンパイラの状態を外側のものに戻す
    this.code = prevCode;
    this.locals = prevLocals;
    this.typeStack = prevTypeStack; // ★ 型スタックを復元

    if (this.typeStack) {
      // ★ 変更: 関数型情報の中に「戻り値の型(returnType)」も一緒に記憶させておく
      this.typeStack.push({ type: 'Function', id: funcId, returnType: returnType });
    }
  }

  compileSpace(node) {
    this.visit(node.left);
    let leftType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    this.visit(node.right);
    let rightType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    if (leftType.type === 'Function' && rightType.type === 'Function') {
      this.emit(`    ;; ⚡ [静的型解決] 関数 ␣ 関数 -> 関数合成`);
      this.emit(`    call $compose`);
      // 合成された関数の戻り値は、左側の関数の戻り値になる
      if (this.typeStack) this.typeStack.push({ type: 'Function', returnType: leftType.returnType });

    } else if (leftType.type === 'Function') {
      this.emit(`    ;; ⚡ [静的型解決] 関数 ␣ Any -> 関数適用 (call_indirect)`);
      this.emit(`    local.set $tmp_r`);
      this.emit(`    local.set $tmp_l`);

      this.emit(`    local.get $tmp_l`);
      this.emit(`    i64.reinterpret_f64`);
      this.emit(`    i64.const 0xFFFFFFFF`);
      this.emit(`    i64.and`);
      this.emit(`    f64.convert_i64_u`);

      this.emit(`    local.get $tmp_r`);

      this.emit(`    local.get $tmp_l`);
      this.emit(`    i64.reinterpret_f64`);
      this.emit(`    i64.const 32`);
      this.emit(`    i64.shr_u`);
      this.emit(`    i32.wrap_i64`);

      this.emit(`    call_indirect (type $closure_sig)`);

      let retType = leftType.returnType || { type: 'Float' };
      if (this.typeStack) this.typeStack.push(retType);

    } else if (leftType.type === 'List' && rightType.type === 'List') {
      this.emit(`    ;; ⚡ [静的型解決] List ␣ List -> リスト結合`);
      this.emit(`    call $list_concat`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else if (leftType.type === 'List') {
      this.emit(`    ;; ⚡ [静的型解決] List ␣ Any -> Push`);
      this.emit(`    call $list_push`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else if (rightType.type === 'List') {
      this.emit(`    ;; ⚡ [静的型解決] Any ␣ List -> Unshift`);
      this.emit(`    call $list_unshift`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else {
      this.emit(`    ;; ⚡ [静的型解決] Any ␣ Any -> 積 (Cons)`);
      this.emit(`    call $cons`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });
    }
  }
}