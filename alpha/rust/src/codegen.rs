// alpha/rust/src/codegen.rs
use crate::ast::{AstNode, BlockKind};
use crate::runtime::SignValue;
use std::collections::HashMap;

#[derive(Clone, Debug)]
pub struct FuncSignature {
    pub arity: usize,
    pub args: Vec<String>,
}

#[derive(Clone, Debug, Default)]
pub struct SymbolTable {
    pub functions: HashMap<String, FuncSignature>,
}

pub fn build_symbol_table(ast: &[AstNode]) -> SymbolTable {
    let mut table = SymbolTable::default();
    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                register_definition(&mut table, identifier, definition);
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    register_definition(&mut table, identifier, definition);
                }
            }
            _ => {}
        }
    }
    table
}

fn register_definition(table: &mut SymbolTable, id: &str, def: &AstNode) {
    if let AstNode::Lambda { arguments, body: _body } = def {
        let args = collect_args(arguments);
        table.functions.insert(id.to_string(), FuncSignature {
            arity: args.len(),
            args,
        });
    } else if let Some((func_name, passed_args)) = extract_application(def) {
        if let Some(sig) = table.functions.get(&func_name) {
            let passed_count = passed_args.len();
            if passed_count < sig.arity {
                let missing_args = sig.args[passed_count..].to_vec();
                table.functions.insert(id.to_string(), FuncSignature {
                    arity: missing_args.len(),
                    args: missing_args,
                });
            }
        }
    } else if let AstNode::Identifier(ref_id) = def {
        if let Some(sig) = table.functions.get(ref_id) {
            table.functions.insert(id.to_string(), sig.clone());
        }
    }
}

pub fn transpile_program(ast: &[AstNode], layer: usize) -> Result<String, String> {
    let table = build_symbol_table(ast);
    let mut top_level_code = String::new();
    let mut main_statements = Vec::new();

    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                let def_code = transpile_definition(identifier, definition, layer, &table)?;
                top_level_code.push_str(&def_code);
                top_level_code.push_str("\n\n");
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    let def_code = transpile_definition(identifier, definition, layer, &table)?;
                    top_level_code.push_str("pub ");
                    top_level_code.push_str(&def_code);
                    top_level_code.push_str("\n\n");
                } else {
                    let expr_code = transpile_node(node, layer, true, &table)?;
                    main_statements.push(format!("    {};", expr_code));
                }
            }
            _ => {
                let expr_code = transpile_node(node, layer, true, &table)?;
                main_statements.push(format!("    {};", expr_code));
            }
        }
    }

    let mut output = top_level_code;
    output.push_str("fn main() {\n");
    if layer == 0 {
        output.push_str("    // Running in Layer 0 (Bare Metal)\n");
    } else {
        output.push_str("    // Running in Layer 2 (OS Std)\n");
    }
    output.push_str(&main_statements.join("\n"));
    output.push_str("\n}\n");

    Ok(output)
}

fn transpile_definition(id: &str, def: &AstNode, layer: usize, table: &SymbolTable) -> Result<String, String> {
    if let AstNode::Lambda { arguments, body } = def {
        let args = collect_args(arguments);
        let args_str = args.iter().map(|arg| format!("{}: f64", arg)).collect::<Vec<_>>().join(", ");
        let body_str = transpile_node(body, layer, false, table)?;
        Ok(format!("fn {}({}) -> f64 {{\n    {}\n}}", id, args_str, body_str))
    } else {
        let val_str = transpile_node(def, layer, false, table)?;
        let type_str = if val_str.starts_with("0x") || val_str.contains("usize") { "usize" } else { "f64" };
        
        if table.functions.contains_key(id) && !matches!(def, AstNode::Lambda { .. }) {
            let sig = table.functions.get(id).unwrap();
            let args_str = sig.args.iter().map(|arg| format!("{}: f64", arg)).collect::<Vec<_>>().join(", ");
            Ok(format!("fn {}({}) -> f64 {{\n    {}({})\n}}", id, args_str, val_str, sig.args.join(", ")))
        } else {
            Ok(format!("const {}: {} = {};", id, type_str, val_str))
        }
    }
}

