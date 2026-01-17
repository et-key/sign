"""Sign Compiler Main Driver"""

import sys
import json
import argparse
import os

# srcディレクトリをパスに追加
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from ir_builder import create_module, create_function_type, function, create_builder, int_type, get_backend, constant
from codegen import compile_expr

def compile_module_from_sexpr(s_exprs, module_name="sign_module"):
    """S式のリストからモジュールを生成"""
    module = create_module(module_name)
    
    # main関数を作成
    # int main()
    func_type = create_function_type(int_type(64), [])
    main_func = function(module, func_type, name="main")
    
    # エントリーブロック
    block = main_func.append_basic_block(name="entry")
    builder = create_builder(block)
    
    last_result = None
    
    # トップレベルの式を順次コンパイル
    # ここでは簡易的に、最後の式の結果を返すとする
    # 本来は関数定義などはここで行う
    
    # s_exprsがリストのリスト（複数の式）か、単一の式かを判定
    # SignのJSON出力はトップレベルが配列であることが多い
    
    # 簡易化: 入力が [expr1, expr2, ...] と仮定
    if not isinstance(s_exprs, list):
        s_exprs = [s_exprs] # 単一の値をリスト化
        
    env = {} # グローバル環境（仮）
    
    # モジュールのラムダカウンタ初期化
    module.lambda_counter = 0
    
    for expr in s_exprs:
        last_result = compile_expr(expr, builder, env, module)
        
    # 最後の結果をreturn
    if last_result:
        builder.ret(last_result)
    else:
        # 何もなければ 0 を返す
        builder.ret(constant(int_type(64), 0))
        
    return module

def main():
    parser = argparse.ArgumentParser(description="Sign Language Compiler (proto/a3)")
    parser.add_argument("input", help="Input JSON file path (or '-' for stdin)")
    parser.add_argument("-o", "--output", help="Output LLVM IR file path", default="output.ll")
    parser.add_argument("--backend", help="Backend to use (mock/llvmlite)", choices=["mock", "llvmlite"])
    
    args = parser.parse_args()
    
    # バックエンド情報の表示
    print(f"Using backend: {get_backend()}")

    # 入力読み込み
    if args.input == "-":
        data = json.load(sys.stdin)
    else:
        with open(args.input, "r", encoding="utf-8") as f:
            data = json.load(f)
            
    # コンパイル
    try:
        module = compile_module_from_sexpr(data)
        ir_str = str(module)
        
        # 出力
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(ir_str)
            
        print(f"Compiled successfully to {args.output}")
        
    except Exception as e:
        print(f"Compilation failed: {e}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
