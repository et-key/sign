// alpha/rust/src/ast.rs
use crate::runtime::SignValue;

#[derive(Clone, Debug, PartialEq)]
pub enum BlockKind {
    Paren,
    Bracket,
    Brace,
    Indent,
    Abs,
}

#[derive(Clone, Debug, PartialEq)]
pub enum AstNode {
    Atom(SignValue),
    Identifier(String),
    InlineCode(String), // 追加: ダブルクォーテーションのインラインコード
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
}
