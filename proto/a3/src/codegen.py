"""Code generation logic for Sign language"""

from ir_builder import int_type, constant, create_builder, create_function_type, function, pointer_type, array_type, global_variable

# エラーハンドリング用（簡易的）
def error(msg):
    raise ValueError(msg)

def zext_to_i64(builder, val):
    """i1 (boolean) を i64 に拡張"""
    return builder.zext(val, int_type(64), name="bool_ext")

def compile_literal(value, module=None):
    """リテラルをLLVM定数に変換"""
    if isinstance(value, int):
        return constant(int_type(64), value)
    elif isinstance(value, str) and value.startswith("`") and value.endswith("`"):
        # 文字列リテラル "`Hello`"
        if module is None:
            # モジュールがない場合はとりあえず0を返す（本来はエラーだが）
            return constant(int_type(64), 0)
        
        content = value[1:-1] # `を除去
        # C文字列にするためにNULL終端
        content_bytes = bytearray(content.encode('utf-8')) + b'\x00'
        n = len(content_bytes)
        
        # グローバル定数作成
        # 文字列型: [N x i8]
        str_type = array_type(int_type(8), n)
        val = constant(str_type, content_bytes)
        
        # 名前生成
        if not hasattr(module, 'str_counter'):
             module.str_counter = 0
        module.str_counter += 1
        name = f".str.{module.str_counter}"
        
        gvar = global_variable(module, str_type, name)
        gvar.initializer = val
        gvar.global_constant = True
        gvar.linkage = 'private' # llvmlite用、mockでは無視されるかも
        
        # i8* にキャストして返す必要あり？
        # しかしSignの値は i64 (または i64*) なので、ポインタを i64 にして返す
        # (グローバル変数はポインタ)
        # compile_expr 内で ptrtoint する
        return gvar
        
    error(f"Unsupported literal type: {type(value)}")

def get_malloc(module):
    """malloc関数を取得または宣言"""
    malloc = None
    if hasattr(module, 'functions'): # llvmlite.Module compatible
        for f in module.functions:
            if f.name == 'malloc':
                malloc = f
                break
    
    if not malloc:
        # declare i8* @malloc(i64)
        from .ir_builder import create_function_type, function, pointer_type, int_type
        i8_ptr = pointer_type(int_type(8))
        fty = create_function_type(i8_ptr, [int_type(64)])
        malloc = function(module, fty, "malloc")
    
    return malloc

def compile_cons(expr, builder, env, module):
    """Consセルの生成"""
    # ["cons", head, tail]
    head_expr = expr[1]
    tail_expr = expr[2]
    
    head_val = compile_expr(head_expr, builder, env, module)
    tail_val = compile_expr(tail_expr, builder, env, module)
    
    # メモリ確保: {i64, i64} (16 bytes)
    # 構造体型
    from .ir_builder import struct_type, pointer_type, int_type
    
    cons_type = struct_type([int_type(64), int_type(64)])
    cons_ptr_type = pointer_type(cons_type)
    
    malloc_func = get_malloc(module)
    if not malloc_func:
        error("Failed to declare malloc")
        
    # size = 16
    size_val = constant(int_type(64), 16)
    
    # void* (i8*) が返る
    raw_ptr = builder.call(malloc_func, [size_val], name="malloc_call")
    
    # i8* -> {i64, i64}* (bitcast)
    # mockにはbitcastがないので、pointer cast的なptrtoint -> inttoptr?
    # いえ、MockValueには型情報があるだけなので、MockIRBuilderにbitcastを追加するか、
    # あるいは store 時に型を無視するか。
    # MockIRBuilder.store は i64* を期待しているが...
    # 正統なLLVM IRなら bitcast i8* %malloc to {i64,i64}*
    
    # MockIRBuilderにbitcastを追加するのが筋
    # ここでは仮に struct pointer として直接扱えるように、
    # mallocの戻り値をそのまま使う...わけにはいかない（型が違う）
    
    cons_ptr = builder.bitcast(raw_ptr, cons_ptr_type, name="cons_ptr")
    
    # headをstore
    # gep (getelementptr) で要素アドレス取得
    head_ptr = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), 0)], name="head_ptr")
    builder.store(head_val, head_ptr)
    
    # tailをstore
    tail_ptr = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), 1)], name="tail_ptr")
    builder.store(tail_val, tail_ptr)
    
    # ポインタをi64として返す
    return builder.ptrtoint(cons_ptr, int_type(64), name="cons_ptr_i64")

