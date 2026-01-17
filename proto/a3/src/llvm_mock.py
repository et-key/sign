"""モックLLVM IRジェネレータ（llvmlite不要）"""

class MockType:
    """型のモック"""
    def __init__(self, name):
        self.name = name
    
    def __str__(self):
        return self.name

class IntType(MockType):
    """整数型"""
    def __init__(self, bits):
        super().__init__(f"i{bits}")
        self.bits = bits

class DoubleType(MockType):
    """浮動小数点型"""
    def __init__(self):
        super().__init__("double")

class VoidType(MockType):
    """void型"""
    def __init__(self):
        super().__init__("void")

class PointerType(MockType):
    """ポインタ型"""
    def __init__(self, pointee):
        self.pointee = pointee
        super().__init__(f"{pointee}*")

class ArrayType(MockType):
    """配列型"""
    def __init__(self, element_type, count):
        self.element_type = element_type
        self.count = count
        super().__init__(f"[{count} x {element_type}]")

class StructType(MockType):
    """構造体型"""
    def __init__(self, element_types):
        self.element_types = element_types
        # 簡易的な表記 {i64, i64}
        types_str = ", ".join([str(t) for t in element_types])
        super().__init__(f"{{{types_str}}}")

class Constant:
    """定数値"""
    def __init__(self, type, value):
        self.type = type
        self.value = value
    
    def __str__(self):
        if isinstance(self.type, IntType):
            return str(self.value)
        elif isinstance(self.type, DoubleType):
            return str(float(self.value))
        return str(self.value)

class MockValue:
    """SSA値のモック"""
    def __init__(self, name, type):
        self.name = name
        self.type = type
    
    def __str__(self):
        # SSA値は % プレフィックスが必要
        # ただし、すでに % で始まっている場合は追加しない
        if self.name.startswith('%') or self.name.startswith('@'):
            return self.name
        return f"%{self.name}"

