"""モックLLVM IRのテスト"""

import unittest
from src.llvm_mock import MockIRBuilder, Module, IntType, Constant

class TestMockIRBuilder(unittest.TestCase):
    
    def setUp(self):
        # ブロックをモックするための簡易クラス
        class Block:
            def __init__(self):
                self.instructions = []
        
        self.block = Block()
        self.builder = MockIRBuilder(self.block)
    
    def test_add_instruction(self):
        """加算命令の生成"""
        result = self.builder.add(
            Constant(IntType(64), 1),
            Constant(IntType(64), 2)
        )
        
        # position_at_end などを介さずに直接命令をチェック
        # 実装に合わせて調整: instructions は builder 内に溜まるか block に追加されるか
        # 修正された llvm_mock.py では builder.instructions に追加される
        
        ir = "\n".join(self.builder.instructions)
        self.assertIn("add i64 1, 2", ir)
        self.assertIn("%", str(result))  # 一時変数が生成される
    
    def test_alloca_and_store(self):
        """メモリ確保と書き込み"""
        ptr = self.builder.alloca(IntType(64), name="x")
        self.builder.store(Constant(IntType(64), 42), ptr)
        
        ir = "\n".join(self.builder.instructions)
        self.assertIn("alloca i64", ir)
        self.assertIn("store i64 42", ir)
        self.assertIn("%x_ptr", ir)
    
    def test_load(self):
        """メモリ読み込み"""
        ptr = self.builder.alloca(IntType(64), name="x")
        self.builder.load(ptr)
        
        ir = "\n".join(self.builder.instructions)
        self.assertIn("load i64", ir)
    
    def test_function_with_return(self):
        """関数とreturn"""
        self.builder.ret(Constant(IntType(64), 42))
        
        ir = "\n".join(self.builder.instructions)
        self.assertIn("ret i64 42", ir)

class TestMockModule(unittest.TestCase):
    
    def test_module_creation(self):
        """モジュールの作成"""
        module = Module("test_module")
        self.assertEqual(module.name, "test_module")
    
    def test_module_string_output(self):
        """モジュールの文字列出力"""
        module = Module("test")
        # NOTE: 関数を追加しないと出力が寂しいが、ヘッダーは出るはず
        output = str(module)
        self.assertIn("ModuleID", output)

if __name__ == "__main__":
    unittest.main()
