"""
Sign言語構文解析器のCLIインターフェース

使用例:
    python main.py path/to/file.sn
    python main.py --code "x : 5"
"""

import sys
import json
from pathlib import Path
from lexer import Lexer
from parser import Parser


def parse_file(filepath: str) -> dict:
    """Sign言語ファイルを構文解析"""
    with open(filepath, 'r', encoding='utf-8') as f:
        source = f.read()
    
    lexer = Lexer(source)
    tokens = lexer.tokenize()
    
    parser = Parser(tokens)
    ast = parser.parse()
    
    return ast.to_dict()


def parse_code(code: str) -> dict:
    """Sign言語コードを構文解析"""
    lexer = Lexer(code)
    tokens = lexer.tokenize()
    
    parser = Parser(tokens)
    ast = parser.parse()
    
    return ast.to_dict()


def main():
    """メイン関数"""
    if len(sys.argv) < 2:
        print("使用法:")
        print("  python main.py <file.sn>")
        print("  python main.py --code '<code>'")
        sys.exit(1)
    
    try:
        if sys.argv[1] == '--code':
            if len(sys.argv) < 3:
                print("エラー: --code オプションにはコードを指定してください")
                sys.exit(1)
            code = sys.argv[2]
            ast = parse_code(code)
        else:
            filepath = sys.argv[1]
            if not Path(filepath).exists():
                print(f"エラー: ファイルが見つかりません: {filepath}")
                sys.exit(1)
            ast = parse_file(filepath)
        
        # ASTをJSON形式で出力
        print(json.dumps(ast, indent=2, ensure_ascii=False))
        
    except SyntaxError as e:
        print(f"構文エラー: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"エラー: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