def compile_list_access(expr, builder, env, module, index=0):
    """リストアクセサ (head/tail)"""
    # ["head", list_expr]
    list_expr = expr[1]
    list_val = compile_expr(list_expr, builder, env, module)
    
    # i64 (address) -> {i64, i64}* (bitcast)
    from .ir_builder import struct_type, pointer_type, int_type
    cons_type = struct_type([int_type(64), int_type(64)])
    cons_ptr_type = pointer_type(cons_type)
    
    # まず i64 -> i8* (inttoptr) ... だがmockにはinttoptrがない
    # ptrtointの逆が必要。
    # しかしMockでは「値としてのi64」と「ポインタ」が厳密には区別されていない（全部文字列かMockValue）
    # bitcastは `bitcast i8* ...` を想定している。
    # ここで `list_val` が i64 型の整数（本来はポインタ）
    # LLVMなら `inttoptr i64 %val to {i64, i64}*`
    
    # MockIRBuilderに inttoptr を追加するか？
    # とりあえず bitcast で誤魔化せるか？ bitcastは同じサイズの型変換だが、i64とptrはサイズ同じ(64bit)
    # llvmlite/llvmでは inttoptr を使うべき。
    
    # MockIRBuilderに inttoptr を実装します。
    # とりあえずここには呼び出しを書いておく。
    cons_ptr = builder.inttoptr(list_val, cons_ptr_type, name="cons_ptr")
    
    # gep
    elem_ptr = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), index)], name="elem_ptr")
    
    # gep
    elem_ptr = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), index)], name="elem_ptr")
    
    # load
    return builder.load(elem_ptr, name="elem_val")


