use crate::ast::{AstNode, BlockKind};
use std::collections::{HashMap, HashSet};

/// Sign 言語 of Atom 内部型 (Type_System_ja-jp.md §2, Layer 2)
#[derive(Clone, Debug, PartialEq, Default)]
pub enum AtomType {
    Number,   // f64 数値
    String,   // Unicode スカラー値のリスト (Rust String)
    Char,     // 単一 Unicode スカラー値 (Rust char)
    List,     // 同一型の配列 (Rust Vec)
    Struct,   // 直積 (多相リスト)
    Unit,     // __
    Address,  // 暗黙アドレス ($expr の結果)
    Lambda,   // 関数 / クロージャ ($Lambda = アドレス)
    Register, // レジスタ（ビット値等）
    #[default]
    Unknown,  // 未解決 (Pass 1 で識別子参照の場合)
}

#[derive(Clone, Debug)]
pub struct FuncSignature {
    pub arity: usize,
    pub args: Vec<String>,
    pub body: Option<AstNode>,
    pub is_recursive: bool,
    pub rest_idx: Option<usize>,
    pub destructured_args: HashSet<String>,
    pub return_type: AtomType,  // 関数の戻り型 (Pass 1 で推論)
}

#[derive(Clone, Debug, Default)]
pub struct SymbolTable {
    pub functions: HashMap<String, FuncSignature>,
    pub global_allocs: HashSet<String>,
    pub objects: HashMap<String, Vec<(String, AtomType)>>,
    pub atom_types: HashMap<String, AtomType>,  // 識別子 → Atom 内部型
    pub list_arg_types: HashMap<String, String>, // 引数名 -> オブジェクト構造体名
}

/// ASTノードから Atom 内部型を静的に推論する (Pass 1)
/// 左辺優先ルール: 二項演算の型は左辺の型が決定する
pub fn infer_atom_type(node: &AstNode, table: &SymbolTable) -> AtomType {
    match node {
        AstNode::Scalar(_) => AtomType::Number,
        AstNode::String(_) => AtomType::String,
        AstNode::Char(_) => AtomType::Char,
        AstNode::Unit => AtomType::Unit,
        AstNode::Address(_) => AtomType::Address,
        AstNode::Register(_) => AtomType::Register,
        AstNode::Block { kind: BlockKind::Bracket, .. } => AtomType::List,
        AstNode::Coproduct(list) => {
            if !list.is_empty() {
                if let AstNode::Identifier(func_name) = &list[0] {
                    if let Some(sig) = table.functions.get(func_name) {
                        return sig.return_type.clone();
                    }
                }
            }
            AtomType::List
        }
        AstNode::Lambda { .. } => AtomType::Lambda,
        AstNode::Identifier(id) => {
            if table.functions.contains_key(id) {
                AtomType::Lambda
            } else {
                table.atom_types.get(id).cloned().unwrap_or(AtomType::Unknown)
            }
        }
        AstNode::BinaryOperation { operator, left, .. } => {
            // 左辺優先ルール: 演算結果の型は左辺の型
            match operator.as_str() {
                " " => {
                    if let AstNode::Identifier(func_name) = &**left {
                        if let Some(sig) = table.functions.get(func_name) {
                            return sig.return_type.clone();
                        }
                    }
                    let lt = infer_atom_type(left, table);
                    if lt == AtomType::Lambda {
                        lt
                    } else {
                        AtomType::List
                    }
                }
                "+" | "-" | "*" | "/" | "%" | "^" => infer_atom_type(left, table),
                "<" | "<=" | "=" | ">=" | ">" | "!=" | "==" => AtomType::Number, // Unit or Number
                "," => AtomType::Struct,
                "~" | "~+" | "~-" | "~*" | "~/" | "~^" => AtomType::List,
                "<<" | ">>" | "||" | ";;" | "&&" => {
                    let lt = infer_atom_type(left, table);
                    if lt == AtomType::Address || lt == AtomType::Register {
                        lt
                    } else {
                        AtomType::Register
                    }
                }
                _ => AtomType::Unknown,
            }
        }
        AstNode::Prefix { operator, operand, .. } => match operator.as_str() {
            "$" => AtomType::Address,
            "@" => infer_atom_type(operand, table), // deref: オペランドが指す型
            "!" | "!!" => {
                let ot = infer_atom_type(operand, table);
                if ot == AtomType::Address || ot == AtomType::Register {
                    ot
                } else {
                    AtomType::Register
                }
            }
            _ => AtomType::Unknown,
        },
        AstNode::Postfix { operator, operand, .. } => match operator.as_str() {
            "!" => AtomType::Number, // 階乗
            "~" => AtomType::List,  // 後置チルダ = リストのアドレス参照を展開
            _ => infer_atom_type(operand, table),
        },
        _ => AtomType::Unknown,
    }
}
