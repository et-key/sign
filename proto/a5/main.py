"""
Sign言語構文解析器のCLIインターフェース

使用例:
    python main.py path/to/file.sn
    python main.py --code "x : 5"
    python main.py --code "x : 5" --format sexp
"""

import sys
import json
from pathlib import Path
from lexer import Lexer
from parser import Parser


def parse_file(filepath: str):
    """Sign言語ファイルを構文解析"""
    with open(filepath, 'r', encoding='utf-8') as f:
        source = f.read()
    
    lexer = Lexer(source)
    tokens = lexer.tokenize()
    
    parser = Parser(tokens)
    ast = parser.parse()
    
    return ast  # ASTオブジェクトを返す


def parse_code(code: str):
    """Sign言語コードを構文解析"""
    lexer = Lexer(code)
    tokens = lexer.tokenize()
    
    parser = Parser(tokens)
    ast = parser.parse()
    
    return ast  # ASTオブジェクトを返す


def main():
    """メイン関数"""
    if len(sys.argv) < 2:
        print("使用法:")
        print("  python main.py <file.sn>")
        print("  python main.py --code '<code>'")
        print("  python main.py --code '<code>' --format sexp")
        print("  python main.py --code '<code>' --format clisp")
        print("")
        print("オプション:")
        print("  --format ast   : JSON形式のAST（デフォルト）")
        print("  --format sexp  : S式（前置記法）")
        print("  --format clisp : Common Lispコード")
        sys.exit(1)
    
    try:
        # 出力形式の判定
        output_format = 'ast'
        code_or_file = None
        output_file = None  # 出力ファイルパス
        is_code = False
        
        i = 1
        while i < len(sys.argv):
            if sys.argv[i] == '--code':
                if i + 1 < len(sys.argv):
                    code_or_file = sys.argv[i + 1]
                    is_code = True
                    i += 2
                else:
                    print("エラー: --code オプションにはコードを指定してください")
                    sys.exit(1)
            elif sys.argv[i] == '--format':
                if i + 1 < len(sys.argv):
                    output_format = sys.argv[i + 1]
                    i += 2
                else:
                    print("エラー: --format オプションには形式を指定してください")
                    sys.exit(1)
            elif sys.argv[i] in ('--output', '-o'):
                if i + 1 < len(sys.argv):
                    output_file = sys.argv[i + 1]
                    i += 2
                else:
                    print("エラー: --output オプションにはファイルパスを指定してください")
                    sys.exit(1)
            else:
                code_or_file = sys.argv[i]
                is_code = False
                i += 1
        
        if code_or_file is None:
            print("エラー: ファイルまたはコードを指定してください")
            sys.exit(1)
        
        # 構文解析
        if is_code:
            ast = parse_code(code_or_file)
        else:
            filepath = code_or_file
            if not Path(filepath).exists():
                print(f"エラー: ファイルが見つかりません: {filepath}")
                sys.exit(1)
            ast = parse_file(filepath)
        
        # 出力内容の生成
        result = ""
        if output_format == 'sexp':
            # S式形式で出力
            result = ast.to_sexp()
        elif output_format == 'clisp':
            # Common Lisp形式で出力
            result = ast.to_clisp()
        else:
            # JSON形式で出力（デフォルト）
            result = json.dumps(ast.to_dict(), indent=2, ensure_ascii=False)
            
        # ファイルまたは標準出力へ書き込み
        if output_file:
            # UTF-8 (BOMなし) で書き込み
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(result)
            print(f"出力しました: {output_file}")
        else:
            print(result)
        
    except SyntaxError as e:
        print(f"構文エラー: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"エラー: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