def compile_match_op(expr, builder, env, module):
    """パターンマッチ (match target clauses...)"""
    from .ir_builder import struct_type, pointer_type, int_type

    target_expr = expr[1]
    clauses = expr[2:]
    
    target_val = compile_expr(target_expr, builder, env, module)
    
    func = builder.block.parent
    merge_block = func.append_basic_block("match_merge")
    phi_inputs = []
    
    for i, clause in enumerate(clauses):
        # clause: [pat, body]
        # ただし最後のケースが body のみの場合もある？
        # ここでは [pat, body] 形式のみサポート
        # pat が "0" (nil) の場合と ["cons", h, t] の場合、 "_" (default) の場合
        
        if not isinstance(clause, list) or len(clause) != 2:
             error(f"Invalid match clause: {clause}")
        
        pat = clause[0]
        body = clause[1]
        
        # マッチ判定ブロック
        check_block = func.append_basic_block(f"match_check_{i}")
        if i == 0:
            builder.branch(check_block) # 最初のチェックへ
        else:
            # 前のブロックからここへ (直前のループで処理されるべきだが、
            # 構造上 cbranch の false 側がここに来るようにする)
            pass 
            
        builder.position_at_end(check_block)
        
        # パターン解析
        is_match_val = None
        matched_env = env.copy()
        
        if pat == "_":
            # 常にマッチ
            is_match_val = constant(int_type(1), 1)
            
        elif pat == 0:
            # 0 (nil) と等しいか
            is_match_val = builder.icmp_signed("eq", target_val, constant(int_type(64), 0), name=f"is_nil_{i}")
            
        elif isinstance(pat, list) and len(pat) == 3 and pat[0] == "cons":
            # ["cons", h, t]
            h_name = pat[1]
            t_name = pat[2]
            
            # リストか？ (!= 0)
            is_match_val = builder.icmp_signed("ne", target_val, constant(int_type(64), 0), name=f"is_cons_{i}")
            
            # バインド変数の準備（Thenブロックで行う必要があるが、env更新はここで行い、Thenブロックでalloca/storeする）
            # ここは分岐の生成だけ。Thenブロックの生成コードで実際の抽出を行う。
            
        else:
            # リテラルマッチ？
             if isinstance(pat, int):
                 is_match_val = builder.icmp_signed("eq", target_val, constant(int_type(64), pat), name=f"is_lit_{i}")
             else:
                 is_match_val = constant(int_type(1), 0) # 未サポートのパターンはマッチしない
        
        # 分岐
        then_block = func.append_basic_block(f"match_then_{i}")
        next_block = func.append_basic_block(f"match_next_{i}")
        
        builder.cbranch(is_match_val, then_block, next_block)
        
        # Thenブロック (Bodyコンパイル)
        builder.position_at_end(then_block)
        
        # 変数バインド
        if isinstance(pat, list) and pat[0] == "cons":
            # head/tail取得
            # ここで compile_list_access のロジックを展開するか再利用したいが、
            # target_val は既に評価済み。
            # compile_list_access は expr を受け取るので使いにくい。
            # 直接書く。
            
            h_name = pat[1]
            t_name = pat[2]
            
            # bitcast / gep / load
            # imports moved to top 
            cons_type = struct_type([int_type(64), int_type(64)])
            cons_ptr_type = pointer_type(cons_type)
            
            cons_ptr = builder.inttoptr(target_val, cons_ptr_type, name="cons_ptr_match")
            
            # head
            head_ptr_gep = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), 0)])
            head_val = builder.load(head_ptr_gep, name="head_val")
            
            # tail
            tail_ptr_gep = builder.gep(cons_ptr, [constant(int_type(32), 0), constant(int_type(32), 1)])
            tail_val = builder.load(tail_ptr_gep, name="tail_val")
            
            # 環境登録 (alloca & store)
            h_ptr = builder.alloca(int_type(64), name=h_name)
            builder.store(head_val, h_ptr)
            matched_env[h_name] = h_ptr
            
            t_ptr = builder.alloca(int_type(64), name=t_name)
            builder.store(tail_val, t_ptr)
            matched_env[t_name] = t_ptr
            
        
        body_val = compile_expr(body, builder, matched_env, module)
        phi_inputs.append((body_val, builder.block))
        builder.branch(merge_block)
        
        # Nextブロックへ移動 (次のループの先頭で position_at_end される)
        builder.position_at_end(next_block)
        
    # Default case (if no match matches and loop ends)
    # 最後のnext_blockにいる
    # 0を返してマージへ（またはエラー？）
    builder.branch(merge_block)
    phi_inputs.append((constant(int_type(64), 0), builder.block))
    
    builder.position_at_end(merge_block)
    phi = builder.phi(int_type(64), name="match_res")
    for val, blk in phi_inputs:
        phi.add_incoming(val, blk)
        
    return phi

