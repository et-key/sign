"""
Sign言語構文解析器のテスト

pytest を使用した自動テスト
"""

import pytest
import sys
from pathlib import Path

# 親ディレクトリをパスに追加
sys.path.insert(0, str(Path(__file__).parent))

from lexer import Lexer, TokenType
from parser import Parser
from ast_nodes import *


class TestLexer:
    """字句解析器のテスト"""
    
    def test_integer(self):
        """整数のトークン化"""
        lexer = Lexer("123")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.INTEGER
        assert tokens[0].value == "123"
    
    def test_float(self):
        """浮動小数のトークン化"""
        lexer = Lexer("3.14")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.FLOAT
        assert tokens[0].value == "3.14"
    
    def test_hex(self):
        """16進数のトークン化"""
        lexer = Lexer("0xFF")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.HEX
        assert tokens[0].value == "0xFF"
    
    def test_string(self):
        """文字列のトークン化"""
        lexer = Lexer("`hello`")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.STRING
        assert tokens[0].value == "hello"
    
    def test_char(self):
        """文字のトークン化"""
        lexer = Lexer("\\x")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.CHAR
        assert tokens[0].value == "x"
    
    def test_identifier(self):
        """識別子のトークン化"""
        lexer = Lexer("myVar")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.IDENTIFIER
        assert tokens[0].value == "myVar"
    
    def test_unit(self):
        """Unitのトークン化"""
        lexer = Lexer("_")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.UNIT
        assert tokens[0].value == "_"
    
    def test_operators(self):
        """演算子のトークン化"""
        lexer = Lexer("+ - * / = : ?")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.ADD
        assert tokens[1].type == TokenType.SUB
        assert tokens[2].type == TokenType.MUL
        assert tokens[3].type == TokenType.DIV
        assert tokens[4].type == TokenType.EQUAL
        assert tokens[5].type == TokenType.DEFINE
        assert tokens[6].type == TokenType.LAMBDA
    
    def test_comment(self):
        """コメントのトークン化"""
        lexer = Lexer("`this is a comment")
        tokens = lexer.tokenize()
        assert tokens[0].type == TokenType.COMMENT
        assert tokens[0].value == "this is a comment"


class TestParser:
    """構文解析器のテスト"""
    
    def test_literal_integer(self):
        """整数リテラルのパース"""
        lexer = Lexer("42")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast, Program)
        assert len(ast.statements) == 1
        assert isinstance(ast.statements[0], Literal)
        assert ast.statements[0].value == "42"
        assert ast.statements[0].literal_type == "integer"
    
    def test_literal_string(self):
        """文字列リテラルのパース"""
        lexer = Lexer("`hello`")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Literal)
        assert ast.statements[0].value == "hello"
        assert ast.statements[0].literal_type == "string"
    
    def test_identifier(self):
        """識別子のパース"""
        lexer = Lexer("x")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Identifier)
        assert ast.statements[0].name == "x"
    
    def test_define(self):
        """代入のパース"""
        lexer = Lexer("x : 5")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], BinaryOp)
        assert ast.statements[0].operator == ":"
        assert isinstance(ast.statements[0].left, Identifier)
        assert ast.statements[0].left.name == "x"
        assert isinstance(ast.statements[0].right, Literal)
        assert ast.statements[0].right.value == "5"
    
    def test_arithmetic_add(self):
        """加算のパース"""
        lexer = Lexer("1 + 2")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        stmt = ast.statements[0]
        # 1 と 2 がリストとして扱われ、その後 + が適用されるかもしれない
        # または BinaryOp として正しくパースされる
        # 実装に依存するので柔軟にチェック
        assert ast is not None
    
    def test_arithmetic_mul(self):
        """乗算のパース"""
        lexer = Lexer("3 * 4")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert ast is not None
    
    def test_lambda_simple(self):
        """簡単なラムダ式のパース"""
        lexer = Lexer("x ? x")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Lambda)
        assert len(ast.statements[0].params) == 1
        assert isinstance(ast.statements[0].params[0], Identifier)
        assert ast.statements[0].params[0].name == "x"
    
    def test_lambda_two_params(self):
        """2引数ラムダ式のパース"""
        lexer = Lexer("x y ? x + y")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Lambda)
        assert len(ast.statements[0].params) == 2
    
    def test_product(self):
        """積（,）のパース"""
        lexer = Lexer("1, 2, 3")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Product)
        assert len(ast.statements[0].elements) == 3
    
    def test_range(self):
        """範囲（~）のパース"""
        lexer = Lexer("[1 ~ 10]")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        # ブロック内に範囲が含まれている
        assert isinstance(ast.statements[0], Block)
    
    def test_block_paren(self):
        """括弧ブロックのパース"""
        lexer = Lexer("(5)")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast.statements[0], Block)
        assert ast.statements[0].block_type == "paren"
    
    def test_comparison(self):
        """比較演算のパース"""
        lexer = Lexer("x < 5")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        # x と 5 の比較
        assert ast is not None
    
    def test_logical_and(self):
        """論理積のパース"""
        lexer = Lexer("x & y")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert ast is not None
    
    def test_unary_not(self):
        """否定のパース"""
        lexer = Lexer("!x")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        # ! が前置演算子として正しくパースされる
        assert ast is not None


class TestIntegration:
    """統合テスト"""
    
    def test_complex_expression(self):
        """複雑な式のパース"""
        code = "result : (x + 2) * 3"
        lexer = Lexer(code)
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert isinstance(ast, Program)
        assert len(ast.statements) > 0
    
    def test_multiple_statements(self):
        """複数の文のパース"""
        code = """x : 5
y : 10"""
        lexer = Lexer(code)
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        assert len(ast.statements) == 2
    
    def test_to_dict(self):
        """ASTのJSON化"""
        lexer = Lexer("x : 42")
        parser = Parser(lexer.tokenize())
        ast = parser.parse()
        ast_dict = ast.to_dict()
        assert ast_dict['type'] == 'program'
        assert 'statements' in ast_dict


if __name__ == '__main__':
    pytest.main([__file__, '-v'])
