use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
#[serde(untagged)]
pub enum SExpr {
    Atom(String),
    List(Vec<SExpr>),
}

impl SExpr {
    pub fn atom(s: impl Into<String>) -> Self {
        SExpr::Atom(s.into())
    }
    
    pub fn list(items: Vec<SExpr>) -> Self {
        SExpr::List(items)
    }
}

#[derive(Debug, Clone, PartialEq)]
pub enum Token<'a> {
    Number(&'a str),
    String(&'a str),
    Char(&'a str),
    Ident(&'a str),
    Unit,
    Prefix(&'a str),
    Infix(&'a str),
    Postfix(&'a str),
    Block(Vec<Token<'a>>),
}

pub fn precedence(op: &str) -> u8 {
    match op {
        "#" => 1, ":" => 2, "?" => 7, "," => 4, "~" => 8,
        "|" => 10, ";" => 10, "&" => 11,
        "<" | "<=" | "=" | ">=" | ">" | "!=" => 13,
        "+" | "-" => 14, "*" | "/" | "%" => 15, "^" => 16,
        "'" | "@" => 21, _ => 0,
    }
}

pub fn is_right_assoc(op: &str) -> bool {
    matches!(op, ":" | "," | "?" | "^" | "@")
}