class MockIRBuilder:
    """LLVM IR生成のモック（llvmliteと同じインターフェース）"""
    
    def __init__(self, block=None):
        self.block = block
        self.instructions = [] # for fallback if no block
        self.temp_counter = 0
    
    def _append(self, instr):
        if self.block:
            self.block.instructions.append(instr)
        else:
            self.instructions.append(instr)
    
    def _next_temp(self, prefix=""):
        """一時変数名を生成"""
        name = f"{prefix}{self.temp_counter}"
        self.temp_counter += 1
        return name
    
    def _normalize_name(self, name):
        """SSA名を正規化（%プレフィックスを確保）"""
        if not name:
            return name
        if name.startswith('%') or name.startswith('@'):
            return name
        return f"%{name}"
    
    def add(self, lhs, rhs, name=""):
        """加算"""
        result_name = self._next_temp(name if name else "add_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = add i64 {lhs}, {rhs}")
        return MockValue(result_name, IntType(64))
    
    def sub(self, lhs, rhs, name=""):
        """減算"""
        result_name = self._next_temp(name if name else "sub_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = sub i64 {lhs}, {rhs}")
        return MockValue(result_name, IntType(64))
    
    def mul(self, lhs, rhs, name=""):
        """乗算"""
        result_name = self._next_temp(name if name else "mul_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = mul i64 {lhs}, {rhs}")
        return MockValue(result_name, IntType(64))
    
    def sdiv(self, lhs, rhs, name=""):
        """符号付き除算"""
        result_name = self._next_temp(name if name else "div_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = sdiv i64 {lhs}, {rhs}")
        return MockValue(result_name, IntType(64))
    
    def icmp_signed(self, cmp_op, lhs, rhs, name=""):
        """比較演算"""
        result_name = self._next_temp(name if name else "cmp_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = icmp {cmp_op} i64 {lhs}, {rhs}")
        return MockValue(result_name, IntType(1))
    
    def zext(self, value, type, name=""):
        """ゼロ拡張"""
        result_name = self._next_temp(name if name else "zext_tmp")
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = zext {value.type} {value} to {type}")
        return MockValue(result_name, type)

    def alloca(self, type, name=""):
        """メモリ確保"""
        # allocaの変数名もユニークにする
        suffix = "_ptr" if name else "alloca_tmp"
        base = name if name else ""
        result_name = self._next_temp(base + suffix)
        
        # allocaは変数名を自分で作っているが、%がついているか再確認
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = alloca {type}")
        return MockValue(result_name, PointerType(type))
    
    def store(self, value, ptr):
        """メモリ書き込み"""
        value_str = str(value) if isinstance(value, (MockValue, Constant)) else value
        ptr_str = str(ptr) if isinstance(ptr, MockValue) else ptr
        self._append(f"  store i64 {value_str}, i64* {ptr_str}")
    
    def load(self, ptr, name=""):
        """メモリ読み込み"""
        # loadは変数名をそのまま使うことが多いが、uniqueが必要
        result_name = self._next_temp(name if name else "load_tmp")
        normalized = self._normalize_name(result_name)
        ptr_str = str(ptr) if isinstance(ptr, MockValue) else ptr
        self._append(f"  {normalized} = load i64, i64* {ptr_str}")
        return MockValue(result_name, IntType(64))
    
    def ret(self, value):
        """return文"""
        value_str = str(value) if isinstance(value, (MockValue, Constant)) else value
        self._append(f"  ret i64 {value_str}")
    
    def ret_void(self):
        """void return"""
        self._append(f"  ret void")
    
    def call(self, func, args, name=""):
        """関数呼び出し"""
        result_name = self._next_temp(name if name else "call_tmp")
        
        # 関数名と型解決
        func_name = func if isinstance(func, str) else str(func)
        ret_type = IntType(64) # デフォルト
        
        # funcがFunction/MockFunctionなら型情報を取得
        if hasattr(func, 'func_type'):
             ret_type = func.func_type.return_type
        
        # 引数の処理: 値の型を使う
        arg_strs = []
        for arg in args:
             arg_val = str(arg) if isinstance(arg, (MockValue, Constant)) else arg
             arg_type = arg.type if hasattr(arg, 'type') else "i64"
             # 互換性のため、文字列で明示的に型指定されていなければi64と仮定
             # しかしConstantなどであれば型を持っている
             arg_strs.append(f"{arg_type} {arg_val}")
             
        args_str = ", ".join(arg_strs)
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = call {ret_type} {func_name}({args_str})")
        return MockValue(result_name, ret_type)
    
    def cbranch(self, cond, true_block, false_block):
        """条件分岐"""
        cond_str = str(cond) if isinstance(cond, MockValue) else cond
        self._append(f"  br i1 {cond_str}, label %{true_block}, label %{false_block}")
    
    def branch(self, target):
        """無条件分岐"""
        self._append(f"  br label %{target}")
    
    def phi(self, type, name=""):
        """φノード"""
        result_name = self._next_temp(name if name else "phi")
        normalized = self._normalize_name(result_name)
        # MockPhiに渡す名前はnormalizedされたものにする
        phi_node = MockPhi(normalized, type, self)
        self._append(phi_node)
        return phi_node
    
    def ptrtoint(self, val, type, name=""):
        """ポインタを整数に変換"""
        result_name = self._next_temp(name if name else "ptrtoint")
        
        # GlobalVariableの場合は名前(@name)のみを使う
        if isinstance(val, GlobalVariable):
            val_str = f"@{val.name}"
            val_type = f"{val.type}*" 
        else:
            val_str = str(val) if isinstance(val, (MockValue, Constant)) else val
            val_type = val.type if hasattr(val, 'type') else "i8*" # fallback

        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = ptrtoint {val_type} {val_str} to {type}")
        return MockValue(result_name, type)

    def bitcast(self, val, type, name=""):
        """ビットキャスト"""
        result_name = self._next_temp(name if name else "bitcast")
        val_str = str(val) if isinstance(val, (MockValue, Constant)) else val
        val_type = val.type if hasattr(val, 'type') else "i8*"
        
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = bitcast {val_type} {val_str} to {type}")
        return MockValue(result_name, type)

    def inttoptr(self, val, type, name=""):
        """整数をポインタに変換"""
        result_name = self._next_temp(name if name else "inttoptr")
        val_str = str(val) if isinstance(val, (MockValue, Constant)) else val
        val_type = val.type if hasattr(val, 'type') else "i64"
        
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = inttoptr {val_type} {val_str} to {type}")
        return MockValue(result_name, type)

    def gep(self, ptr, indices, name="", inbounds=False):
        """GetElementPtr (GEP)"""
        result_name = self._next_temp(name if name else "gep")
        ptr_str = str(ptr) if isinstance(ptr, MockValue) else ptr
        ptr_type = ptr.type if hasattr(ptr, 'type') else "i8*" # これはポインタ型であるべき
        
        # ptr_typeがPointerTypeなら、pointeeを取得して source type とする
        source_type = "i8" # fallback
        if hasattr(ptr.type, 'pointee'):
            source_type = ptr.type.pointee
        
        indices_str = ", ".join([f"i32 {str(idx)}" for idx in indices])
        
        inbounds_str = "inbounds " if inbounds else ""
        
        normalized = self._normalize_name(result_name)
        self._append(f"  {normalized} = getelementptr {inbounds_str}{source_type}, {ptr_type} {ptr_str}, {indices_str}")
        
        # 結果の型は... 簡易的にPointerType(i64)にするか、ちゃんと計算するか。
        # mockでは厳密な型計算は省略し、i64*として返しておく（Signの値はi64なので大体合う）
        # ただしStructのフィールドが別の型なら変わるが、Signは全部i64。
        from .llvm_mock import IntType, PointerType
        return MockValue(result_name, PointerType(IntType(64)))

    def position_at_end(self, block):
        """ビルダーの位置を移動"""
        self.block = block
    
    def get_ir(self):
        """生成したIRを文字列として返す"""
        instructions = self.block.instructions if self.block else self.instructions
        lines = []
        for instr in instructions:
            if hasattr(instr, 'render'):
                lines.append(instr.render())
            else:
                lines.append(str(instr))
        return "\n".join(lines)

