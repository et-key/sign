"""コンパイラのテスト"""

import unittest
import json
from src.compiler import compile_module_from_sexpr
from src.llvm_mock import MockModule

class TestCompiler(unittest.TestCase):
    
    def test_compile_literal(self):
        """リテラルのコンパイルテスト"""
        # 入力: 42
        s_expr = [42]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        self.assertIn("ret i64 42", ir)
        
    def test_compile_add(self):
        """加算のコンパイルテスト"""
        # 入力: (+ 1 2)
        s_expr = [["+", 1, 2]]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        self.assertIn("add i64 1, 2", ir)
        self.assertIn("ret i64", ir)

    def test_compile_nested_expr(self):
        """ネストした式のコンパイルテスト"""
        # 入力: (* (+ 1 2) 3)
        s_expr = [["*", ["+", 1, 2], 3]]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        self.assertIn("add i64 1, 2", ir)
        # addの結果を使うmulがあるはず。変数名は動的だが構造を確認
        # add i64 1, 2 -> %add_tmp0
        # mul i64 %add_tmp0, 3 -> %mul_tmp1
        self.assertIn("mul i64", ir) 
        self.assertIn(", 3", ir)

    def test_compile_comparison(self):
        """比較演算のコンパイルテスト"""
        # 入力: (< 1 2)
        s_expr = [["<", 1, 2]]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        self.assertIn("icmp slt i64 1, 2", ir)
        self.assertIn("zext i1", ir)
        self.assertIn("to i64", ir)

    def test_compile_function_def(self):
        """関数定義のコンパイルテスト"""
        # 入力: (?, (x), (+ x 1))
        # JSON: ["?", ["x"], ["+", "x", 1]]
        s_expr = [["?", ["x"], ["+", "x", 1]]]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # 関数が定義されているか
        self.assertIn("define i64 @lambda_1(i64 %a)", ir)
        # 本体があるか
        import re
        self.assertRegex(ir, r"add i64 %x\d*, 1") # loadありされる
        # mainから関数ポインタが返されるか
        self.assertIn("ptrtoint", ir)
        self.assertIn("@lambda_1 to i64", ir)

    def test_compile_function_call(self):
        """関数呼び出しのコンパイルテスト"""
        # 入力: (call_test) -> (lambda_1 42)
        # 定義と呼び出しを含む:
        # [
        #   [":", "inc", ["?", ["x"], ["+", "x", 1]]],
        #   ["inc", 41]
        # ]
        s_expr = [
            [":", "inc", ["?", ["x"], ["+", "x", 1]]],
            ["inc", 41]
        ]
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # inc変数のallocaはされなくなった（関数として登録されるため）
        # self.assertIn("%inc_ptr = alloca i64", ir)
        
        # 定義の確認
        self.assertIn("@inc", ir)
        
        # 呼び出し
        self.assertIn("call i64", ir)
        self.assertIn("(i64 41)", ir)

    def test_compile_match(self):
        """条件分岐(match)のコンパイルテスト"""
        # 入力: (abs_test)
        # [
        #   [":", ["<", "x", 0], ["-", "x"]],
        #   "x"
        # ]
        # を関数内でテストする
        s_expr = [
            [":", "abs", ["?", ["x"],
                [
                    [":", ["<", "x", 0], ["-", "x", 1]], # 0から引くのではなく単項マイナスは未実装かも？ "- x 1" は "- x" と "1"? いや ["-", "x"] は単項
                    "x"
                ]
            ]]
        ]
        # 注: codegen.pyの単項マイナスは (len(expr)==2)
        # ["-", "x"] => len=2. OK.
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # 分岐命令
        self.assertIn("icmp slt", ir)
        self.assertIn("br i1", ir)
        # phiノード
        self.assertIn("phi i64", ir)
        self.assertIn("case_0_then:", ir)
        self.assertIn("merge:", ir)

    def test_compile_fibonacci(self):
        """フィボナッチ数列（再帰）のコンパイルテスト"""
        # (fib n) = 
        #   (match 
        #     ((<= n 1) n) 
        #     (+ (fib (- n 1)) (fib (- n 2))))
        s_expr = [
            [":", "fib", ["?", ["n"],
                [
                    [":", ["<=", "n", 1], "n"],
                    ["+", 
                        ["fib", ["-", "n", 1]], 
                        ["fib", ["-", "n", 2]]
                    ]
                ]
            ]],
            ["fib", 10]
        ]
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # 関数定義
        self.assertIn("@fib", ir)
        # 再帰呼び出し
        self.assertIn("call i64 @fib", ir)
        # 条件分岐
        self.assertIn("icmp sle", ir)
        self.assertIn("br i1", ir)
        # 加算
        self.assertIn("add i64", ir)

    def test_compile_string_literal(self):
        """文字列リテラルのコンパイルテスト"""
        # 入力: `Hello`
        s_expr = ["`Hello`"]
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # グローバル変数が定義されているか
        self.assertIn('@.str.1 = global [6 x i8] c"Hello\\00"', ir)
        # main関数内で参照されているか
        self.assertIn('ptrtoint [6 x i8]* @.str.1 to i64', ir)

    def test_compile_printf(self):
        """外部関数呼び出し(printf)のテスト"""
        
        from src.ir_builder import create_module, create_function_type, function, int_type, pointer_type, void_type, constant
        from src.codegen import compile_expr
        from src.ir_builder import create_builder
        
        module = create_module("printf_test")
        
        # printfの宣言: declare i32 @printf(i8*, ...)
        i8_ptr_type = pointer_type(int_type(8))
        printf_type = create_function_type(int_type(32), [i8_ptr_type])
        printf_func = function(module, printf_type, "printf")
        
        # main関数
        main_type = create_function_type(int_type(64), [])
        main_func = function(module, main_type, "main")
        block = main_func.append_basic_block("entry")
        builder = create_builder(block)
        
        env = {"printf": printf_func}
        
        # (printf "Hello")
        s_expr = ["printf", "`Hello`"]
        
        compile_expr(s_expr, builder, env, module)
        builder.ret(constant(int_type(64), 0)) # return 0
        
        ir = str(module)
        
        # declareの確認
        self.assertIn("declare i32 @printf(i8*)", ir)
        # callの確認
        self.assertIn("call i32 @printf", ir) 
        
    def test_compile_cons(self):
        """リスト生成(cons)のテスト"""
        # 入力: [["cons", 1, 2]]
        s_expr = [["cons", 1, 2]]
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # mallocの呼び出し
        self.assertIn("declare i8* @malloc(i64)", ir)
        self.assertIn("call i8* @malloc", ir)
        
        # bitcast
        # {i64, i64}* へのキャスト
        self.assertIn("bitcast i8*", ir)
        self.assertIn("to {i64, i64}*", ir)
        
        # store (gep経由)
        self.assertIn("getelementptr {i64, i64}, {i64, i64}*", ir)
        self.assertIn("store i64 1, i64*", ir)
        self.assertIn("store i64 2, i64*", ir)
        
        # ptrtointで返却
        self.assertIn("ptrtoint {i64, i64}*", ir) 

    def test_compile_list_access(self):
        """リストアクセス(head/tail)のテスト"""
        # 入力: [head [cons 1 2]]
        s_expr = [["head", ["cons", 1, 2]]]
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # inttoptr
        self.assertIn("inttoptr i64", ir)
        self.assertIn("to {i64, i64}*", ir)
        
        # gep (index 0 for head)
        self.assertIn("getelementptr {i64, i64}, {i64, i64}*", ir)
        self.assertIn("i32 0, i32 0", ir)
        
        # load
        self.assertIn("load i64, i64*", ir) 

    def test_compile_match_list(self):
        """Patterns match for lists"""
        # (match [1, 2]
        #   ((cons h t) h)
        #   (_ 0))
        # -> 1
        s_expr = ["match", ["cons", 1, 2], 
                  [["cons", "h", "t"], "h"],
                  ["_", 0]]
        
        module = compile_module_from_sexpr([s_expr]) # wrap in list!
        ir = str(module)
        
        # Check logic
        # Cons check: icmp ne ... 0
        self.assertIn("icmp ne i64", ir)
        
        # Head extraction
        self.assertRegex(ir, r"%head_val\d* = load i64")
        
        # Bind (store)
        self.assertRegex(ir, r"store i64 %head_val\d*")
        
        # Result phi
        self.assertIn("phi i64", ir) 

    def test_compile_recursive_sum(self):
        """Integration test: Recursive sum of list"""
        # (func sum (ls)
        #   (match ls
        #     (0 0)
        #     ((cons h t) (+ h (sum t)))
        #     (_ 0)))
        # (sum [1, 2, 3]) -> 6
        
        sum_func = [":", "sum", ["?", ["ls"], 
            ["match", "ls", 
                [0, 0],
                [["cons", "h", "t"], ["+", "h", ["sum", "t"]]],
                ["_", 0]
            ]
        ]]
        
        call_expr = ["sum", ["cons", 1, ["cons", 2, ["cons", 3, 0]]]]
        
        s_expr = [sum_func, call_expr]
        
        module = compile_module_from_sexpr(s_expr)
        ir = str(module)
        
        # Verify function Definition
        self.assertIn("define i64 @sum(i64 %a)", ir)
        
        # Verify recursion call
        self.assertIn("call i64 @sum", ir)
        
        # Verify main calls sum
        self.assertIn("call i64 @sum", ir)
        
        # Verify structure
        # match structure should be present inside @sum
        self.assertRegex(ir, r"icmp eq i64 %ls\d*, 0") # nil check using arg name
        self.assertRegex(ir, r"icmp ne i64 %ls\d*, 0") # cons check 



if __name__ == "__main__":
    unittest.main()
