"""
Sign言語のAST（抽象構文木）ノード定義

Sign言語の構文要素を表現するASTノードクラス群を提供します。
各ノードはJSON形式（to_dict）、S式形式（to_sexp）、Common Lisp形式（to_clisp）に変換可能です。
"""

from dataclasses import dataclass
from typing import Any, List, Optional, Union
from enum import Enum


# Common Lisp予約語・組み込みシンボルのリスト
# 主要な特殊演算子、マクロ、よく使われる関数をカバー
COMMON_LISP_RESERVED = {
    # 特殊演算子
    'quote', 'function', 'if', 'let', 'let*', 'lambda', 'progn', 'setq',
    'block', 'return-from', 'catch', 'throw', 'tagbody', 'go',
    'multiple-value-call', 'multiple-value-prog1', 'unwind-protect',
    'eval-when', 'load-time-value', 'locally', 'the',
    
    # よく使われるマクロと関数
    'defun', 'defmacro', 'defvar', 'defparameter', 'defconstant',
    'cond', 'case', 'when', 'unless', 'and', 'or', 'not',
    'loop', 'do', 'dolist', 'dotimes', 'map', 'mapcar', 'reduce',
    'list', 'cons', 'car', 'cdr', 'nth', 'append', 'reverse',
    'print', 'format', 'read', 'write', 'error', 'warn',
    'equal', 'eql', 'eq', 'equalp', 'identity',
    'type', 'class', 'struct', 'array', 'vector', 'string',
    'nil', 't',
    
    # 算術・数学関数
    'abs', 'mod', 'expt', 'sqrt', 'sin', 'cos', 'tan',
    'min', 'max', 'floor', 'ceiling', 'round', 'truncate',
    
    # 型述語
    'numberp', 'integerp', 'floatp', 'stringp', 'symbolp',
    'listp', 'consp', 'null', 'atom',
    
    # Common Lispパッケージシステム
    'in-package', 'defpackage', 'export', 'import', 'use-package',
}