fn collect_args(node: &AstNode) -> Vec<String> {
    match node {
        AstNode::Identifier(id) => vec![id.clone()],
        AstNode::Coproduct(list) => {
            let mut res = Vec::new();
            for item in list {
                res.extend(collect_args(item));
            }
            res
        }
        _ => Vec::new(),
    }
}

fn extract_application(node: &AstNode) -> Option<(String, Vec<AstNode>)> {
    match node {
        AstNode::Coproduct(list) => {
            if !list.is_empty() {
                if let AstNode::Identifier(func_name) = &list[0] {
                    return Some((func_name.clone(), list[1..].to_vec()));
                }
            }
        }
        AstNode::BinaryOperation { operator, left, right, name: _name } if operator == " " => {
            if let AstNode::Identifier(func_name) = &**left {
                let args = match &**right {
                    AstNode::Coproduct(list) => list.clone(),
                    _ => vec![*right.clone()],
                };
                return Some((func_name.clone(), args));
            }
        }
        _ => {}
    }
    None
}

fn transpile_node(node: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match node {
        AstNode::Atom(val) => {
            match val {
                SignValue::Scalar(f) => {
                    let mut s = f.to_string();
                    if !s.contains('.') && !s.contains('e') {
                        s.push_str(".0");
                    }
                    Ok(s)
                }
                SignValue::Char(c) => Ok(format!("'{}'", c)),
                SignValue::String(s) => Ok(format!("\"{}\"", s)),
                SignValue::Address(a) => Ok(format!("{:#x}", a)),
                SignValue::Unit => Ok("()".to_string()),
                _ => Ok("()".to_string()),
            }
        }
        AstNode::Identifier(id) => {
            if let Some(sig) = table.functions.get(id) {
                let missing = &sig.args;
                Ok(format!("(move |{}| {}({}))", missing.join(", "), id, missing.join(", ")))
            } else {
                Ok(id.clone())
            }
        }
        AstNode::InlineCode(code) => {
            Ok(code.clone())
        }
        AstNode::Coproduct(list) => {
            if list.is_empty() {
                return Ok("()".to_string());
            }
            
            if let Some((func_name, passed_args)) = extract_application(node) {
                if let Some(sig) = table.functions.get(&func_name) {
                    let passed_count = passed_args.len();
                    if passed_count < sig.arity {
                        let mut all_args = Vec::new();
                        for arg in &passed_args {
                            all_args.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        let missing_args = &sig.args[passed_count..];
                        for arg in missing_args {
                            all_args.push(arg.clone());
                        }
                        return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args.join(", ")));
                    } else {
                        let mut args_code = Vec::new();
                        for arg in &passed_args {
                            args_code.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        return Ok(format!("{}({})", func_name, args_code.join(", ")));
                    }
                }
            }

            let mut parts = Vec::new();
            for item in list {
                parts.push(transpile_node(item, layer, in_main, table)?);
            }
            Ok(format!("vec![{}]", parts.join(", ")))
        }
        AstNode::BinaryOperation { operator, left, right, name: _name } => {
            if operator == "#" {
                if layer == 0 {
                    let left_str = transpile_node(left, layer, in_main, table)?;
                    let right_str = transpile_node(right, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ core::ptr::write_volatile({} as *mut f64, {}) }}", left_str, right_str));
                } else {
                    let left_str = transpile_node(left, layer, in_main, table)?;
                    let right_str = transpile_node(right, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ *({} as *mut f64) = {} }}", left_str, right_str));
                }
            }

            if operator == " " {
                if let Some((func_name, passed_args)) = extract_application(node) {
                    if let Some(sig) = table.functions.get(&func_name) {
                        let passed_count = passed_args.len();
                        if passed_count < sig.arity {
                            let mut all_args = Vec::new();
                            for arg in &passed_args {
                                all_args.push(transpile_node(arg, layer, in_main, table)?);
                            }
                            let missing_args = &sig.args[passed_count..];
                            for arg in missing_args {
                                all_args.push(arg.clone());
                            }
                            return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args.join(", ")));
                        } else {
                            let mut args_code = Vec::new();
                            for arg in &passed_args {
                                args_code.push(transpile_node(arg, layer, in_main, table)?);
                            }
                            return Ok(format!("{}({})", func_name, args_code.join(", ")));
                        }
                    }
                }
            }

            let left_str = transpile_node(left, layer, in_main, table)?;
            let right_str = transpile_node(right, layer, in_main, table)?;
            
            match operator.as_str() {
                "+" => Ok(format!("({} + {})", left_str, right_str)),
                "-" => Ok(format!("({} - {})", left_str, right_str)),
                "*" => Ok(format!("({} * {})", left_str, right_str)),
                "/" => Ok(format!("({} / {})", left_str, right_str)),
                " " => {
                    Ok(format!("{} {}", left_str, right_str))
                }
                _ => Ok(format!("({} {} {})", left_str, operator, right_str)),
            }
        }
        AstNode::Prefix { operator, operand, name: _name } => {
            if operator == "@" {
                if layer == 0 {
                    let op_str = transpile_node(operand, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ core::ptr::read_volatile({} as *const f64) }}", op_str));
                } else {
                    let op_str = transpile_node(operand, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ *({} as *const f64) }}", op_str));
                }
            }

            if operator == "#" || operator == "##" {
                if layer == 0 {
                    return Err("Compile Error: Allocation (#/##) is not allowed in layer 0".to_string());
                }
                let op_str = transpile_node(operand, layer, in_main, table)?;
                let alloc_type = if operator == "#" { "Rc::new" } else { "Arc::new" };
                return Ok(format!("RefCell::new({}({}))", alloc_type, op_str));
            }

            let op_str = transpile_node(operand, layer, in_main, table)?;
            Ok(format!("{}{}", operator, op_str))
        }
        AstNode::Block { kind, content } => {
            let inner = transpile_node(content, layer, in_main, table)?;
            match kind {
                BlockKind::Paren => Ok(format!("({})", inner)),
                BlockKind::Bracket => Ok(format!("vec![{}]", inner)),
                BlockKind::Indent => {
                    let mut lines = Vec::new();
                    collect_lines(content, &mut lines, layer, in_main, table)?;
                    if lines.len() <= 1 {
                        Ok(inner)
                    } else {
                        let formatted_lines = lines.join(";\n    ");
                        Ok(format!("{{\n    {};\n}}", formatted_lines))
                    }
                }
                _ => Ok(inner),
            }
        }
        _ => Err(format!("Unsupported AST node: {:?}", node)),
    }
}

