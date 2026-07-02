// alpha/rust/src/ast.rs

#[derive(Clone, Debug, PartialEq)]
pub enum BlockKind {
    Paren,
    Bracket,
    Brace,
    Indent,
    Abs,
}

#[derive(Clone, Debug, PartialEq)]
pub enum PointFreeKind {
    BinaryOp(String),                  // [+]
    BinaryOpMap(String, Box<AstNode>), // [* 2,] （演算子と右オペランド）
    PrefixOp(String),                  // [!_]
    PostfixOp(String),                 // [_!]
}

#[derive(Clone, Debug, PartialEq)]
pub enum AstNode {
    Scalar(f64),
    Char(char),
    String(String),
    Address(usize),
    Register(isize),
    Unit,
    Hole,
    Identifier(String),
    InlineCode(String),
    Block {
        kind: BlockKind,
        content: Box<AstNode>,
    },
    BinaryOperation {
        operator: String,
        left: Box<AstNode>,
        right: Box<AstNode>,
        name: String,
    },
    Prefix {
        operator: String,
        operand: Box<AstNode>,
        name: String,
    },
    Postfix {
        operator: String,
        operand: Box<AstNode>,
        name: String,
    },
    Coproduct(Vec<AstNode>),
    Product(Vec<AstNode>),
    Lambda {
        arguments: Box<AstNode>,
        body: Box<AstNode>,
    },
    Define {
        identifier: String,
        definition: Box<AstNode>,
    },
    MatchCase {
        cases: Vec<(Option<AstNode>, AstNode)>,
    },
    PointFree(PointFreeKind),
}
