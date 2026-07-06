// alpha/rust/src/algebra_meta.rs

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum OperatorCategory {
    Algebra,    // 積側: T x T -> T (Unitは吸収元)
    Coalgebra,  // 余積側: T -> T x T または T + T -> T (Unitは単位元)
}

pub fn get_operator_category(op: &str) -> OperatorCategory {
    match op {
        "+" | "-" | "*" | "/" | "%" | "^" | "<<" | ">>" | "||" | ";;" | "&&" | "&" |
        "<" | ">" | "<=" | ">=" | "==" | "!=" | "!==" | "=" | "!" | "!!" | "'" => {
            OperatorCategory::Algebra
        }
        "|" | ";" | "~" | " " => {
            OperatorCategory::Coalgebra
        }
        _ => OperatorCategory::Algebra
    }
}