def escape_identifier_for_clisp(name: str) -> str:
    """
    識別子名がCommon Lispの予約語と衝突する場合、-signサフィックスを追加
    
    Args:
        name: Sign言語の識別子名
    
    Returns:
        Common Lispで安全に使える識別子名
    """
    # 小文字に変換して予約語チェック（Common Lispは大文字小文字を区別しない）
    if name.lower() in COMMON_LISP_RESERVED:
        return f"{name}-sign"
    return name


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
    
    def to_sexp(self) -> str:
        """ASTをS式（前置記法）に変換"""
        return str(self.node_type.value)

    def to_clisp(self) -> str:
        """ASTをCommon Lispコードに変換"""
        return str(self.node_type.value)


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
    
    def to_sexp(self) -> str:
        """リテラルをS式に変換"""
        if self.literal_type == "string":
            return f'"{self.value}"'
        elif self.literal_type == "char":
            return f"'{self.value}"
        elif self.literal_type == "unit":
            return "_"
        else:
            return str(self.value)

    def to_clisp(self) -> str:
        """リテラルをCommon Lispに変換"""
        if self.literal_type == "string":
            return f'"{self.value}"'
        elif self.literal_type == "char":
            return f"#\\{self.value}"  # Lispの文字リテラル
        elif self.literal_type == "unit":
            return "nil"  # Unitはnilとする
        elif self.literal_type == "integer":
            return str(self.value)
        elif self.literal_type == "float":
            return str(self.value)
        else:
            return str(self.value)


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
    
    def to_sexp(self) -> str:
        """識別子をS式に変換"""
        return self.name

    def to_clisp(self) -> str:
        """識別子をCommon Lispに変換"""
        # Common Lisp予約語との衝突を回避
        return escape_identifier_for_clisp(self.name)


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
    
    def to_sexp(self) -> str:
        """二項演算をS式に変換"""
        # 特殊な演算子の変換
        op_map = {
            ':': 'define',
            '?': 'lambda',
            ',': 'list',
            '&': 'and',
            '|': 'or',
            ';': 'xor',
            '=': '=',
            '#': 'output'
        }
        
        op = op_map.get(self.operator, self.operator)
        left_sexp = self.left.to_sexp()
        right_sexp = self.right.to_sexp()
        
        return f"({op} {left_sexp} {right_sexp})"

    def to_clisp(self) -> str:
        """二項演算をCommon Lispに変換"""
        # 特殊処理: # (output) 演算子
        if self.operator == '#':
            # 左辺が0x1（標準出力アドレス）の場合
            if isinstance(self.left, Literal) and self.left.literal_type == 'hex' and self.left.value == '0x1':
                # 標準出力: (print right) または (format t "~a" right)
                right_code = self.right.to_clisp()
                return f"(format t \"~a\" {right_code})"
            # 左辺がUnit（_）の場合も標準出力として扱う
            elif isinstance(self.left, Literal) and self.left.literal_type == 'unit':
                right_code = self.right.to_clisp()
                return f"(format t \"~a\" {right_code})"
            # 右辺がUnit（_）の場合（expr # _）も標準出力
            elif isinstance(self.right, Literal) and self.right.literal_type == 'unit':
                left_code = self.left.to_clisp()
                return f"(format t \"~a\" {left_code})"
            # それ以外のアドレスの場合: メモリ書き込みやIO操作
            # Common Lispではコメントとして残す（実際の実装はシステム依存）
            else:
                left_code = self.left.to_clisp()
                right_code = self.right.to_clisp()
                return f"; TODO: Output {right_code} to address {left_code}\n(setf (mem-ref {left_code}) {right_code})"
        
        # 特殊処理: : (define) 演算子でLambdaを定義する場合
        if self.operator == ':':
            # 右辺がLambdaの場合、defunとして定義
            if isinstance(self.right, Lambda):
                func_name = self.left.to_clisp() if isinstance(self.left, Identifier) else str(self.left)
                params = ' '.join(p.to_clisp() for p in self.right.params)
                body = self.right.body.to_clisp()
                return f"(defun {func_name} ({params}) {body})"
        
        # 通常の演算子のマッピング
        op_map = {
            ':': 'defparameter',
            '+': '+', '-': '-', '*': '*', '/': '/', '%': 'mod', '^': 'expt',
            '=': '=', '<': '<', '>': '>', '<=': '<=', '>=': '>=', '!=': '/=',
            '&': 'and', '|': 'or', ';': 'xor',  # XOR追加（Common Lispにはないので後で実装必要）
            ',': 'list'
        }
        
        op = op_map.get(self.operator, self.operator)
        left_code = self.left.to_clisp()
        right_code = self.right.to_clisp()
        
        return f"({op} {left_code} {right_code})"


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
    
    def to_sexp(self) -> str:
        """単項演算をS式に変換"""
        # 特殊な演算子の変換
        op_map = {
            '!': 'not' if self.is_prefix else 'factorial',
            '$': 'address',
            '@': 'input' if self.is_prefix else 'import',
            '~': 'expand',
            '#': 'export',
            'abs': 'abs'
        }
        
        op = op_map.get(self.operator, self.operator)
        operand_sexp = self.operand.to_sexp()
        
        return f"({op} {operand_sexp})"

    def to_clisp(self) -> str:
        """単項演算をCommon Lispに変換"""
        # Export演算子（前置#）の特殊処理
        if self.is_prefix and self.operator == '#':
            # Common Lispのexportはパッケージシステムで使うため、
            # Sign言語のexportとは意味が異なる
            # コメントとして残すか、実際の定義だけを出力
            operand_code = self.operand.to_clisp()
            return f"; EXPORTED\n{operand_code}"
        
        # その他の単項演算子
        op_map = {
            '!': 'not',  # factorialは標準ではないので一旦notのみ
        }
        
        # 階乗などはヘルパー関数が必要
        if not self.is_prefix and self.operator == '!':
            return f"(factorial {self.operand.to_clisp()})"
            
        op = op_map.get(self.operator, self.operator)
        return f"({op} {self.operand.to_clisp()})"


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
    
    def to_sexp(self) -> str:
        """ラムダ式をS式に変換"""
        params_sexp = ' '.join(p.to_sexp() for p in self.params)
        body_sexp = self.body.to_sexp()
        return f"(lambda ({params_sexp}) {body_sexp})"

    def to_clisp(self) -> str:
        """ラムダ式をCommon Lispに変換"""
        params_code = ' '.join(p.to_clisp() for p in self.params)
        body_code = self.body.to_clisp()
        return f"(lambda ({params_code}) {body_code})"


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
    
    def to_sexp(self) -> str:
        """連続パラメータをS式に変換"""
        return f"~{self.name}"

    def to_clisp(self) -> str:
        """連続パラメータをCommon Lispに変換"""
        return f"&rest {self.name}"  # Lispの可変長引数


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
    
    def to_sexp(self) -> str:
        """ブロックをS式に変換"""
        if len(self.statements) == 1:
            return self.statements[0].to_sexp()
        
        statements_sexp = ' '.join(s.to_sexp() for s in self.statements)
        return f"(block {statements_sexp})"

    def to_clisp(self) -> str:
        """ブロックをCommon Lispに変換"""
        if len(self.statements) == 1:
            return self.statements[0].to_clisp()
        
        statements_code = ' '.join(s.to_clisp() for s in self.statements)
        return f"(progn {statements_code})"


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
    
    def to_sexp(self) -> str:
        """リストをS式に変換"""
        elements_sexp = ' '.join(e.to_sexp() for e in self.elements)
        return f"(apply {elements_sexp})"

    def to_clisp(self) -> str:
        """リストをCommon Lispに変換"""
        # Sign言語の空白区切り要素は関数適用を表す
        # 最初の要素が関数、残りが引数
        if len(self.elements) == 0:
            return "nil"
        
        if len(self.elements) == 1:
            return self.elements[0].to_clisp()
        
        # 関数適用: (func arg1 arg2 ...)
        func_code = self.elements[0].to_clisp()
        args_code = ' '.join(e.to_clisp() for e in self.elements[1:])
        return f"({func_code} {args_code})"


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
    
    def to_sexp(self) -> str:
        """積をS式に変換"""
        elements_sexp = ' '.join(e.to_sexp() for e in self.elements)
        return f"(list {elements_sexp})"

    def to_clisp(self) -> str:
        """積をCommon Lispに変換"""
        elements_code = ' '.join(e.to_clisp() for e in self.elements)
        return f"(list {elements_code})"


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
    
    def to_sexp(self) -> str:
        """範囲をS式に変換"""
        start_sexp = self.start.to_sexp()
        end_sexp = self.end.to_sexp()
        
        if self.step:
            step_sexp = self.step.to_sexp()
            return f"(range {start_sexp} {end_sexp} {step_sexp})"
        else:
            return f"(range {start_sexp} {end_sexp})"

    def to_clisp(self) -> str:
        """範囲をCommon Lispに変換"""
        start = self.start.to_clisp()
        end = self.end.to_clisp()
        
        if self.step:
            step = self.step.to_clisp()
            return f"(range {start} {end} {step})"
        else:
            return f"(range {start} {end})"


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
    
    def to_sexp(self) -> str:
        """ポイントフリー記法をS式に変換"""
        if self.operand is None:
            return f"(fold {self.operator})"
        
        operand_sexp = self.operand.to_sexp()
        
        if self.has_comma:
            if self.is_left_partial:
                return f"(map ({self.operator} {operand_sexp} _))"
            else:
                return f"(map ({self.operator} _ {operand_sexp}))"
        else:
            if self.is_left_partial:
                return f"({self.operator} {operand_sexp} _)"
            else:
                return f"({self.operator} _ {operand_sexp})"

    def to_clisp(self) -> str:
        """ポイントフリー記法をCommon Lispに変換"""
        op = self.operator
        # 演算子のマッピング
        op_map = {'+': '+', '-': '-', '*': '*', '/': '/', '%': 'mod'}
        op = op_map.get(op, op)

        if self.operand is None:
            # DirectFold: [+] → (lambda (lst) (reduce #'+ lst))
            return f"(lambda (lst) (reduce #'{op} lst))"
        
        operand_code = self.operand.to_clisp()
        
        if self.has_comma:
            # map用: [* 2,] → (lambda (lst) (mapcar (lambda (x) (* x 2)) lst))
            if self.is_left_partial:
                # [2 *] -> (* 2 x)
                return f"(lambda (lst) (mapcar (lambda (x) ({op} {operand_code} x)) lst))"
            else:
                # [* 2] -> (* x 2)
                return f"(lambda (lst) (mapcar (lambda (x) ({op} x {operand_code})) lst))"
        else:
            # 部分適用
            if self.is_left_partial:
                # [5 -] → (lambda (x) (- 5 x))
                return f"(lambda (x) ({op} {operand_code} x))"
            else:
                # [+ 1] → (lambda (x) (+ x 1))
                return f"(lambda (x) ({op} x {operand_code}))"


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
    
    def to_sexp(self) -> str:
        """プログラムをS式に変換"""
        if len(self.statements) == 0:
            return "()"
        
        if len(self.statements) == 1:
            return self.statements[0].to_sexp()
        
        statements_sexp = '\n  '.join(s.to_sexp() for s in self.statements)
        return f"(begin\n  {statements_sexp})"

    def to_clisp(self) -> str:
        """プログラムをCommon Lispに変換"""
        if len(self.statements) == 0:
            return "()"
        
        # トップレベルのステートメントを並べる
        statements_code = '\n'.join(s.to_clisp() for s in self.statements)
        return statements_code