def compile_match_impl(expr, builder, env, module):
    """条件分岐 (Match) のコンパイル"""
    # builder.block.parent (MockFunction) を取得
    func = builder.block.parent
    
    merge_block = func.append_basic_block("merge")
    phi_inputs = [] # (value, block)
    
    incoming_blocks = [] # 処理すべきケース
    
    # ケースの解析
    for item in expr:
        if isinstance(item, list) and len(item) > 0 and item[0] == ":":
            # [":", cond, body]
            cond = item[1]
            body = item[2]
            incoming_blocks.append((cond, body))
        else:
            # デフォルト値（条件なし）
            incoming_blocks.append((None, item))
            
    # 各ケースを生成
    for i, (cond, body) in enumerate(incoming_blocks):
        # 現在のブロックで条件評価（デフォルトなら常に真だが、if-else連鎖にする）
        
        if cond is None:
            # デフォルトケース（最後のelse）
            val = compile_expr(body, builder, env, module)
            phi_inputs.append((val, builder.block))
            builder.branch(merge_block)
            break # これ以降は到達不能
        
        # 条件あり
        cond_val = compile_expr(cond, builder, env, module)
        
        # i64 -> i1 (0と比較)
        cmp = builder.icmp_signed("ne", cond_val, constant(int_type(64), 0), name=f"cond_{i}")
        
        then_block = func.append_basic_block(f"case_{i}_then")
        next_block = func.append_basic_block(f"case_{i}_next")
        
        builder.cbranch(cmp, then_block, next_block)
        
        # Thenブロック
        builder.position_at_end(then_block)
        val = compile_expr(body, builder, env, module)
        phi_inputs.append((val, builder.block))
        builder.branch(merge_block)
        
        # Nextブロック（次の条件へ）
        builder.position_at_end(next_block)
        
    # mergeブロック
    builder.position_at_end(merge_block)
    phi = builder.phi(int_type(64), name="match_result")
    for val, blk in phi_inputs:
        phi.add_incoming(val, blk)
        
    return phi

def compile_expr(expr, builder, env=None, module=None):
    """S式をLLVM IRに変換"""
    if env is None:
        env = {}
    
    # 1. リテラル (Int)
    if isinstance(expr, int):
        return constant(int_type(64), expr)
    
    # 2. 変数参照 または 数値リテラル（文字列形式） または 文字列リテラル
    if isinstance(expr, str):
        # 文字列リテラル
        if expr.startswith("`"):
           gvar = compile_literal(expr, module)
           # グローバル変数のアドレス(pointer)をi64に変換して返す
           return builder.ptrtoint(gvar, int_type(64), name="str_ptr")

        # 数値として解釈を試みる
        try:
            val = int(expr, 0)
            return constant(int_type(64), val)
        except ValueError:
            pass
            
        if expr in env:
            val_or_ptr = env[expr]
            
            # 関数オブジェクトならポインタを整数化して返す
            if hasattr(val_or_ptr, 'func_type'):
                 return builder.ptrtoint(val_or_ptr, int_type(64), name=f"{expr}_ptr")
            
            # 通常の変数はポインタなのでロード
            return builder.load(val_or_ptr, name=expr)
        else:
            return constant(int_type(64), 0)

    # 3. リスト
    if isinstance(expr, list):
        if not expr:
            error("Empty expression")
        
        # Match/Cond判定
        first = expr[0]
        if isinstance(first, list) and len(first) > 0 and first[0] == ":":
            return compile_match_impl(expr, builder, env, module)

        op = expr[0]
        
        # 四則演算
        if op == "+":
            left = compile_expr(expr[1], builder, env, module)
            right = compile_expr(expr[2], builder, env, module)
            return builder.add(left, right, name="add_tmp")
        
        elif op == "-":
            if len(expr) == 2:  # 単項マイナス
                val = compile_expr(expr[1], builder, env, module)
                return builder.sub(
                    constant(int_type(64), 0), 
                    val, 
                    name="neg_tmp"
                )
            else:  # 二項マイナス
                left = compile_expr(expr[1], builder, env, module)
                right = compile_expr(expr[2], builder, env, module)
                return builder.sub(left, right, name="sub_tmp")
        
        elif op == "*":
            left = compile_expr(expr[1], builder, env, module)
            right = compile_expr(expr[2], builder, env, module)
            return builder.mul(left, right, name="mul_tmp")
        
        elif op == "/":
            left = compile_expr(expr[1], builder, env, module)
            right = compile_expr(expr[2], builder, env, module)
            return builder.sdiv(left, right, name="div_tmp")

        # 比較演算
        elif op in ["<", ">", "=", "!=", "<=", ">="]:
            left = compile_expr(expr[1], builder, env, module)
            right = compile_expr(expr[2], builder, env, module)
            
            # 演算子のマッピング
            op_map = {
                "<": "slt",
                ">": "sgt",
                "=": "eq",
                "!=": "ne",
                "<=": "sle",
                ">=": "sge"
            }
            llvm_op = op_map[op]
            
            cmp_res = builder.icmp_signed(llvm_op, left, right, name="cmp_tmp")
            return zext_to_i64(builder, cmp_res)

        # 関数定義 [?, [args], body]
        elif op == "?":
            func = compile_function_def(expr, builder, env, module)
            return builder.ptrtoint(func, int_type(64), name="func_ptr")
        
        # 4. 定義 [":", "name", value]
        elif op == ":":
            var_name = expr[1]
            val_expr = expr[2]
            
            # 値が関数定義 [?, ...] の場合、名前付き関数としてコンパイル
            if isinstance(val_expr, list) and len(val_expr) > 0 and val_expr[0] == "?":
                func = compile_function_def(val_expr, builder, env, module, name=var_name)
                env[var_name] = func
                return builder.ptrtoint(func, int_type(64), name=f"{var_name}_ptr")

            # 通常の変数定義
            ptr = builder.alloca(int_type(64), name=var_name)
            env[var_name] = ptr
            val = compile_expr(val_expr, builder, env, module)
            builder.store(val, ptr)
            return val
            
        # 5. リスト生成 (Cons) ["cons", heads, tail]
        # 簡易的に ["cons", head, tail] とする
        # 5. リスト生成 (Cons) ["cons", heads, tail]
        # 簡易的に ["cons", head, tail] とする
        elif op == "cons":
            return compile_cons(expr, builder, env, module)

        # 6. リストアクセス (car/cdr, head/tail)
        elif op in ["car", "head"]:
            return compile_list_access(expr, builder, env, module, index=0)
        elif op in ["cdr", "tail"]:
            return compile_list_access(expr, builder, env, module, index=1)

        # 7. パターンマッチ (match) ["match", target, [pat, body], ...]
        elif op == "match":
            return compile_match_op(expr, builder, env, module)

        else:
             # 関数呼び出し [func, arg1, arg2, ...]
             func_expr = expr[0]
             # ...
             args_vals = []
             for arg_expr in expr[1:]:
                 args_vals.append(compile_expr(arg_expr, builder, env, module))
             
             # 最適化: 関数名が直接指定され、環境にある場合は直接呼び出し
             if isinstance(func_expr, str) and func_expr in env:
                 func_obj = env[func_expr]
                 if hasattr(func_obj, 'func_type'):
                     return builder.call(func_obj, args_vals)
            
             func_val = compile_expr(func_expr, builder, env, module)
             return builder.call(func_val, args_vals)

    return constant(int_type(64), 0)

