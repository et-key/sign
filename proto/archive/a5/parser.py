"""
Sign言語の構文解析器（Parser）

PEG文法（sign_ja-jp.peg）の優先順位1-16を実装
再帰下降パーサーによる実装
ポイントフリー記法対応
"""

from typing import List, Optional, Union
from lexer import Token, TokenType, Lexer
from ast_nodes import *


class Parser:
    """Sign言語の構文解析器"""
    
    def __init__(self, tokens: List[Token]):
        self.tokens = [t for t in tokens if t.type not in (TokenType.COMMENT,)]
        self.pos = 0
    
    def current_token(self) -> Optional[Token]:
        """現在位置のトークンを取得"""
        if self.pos >= len(self.tokens):
            return None
        return self.tokens[self.pos]
    
    def peek_token(self, offset: int = 1) -> Optional[Token]:
        """先読み"""
        pos = self.pos + offset
        if pos >= len(self.tokens):
            return None
        return self.tokens[pos]
    
    def advance(self) -> Optional[Token]:
        """1トークン進める"""
        token = self.current_token()
        if token is not None:
            self.pos += 1
        return token
    
    def expect(self, token_type: TokenType) -> Token:
        """指定したトークンタイプを要求"""
        token = self.current_token()
        if token is None or token.type != token_type:
            raise SyntaxError(f"Expected {token_type}, got {token}")
        return self.advance()
    
    def skip_newlines(self):
        """改行をスキップ"""
        while self.current_token() and self.current_token().type == TokenType.NEWLINE:
            self.advance()
    
    # ==================== 優先順位1: Export ====================
    
    def parse_export_level(self) -> ASTNode:
        """優先順位1: Export"""
        self.skip_newlines()
        
        token = self.current_token()
        if token and token.type == TokenType.EXPORT:
            self.advance()
            expr = self.parse_define_level()
            return UnaryOp('#', expr, is_prefix=True)
        
        return self.parse_define_level()
    
    # ==================== 優先順位2: Define + Output ====================
    
    def parse_define_level(self) -> ASTNode:
        """優先順位2: Define"""
        left = self.parse_output_level()
        
        token = self.current_token()
        if token and token.type == TokenType.DEFINE:
            # 識別子 : 式 の形式のみ
            if isinstance(left, Identifier):
                self.advance()
                right = self.parse_output_level()
                return BinaryOp(':', left, right)
        
        return left
    
    def parse_output_level(self) -> ASTNode:
        """優先順位3: Output"""
        left = self.parse_function_apply_level()
        
        token = self.current_token()
        if token and token.type == TokenType.EXPORT:  # # は output としても使用
            # 識別子/16進数 # 式 の形式
            self.advance()
            right = self.parse_function_apply_level()
            return BinaryOp('#', left, right)
        
        return left
    
    # ==================== 優先順位3-7: 構築域 ====================
    
    def parse_function_apply_level(self) -> ASTNode:
        """優先順位: 関数適用（空白による余積）"""
        elements = [self.parse_function_compose_level()]
        
        # 空白で区切られた要素を収集
        while True:
            token = self.current_token()
            if token is None or token.type in (TokenType.NEWLINE, TokenType.EOF, 
                                                TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE,
                                                TokenType.DEFINE, TokenType.EXPORT):
                break
            
            # カンマや演算子が来たら終了
            if token.type in (TokenType.PRODUCT, TokenType.RANGE, TokenType.XOR, TokenType.OR, TokenType.AND,
                            TokenType.LESS, TokenType.LESS_EQUAL, TokenType.EQUAL,
                            TokenType.MORE_EQUAL, TokenType.MORE, TokenType.NOT_EQUAL):
                break
            
            elements.append(self.parse_function_compose_level())
        
        if len(elements) == 1:
            return elements[0]
        
        # 複数要素の場合、関数適用またはリスト構築
        return ListNode(elements)
    
    def parse_function_compose_level(self) -> ASTNode:
        """関数合成レベル（現時点では function_apply と統合）"""
        return self.parse_lambda_level()
    
    def parse_lambda_level(self) -> ASTNode:
        """優先順位: Lambda"""
        # ラムダの判定: params ? body の形式
        # 先読みして ? があるか確認
        
        params = []
        start_pos = self.pos
        
        # パラメータの収集を試みる
        while True:
            token = self.current_token()
            if token is None or token.type in (TokenType.NEWLINE, TokenType.EOF):
                break
            
            if token.type == TokenType.LAMBDA:
                # ラムダ構文確定
                self.advance()
                # Lambda本体は優先順位3（Output）まで含む必要がある
                body = self.parse_output_level()
                return Lambda(params, body)
            
            if token.type == TokenType.IDENTIFIER:
                params.append(Identifier(token.value))
                self.advance()
            elif token.type == TokenType.RANGE:  # ~ (continuous param)
                self.advance()
                if self.current_token() and self.current_token().type == TokenType.IDENTIFIER:
                    params.append(ContinuousParam(self.current_token().value))
                    self.advance()
                else:
                    # ~ の後に識別子がない場合、ラムダではない
                    self.pos = start_pos
                    break
            else:
                # ラムダパラメータではない
                self.pos = start_pos
                break
        
        # ラムダでない場合
        self.pos = start_pos
        return self.parse_product_level()
    
    def parse_product_level(self) -> ASTNode:
        """優先順位: Product (,演算子)"""
        elements = [self.parse_range_level()]
        
        while self.current_token() and self.current_token().type == TokenType.PRODUCT:
            self.advance()
            elements.append(self.parse_range_level())
        
        if len(elements) == 1:
            return elements[0]
        
        return Product(elements)
    
    def parse_range_level(self) -> ASTNode:
        """優先順位: Range (~演算子)"""
        left = self.parse_logical_xor_level()
        
        if self.current_token() and self.current_token().type == TokenType.RANGE:
            self.advance()
            middle = self.parse_logical_xor_level()
            
            # 3項の範囲指定: start ~ step ~ end
            if self.current_token() and self.current_token().type == TokenType.RANGE:
                self.advance()
                end = self.parse_logical_xor_level()
                return Range(left, end, middle)
            
            # 2項の範囲指定: start ~ end
            return Range(left, middle)
        
        return left
    
    # ==================== 優先順位4-6: 論理域 ====================
    
    def parse_logical_xor_level(self) -> ASTNode:
        """優先順位: XOR"""
        left = self.parse_logical_or_level()
        
        while self.current_token() and self.current_token().type == TokenType.XOR:
            op = self.advance()
            right = self.parse_logical_or_level()
            left = BinaryOp(';', left, right)
        
        return left
    
    def parse_logical_or_level(self) -> ASTNode:
        """優先順位: OR"""
        left = self.parse_logical_and_level()
        
        while self.current_token() and self.current_token().type == TokenType.OR:
            op = self.advance()
            right = self.parse_logical_and_level()
            left = BinaryOp('|', left, right)
        
        return left
    
    def parse_logical_and_level(self) -> ASTNode:
        """優先順位: AND"""
        left = self.parse_logical_not_level()
        
        while self.current_token() and self.current_token().type == TokenType.AND:
            op = self.advance()
            right = self.parse_logical_not_level()
            left = BinaryOp('&', left, right)
        
        return left
    
    def parse_logical_not_level(self) -> ASTNode:
        """優先順位: NOT（前置）"""
        if self.current_token() and self.current_token().type == TokenType.NOT:
            # 次のトークンとの間に空白が無いかチェック（簡易版）
            self.advance()
            expr = self.parse_comparison_level()
            return UnaryOp('!', expr, is_prefix=True)
        
        return self.parse_comparison_level()
    
    # ==================== 優先順位7: 比較演算域 ====================
    
    def parse_comparison_level(self) -> ASTNode:
        """優先順位: 比較演算（連鎖比較対応）"""
        left = self.parse_absolute_level()
        
        comparisons = []
        while self.current_token() and self.current_token().type in (
            TokenType.LESS, TokenType.LESS_EQUAL, TokenType.EQUAL,
            TokenType.MORE_EQUAL, TokenType.MORE, TokenType.NOT_EQUAL
        ):
            op_token = self.advance()
            right = self.parse_absolute_level()
            comparisons.append((op_token.value, right))
        
        if not comparisons:
            return left
        
        # 連鎖比較の構築
        result = left
        for op, right_expr in comparisons:
            result = BinaryOp(op, result, right_expr)
        
        return result
    
    # ==================== 優先順位8: 絶対値 ====================
    
    def parse_absolute_level(self) -> ASTNode:
        """優先順位: 絶対値（|expr|）"""
        if self.current_token() and self.current_token().type == TokenType.OR:
            # |expr| の形式
            self.advance()
            expr = self.parse_arithmetic_add_level()
            if self.current_token() and self.current_token().type == TokenType.OR:
                self.advance()
                return UnaryOp('abs', expr, is_prefix=True)
            else:
                # | が1つだけの場合、論理ORとして扱うべきだが、
                # ここでは簡易的にエラーとする
                raise SyntaxError("Unclosed absolute value")
        
        return self.parse_arithmetic_add_level()
    
    # ==================== 優先順位9-11: 算術演算域 ====================
    
    def parse_arithmetic_add_level(self) -> ASTNode:
        """優先順位: 加減算"""
        left = self.parse_arithmetic_mul_level()
        
        while self.current_token() and self.current_token().type in (TokenType.ADD, TokenType.SUB):
            op = self.advance()
            right = self.parse_arithmetic_mul_level()
            left = BinaryOp(op.value, left, right)
        
        return left
    
    def parse_arithmetic_mul_level(self) -> ASTNode:
        """優先順位: 乗除算"""
        left = self.parse_power_level()
        
        while self.current_token() and self.current_token().type in (TokenType.MUL, TokenType.DIV, TokenType.MOD):
            op = self.advance()
            right = self.parse_power_level()
            left = BinaryOp(op.value, left, right)
        
        return left
    
    def parse_power_level(self) -> ASTNode:
        """優先順位: 冪乗（右結合）"""
        left = self.parse_factorial_level()
        
        if self.current_token() and self.current_token().type == TokenType.POW:
            op = self.advance()
            right = self.parse_power_level()  # 右結合
            return BinaryOp('^', left, right)
        
        return left
    
    def parse_factorial_level(self) -> ASTNode:
        """優先順位: 階乗（後置）"""
        expr = self.parse_resolve_level()
        
        if self.current_token() and self.current_token().type == TokenType.NOT:
            # ! が後置演算子として使用されているか判定（簡易版）
            self.advance()
            return UnaryOp('!', expr, is_prefix=False)
        
        return expr
    
    # ==================== 優先順位13-15: 解決評価域 ====================
    
    def parse_resolve_level(self) -> ASTNode:
        """優先順位: 解決評価域（Expand, Address, Get）"""
        return self.parse_expand_level()
    
    def parse_expand_level(self) -> ASTNode:
        """優先順位: Expand（~後置）"""
        expr = self.parse_address_level()
        
        if self.current_token() and self.current_token().type == TokenType.RANGE:
            # 先読み: 次にパース可能な式がある場合は、後置ではなく二項演算子として扱う
            next_token = self.peek_token()
            if next_token and next_token.type not in (
                TokenType.NEWLINE, TokenType.EOF, TokenType.RPAREN, 
                TokenType.RBRACKET, TokenType.RBRACE, TokenType.DEFINE,
                TokenType.PRODUCT, TokenType.XOR, TokenType.OR, TokenType.AND,
                TokenType.LESS, TokenType.LESS_EQUAL, TokenType.EQUAL,
                TokenType.MORE_EQUAL, TokenType.MORE, TokenType.NOT_EQUAL
            ):
                # 次に式が続くので、後置ではなく二項Range演算子として扱う
                # ここでは処理せず、上位のparse_range_levelに任せる
                return expr
            
            # 後置Expand演算子として処理
            self.advance()
            return UnaryOp('~', expr, is_prefix=False)
        
        return expr
    
    def parse_address_level(self) -> ASTNode:
        """優先順位: Address（$前置）"""
        if self.current_token() and self.current_token().type == TokenType.ADDRESS:
            self.advance()
            expr = self.parse_get_level()
            return UnaryOp('$', expr, is_prefix=True)
        
        return self.parse_get_level()
    
    def parse_get_level(self) -> ASTNode:
        """優先順位: Get（'と@）"""
        expr = self.parse_import_level()
        
        # ' 演算子（左単位元）
        while self.current_token() and self.current_token().type == TokenType.GET_LEFT:
            self.advance()
            if self.current_token() and self.current_token().type in (TokenType.IDENTIFIER, TokenType.STRING, TokenType.INTEGER):
                key_token = self.advance()
                if key_token.type == TokenType.IDENTIFIER:
                    key = Identifier(key_token.value)
                elif key_token.type == TokenType.STRING:
                    key = Literal(key_token.value, "string")
                else:
                    key = Literal(key_token.value, "integer")
                expr = BinaryOp("'", expr, key)
        
        return expr
    
    def parse_import_level(self) -> ASTNode:
        """優先順位: Import（@後置）"""
        expr = self.parse_input_level()
        
        if self.current_token() and self.current_token().type == TokenType.INPUT:
            # @ が後置の import として使用されているか判定
            self.advance()
            return UnaryOp('@', expr, is_prefix=False)
        
        return expr
    
    def parse_input_level(self) -> ASTNode:
        """優先順位: Input（@前置）"""
        if self.current_token() and self.current_token().type == TokenType.INPUT:
            self.advance()
            expr = self.parse_primary_level()
            return UnaryOp('@', expr, is_prefix=True)
        
        return self.parse_primary_level()
    
    # ==================== 優先順位16: ブロック・基本要素 ====================
    
    def parse_primary_level(self) -> ASTNode:
        """優先順位16: 基本要素"""
        token = self.current_token()
        
        if token is None:
            raise SyntaxError("Unexpected end of input")
        
        # リテラル
        if token.type == TokenType.INTEGER:
            self.advance()
            return Literal(token.value, "integer")
        
        if token.type == TokenType.FLOAT:
            self.advance()
            return Literal(token.value, "float")
        
        if token.type == TokenType.HEX:
            self.advance()
            return Literal(token.value, "hex")
        
        if token.type == TokenType.OCT:
            self.advance()
            return Literal(token.value, "oct")
        
        if token.type == TokenType.BIN:
            self.advance()
            return Literal(token.value, "bin")
        
        if token.type == TokenType.STRING:
            self.advance()
            return Literal(token.value, "string")
        
        if token.type == TokenType.CHAR:
            self.advance()
            return Literal(token.value, "char")
        
        if token.type == TokenType.UNIT:
            self.advance()
            return Literal("_", "unit")
        
        if token.type == TokenType.IDENTIFIER:
            self.advance()
            return Identifier(token.value)
        
        # ブロック（括弧）
        if token.type == TokenType.LPAREN:
            return self.parse_block_expression('(')
        
        if token.type == TokenType.LBRACKET:
            return self.parse_block_expression('[')
        
        if token.type == TokenType.LBRACE:
            return self.parse_block_expression('{')
        
        raise SyntaxError(f"Unexpected token: {token}")
    
    def parse_block_expression(self, open_bracket: str) -> ASTNode:
        """ブロック式のパース（ポイントフリー記法対応）"""
        close_map = {'(': TokenType.RPAREN, '[': TokenType.RBRACKET, '{': TokenType.RBRACE}
        block_type_map = {'(': 'paren', '[': 'bracket', '{': 'brace'}
        
        self.advance()  # 開き括弧をスキップ
        
        # ポイントフリー記法の判定
        pointless = self.try_parse_pointless()
        if pointless:
            close_type = close_map[open_bracket]
            if self.current_token() and self.current_token().type == close_type:
                self.advance()
                return pointless
            else:
                raise SyntaxError(f"Expected closing bracket for {open_bracket}")
        
        # 通常のブロック式
        expr = self.parse_export_level()
        
        close_type = close_map[open_bracket]
        if self.current_token() and self.current_token().type == close_type:
            self.advance()
        else:
            raise SyntaxError(f"Expected closing bracket for {open_bracket}")
        
        return Block([expr], block_type_map[open_bracket])
    
    def try_parse_pointless(self) -> Optional[ASTNode]:
        """ポイントフリー記法のパースを試みる"""
        start_pos = self.pos
        token = self.current_token()
        
        if token is None:
            return None
        
        # 演算子トークンの判定
        operator_types = {
            TokenType.ADD, TokenType.SUB, TokenType.MUL, TokenType.DIV, TokenType.MOD,
            TokenType.POW, TokenType.EQUAL, TokenType.LESS, TokenType.LESS_EQUAL,
            TokenType.MORE, TokenType.MORE_EQUAL, TokenType.NOT_EQUAL,
            TokenType.AND, TokenType.OR, TokenType.XOR,
            TokenType.PRODUCT, TokenType.RANGE, TokenType.GET_LEFT,
            TokenType.DEFINE
        }
        
        # パターン1: 前置演算子のみ [!] や [$]
        if token.type in (TokenType.NOT, TokenType.ADDRESS, TokenType.INPUT):
            op = token.value
            self.advance()
            # 次が閉じ括弧かチェック
            if self.current_token() and self.current_token().type in (TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE):
                return PointlessFn(op, None, False, False)
            # そうでなければポイントフリーではない
            self.pos = start_pos
            return None
        
        # パターン2: 後置演算子 [_!] や [_~]
        if token.type == TokenType.UNIT:
            next_token = self.peek_token()
            if next_token and next_token.type in (TokenType.NOT, TokenType.RANGE, TokenType.INPUT):
                self.advance()  # _
                op = self.advance().value  # 演算子
                # 次が閉じ括弧かチェック
                if self.current_token() and self.current_token().type in (TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE):
                    return PointlessFn(op + '_postfix', None, False, False)
            # そうでなければポイントフリーではない
            self.pos = start_pos
            return None
        
        # パターン3: 中置演算子のみ [+] （DirectFold）
        if token.type in operator_types:
            op = token.value
            self.advance()
            
            # 次がカンマか閉じ括弧かチェック
            next_token = self.current_token()
            if next_token and next_token.type in (TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE):
                # 演算子のみ：DirectFold
                return PointlessFn(op, None, False, False)
            
            # 次がリテラルまたは識別子の場合：部分適用 [+ 1]
            if next_token and next_token.type in (
                TokenType.INTEGER, TokenType.FLOAT, TokenType.STRING, 
                TokenType.CHAR, TokenType.IDENTIFIER, TokenType.UNIT
            ):
                operand = self.parse_primary_level()
                
                # カンマのチェック
                has_comma = False
                if self.current_token() and self.current_token().type == TokenType.PRODUCT:
                    has_comma = True
                    self.advance()
                
                # 次が閉じ括弧かチェック
                if self.current_token() and self.current_token().type in (TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE):
                    return PointlessFn(op, operand, False, has_comma)
            
            # そうでなければ通常のブロック
            self.pos = start_pos
            return None
        
        # パターン4: リテラル + 演算子 [1 +] （左部分適用）
        if token.type in (
            TokenType.INTEGER, TokenType.FLOAT, TokenType.STRING, 
            TokenType.CHAR, TokenType.IDENTIFIER, TokenType.UNIT
        ):
            operand = self.parse_primary_level()
            
            # 次が演算子かチェック
            op_token = self.current_token()
            if op_token and op_token.type in operator_types:
                op = op_token.value
                self.advance()
                
                # カンマのチェック
                has_comma = False
                if self.current_token() and self.current_token().type == TokenType.PRODUCT:
                    has_comma = True
                    self.advance()
                
                # 次が閉じ括弧かチェック
                if self.current_token() and self.current_token().type in (TokenType.RPAREN, TokenType.RBRACKET, TokenType.RBRACE):
                    return PointlessFn(op, operand, True, has_comma)
        
        # ポイントフリーではない
        self.pos = start_pos
        return None
    
    # ==================== プログラム全体のパース ====================
    
    def parse(self) -> Program:
        """プログラム全体をパース"""
        statements = []
        
        while self.current_token() and self.current_token().type != TokenType.EOF:
            self.skip_newlines()
            
            if self.current_token() and self.current_token().type != TokenType.EOF:
                stmt = self.parse_export_level()
                statements.append(stmt)
                
                # 改行またはEOF
                if self.current_token() and self.current_token().type == TokenType.NEWLINE:
                    self.advance()
        
        return Program(statements)
