"""
Sign言語の字句解析器（Lexer）

Parse_Strategy_ja-jp.mdの「三段階判定の原則」に基づいて実装：
1. 文字列リテラル（`で囲まれた部分）の識別
2. 文字リテラル（\の直後の1文字）の識別
3. リテラル（数値・識別子）vs 演算子の判定
"""

from dataclasses import dataclass
from enum import Enum
from typing import List, Optional
import re


class TokenType(Enum):
    """トークンの種類"""
    # リテラル
    INTEGER = "integer"
    FLOAT = "float"
    HEX = "hex"
    OCT = "oct"
    BIN = "bin"
    STRING = "string"
    CHAR = "char"
    IDENTIFIER = "identifier"
    UNIT = "unit"  # _
    
    # 演算子
    EXPORT = "export"  # #
    DEFINE = "define"  # :
    OUTPUT = "output"  # #
    LAMBDA = "lambda"  # ?
    PRODUCT = "product"  # ,
    RANGE = "range"  # ~
    XOR = "xor"  # ;
    OR = "or"  # |
    AND = "and"  # &
    NOT = "not"  # !
    FACTORIAL = "factorial"  # !
    LESS = "less"  # <
    LESS_EQUAL = "less_equal"  # <=
    EQUAL = "equal"  # =
    MORE_EQUAL = "more_equal"  # >=
    MORE = "more"  # >
    NOT_EQUAL = "not_equal"  # !=
    ADD = "add"  # +
    SUB = "sub"  # -
    MUL = "mul"  # *
    DIV = "div"  # /
    MOD = "mod"  # %
    POW = "pow"  # ^
    EXPAND = "expand"  # ~
    ADDRESS = "address"  # $
    GET_LEFT = "get_left"  # '
    GET_RIGHT = "get_right"  # @
    IMPORT = "import"  # @
    INPUT = "input"  # @
    CONTINUOUS = "continuous"  # ~
    
    # 括弧
    LPAREN = "lparen"  # (
    RPAREN = "rparen"  # )
    LBRACKET = "lbracket"  # [
    RBRACKET = "rbracket"  # ]
    LBRACE = "lbrace"  # {
    RBRACE = "rbrace"  # }
    
    # 制御
    NEWLINE = "newline"
    INDENT = "indent"  # タブ
    EOF = "eof"
    COMMENT = "comment"


@dataclass
class Token:
    """トークン"""
    type: TokenType
    value: any
    line: int
    column: int
    
    def __repr__(self):
        return f"Token({self.type.value}, {repr(self.value)}, L{self.line}:C{self.column})"