fn collect_lines(node: &AstNode, lines: &mut Vec<String>, layer: usize, in_main: bool, table: &SymbolTable) -> Result<(), String> {
    if let AstNode::BinaryOperation { operator, left, right, name: _name } = node {
        if operator == "\\n" {
            collect_lines(left, lines, layer, in_main, table)?;
            collect_lines(right, lines, layer, in_main, table)?;
            return Ok(());
        }
    }
    lines.push(transpile_node(node, layer, in_main, table)?);
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::lexer::preprocess;
    use crate::parser::sign_parser;

    #[test]
    fn test_transpile_math() {
        let code = "1 + 2 * 3";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("(1.0 + (2.0 * 3.0))"));
    }

    #[test]
    fn test_transpile_volatile_layer0() {
        let code = "@0x08000000";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 0).unwrap();
        assert!(out.contains("unsafe { core::ptr::read_volatile(0x8000000 as *const f64) }"));
    }

    #[test]
    fn test_transpile_alloc_layer0_error() {
        let code = "#10";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 0);
        assert!(out.is_err());
    }

    #[test]
    fn test_transpile_partial_application_one_arg() {
        let code = "add : x y ? x + y\nadd 10";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("(move |y| add(10.0, y))"));
    }

    #[test]
    fn test_transpile_partial_application_zero_args() {
        let code = "add : x y ? x + y\nmain_func : add";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("(move |x, y| add(x, y))"));
    }
}
