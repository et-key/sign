"""統一インターフェース: llvmliteとモックを切り替え可能"""

import os

# 環境変数でバックエンドを選択
USE_LLVMLITE = os.environ.get('USE_LLVMLITE', 'false').lower() == 'true'

if USE_LLVMLITE:
    try:
        import llvmlite.ir as ir
        BACKEND = 'llvmlite'
    except ImportError:
        print("Warning: llvmlite not available, falling back to mock")
        from .llvm_mock import *
        from .llvm_mock import MockIRBuilder # specific import
        BACKEND = 'mock'
else:
    from .llvm_mock import *
    from .llvm_mock import MockIRBuilder # specific import
    BACKEND = 'mock'

def get_backend():
    """現在のバックエンドを取得"""
    return BACKEND

def create_module(name):
    """モジュールを作成"""
    if BACKEND == 'llvmlite':
        return ir.Module(name=name)
    else:
        return Module(name)

def create_function_type(return_type, args):
    """関数型を作成"""
    if BACKEND == 'llvmlite':
        return ir.FunctionType(return_type, args)
    else:
        return FunctionType(return_type, args)

def create_builder(block):
    """IRBuilderを作成"""
    if BACKEND == 'llvmlite':
        return ir.IRBuilder(block)
    else:
        return MockIRBuilder(block)

# 型のエクスポート
if BACKEND == 'llvmlite':
    int_type = ir.IntType
    double_type = ir.DoubleType
    void_type = ir.VoidType
    pointer_type = ir.PointerType
    array_type = ir.ArrayType
    struct_type = ir.LiteralStructType
    constant = ir.Constant
    global_variable = ir.GlobalVariable
    function = ir.Function
else:
    int_type = IntType
    double_type = DoubleType
    void_type = VoidType
    pointer_type = PointerType
    array_type = ArrayType
    struct_type = StructType
    constant = Constant
    global_variable = GlobalVariable
    function = Function
