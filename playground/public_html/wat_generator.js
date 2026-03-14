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
    this.emit('  (import "env" "str_to_num" (func $str_to_num (param f64) (result f64)))');
    this.emit('  (import "env" "str_concat" (func $str_concat (param f64 f64) (result f64)))');

    this.emit('  (memory $mem 1)');
    this.emit('  (export "memory" (memory $mem))');
    this.emit('  (global $hp (mut i32) (i32.const 8))');
    // ★追加: 高階関数のためのテーブルと、クロージャ呼び出しの型シグネチャ
    this.emit('  (table $func_table 100 funcref)');
    // ⚡ 関数シグネチャを単一の「コンテキストリスト (ctx)」のみに変更
    this.emit('  (type $closure_sig (func (param f64) (result f64)))');
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
  (func $alloc (export "alloc") (param $size i32) (result i32)
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

    // ★ 鉄壁のTruthy判定（0やすべてのポインタは真、純粋なNaNだけ偽）
    this.emit(`
  (func $is_truthy (param $val f64) (result i32)
    (local $tag i32)
    local.get $val
    local.get $val
    f64.eq
    if (result i32)
      i32.const 1
    else
      local.get $val
      i64.reinterpret_f64
      i64.const 32
      i64.shr_u
      i32.wrap_i64
      i32.const 0xFFFF0000
      i32.and
      local.set $tag
      
      local.get $tag
      i32.const 0x7FF90000
      i32.ge_u
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

    // ⚡ 1. Pipeline Caller (Dispatcher) - 堅牢なポインタ渡し版
    this.emit(`
  (func $composed_caller (param $ctx f64) (result f64)
    (local $ctx_ptr i32)
    (local $arg f64)
    (local $env f64)
    (local $f f64)
    (local $g f64)
    (local $f_res f64)

    local.get $ctx
    call $f64_to_ptr
    local.set $ctx_ptr
    
    local.get $ctx_ptr
    f64.load offset=0
    local.set $arg
    local.get $ctx_ptr
    f64.load offset=8
    local.set $env

    local.get $env
    call $f64_to_ptr
    local.set $ctx_ptr
    
    local.get $ctx_ptr
    f64.load offset=0
    local.set $f
    local.get $ctx_ptr
    f64.load offset=8
    local.set $g

    local.get $arg

    local.get $f
    i64.reinterpret_f64
    i64.const 0xFFFFFFFF
    i64.and
    i32.wrap_i64
    call $ptr_to_f64
    
    call $cons

    local.get $f
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    call_indirect (type $closure_sig)
    local.set $f_res

    local.get $f_res

    local.get $g
    i64.reinterpret_f64
    i64.const 0xFFFFFFFF
    i64.and
    i32.wrap_i64
    call $ptr_to_f64
    
    call $cons
    
    local.get $g
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    call_indirect (type $closure_sig)
  )`);

    // ⚡ 2. Compose function - 堅牢なポインタ取得版
    this.emit(`
  (func $compose (param $f f64) (param $g f64) (result f64)
    (local $env_ptr i32)
    local.get $f
    local.get $g
    call $cons
    
    call $f64_to_ptr
    local.set $env_ptr
    
    i64.const 99
    i64.const 32
    i64.shl
    local.get $env_ptr
    i64.extend_i32_u
    i64.or
    f64.reinterpret_i64
  )`);

    // ⚡ 3. List Concat (完全修正版)
    this.emit(`
  (func $list_concat (param $l1 f64) (param $l2 f64) (result f64)
    (local $curr_ptr i32)
    (local $cdr_val f64)

    local.get $l1
    call $is_ptr
    i32.eqz
    if
      local.get $l1
      local.get $l1
      f64.ne
      if
        local.get $l2
        return
      else
        local.get $l1
        local.get $l2
        call $cons
        return
      end
    end

    local.get $l1
    call $f64_to_ptr
    local.set $curr_ptr

    (loop $find_end
      local.get $curr_ptr
      f64.load offset=8
      local.set $cdr_val

      local.get $cdr_val
      call $is_ptr
      if
        local.get $cdr_val
        call $f64_to_ptr
        local.set $curr_ptr
        br $find_end
      end
    )

    local.get $cdr_val
    local.get $cdr_val
    f64.ne
    if
      local.get $curr_ptr
      local.get $l2
      f64.store offset=8
    else
      local.get $curr_ptr
      local.get $cdr_val
      local.get $l2
      call $cons
      f64.store offset=8
    end

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

    // ⚡ 6. List Flatten (後置 ~ の実体)
    this.emit(`
  (func $list_flatten (param $val f64) (result f64)
    (local $car f64)
    (local $cdr f64)

    local.get $val
    call $is_ptr
    i32.eqz
    if
      local.get $val
      return
    end

    local.get $val
    call $f64_to_ptr
    f64.load offset=0
    call $list_flatten
    local.set $car

    local.get $val
    call $f64_to_ptr
    f64.load offset=8
    call $list_flatten
    local.set $cdr

    local.get $car
    local.get $cdr
    call $list_concat
  )`);

    // ⚡ 7. Deep Search Equality (ディープ・サーチ・イコール)
    this.emit(`
  (func $val_eq (param $p1 f64) (param $p2 f64) (result i32)
    (local $ptr1 i32)
    (local $ptr2 i32)
    (local $tag1 i32)
    (local $tag2 i32)
    (local $len1 i32)
    (local $len2 i32)
    (local $i i32)

    local.get $p1
    i64.reinterpret_f64
    local.get $p2
    i64.reinterpret_f64
    i64.eq
    if i32.const 1 return end

    local.get $p1
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 0xFFFF0000
    i32.and
    local.set $tag1

    local.get $p2
    i64.reinterpret_f64
    i64.const 32
    i64.shr_u
    i32.wrap_i64
    i32.const 0xFFFF0000
    i32.and
    local.set $tag2

    local.get $tag1
    local.get $tag2
    i32.ne
    if i32.const 0 return end

    local.get $tag1
    i32.const 0x7FFB0000
    i32.eq
    if
      local.get $p1
      call $f64_to_ptr
      local.set $ptr1
      local.get $p2
      call $f64_to_ptr
      local.set $ptr2

      local.get $ptr1
      i32.load offset=0
      local.set $len1
      local.get $ptr2
      i32.load offset=0
      local.set $len2

      local.get $len1
      local.get $len2
      i32.ne
      if i32.const 0 return end

      i32.const 0
      local.set $i
      (block $break
        (loop $compare_loop
          local.get $i
          local.get $len1
          i32.ge_u
          br_if $break

          local.get $ptr1
          local.get $i
          i32.add
          i32.load8_u offset=4
          local.get $ptr2
          local.get $i
          i32.add
          i32.load8_u offset=4
          i32.ne
          if i32.const 0 return end

          local.get $i
          i32.const 1
          i32.add
          local.set $i
          br $compare_loop
        )
      )
      i32.const 1
      return
    end

    local.get $tag1
    i32.const 0x7FFC0000
    i32.eq
    local.get $tag1
    i32.const 0x7FF40000
    i32.eq
    i32.or
    if
      local.get $p1
      call $f64_to_ptr
      f64.load offset=0
      local.get $p2
      call $f64_to_ptr
      f64.load offset=0
      call $val_eq
      i32.eqz
      if i32.const 0 return end

      local.get $p1
      call $f64_to_ptr
      f64.load offset=8
      local.get $p2
      call $f64_to_ptr
      f64.load offset=8
      call $val_eq
      return
    end

    i32.const 0
    return
  )`);

    // ⚡ 8. Dictionary Get (辞書/A-Listからの値取得)
    this.emit(`
  (func $dict_get (param $alist f64) (param $key f64) (result f64)
    (local $current_node i32)
    (local $pair_ptr i32)
    (local $current_key f64)

    local.get $alist
    call $f64_to_ptr
    local.set $current_node

    (block $exit
      (loop $search
        local.get $current_node
        i32.eqz
        br_if $exit

        local.get $current_node
        f64.load offset=0
        call $f64_to_ptr
        local.set $pair_ptr

        local.get $pair_ptr
        f64.load offset=0
        local.set $current_key

        local.get $current_key
        local.get $key
        call $val_eq
        if
          local.get $pair_ptr
          f64.load offset=8
          return
        end

        ;; 次のノードへ
        local.get $current_node
        f64.load offset=8
        call $f64_to_ptr
        local.set $current_node
        br $search
      )
    )
    f64.const nan
  )`);

    // ⚡ 9. Memory Store (アドレスへの破壊的書き込み)
    this.emit(`
  (func $store_data (param $addr f64) (param $data f64) (result f64)
    local.get $addr
    call $f64_to_ptr
    local.get $data
    f64.store offset=0
    local.get $data
  )`);

    // ⚡ 10. String Map Add (文字列の各文字コードに数値を加算してリスト化する)
    this.emit(`
  (func $str_map_add (param $str f64) (param $num f64) (result f64)
    (local $str_ptr i32)
    (local $len i32)
    (local $i i32)
    (local $char_val f64)
    (local $list f64)

    local.get $str
    call $f64_to_ptr
    local.set $str_ptr

    local.get $str_ptr
    i32.load offset=0
    local.set $len

    f64.const nan
    local.set $list
    local.get $len
    local.set $i

    (block $break
      (loop $loop
        local.get $i
        i32.eqz
        br_if $break

        local.get $i
        i32.const 1
        i32.sub
        local.set $i

        local.get $str_ptr
        local.get $i
        i32.add
        i32.load8_u offset=4
        f64.convert_i32_u
        local.get $num
        f64.add
        local.set $char_val

        local.get $char_val
        local.get $list
        call $cons
        local.set $list
        br $loop
      )
    )
    local.get $list
  )`);

    this.emit('  (func $main (export "main") (result f64)');

    // ★ 追加：変数の二重宣言を絶対に防ぐガード
    const declaredLocals = new Set();

    this.emit('    (local $tmp_ptr i32)');
    declaredLocals.add('tmp_ptr');

    // ⚡ 追加: ストリームマッチ用のターゲットレジスタ
    this.emit('    (local $tmp_match_target f64)');
    declaredLocals.add('tmp_match_target');

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

      // ⚡ [究極の改善] ブロックの脱出ラベル (ガード節による早期リターンのため)
      const blockLabel = `$block_exit_${Math.floor(Math.random() * 1000000)}`;
      this.emit(`    (block ${blockLabel} (result f64)`);

      for (let i = 0; i < body.length; i++) {
        let expr = body[i];

        // ⚡ ガード節 ( 例: token = Unit ? Unit ) の検知
        let isGuard = false;
        if (expr.type === 'infix' && expr.op === '?') {
          let left = expr.left;
          let isLambdaDef = false; // 左辺がラムダの引数か判定
          if (left && (left.type === 'identifier' || left.type === 'variable')) isLambdaDef = true;
          else if (left && left.type === 'prefix' && left.op === '~') isLambdaDef = true;

          if (!isLambdaDef) isGuard = true;
        }

        if (isGuard) {
          this.visit(expr.left);
          this.emit(`    call $is_truthy`);
          this.emit(`    if`);
          this.visit(expr.right);
          this.emit(`    br ${blockLabel}`); // 真なら評価して即座にブロックを抜ける！
          this.emit(`    end`);

          if (i === body.length - 1) {
            this.emit(`    f64.const nan`); // 最後の式が偽だった場合のフォールバック
          }
        } else {
          // 通常の式の評価
          this.visit(expr);
          if (i < body.length - 1) {
            this.emit('    drop');
            if (this.typeStack) this.typeStack.pop();
          }
        }
      }
      this.emit(`    )`); // ブロック終了
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

      // ==========================================
      // ⚡ [追加] 文字型 (Char) ノードの処理
      // ==========================================
      case 'char':
        this.emit(`    i32.const ${node.value}`);
        this.emit(`    i64.extend_i32_u`);
        // ポインタ(0x7FFC~)と衝突しない独自のCharタグ(0x7FFA~)を付与
        this.emit(`    i64.const 0x7FFA000000000000`);
        this.emit(`    i64.or`);
        this.emit(`    f64.reinterpret_i64`); // NaN-Box化してスタックに積む

        if (this.typeStack) this.typeStack.push({ type: 'Char' });
        break;
      // ==========================================

      // ==========================================
      // ⚡ [追加] 文字列 (String) ノードの処理
      // ==========================================
      case 'string': {
        // 1. バッククォートの安全な除去
        let strVal = node.value;
        if (strVal.startsWith('`') && strVal.endsWith('`')) {
          strVal = strVal.slice(1, -1);
        }

        // 2. UTF-8バイト列へのエンコード
        const encoder = new TextEncoder();
        const bytes = encoder.encode(strVal);
        const len = bytes.length;

        // 3. メモリ確保 (文字列長: 4バイト + 本体: lenバイト)
        this.emit(`    i32.const ${len + 4}`);
        this.emit(`    call $alloc`);
        this.emit(`    local.set $tmp_ptr`);

        // 4. 文字列長の保存 (先頭4バイト, i32)
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    i32.const ${len}`);
        this.emit(`    i32.store offset=0`);

        // 5. 各バイトデータの保存
        for (let i = 0; i < len; i++) {
          this.emit(`    local.get $tmp_ptr`);
          this.emit(`    i32.const ${bytes[i]}`);
          this.emit(`    i32.store8 offset=${4 + i}`);
        }

        // 6. ポインタをNaN-Box化してスタックに積む
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    i64.extend_i32_u`);
        this.emit(`    i64.const 0x7FFB000000000000`);
        this.emit(`    i64.or`);
        this.emit(`    f64.reinterpret_i64`);

        // 型スタックにStringを記憶
        if (this.typeStack) this.typeStack.push({ type: 'String' });
        break;
      }
      // ==========================================

      case 'identifier':
      case 'variable':
        const varName = node.name || node.value || node.text;
        if (varName === '_' || varName === 'nan') {
          this.emit(`    f64.const nan`);
          if (this.typeStack) this.typeStack.push({ type: 'Unit' });
        } else {
          const wasmVarName = varName.startsWith('$') ? varName : '$' + varName;

          // ⚡ [究極の改善] Hardware-Isomorphic Stream Lookup with Local Fallback
          // ストリーム(token~)のコンテキスト内にいる場合、まずポインタから辞書引きする
          if (this.currentMatchTarget) {
            this.emit(`    ;; Hardware-Isomorphic Stream Lookup: ${varName}`);
            this.emit(`    local.get ${this.currentMatchTarget}`);

            let rawName = varName.startsWith('$') ? varName.slice(1) : varName;
            this.visit({ type: 'string', value: '\`' + rawName + '\`' });
            if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

            this.emit(`    call $dict_get`);
            this.emit(`    local.set $tmp_cond`); // 検索結果を一時保存

            // ⚡ 修正: NaN かどうかの判定に is_truthy を使う！
            this.emit(`    local.get $tmp_cond`);
            this.emit(`    call $is_truthy`);
            this.emit(`    if (result f64)`);
            this.emit(`      local.get $tmp_cond`); // 見つかったらストリームの値をそのまま使う！
            this.emit(`    else`);
            this.emit(`      local.get ${wasmVarName}`); // 無ければ外側のローカル変数にフォールバック
            this.emit(`    end`);
          } else {
            this.emit(`    local.get ${wasmVarName}`);
          }

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
        this.emit(`    i64.extend_i32_u`);
        this.emit(`    i64.const 0x7FF9000000000000`);
        this.emit(`    i64.or`);
        this.emit(`    f64.reinterpret_i64`);
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
      // ★ リストへの Lift (単一値を長さ1のリストにする)
      case '~':
        this.emit(`    f64.const nan`);
        this.emit(`    call $cons`);
        if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();
        if (this.typeStack) this.typeStack.push({ type: 'List' }); // ★ List型として積む
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

      // ==========================================
      // ⚡ リストの Flat (平坦化・スプレッド展開)
      // ==========================================
      case '~':
        this.emit(`    call $list_flatten`);
        if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();
        if (this.typeStack) this.typeStack.push({ type: 'SpreadList' }); // ★ スプレッド展開済みタグを積む
        break;

      default: throw new Error(`[WASM Compiler] Unsupported postfix operator: "${op}"`);
    }
  }

  compileInfix(node) {
    const { op, left, right } = node;

    if (op === '?') {
      // ⚡ 修正: 左辺がラムダの引数定義であるかを厳密に判定
      let isLambdaDef = false;
      if (left && (left.type === 'identifier' || left.type === 'variable')) {
        isLambdaDef = true;
      } else if (left && left.type === 'prefix' && left.op === '~') {
        isLambdaDef = true;
      }

      if (isLambdaDef) {
        this.compileLambda(node);
      } else {
        // インラインのガード節 (ブロック内ではなく単独で評価された場合)
        this.visit(left);
        this.emit(`    call $is_truthy`);
        this.emit(`    if (result f64)`);
        this.visit(right);
        this.emit(`    else`);
        this.emit(`      f64.const nan`);
        this.emit(`    end`);
      }
      return;
    }

    if (op === ' ') {
      this.compileSpace(node);
      return;
    }

    // ==========================================
    // ⚡ カンマ(積)の賢い静的ディスパッチ (Spread対応)
    // ==========================================
    if (op === ',') {
      this.visit(left);
      let leftType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

      this.visit(right);
      let rightType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

      // 左右どちらかが「スプレッド展開済み(SpreadList)」であれば、平坦に結合(concat)する！
      if (leftType.type === 'SpreadList' || rightType.type === 'SpreadList') {
        this.emit(`    call $list_concat`);
      } else {
        this.emit(`    call $cons`);
      }

      if (this.typeStack) {
        this.typeStack.push({ type: 'List' });
      }
      return;
    }

    // ==========================================
    // ⚡ 辞書からの値取得 (')
    // ==========================================
    if (op === "'") {
      this.visit(left);
      if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

      this.visit(right);
      if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

      this.emit(`    call $dict_get`);

      if (this.typeStack) {
        this.typeStack.push({ type: 'Any' });
      }
      return;
    }

    // ==========================================
    // ⚡ アドレスへのデータ関連付け/書き込み (#)
    // ==========================================
    if (op === '#') {
      this.visit(left);
      if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

      this.visit(right);
      if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

      this.emit(`    call $store_data`);

      if (this.typeStack) {
        this.typeStack.push({ type: 'Any' });
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

    // ⚡ 型を推論しながらスタックに積む
    this.visit(left);
    let leftType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    this.visit(right);
    let rightType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    switch (op) {
      case '+':
        if (leftType.type === 'String') {
          this.emit(`    call $str_map_add`);
          if (this.typeStack) this.typeStack.push({ type: 'List' });
        } else if (rightType.type === 'String') {
          this.emit(`    call $str_to_num`);
          this.emit(`    f64.add`);
          if (this.typeStack) this.typeStack.push({ type: 'Float' });
        } else {
          this.emit(`    f64.add`);
          if (this.typeStack) this.typeStack.push({ type: 'Float' });
        }
        break;
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

      // ⚡ 変更: f64.eq ではなく $val_eq を呼ぶ
      case '=':
        this.emit(`    call $val_eq`);
        break;

      // ⚡ 変更: $val_eq を呼んでから結果(i32)を反転させる
      case '!=':
        this.emit(`    call $val_eq`);
        this.emit(`    i32.eqz`);
        break;

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

  // ⚡ 修正: initialBoundArray (配列) を受け取るように変更
  getFreeVariables(node, initialBoundArray) {
    let freeVars = new Set();

    const traverse = (n, bound) => {
      if (!n) return;
      if (n.type === 'identifier' || n.type === 'variable') {
        const vName = n.name || n.value || n.text;
        const normalizedName = vName.startsWith('$') ? vName : '$' + vName;

        if (!bound.has(normalizedName) && normalizedName !== '$_' && normalizedName !== '$nan') {
          freeVars.add(normalizedName);
        }
      } else if (n.type === 'infix') {
        if (n.op === '?') {
          const newBound = new Set(bound);
          let pName = n.left.name || n.left.value || n.left.text;

          // ~b のような接頭辞付きパラメータの救済
          if (!pName && n.left.type === 'prefix' && n.left.op === '~') {
            pName = n.left.expr.name || n.left.expr.value || n.left.expr.text;
          }
          if (pName) newBound.add(pName.startsWith('$') ? pName : '$' + pName);

          traverse(n.right, newBound);
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

    traverse(node, new Set(initialBoundArray));
    return Array.from(freeVars);
  }

  compileLambda(node) {
    this.lambdaCount++;
    const funcId = this.lambdaCount;
    const funcName = `$lambda_${funcId}`;

    let isDestructuring = false;
    let headName = null;
    let tailName = null;
    let actualBody = node.right;
    let paramName = null;

    // ==========================================
    // ⚡ 1. 構造分解 ( a ~b ? ... ) の検知
    // パーサーが a ? (~b ? ...) と解釈したものをフラット化
    // ==========================================
    if (node.left && (node.left.type === 'identifier' || node.left.type === 'variable')) {
      if (node.right && node.right.type === 'infix' && node.right.op === '?') {
        if (node.right.left && node.right.left.type === 'prefix' && node.right.left.op === '~') {
          isDestructuring = true;
          let hName = node.left.name || node.left.value || node.left.text;
          let tName = node.right.left.expr.name || node.right.left.expr.value || node.right.left.expr.text;
          headName = hName.startsWith('$') ? hName : '$' + hName;
          tailName = tName.startsWith('$') ? tName : '$' + tName;
          actualBody = node.right.right;
          paramName = '$list_arg'; // 引数全体(リスト)の一時変数
        }
      }
    }

    if (!isDestructuring) {
      let pName = node.left.name || node.left.value || node.left.text;
      if (!pName && node.left.type === 'prefix' && node.left.op === '~') {
        pName = node.left.expr.name || node.left.expr.value || node.left.expr.text;
      }
      paramName = pName.startsWith('$') ? pName : '$' + pName;
    }

    // ⚡ 2. キャプチャ解析
    let freeVars;
    if (isDestructuring) {
      freeVars = this.getFreeVariables(actualBody, [headName, tailName]);
    } else {
      freeVars = this.getFreeVariables(actualBody, [paramName]);
    }

    // ==========================================
    // ⚡ [CALLER] 外側の環境（クロージャ）の確保
    // ==========================================
    const envSize = freeVars.length * 8;
    if (envSize > 0) {
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

    this.emit(`    i64.const ${funcId}`);
    this.emit(`    i64.const 32`);
    this.emit(`    i64.shl`);
    this.emit(`    local.get $tmp_ptr`);
    this.emit(`    i64.extend_i32_u`);
    this.emit(`    i64.or`);
    this.emit(`    f64.reinterpret_i64`);

    // ==========================================
    // ⚡ [LAMBDA] 内側の関数定義
    // ==========================================
    const prevCode = this.code;
    const prevLocals = this.locals;
    const prevTypeStack = this.typeStack;

    this.code = [];
    this.locals = [paramName, ...freeVars];
    if (isDestructuring) {
      this.locals.push(headName, tailName);
    }
    this.typeStack = [];

    this.emit(`  (func ${funcName} (param $ctx f64) (result f64)`);
    this.emit(`    (local $tmp_l f64)`);
    this.emit(`    (local $tmp_r f64)`);
    this.emit(`    (local $tmp_cond f64)`);
    this.emit(`    (local $tmp_ptr i32)`);

    this.emit(`    (local $tmp_match_target f64)`);

    this.emit(`    (local ${paramName} f64)`);
    if (isDestructuring) {
      this.emit(`    (local ${headName} f64)`);
      this.emit(`    (local ${tailName} f64)`);
    }
    this.emit(`    (local $env f64)`);
    this.emit(`    (local $ctx_ptr i32)`);
    freeVars.forEach(v => {
      this.emit(`    (local ${v} f64)`);
    });

    this.emit(`    local.get $ctx`);
    this.emit(`    call $f64_to_ptr`);
    this.emit(`    local.set $ctx_ptr`);

    this.emit(`    local.get $ctx_ptr`);
    this.emit(`    f64.load offset=0`);
    this.emit(`    local.set ${paramName}`);

    this.emit(`    local.get $ctx_ptr`);
    this.emit(`    f64.load offset=8`);
    this.emit(`    local.set $env`);

    if (freeVars.length > 0) {
      this.emit(`    local.get $env`);
      this.emit(`    call $f64_to_ptr`);
      this.emit(`    local.set $tmp_ptr`);

      freeVars.forEach((v, idx) => {
        this.emit(`    local.get $tmp_ptr`);
        this.emit(`    f64.load offset=${idx * 8}`);
        this.emit(`    local.set ${v}`);
      });
    }

    // ==========================================
    // ⚡ 3. リストの構造分解アセンブリ出力
    // ==========================================
    if (isDestructuring) {
      this.emit(`    local.get ${paramName}`);
      this.emit(`    call $is_ptr`);
      this.emit(`    if`);
      this.emit(`      local.get ${paramName}`);
      this.emit(`      call $f64_to_ptr`);
      this.emit(`      f64.load offset=0`);
      this.emit(`      local.set ${headName}`);

      this.emit(`      local.get ${paramName}`);
      this.emit(`      call $f64_to_ptr`);
      this.emit(`      f64.load offset=8`);
      this.emit(`      local.set ${tailName}`);
      this.emit(`    else`);
      // リストでないものが渡された場合は安全に Unit にする
      this.emit(`      f64.const nan`);
      this.emit(`      local.set ${headName}`);
      this.emit(`      f64.const nan`);
      this.emit(`      local.set ${tailName}`);
      this.emit(`    end`);
    }

    // ==========================================
    // パターンマッチ または 通常の評価
    // ==========================================
    const isMatchBlock = actualBody && actualBody.type === 'block' &&
      actualBody.body && actualBody.body.length > 0 &&
      actualBody.body[0].type === 'infix' && actualBody.body[0].op === ':';

    if (isMatchBlock) {
      this.emit(`    (block $match_exit (result f64)`);

      for (let i = 0; i < actualBody.body.length; i++) {
        const branch = actualBody.body[i];

        if (branch.type === 'infix' && branch.op === ':') {
          this.visit(branch.left);
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

          this.emit(`      local.get ${paramName}`);
          this.emit(`      call $val_eq`);
          this.emit(`      if`);

          this.visit(branch.right);
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();
          this.emit(`      br $match_exit`);
          this.emit(`      end`);
        } else {
          this.visit(branch);
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();
          this.emit(`      br $match_exit`);
        }
      }

      this.emit(`      f64.const nan`);
      this.emit(`    )`);

      if (this.typeStack) this.typeStack.push({ type: 'Any' });

    } else {
      this.visit(actualBody);
    }

    let returnType = this.typeStack.length > 0 ? this.typeStack.pop() : { type: 'Float' };

    this.emit(`  )`); // 関数終了

    this.functions.push(...this.code);
    this.elemFuncs[funcId] = funcName;

    this.code = prevCode;
    this.locals = prevLocals;
    this.typeStack = prevTypeStack;

    if (this.typeStack) {
      this.typeStack.push({ type: 'Function', id: funcId, returnType: returnType });
    }
  }

  compileSpace(node) {
    // ==========================================
    // ⚡ [究極の改善] Hardware-Isomorphic Stream Match Block
    // token~ { type = `number` : ... } の展開
    // ==========================================
    // ⚡ 修正: 右辺が block (複数パターン) の場合と、単独の infix ':' (1パターンの場合) の両方を許可する
    const isStreamMatch = node.left && node.left.type === 'postfix' && node.left.op === '~' &&
      node.right && (node.right.type === 'block' || (node.right.type === 'infix' && node.right.op === ':'));

    if (isStreamMatch) {
      this.emit(`    ;; --- Hardware-Isomorphic Stream Match ---`);
      this.visit(node.left.expr); // ターゲット(token)を評価
      if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

      this.emit(`    local.set $tmp_match_target`);
      this.emit(`    (block $stream_match_exit (result f64)`);

      // ⚡ 修正: blockなら中身を、単独の ':' なら配列で包んでループを統一化
      const branches = node.right.type === 'block' ? (node.right.body || []) : [node.right];

      for (let i = 0; i < branches.length; i++) {
        const branch = branches[i];

        // ⚡ このブロック内では未知の識別子を $tmp_match_target から読むようコンテキストを切り替え
        let prevTarget = this.currentMatchTarget;
        this.currentMatchTarget = '$tmp_match_target';

        if (branch.type === 'infix' && branch.op === ':') {
          // パターンマッチ (例: type = `number` : ...)
          this.visit(branch.left);
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

          this.emit(`      call $is_truthy`);
          this.emit(`      if`);

          this.visit(branch.right); // 右辺もストリームコンテキストで評価！
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();

          this.emit(`      br $stream_match_exit`);
          this.emit(`      end`);
        } else {
          // デフォルトケース
          this.visit(branch);
          if (this.typeStack && this.typeStack.length > 0) this.typeStack.pop();
          this.emit(`      br $stream_match_exit`);
        }

        // コンテキストを元に戻す
        this.currentMatchTarget = prevTarget;
      }

      this.emit(`      f64.const nan`);
      this.emit(`    )`);
      if (this.typeStack) this.typeStack.push({ type: 'Any' });
      return;
    }

    this.visit(node.left);
    let leftType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    this.visit(node.right);
    let rightType = (this.typeStack && this.typeStack.length > 0) ? this.typeStack.pop() : { type: 'Unknown' };

    if (leftType.type === 'Function' && rightType.type === 'Function') {
      this.emit(`    call $compose`);
      // 合成された関数の戻り値は、左側の関数の戻り値になる
      if (this.typeStack) this.typeStack.push({ type: 'Function', returnType: leftType.returnType });

    } else if (leftType.type === 'Function') {
      this.emit(`    ;; ⚡ [静的型解決] 関数 ␣ Any -> 関数適用 (コンテキストリストの作成)`);
      this.emit(`    local.set $tmp_r`); // arg
      this.emit(`    local.set $tmp_l`); // func

      // 1. 実引数 (arg) を積む
      this.emit(`    local.get $tmp_r`);

      // 2. 関数の環境ポインタ (env) を積んで NaN-Boxing する
      this.emit(`    local.get $tmp_l`);
      this.emit(`    i64.reinterpret_f64`);
      this.emit(`    i64.const 0xFFFFFFFF`);
      this.emit(`    i64.and`);
      this.emit(`    i32.wrap_i64`);        // ⚡ 修正
      this.emit(`    call $ptr_to_f64`);   // ⚡ 修正

      // 3. arg と env を cons して１つのリスト(ctx)にする！
      this.emit(`    call $cons`);

      // 4. 関数インデックスを取り出して間接呼び出し
      this.emit(`    local.get $tmp_l`);
      this.emit(`    i64.reinterpret_f64`);
      this.emit(`    i64.const 32`);
      this.emit(`    i64.shr_u`);
      this.emit(`    i32.wrap_i64`);
      this.emit(`    call_indirect (type $closure_sig)`);

      let retType = leftType.returnType || { type: 'Float' };
      if (this.typeStack) this.typeStack.push(retType);

    } else if (leftType.type === 'List' && rightType.type === 'List') {
      this.emit(`    call $list_concat`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else if (leftType.type === 'String' && rightType.type === 'Float') {
      this.emit(`    call $str_concat`);
      if (this.typeStack) this.typeStack.push({ type: 'String' });

    } else if (leftType.type === 'List') {
      this.emit(`    call $list_push`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else if (rightType.type === 'List') {
      this.emit(`    call $list_unshift`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });

    } else {
      this.emit(`    call $cons`);
      if (this.typeStack) this.typeStack.push({ type: 'List' });
    }
  }
}