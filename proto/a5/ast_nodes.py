"""
Sign言語のAST（抽象構文木）ノード定義

Sign言語の構文要素を表現するASTノードクラス群を提供します。
"""

from dataclasses import dataclass
from typing import Any, List, Optional, Union
from enum import Enum


class ASTNodeType(Enum):
    """ASTノードの種類"""
    PROGRAM = "program"
    LITERAL = "literal"
    IDENTIFIER = "identifier"
    BINARY_OP = "binary_op"
    UNARY_OP = "unary_op"
    LAMBDA = "lambda"
    BLOCK = "block"
    LIST = "list"
    PRODUCT = "product"
    RANGE = "range"
    POINTLESS_FN = "pointless_fn"


@dataclass
class ASTNode:
    """AST基底クラス"""
    node_type: ASTNodeType
    
    def to_dict(self) -> dict:
        """ASTをdict形式に変換（JSON化用）"""
        return {"type": self.node_type.value}


@dataclass
class Literal(ASTNode):
    """リテラルノード（数値、文字列、文字、Unit）"""
    value: Any
    literal_type: str  # "integer", "float", "hex", "oct", "bin", "string", "char", "unit"
    
    def __init__(self, value: Any, literal_type: str):
        super().__init__(ASTNodeType.LITERAL)
        self.value = value
        self.literal_type = literal_type
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "literal_type": self.literal_type,
            "value": self.value
        }


@dataclass
class Identifier(ASTNode):
    """識別子ノード"""
    name: str
    
    def __init__(self, name: str):
        super().__init__(ASTNodeType.IDENTIFIER)
        self.name = name
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "name": self.name
        }


@dataclass
class BinaryOp(ASTNode):
    """二項演算ノード（中置演算子）"""
    operator: str
    left: ASTNode
    right: ASTNode
    
    def __init__(self, operator: str, left: ASTNode, right: ASTNode):
        super().__init__(ASTNodeType.BINARY_OP)
        self.operator = operator
        self.left = left
        self.right = right
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "operator": self.operator,
            "left": self.left.to_dict(),
            "right": self.right.to_dict()
        }


@dataclass
class UnaryOp(ASTNode):
    """単項演算ノード（前置・後置演算子）"""
    operator: str
    operand: ASTNode
    is_prefix: bool  # True: 前置, False: 後置
    
    def __init__(self, operator: str, operand: ASTNode, is_prefix: bool):
        super().__init__(ASTNodeType.UNARY_OP)
        self.operator = operator
        self.operand = operand
        self.is_prefix = is_prefix
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "operator": self.operator,
            "is_prefix": self.is_prefix,
            "operand": self.operand.to_dict()
        }


@dataclass
class Lambda(ASTNode):
    """ラムダ式ノード"""
    params: List[Union[Identifier, 'ContinuousParam']]
    body: ASTNode
    
    def __init__(self, params: List[Union[Identifier, 'ContinuousParam']], body: ASTNode):
        super().__init__(ASTNodeType.LAMBDA)
        self.params = params
        self.body = body
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "params": [p.to_dict() for p in self.params],
            "body": self.body.to_dict()
        }


@dataclass
class ContinuousParam(ASTNode):
    """連続パラメータ（~x）"""
    name: str
    
    def __init__(self, name: str):
        super().__init__(ASTNodeType.IDENTIFIER)
        self.name = name
    
    def to_dict(self) -> dict:
        return {
            "type": "continuous_param",
            "name": self.name
        }


@dataclass
class Block(ASTNode):
    """ブロックノード"""
    statements: List[ASTNode]
    block_type: str  # "indent", "paren", "bracket", "brace"
    
    def __init__(self, statements: List[ASTNode], block_type: str = "indent"):
        super().__init__(ASTNodeType.BLOCK)
        self.statements = statements
        self.block_type = block_type
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "block_type": self.block_type,
            "statements": [s.to_dict() for s in self.statements]
        }


@dataclass
class ListNode(ASTNode):
    """リストノード"""
    elements: List[ASTNode]
    
    def __init__(self, elements: List[ASTNode]):
        super().__init__(ASTNodeType.LIST)
        self.elements = elements
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "elements": [e.to_dict() for e in self.elements]
        }


@dataclass
class Product(ASTNode):
    """積演算ノード（,演算子）"""
    elements: List[ASTNode]
    
    def __init__(self, elements: List[ASTNode]):
        super().__init__(ASTNodeType.PRODUCT)
        self.elements = elements
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "elements": [e.to_dict() for e in self.elements]
        }


@dataclass
class Range(ASTNode):
    """範囲ノード（~演算子による範囲指定）"""
    start: ASTNode
    end: ASTNode
    step: Optional[ASTNode] = None
    
    def __init__(self, start: ASTNode, end: ASTNode, step: Optional[ASTNode] = None):
        super().__init__(ASTNodeType.RANGE)
        self.start = start
        self.end = end
        self.step = step
    
    def to_dict(self) -> dict:
        result = {
            "type": self.node_type.value,
            "start": self.start.to_dict(),
            "end": self.end.to_dict()
        }
        if self.step:
            result["step"] = self.step.to_dict()
        return result


@dataclass
class PointlessFn(ASTNode):
    """ポイントフリー記法ノード"""
    operator: str
    operand: Optional[ASTNode] = None
    is_left_partial: bool = False  # True: [1 +], False: [+ 1] or [+]
    has_comma: bool = False  # mapのための , があるか
    
    def __init__(self, operator: str, operand: Optional[ASTNode] = None, 
                 is_left_partial: bool = False, has_comma: bool = False):
        super().__init__(ASTNodeType.POINTLESS_FN)
        self.operator = operator
        self.operand = operand
        self.is_left_partial = is_left_partial
        self.has_comma = has_comma
    
    def to_dict(self) -> dict:
        result = {
            "type": self.node_type.value,
            "operator": self.operator
        }
        if self.operand:
            result["operand"] = self.operand.to_dict()
            result["is_left_partial"] = self.is_left_partial
        if self.has_comma:
            result["has_comma"] = self.has_comma
        return result


@dataclass
class Program(ASTNode):
    """プログラム全体ノード"""
    statements: List[ASTNode]
    
    def __init__(self, statements: List[ASTNode]):
        super().__init__(ASTNodeType.PROGRAM)
        self.statements = statements
    
    def to_dict(self) -> dict:
        return {
            "type": self.node_type.value,
            "statements": [s.to_dict() for s in self.statements]
        }