def compile_function_def(expr, builder, env, module, name=None):
    """関数定義をコンパイル"""
    if module is None:
        error("Module required for function definition")
    
    args_list = expr[1]
    body_expr = expr[2]
    
    # 関数名決定
    if name:
        func_name = name
    else:
        if not hasattr(module, 'lambda_counter'):
                module.lambda_counter = 0
        module.lambda_counter += 1
        func_name = f"lambda_{module.lambda_counter}"
    
    # 関数型: (i64, i64, ...) -> i64
    arg_types = [int_type(64)] * len(args_list)
    func_type = create_function_type(int_type(64), arg_types)
    
    # 関数作成
    func = function(module, func_type, name=func_name)
    
    # 既存の環境に関数を登録（再帰呼び出し用）
    if name:
        env[name] = func

    # エントリーブロック作成
    entry_block = func.append_basic_block(name="entry")
    func_builder = create_builder(entry_block)
    
    # 引数を環境に登録
    func_env = env.copy() # 親環境を継承
    
    for i, arg_name in enumerate(args_list):
        arg_val = func.args[i]
        ptr = func_builder.alloca(int_type(64), name=arg_name)
        func_builder.store(arg_val, ptr)
        func_env[arg_name] = ptr
        
    # Bodyコンパイル
    ret_val = compile_expr(body_expr, func_builder, func_env, module)
    
    if ret_val is None:
        ret_val = constant(int_type(64), 0)
        
    func_builder.ret(ret_val)
    
    return func