class MockPhi:
    """φノードのモック"""
    def __init__(self, name, type, builder):
        self.name = name
        self.type = type
        self.builder = builder
        self.incomings = []
    
    def add_incoming(self, value, block):
        """incoming値を追加"""
        value_str = str(value) if isinstance(value, MockValue) else value
        self.incomings.append((value_str, block))
    
    def finalize(self):
        """φノードを確定（使われないかもだが互換性のため）"""
        pass
        
    def render(self):
        """IR命令文字列を生成"""
        incoming_strs = [f"[ {val}, %{blk} ]" for val, blk in self.incomings]
        return f"  {self.name} = phi i64 " + ", ".join(incoming_strs)

    def __str__(self):
        # オペランドとして使われる場合は名前を返す
        return self.name

class MockBlock:
    """基本ブロックのモック"""
    def __init__(self, name, parent=None):
        self.name = name
        self.parent = parent
        self.instructions = []
    
    def __str__(self):
        return self.name

class MockFunction:
    """関数のモック"""
    def __init__(self, module, func_type, name):
        self.module = module
        self.func_type = func_type
        self.name = name
        self.type = PointerType(func_type) # For ptrtoint
        self.blocks = []
        self.args = [MockValue(f"%{chr(97+i)}", IntType(64)) for i in range(len(func_type.args))]
        self.block_counter = 0
        module.add_function(self)
    
    def __str__(self):
        return f"@{self.name}"

    def append_basic_block(self, name=""):
        """基本ブロックを追加"""
        block_name = name if name else f"bb{self.block_counter}"
        self.block_counter += 1
        block = MockBlock(block_name, self)
        self.blocks.append(block)
        return block

class MockFunctionType:
    """関数型のモック"""
    def __init__(self, return_type, args):
        self.return_type = return_type
        self.args = args
    
    def __str__(self):
        # 簡易的な関数型表記
        args_str = ", ".join([str(arg) for arg in self.args])
        return f"{self.return_type} ({args_str})"

