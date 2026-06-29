// alpha/rust/src/parser.rs
use crate::ast::{AstNode, BlockKind};
use crate::runtime::SignValue;

peg::parser!{
    pub grammar sign_parser() for str {
        rule whitespace() = [' ']*
        rule EOL() = "\r\n" / "\r" / "\n"
        rule comment() = "`" [^'\r' | '\n']*
        rule hex() = ['0'..='9' | 'a'..='f' | 'A'..='F']

        pub rule program() -> Vec<AstNode>
            = (EOL() / comment())* lines:(_line:line() (EOL() / comment())* { _line })* {
                lines
            }

        rule line() -> AstNode
            = whitespace() expr:expression() whitespace() { expr }

        pub rule expression() -> AstNode = export()

        rule export() -> AstNode
            = op:$("###" / "##" / "#") expr:export() {
                let name = match op {
                    "###" => "export_pin",
                    "##" => "export_external",
                    _ => "export_internal",
                };
                AstNode::Prefix {
                    operator: op.to_string(),
                    operand: Box::new(expr),
                    name: name.to_string(),
                }
            }
            / definition()

        rule definition() -> AstNode
            = left:lambda() whitespace() ":" whitespace() right:definition() {
                if let AstNode::Identifier(ref id) = left {
                    AstNode::Define {
                        identifier: id.clone(),
                        definition: Box::new(right),
                    }
                } else {
                    AstNode::BinaryOperation {
                        operator: ":".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "define".to_string(),
                    }
                }
            }
            / lambda()

        rule lambda() -> AstNode
            = left:output() whitespace() "?" whitespace() right:lambda() {
                AstNode::Lambda {
                    arguments: Box::new(left),
                    body: Box::new(right),
                }
            }
            / output()

        rule output() -> AstNode
            = left:logical_xor() whitespace() "#" whitespace() right:output() {
                AstNode::BinaryOperation {
                    operator: "#".to_string(),
                    left: Box::new(left),
                    right: Box::new(right),
                    name: "output".to_string(),
                }
            }
            / logical_xor()

        rule logical_xor() -> AstNode
            = head:logical_or() tail:(whitespace() ";" whitespace() right:logical_or() { right })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: ";".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "xor".to_string(),
                    }
                })
            }

        rule logical_or() -> AstNode
            = head:logical_and() tail:(whitespace() op:$("|/" / "|") whitespace() right:logical_and() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = if op == "|/" { "div_or" } else { "or" };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule logical_and() -> AstNode
            = head:equal() tail:(whitespace() "&" whitespace() right:equal() { right })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: "&".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "and".to_string(),
                    }
                })
            }

        rule equal() -> AstNode
            = head:product() tail:(whitespace() op:$("==" / "!==") whitespace() right:product() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = if op == "==" { "equal" } else { "not_equal" };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule product() -> AstNode
            = left:coproduct() whitespace() "," whitespace() right:product() {
                AstNode::BinaryOperation {
                    operator: ",".to_string(),
                    left: Box::new(left),
                    right: Box::new(right),
                    name: "product".to_string(),
                }
            }
            / coproduct()

        rule coproduct() -> AstNode
            = head:range() tail:(" "+ right:range() { right })+ {
                let mut elems = vec![head];
                elems.extend(tail);
                AstNode::Coproduct(elems)
            }
            / range()

        rule range() -> AstNode
            = head:comparison() tail:(whitespace() op:$("~+" / "~-" / "~*" / "~/" / "~^" / "~") whitespace() right:comparison() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = match op {
                        "~+" => "range_arithmetic",
                        "~-" => "range_arithmetic_rev",
                        "~*" => "range_geometric",
                        "~/" => "range_geometric_rev",
                        "~^" => "range_power",
                        _ => "range",
                    };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule comparison() -> AstNode
            = head:additive() tail:(whitespace() op:$("<=" / ">=" / "==" / "!=" / "<" / "=" / ">") whitespace() right:additive() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = match op {
                        "<" => "less",
                        "<=" => "less_equal",
                        "=" => "assign_equal",
                        ">=" => "more_equal",
                        ">" => "more",
                        "!=" => "not_equal",
                        _ => "equal",
                    };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule additive() -> AstNode
            = head:multiplicative() tail:(whitespace() op:$("+" / "-") whitespace() right:multiplicative() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = if op == "+" { "add" } else { "sub" };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule multiplicative() -> AstNode
            = head:exponential() tail:(whitespace() op:$("*" / "/" / "%") whitespace() right:exponential() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name_str = match op {
                        "*" => "mul",
                        "/" => "div",
                        _ => "mod",
                    };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name_str.to_string(),
                    }
                })
            }

        rule exponential() -> AstNode
            = head:get_prop() tail:(whitespace() "^" whitespace() right:exponential() { right })? {
                if let Some(right) = tail {
                    AstNode::BinaryOperation {
                        operator: "^".to_string(),
                        left: Box::new(head),
                        right: Box::new(right),
                        name: "pow".to_string(),
                    }
                } else {
                    head
                }
            }

        rule get_prop() -> AstNode
            = head:bitwise_shift() tail:(whitespace() op:$("'" / "@") whitespace() right:bitwise_shift() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = if op == "'" { "get_prop" } else { "get_at" };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule bitwise_shift() -> AstNode
            = head:bitwise_or() tail:(whitespace() op:$("<<" / ">>") whitespace() right:bitwise_or() { (op, right) })* {
                tail.into_iter().fold(head, |left, (op, right)| {
                    let name = if op == "<<" { "bit_shift_left" } else { "bit_shift_right" };
                    AstNode::BinaryOperation {
                        operator: op.to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: name.to_string(),
                    }
                })
            }

        rule bitwise_or() -> AstNode
            = head:bitwise_xor() tail:(whitespace() "||" whitespace() right:bitwise_xor() { right })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: "||".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "bit_or".to_string(),
                    }
                })
            }

        rule bitwise_xor() -> AstNode
            = head:bitwise_and() tail:(whitespace() ";;" whitespace() right:bitwise_and() { right })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: ";;".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "bit_xor".to_string(),
                    }
                })
            }

        rule bitwise_and() -> AstNode
            = head:postfix() tail:(whitespace() "&&" whitespace() right:postfix() { right })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: "&&".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "bit_and".to_string(),
                    }
                })
            }

        rule postfix() -> AstNode
            = head:prefix() ops:postfix_op()* {
                ops.into_iter().fold(head, |result, op| {
                    let name = match op.as_str() {
                        "!" => "factorial",
                        "~" => "expand",
                        _ => "import",
                    };
                    AstNode::Postfix {
                        operator: op,
                        operand: Box::new(result),
                        name: name.to_string(),
                    }
                })
            }

        rule postfix_op() -> String
            = op:$("!" / "~" / "@") { op.to_string() }

        rule prefix() -> AstNode
            = op:prefix_op() expr:prefix() {
                let name = match op.as_str() {
                    "~" => "continuous",
                    "!" => "not",
                    "$" => "address",
                    "@" => "input",
                    "!!" => "bit_not",
                    "-" => "negate",
                    _ => "reverse",
                };
                AstNode::Prefix {
                    operator: op,
                    operand: Box::new(expr),
                    name: name.to_string(),
                }
            }
            / primary()

        rule prefix_op() -> String
            = op:$("><" / "~" / "!!" / "!" / "$" / "@" / "-") { op.to_string() }

        rule primary() -> AstNode
            = block()
            / atom()

        rule block() -> AstNode
            = "(" whitespace() contents:block_contents_opt() whitespace() ")" {
                AstNode::Block { kind: BlockKind::Paren, content: Box::new(contents) }
            }
            / "[" whitespace() contents:block_contents_opt() whitespace() "]" {
                AstNode::Block { kind: BlockKind::Bracket, content: Box::new(contents) }
            }
            / "{" whitespace() contents:block_contents_opt() whitespace() "}" {
                AstNode::Block { kind: BlockKind::Brace, content: Box::new(contents) }
            }
            / "|" whitespace() expr:expression() whitespace() "|" {
                AstNode::Block { kind: BlockKind::Abs, content: Box::new(expr) }
            }
            / "\x02" whitespace() contents:block_contents() whitespace() "\x03" {
                AstNode::Block { kind: BlockKind::Indent, content: Box::new(contents) }
            }

        rule block_contents() -> AstNode
            = head:expression() tail:(whitespace() EOL() whitespace() expr:expression() { expr })* {
                tail.into_iter().fold(head, |left, right| {
                    AstNode::BinaryOperation {
                        operator: "\\n".to_string(),
                        left: Box::new(left),
                        right: Box::new(right),
                        name: "newline".to_string(),
                    }
                })
            }

        rule block_contents_opt() -> AstNode
            = contents:block_contents() { contents }
            / { AstNode::Atom(SignValue::Unit) }

        rule atom() -> AstNode
            = val:string_literal() { AstNode::Atom(SignValue::String(val)) }
            / val:inline_code() { AstNode::InlineCode(val) }
            / val:char_literal() { AstNode::Atom(SignValue::Char(val)) }
            / val:address_literal() { AstNode::Atom(SignValue::Address(val)) }
            / val:number_literal() { AstNode::Atom(SignValue::Scalar(val)) }
            / val:identifier_literal() { AstNode::Identifier(val) }
            / "__" { AstNode::Atom(SignValue::Unit) }
            / "_" { AstNode::Atom(SignValue::Hole) }

        rule string_literal() -> String
            = "`" s:[^'`']* "`" { s.into_iter().collect() }

        rule inline_code() -> String
            = "\"" s:inline_char()* "\"" { s.into_iter().collect() }

        rule inline_char() -> char
            = "\\" c:[_] { c }
            / [^'"']

        rule char_literal() -> char
            = "\\" c:[_] { c }

        rule address_literal() -> usize
            = "0x" h:$(hex()+) { usize::from_str_radix(h, 16).unwrap() }

        rule number_literal() -> f64
            = n:$("-"? ['0'..='9']+ ("." ['0'..='9']*)?) { n.parse().unwrap() }

        rule identifier_literal() -> String
            = id:$(['a'..='z' | 'A'..='Z'] ['a'..='z' | 'A'..='Z' | '0'..='9' | '_']*) { id.to_string() }
            / id:$("_" ['a'..='z' | 'A'..='Z' | '0'..='9' | '_']+) { id.to_string() }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::lexer::preprocess;

    #[test]
    fn test_parse_simple() {
        let code = "1 + 2 * 3";
        let pre = preprocess(code);
        let res = sign_parser::expression(&pre);
        assert!(res.is_ok());
        let node = res.unwrap();
        if let AstNode::BinaryOperation { ref operator, .. } = node {
            assert_eq!(operator, "+");
        } else {
            panic!("Expected BinaryOperation");
        }
    }

    #[test]
    fn test_parse_list() {
        let code = "[1 2 , 3 4]";
        let pre = preprocess(code);
        let res = sign_parser::expression(&pre);
        assert!(res.is_ok());
    }
}