class Lexer:
    """Sign言語の字句解析器"""
    
    def __init__(self, source: str):
        self.source = source
        self.pos = 0
        self.line = 1
        self.column = 1
        self.tokens: List[Token] = []
    
    def current_char(self) -> Optional[str]:
        """現在位置の文字を取得"""
        if self.pos >= len(self.source):
            return None
        return self.source[self.pos]
    
    def peek_char(self, offset: int = 1) -> Optional[str]:
        """先読み"""
        pos = self.pos + offset
        if pos >= len(self.source):
            return None
        return self.source[pos]
    
    def advance(self) -> Optional[str]:
        """1文字進める"""
        if self.pos >= len(self.source):
            return None
        
        char = self.source[self.pos]
        self.pos += 1
        
        if char == '\n':
            self.line += 1
            self.column = 1
        else:
            self.column += 1
        
        return char
    
    def skip_whitespace(self, skip_newline: bool = False):
        """空白をスキップ（改行は除く）"""
        while self.current_char() is not None:
            if self.current_char() == ' ':
                self.advance()
            elif skip_newline and self.current_char() in '\n\r':
                self.advance()
            else:
                break
    
    def tokenize_string(self) -> Token:
        """文字列リテラルをトークン化（第一段階）"""
        start_line = self.line
        start_column = self.column
        
        self.advance()  # ` をスキップ
        
        chars = []
        while self.current_char() is not None:
            if self.current_char() == '`':
                self.advance()
                break
            elif self.current_char() in '\n\r':
                # 文字列内に改行は含められない
                break
            else:
                chars.append(self.current_char())
                self.advance()
        
        return Token(TokenType.STRING, ''.join(chars), start_line, start_column)
    
    def tokenize_char(self) -> Token:
        """文字リテラルをトークン化（第二段階）"""
        start_line = self.line
        start_column = self.column
        
        self.advance()  # \ をスキップ
        
        char = self.current_char()
        if char is None:
            return Token(TokenType.CHAR, '', start_line, start_column)
        
        self.advance()
        return Token(TokenType.CHAR, char, start_line, start_column)
    
    def tokenize_number(self) -> Token:
        """数値リテラルをトークン化"""
        start_line = self.line
        start_column = self.column
        
        # 16進数
        if self.current_char() == '0' and self.peek_char() in 'xX':
            self.advance()  # 0
            self.advance()  # x
            digits = []
            while self.current_char() is not None and self.current_char() in '0123456789ABCDEFabcdef':
                digits.append(self.current_char())
                self.advance()
            return Token(TokenType.HEX, '0x' + ''.join(digits), start_line, start_column)
        
        # 8進数
        if self.current_char() == '0' and self.peek_char() in 'oO':
            self.advance()  # 0
            self.advance()  # o
            digits = []
            while self.current_char() is not None and self.current_char() in '01234567':
                digits.append(self.current_char())
                self.advance()
            return Token(TokenType.OCT, '0o' + ''.join(digits), start_line, start_column)
        
        # 2進数
        if self.current_char() == '0' and self.peek_char() in 'bB':
            self.advance()  # 0
            self.advance()  # b
            digits = []
            while self.current_char() is not None and self.current_char() in '01':
                digits.append(self.current_char())
                self.advance()
            return Token(TokenType.BIN, '0b' + ''.join(digits), start_line, start_column)
        
        # 整数または浮動小数
        is_negative = False
        if self.current_char() == '-':
            is_negative = True
            self.advance()
        
        digits = []
        while self.current_char() is not None and self.current_char().isdigit():
            digits.append(self.current_char())
            self.advance()
        
        # 浮動小数点
        if self.current_char() == '.':
            digits.append(self.current_char())
            self.advance()
            
            while self.current_char() is not None and self.current_char().isdigit():
                digits.append(self.current_char())
                self.advance()
            
            value = ('-' if is_negative else '') + ''.join(digits)
            return Token(TokenType.FLOAT, value, start_line, start_column)
        
        # 整数
        value = ('-' if is_negative else '') + ''.join(digits)
        return Token(TokenType.INTEGER, value, start_line, start_column)
    
    def tokenize_identifier(self) -> Token:
        """識別子をトークン化"""
        start_line = self.line
        start_column = self.column
        
        chars = []
        while self.current_char() is not None:
            if self.current_char().isalnum() or self.current_char() == '_':
                chars.append(self.current_char())
                self.advance()
            else:
                break
        
        name = ''.join(chars)
        
        # _ だけは Unit
        if name == '_':
            return Token(TokenType.UNIT, '_', start_line, start_column)
        
        return Token(TokenType.IDENTIFIER, name, start_line, start_column)
    
    def tokenize(self) -> List[Token]:
        """ソースコードをトークン列に変換"""
        self.tokens = []
        
        while self.pos < len(self.source):
            char = self.current_char()
            
            # 第一段階: 文字列リテラル
            if char == '`':
                # コメント判定: 行頭の ` はコメント
                if self.column == 1 or (len(self.tokens) > 0 and self.tokens[-1].type == TokenType.NEWLINE):
                    # コメントとして処理
                    self.advance()
                    comment_chars = []
                    while self.current_char() is not None and self.current_char() not in '\n\r':
                        if self.current_char() == '`':
                            self.advance()
                            break
                        comment_chars.append(self.current_char())
                        self.advance()
                    self.tokens.append(Token(TokenType.COMMENT, ''.join(comment_chars), self.line, self.column))
                else:
                    # 文字列リテラル
                    self.tokens.append(self.tokenize_string())
                continue
            
            # 第二段階: 文字リテラル
            if char == '\\':
                self.tokens.append(self.tokenize_char())
                continue
            
            # 空白
            if char == ' ':
                self.advance()
                continue
            
            # タブ（インデント）
            if char == '\t':
                self.tokens.append(Token(TokenType.INDENT, '\t', self.line, self.column))
                self.advance()
                continue
            
            # 改行
            if char in '\n\r':
                if char == '\r' and self.peek_char() == '\n':
                    self.advance()
                self.tokens.append(Token(TokenType.NEWLINE, char, self.line, self.column))
                self.advance()
                continue
            
            # 第三段階: 数値リテラル
            if char.isdigit() or (char == '-' and self.peek_char() is not None and self.peek_char().isdigit()):
                self.tokens.append(self.tokenize_number())
                continue
            
            # 識別子
            if char.isalpha() or char == '_':
                self.tokens.append(self.tokenize_identifier())
                continue
            
            # 演算子（2文字）
            if char == '<' and self.peek_char() == '=':
                self.tokens.append(Token(TokenType.LESS_EQUAL, '<=', self.line, self.column))
                self.advance()
                self.advance()
                continue
            
            if char == '>' and self.peek_char() == '=':
                self.tokens.append(Token(TokenType.MORE_EQUAL, '>=', self.line, self.column))
                self.advance()
                self.advance()
                continue
            
            if char == '!' and self.peek_char() == '=':
                self.tokens.append(Token(TokenType.NOT_EQUAL, '!=', self.line, self.column))
                self.advance()
                self.advance()
                continue
            
            # 演算子（1文字）
            operators = {
                '#': TokenType.EXPORT,  # exportとoutputは文脈で判断
                ':': TokenType.DEFINE,
                '?': TokenType.LAMBDA,
                ',': TokenType.PRODUCT,
                '~': TokenType.RANGE,  # 前置・中置・後置は文脈で判断
                ';': TokenType.XOR,
                '|': TokenType.OR,
                '&': TokenType.AND,
                '!': TokenType.NOT,  # notとfactorialは文脈で判断
                '<': TokenType.LESS,
                '=': TokenType.EQUAL,
                '>': TokenType.MORE,
                '+': TokenType.ADD,
                '-': TokenType.SUB,
                '*': TokenType.MUL,
                '/': TokenType.DIV,
                '%': TokenType.MOD,
                '^': TokenType.POW,
                '$': TokenType.ADDRESS,
                "'": TokenType.GET_LEFT,
                '@': TokenType.INPUT,  # input, get_right, importは文脈で判断
                '(': TokenType.LPAREN,
                ')': TokenType.RPAREN,
                '[': TokenType.LBRACKET,
                ']': TokenType.RBRACKET,
                '{': TokenType.LBRACE,
                '}': TokenType.RBRACE,
            }
            
            if char in operators:
                self.tokens.append(Token(operators[char], char, self.line, self.column))
                self.advance()
                continue
            
            # 未知の文字はスキップ
            self.advance()
        
        self.tokens.append(Token(TokenType.EOF, None, self.line, self.column))
        return self.tokens