class MockModule:
    """モジュールのモック"""
    def __init__(self, name):
        self.name = name
        self.functions = []
        self.globals = []

    def add_function(self, func):
        """関数を追加"""
        self.functions.append(func)
    
    def get_function(self, name):
        """関数を取得"""
        for func in self.functions:
            if func.name == name:
                return func
        return None

    def add_global(self, glob):
        self.globals.append(glob)
    
    def __str__(self):
        """完全なLLVM IRを生成"""
        result = [f"; ModuleID = '{self.name}'"]
        
        for glob in self.globals:
             result.append(str(glob))

        for func in self.functions:
            # 戻り値の型
            ret_type = func.func_type.return_type
            
            # 引数リスト
            args_str = ", ".join([f"i64 %{chr(97+i)}" for i in range(len(func.func_type.args))])
            
            # ブロックがない場合は declare
            if not func.blocks:
                # 引数の型リスト（名前なし）
                # declare i32 @printf(i8*, ...)
                # 簡易的に引数の型だけ並べる
                # しかし現在のMockFunctionはargsをi64固定にしている部分がある
                # func.func_type.args を使う
                arg_types_str = ", ".join([str(arg) for arg in func.func_type.args])
                # 可変長引数は未定だが、とりあえず固定
                result.append(f"declare {ret_type} @{func.name}({arg_types_str})")
            else:
                # 関数定義
                result.append(f"\ndefine {ret_type} @{func.name}({args_str}) {{")
                
                # 各ブロック
                for block in func.blocks:
                    result.append(f"{block.name}:")
                    for instr in block.instructions:
                        if hasattr(instr, 'render'):
                            result.append(instr.render())
                        else:
                            result.append(str(instr))
                
                result.append("}")
        
        return "\n".join(result)

class GlobalVariable:
    def __init__(self, module, type, name):
        self.module = module
        self.type = type
        self.name = name
        self.initializer = None
        module.add_global(self)
    
    def __str__(self):
        init_str = "0"
        if self.initializer:
            # Constant(ArrayType, bytearray) の場合
            if isinstance(self.initializer, Constant) and isinstance(self.initializer.value, (bytes, bytearray)):
               try:
                   s = self.initializer.value.decode('utf-8')
                   # 制御文字のエスケープなどは簡易的
                   escaped = s.replace('\00', '\\00').replace('\n', '\\OA')
                   init_str = f'c"{escaped}"'
               except:
                   init_str = str(self.initializer.value)
            else:
               init_str = str(self.initializer)
               
        return f"@{self.name} = global {self.type} {init_str}"

class Module:
    """モジュールのファクトリー（llvmliteと互換）"""
    def __init__(self, name):
        self.impl = MockModule(name)
        self.name = name
        self.functions = self.impl.functions # 互換性のため
    
    def __str__(self):
        return str(self.impl)

    def add_global(self, glob):
        self.impl.add_global(glob)

class FunctionType:
    """関数型のファクトリー"""
    def __init__(self, return_type, args):
        self.impl = MockFunctionType(return_type, args)
        self.args = args # 互換性のため
    
    @property
    def return_type(self):
        return self.impl.return_type
    
    def __str__(self):
        return str(self.impl)

class Function:
    """関数のファクトリー"""
    def __init__(self, module, func_type, name):
        self.impl = MockFunction(module.impl, func_type, name)
        self.args = self.impl.args
    
    @property
    def type(self):
        return self.impl.type

    @property
    def func_type(self):
        return self.impl.func_type
    
    def __str__(self):
        return str(self.impl)
        
    def append_basic_block(self, name=""):
        return self.impl.append_basic_block(name)

# llvmlite互換のエクスポート
__all__ = [
    'Module', 'FunctionType', 'Function', 'GlobalVariable',
    'IntType', 'DoubleType', 'VoidType', 'PointerType', 'ArrayType', 'StructType',
    'Constant', 'MockIRBuilder'
]
