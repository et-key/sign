// alpha/rust/src/codegen.rs
use crate::ast::{AstNode, BlockKind, PointFreeKind};
use std::collections::{HashMap, HashSet};

#[derive(Clone, Debug)]
pub struct FuncSignature {
    pub arity: usize,
    pub args: Vec<String>,
    pub body: Option<AstNode>,
    pub is_recursive: bool,
    pub rest_idx: Option<usize>,
}

#[derive(Clone, Debug, Default)]
pub struct SymbolTable {
    pub functions: HashMap<String, FuncSignature>,
    pub global_allocs: HashSet<String>,
}

pub fn build_symbol_table(ast: &[AstNode]) -> SymbolTable {
    let mut table = SymbolTable::default();
    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                register_definition(&mut table, identifier, definition);
                if let AstNode::Prefix { operator, .. } = &**definition {
                    if operator == "#" || operator == "##" || operator == "###" {
                        table.global_allocs.insert(identifier.clone());
                    }
                }
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    register_definition(&mut table, identifier, definition);
                    table.global_allocs.insert(identifier.clone());
                }
            }
            _ => {}
        }
    }
    table
}

fn collect_arg_nodes(node: &AstNode, res: &mut Vec<AstNode>) {
    match node {
        AstNode::Coproduct(list) => {
            for item in list {
                collect_arg_nodes(item, res);
            }
        }
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "~" => {
            collect_arg_nodes(left, res);
            if let AstNode::Identifier(id) = &**right {
                res.push(AstNode::Prefix {
                    operator: "~".to_string(),
                    operand: Box::new(AstNode::Identifier(id.clone())),
                    name: "continuous".to_string(),
                });
            } else {
                collect_arg_nodes(right, res);
            }
        }
        _ => {
            res.push(node.clone());
        }
    }
}

fn find_rest_idx(arguments: &AstNode) -> Option<usize> {
    let mut nodes = Vec::new();
    collect_arg_nodes(arguments, &mut nodes);
    for (i, node) in nodes.iter().enumerate() {
        if let AstNode::Prefix { operator, .. } = node {
            if operator == "~" {
                return Some(i);
            }
        }
    }
    None
}

fn register_definition(table: &mut SymbolTable, id: &str, def: &AstNode) {
    if let AstNode::Lambda { arguments, body } = def {
        let args = collect_args(arguments);
        let is_rec = contains_identifier(body, id);
        let rest_idx = find_rest_idx(arguments);
        table.functions.insert(id.to_string(), FuncSignature {
            arity: args.len(),
            args,
            body: Some(*body.clone()),
            is_recursive: is_rec,
            rest_idx,
        });
    } else if let Some((func_name, passed_args)) = extract_application(def) {
        if let Some(sig) = table.functions.get(&func_name) {
            let passed_count = passed_args.len();
            if passed_count < sig.arity {
                let missing_args = sig.args[passed_count..].to_vec();
                let new_rest_idx = sig.rest_idx.and_then(|r_idx| {
                    if r_idx >= passed_count {
                        Some(r_idx - passed_count)
                    } else {
                        None
                    }
                });
                table.functions.insert(id.to_string(), FuncSignature {
                    arity: missing_args.len(),
                    args: missing_args,
                    body: None,
                    is_recursive: false,
                    rest_idx: new_rest_idx,
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
    
    if layer == 2 {
        top_level_code.push_str("#![allow(unused_parens)]\n#![allow(unused_variables)]\n#![allow(non_upper_case_globals)]\n\n");
    }
    
    let mut main_statements = Vec::new();
    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                if let AstNode::Lambda { .. } = &**definition {
                    if let Some(sig) = table.functions.get(identifier) {
                        if !is_high_order_function(sig) {
                            let def_code = transpile_definition(identifier, definition, layer, &table)?;
                            top_level_code.push_str(&def_code);
                            top_level_code.push_str("\n\n");
                        }
                    }
                } else if let AstNode::PointFree(_) = &**definition {
                    let def_code = transpile_definition(identifier, definition, layer, &table)?;
                    top_level_code.push_str(&def_code);
                    top_level_code.push_str("\n\n");
                } else {
                    let val_str = transpile_node(definition, layer, true, &table)?;
                    if table.global_allocs.contains(identifier) {
                        let inner_type = if val_str.contains("vec!") { "Vec<f64>" } else { "f64" };
                        let thread_local_decl = format!(
                            "thread_local! {{\n    static {}: std::cell::OnceCell<std::rc::Rc<std::cell::RefCell<{}>>> = std::cell::OnceCell::new();\n}}\n\n",
                            identifier, inner_type
                        );
                        top_level_code.push_str(&thread_local_decl);
                        main_statements.push(format!("    {}.with(|cell| cell.set({}).unwrap());", identifier, val_str));
                    } else {
                        main_statements.push(format!("    let {} = {};", identifier, val_str));
                    }
                }
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    if let AstNode::Lambda { .. } = &**definition {
                        if let Some(sig) = table.functions.get(identifier) {
                            if !is_high_order_function(sig) {
                                let def_code = transpile_definition(identifier, definition, layer, &table)?;
                                top_level_code.push_str("pub ");
                                top_level_code.push_str(&def_code);
                                top_level_code.push_str("\n\n");
                            }
                        }
                    } else if let AstNode::PointFree(_) = &**definition {
                        let def_code = transpile_definition(identifier, definition, layer, &table)?;
                        top_level_code.push_str("pub ");
                        top_level_code.push_str(&def_code);
                        top_level_code.push_str("\n\n");
                    } else {
                        let val_str = transpile_node(definition, layer, true, &table)?;
                        if table.global_allocs.contains(identifier) {
                            let inner_type = if val_str.contains("vec!") { "Vec<f64>" } else { "f64" };
                            let thread_local_decl = format!(
                                "thread_local! {{\n    pub static {}: std::cell::OnceCell<std::rc::Rc<std::cell::RefCell<{}>>> = std::cell::OnceCell::new();\n}}\n\n",
                                identifier, inner_type
                            );
                            top_level_code.push_str(&thread_local_decl);
                            main_statements.push(format!("    {}.with(|cell| cell.set({}).unwrap());", identifier, val_str));
                        } else {
                            main_statements.push(format!("    pub let {} = {};", identifier, val_str));
                        }
                    }
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
        let sig = table.functions.get(id);
        let args_str = args.iter().enumerate().map(|(i, arg)| {
            if let Some(s) = sig {
                if s.rest_idx == Some(i) {
                    return format!("{}: Vec<f64>", arg);
                }
            }
            format!("{}: f64", arg)
        }).collect::<Vec<_>>().join(", ");
        let body_str = transpile_node(body, layer, false, table)?;
        let ret_type = if sig.map(|s| s.is_recursive).unwrap_or(false) {
            "f64"
        } else if body_str.contains("vec!") || body_str.contains("Vec<") {
            "Vec<f64>"
        } else if body_str.contains("Some") || body_str.contains("None") {
            "Option<f64>"
        } else {
            "f64"
        };
        Ok(format!("fn {}({}) -> {} {{\n    {}\n}}", id, args_str, ret_type, body_str))
    } else {
        let val_str = transpile_node(def, layer, false, table)?;
        
        // ポイントフリーノードが直接代入されている場合の特別ラッパー
        if let AstNode::PointFree(kind) = def {
            match kind {
                PointFreeKind::BinaryOp(_) | PointFreeKind::BinaryOpMap(_, _) => {
                    return Ok(format!("// Point-free wrapper\nfn {}(xs: Vec<f64>) -> Vec<f64> {{\n    ({}) (xs)\n}}", id, val_str));
                }
                _ => {
                    return Ok(format!("// Point-free wrapper\nfn {}(x: f64) -> f64 {{\n    ({}) (x)\n}}", id, val_str));
                }
            }
        }

        let type_str = if val_str.starts_with("0x") || val_str.contains("usize") {
            "usize"
        } else if val_str.contains("Some") || val_str.contains("None") || val_str.contains("match") {
            "Option<f64>"
        } else if val_str.contains("vec!") {
            "Vec<f64>"
        } else {
            "f64"
        };
        
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
        AstNode::Prefix { operator, operand, .. } if operator == "~" => collect_args(operand),
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "~" => {
            let mut res = collect_args(left);
            res.extend(collect_args(right));
            res
        }
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

// match_case および 三項演算の統一解決用構造体
struct MatchArm {
    condition: Option<AstNode>,
    body: AstNode,
}

fn is_match_case_block(node: &AstNode) -> bool {
    match node {
        AstNode::Block { kind: BlockKind::Indent, content } => {
            let mut lines = Vec::new();
            collect_lines_raw(content, &mut lines);
            lines.iter().any(|line| is_case_line(line))
        }
        _ => false,
    }
}

fn collect_lines_raw(node: &AstNode, lines: &mut Vec<AstNode>) {
    if let AstNode::BinaryOperation { operator, left, right, name: _name } = node {
        if operator == "\\n" {
            collect_lines_raw(left, lines);
            collect_lines_raw(right, lines);
            return;
        }
    }
    lines.push(node.clone());
}

fn is_case_line(node: &AstNode) -> bool {
    match node {
        AstNode::Define { .. } => true,
        AstNode::BinaryOperation { operator, .. } if operator == ":" => true,
        _ => false,
    }
}

fn transpile_match_arms(arms: &[MatchArm], layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if arms.is_empty() {
        return Ok("None".to_string());
    }

    let mut parts = Vec::new();
    for (i, arm) in arms.iter().enumerate() {
        let body_str = transpile_node(&arm.body, layer, in_main, table)?;
        let formatted_body = if body_str.contains("Some") || body_str.contains("None") || body_str.contains("match") || body_str.contains("if ") {
            body_str
        } else {
            format!("Some({})", body_str)
        };

        if let Some(cond) = &arm.condition {
            let cond_str = transpile_node(cond, layer, in_main, table)?;
            let prefix = if i == 0 { "if" } else { "else if" };
            parts.push(format!("{} {}.is_some() {{\n        {}\n    }}", prefix, cond_str, formatted_body));
        } else {
            if i == 0 {
                return Ok(formatted_body);
            }
            parts.push(format!("else {{\n        {}\n    }}", formatted_body));
        }
    }

    if arms.last().unwrap().condition.is_some() {
        parts.push("else {\n        None\n    }".to_string());
    }

    Ok(format!("(\n    {}\n)", parts.join(" ")))
}

// ----------------------------------------------------
// Coproduct Resolver (余積解決器) 実装
// ----------------------------------------------------

#[derive(Clone, Copy, Debug, PartialEq)]
enum TypeCategory {
    Lambda,
    Atom,
}

fn get_category(node: &AstNode, table: &SymbolTable) -> TypeCategory {
    match node {
        AstNode::Block { kind: BlockKind::Paren, content } => get_category(content, table),
        AstNode::Coproduct(list) => {
            let flat_items = {
                let mut flat = Vec::new();
                for item in list {
                    collect_coproduct_items(item, &mut flat);
                }
                flat
            };
            if let Ok(reduced) = resolve_coproduct(&flat_items, table) {
                if !matches!(reduced, AstNode::Coproduct(_)) {
                    return get_category(&reduced, table);
                }
            }
            TypeCategory::Atom
        }
        AstNode::Lambda { .. } => TypeCategory::Lambda,
        AstNode::PointFree(_) => TypeCategory::Lambda,
        AstNode::Identifier(id) => {
            if table.functions.contains_key(id) {
                TypeCategory::Lambda
            } else if id == "print" || id == "println" {
                TypeCategory::Lambda
            } else {
                TypeCategory::Atom
            }
        }
        AstNode::Prefix { operator, operand, .. } if operator == "@" => {
            if let AstNode::Prefix { operator: inner_op, operand: inner_operand, .. } = &**operand {
                if inner_op == "$" {
                    return get_category(inner_operand, table);
                }
            }
            TypeCategory::Lambda
        }
        AstNode::Prefix { operator, .. } if operator == "$" => TypeCategory::Atom,
        AstNode::BinaryOperation { operator, name, .. } if operator == " " && name == "resolved" => {
            let mut applied_args = Vec::new();
            if let Some(func_name) = extract_applied_func_and_args(node, &mut applied_args) {
                if let Some(sig) = table.functions.get(&func_name) {
                    if applied_args.len() < sig.arity {
                        return TypeCategory::Lambda;
                    }
                }
            }
            TypeCategory::Atom
        }
        _ => TypeCategory::Atom,
    }
}

fn get_reduction_priority(left: TypeCategory, right: TypeCategory) -> usize {
    match (left, right) {
        (TypeCategory::Atom, TypeCategory::Atom) => 3,     // 10.3: concat (リスト連接)
        (TypeCategory::Lambda, TypeCategory::Lambda) => 2, // 10.2: compose (関数合成)
        (TypeCategory::Lambda, TypeCategory::Atom) => 1,   // 10.1: apply (関数適用)
        (TypeCategory::Atom, TypeCategory::Lambda) => 0,   // 10.0: apply_reverse (逆適用)
    }
}

fn collect_coproduct_items(node: &AstNode, items: &mut Vec<AstNode>) {
    match node {
        AstNode::Coproduct(list) => {
            for item in list {
                collect_coproduct_items(item, items);
            }
        }
        AstNode::BinaryOperation { operator, left, right, name } if (operator == " " && name != "resolved") || operator == "," => {
            collect_coproduct_items(left, items);
            collect_coproduct_items(right, items);
        }
        _ => {
            items.push(node.clone());
        }
    }
}

fn resolve_coproduct(list: &[AstNode], table: &SymbolTable) -> Result<AstNode, String> {
    if list.is_empty() {
        return Ok(AstNode::Unit);
    }
    let mut items = list.to_vec();

    // 優先度 3 (concat) から 0 (apply_reverse) へ
    for priority in (0..=3).rev() {
        let mut i = 0;
        while i < items.len().saturating_sub(1) {
            let cat_l = get_category(&items[i], table);
            let cat_r = get_category(&items[i + 1], table);
            let p = get_reduction_priority(cat_l, cat_r);
            if p == priority {
                let left = items.remove(i);
                let right = items.remove(i);
                
                let reduced = match priority {
                    3 => {
                        AstNode::BinaryOperation {
                            operator: ",".to_string(),
                            left: Box::new(left),
                            right: Box::new(right),
                            name: "concat".to_string(),
                        }
                    }
                    2 => {
                        // compose (左結合な関数合成): x ? RHS(LHS(x))
                        let x_id = AstNode::Identifier("comp_arg".to_string());
                        let apply_left = AstNode::BinaryOperation {
                            operator: " ".to_string(),
                            left: Box::new(left),
                            right: Box::new(x_id.clone()),
                            name: "resolved".to_string(),
                        };
                        let apply_right = AstNode::BinaryOperation {
                            operator: " ".to_string(),
                            left: Box::new(right),
                            right: Box::new(apply_left),
                            name: "resolved".to_string(),
                        };
                        AstNode::Lambda {
                            arguments: Box::new(x_id),
                            body: Box::new(apply_right),
                        }
                    }
                    1 => {
                        AstNode::BinaryOperation {
                            operator: " ".to_string(),
                            left: Box::new(left),
                            right: Box::new(right),
                            name: "resolved".to_string(),
                        }
                    }
                    0 => {
                        AstNode::BinaryOperation {
                            operator: " ".to_string(),
                            left: Box::new(right),
                            right: Box::new(left),
                            name: "resolved".to_string(),
                        }
                    }
                    _ => unreachable!(),
                };
                items.insert(i, reduced);
                i = 0;
                continue;
            }
            i += 1;
        }
    }

    if items.len() == 1 {
        Ok(items.remove(0))
    } else {
        Err("Failed to resolve coproduct to a single node".to_string())
    }
}

// 解決済み二分木から、適用関数名と適用済み引数リストを再帰的に抽出するヘルパー
fn extract_applied_func_and_args(node: &AstNode, args: &mut Vec<AstNode>) -> Option<String> {
    match node {
        AstNode::Identifier(id) => Some(id.clone()),
        AstNode::Block { kind: BlockKind::Paren, content } => extract_applied_func_and_args(content, args),
        AstNode::BinaryOperation { operator, left, right, name } if operator == " " && name == "resolved" => {
            let func_name = extract_applied_func_and_args(left, args)?;
            args.push(*right.clone());
            Some(func_name)
        }
        _ => None,
    }
}

// ----------------------------------------------------

pub fn transpile_node(node: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match node {
        AstNode::Scalar(f) => {
            let mut s = f.to_string();
            if !s.contains('.') && !s.contains('e') {
                s.push_str(".0");
            }
            Ok(s)
        }
        AstNode::Char(c) => Ok(format!("'{}'", c)),
        AstNode::String(s) => Ok(format!("\"{}\"", s)),
        AstNode::Address(a) => Ok(format!("{:#x}", a)),
        AstNode::Unit => Ok("None".to_string()),
        AstNode::Hole => Ok("None".to_string()),
        AstNode::Identifier(id) => transpile_identifier(id, table),
        AstNode::InlineCode(code) => transpile_inline_code(code, layer, in_main, table),
        AstNode::Coproduct(list) => transpile_coproduct(node, list, layer, in_main, table),
        AstNode::BinaryOperation { operator, left, right, name } => {
            transpile_binary_op(operator, left, right, name, layer, in_main, table)
        }
        AstNode::Prefix { operator, operand, .. } => {
            transpile_prefix_op(operator, operand, layer, in_main, table)
        }
        AstNode::Block { kind, content } => {
            transpile_block(node, kind, content, layer, in_main, table)
        }
        AstNode::Lambda { arguments, body } => {
            transpile_lambda(arguments, body, layer, in_main, table)
        }
        AstNode::PointFree(kind) => transpile_point_free(kind, layer, in_main, table),
        AstNode::Postfix { operator, operand, .. } => {
            transpile_postfix_op(operator, operand, layer, in_main, table)
        }
        _ => Err(format!("Unsupported AST node: {:?}", node)),
    }
}

fn transpile_identifier(id: &str, table: &SymbolTable) -> Result<String, String> {
    if let Some(sig) = table.functions.get(id) {
        let missing = &sig.args;
        Ok(format!("(move |{}| {}({}))", missing.join(", "), id, missing.join(", ")))
    } else if id == "env" || id == "args" {
        Ok("None".to_string())
    } else {
        Ok(id.to_string())
    }
}

fn transpile_coproduct(_node: &AstNode, list: &[AstNode], layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if list.is_empty() {
        return Ok("()".to_string());
    }

    // 先頭要素が PointFree の場合は、Coproduct Resolver をバイパスし、
    // 従来のポイントフリー静的展開ルールを適用する
    if let AstNode::PointFree(pf_kind) = &list[0] {
        match pf_kind {
            PointFreeKind::BinaryOp(op) => {
                let mut parts = Vec::new();
                for item in &list[1..] {
                    parts.push(transpile_node(item, layer, in_main, table)?);
                }
                return Ok(format!("({})", parts.join(&format!(" {} ", op))));
            }
            PointFreeKind::BinaryOpMap(op, right_node) => {
                let right_str = transpile_node(right_node, layer, in_main, table)?;
                let mut parts = Vec::new();
                for item in &list[1..] {
                    let item_str = transpile_node(item, layer, in_main, table)?;
                    parts.push(format!("({} {} {})", item_str, op, right_str));
                }
                return Ok(format!("vec![{}]", parts.join(", ")));
            }
            PointFreeKind::PrefixOp(op) => {
                if list.len() >= 2 {
                    let operand_str = transpile_node(&list[1], layer, in_main, table)?;
                    return Ok(format!("({}{})", op, operand_str));
                }
            }
            PointFreeKind::PostfixOp(op) => {
                if list.len() >= 2 {
                    let operand_str = transpile_node(&list[1], layer, in_main, table)?;
                    return Ok(format!("({}{})", operand_str, op));
                }
            }
        }
    }

    // それ以外は Coproduct Resolver にかけて単一ノードに縮約
    let mut flat_items = Vec::new();
    for item in list {
        collect_coproduct_items(item, &mut flat_items);
    }
    
    let has_lambda = flat_items.iter().any(|item| get_category(item, table) == TypeCategory::Lambda);
    if !has_lambda {
        let mut parts = Vec::new();
        for item in &flat_items {
            parts.push(transpile_node(item, layer, in_main, table)?);
        }
        return Ok(format!("vec![{}]", parts.join(", ")));
    }
    
    let reduced = resolve_coproduct(&flat_items, table)?;
    if !matches!(reduced, AstNode::Coproduct(_)) {
        return transpile_node(&reduced, layer, in_main, table);
    }
    
    let mut parts = Vec::new();
    for item in list {
        parts.push(transpile_node(item, layer, in_main, table)?);
    }
    Ok(format!("vec![{}]", parts.join(", ")))
}

fn transpile_binary_op(operator: &str, left: &AstNode, right: &AstNode, name: &str, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if operator == "#" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        if layer == 0 {
            return Ok(format!("unsafe {{ core::ptr::write_volatile({} as *mut f64, {}) }}", left_str, right_str));
        } else {
            if let AstNode::Identifier(id) = left {
                if table.global_allocs.contains(id) {
                    return Ok(format!("{}.with(|cell| *cell.get().unwrap().borrow_mut() = {})", id, right_str));
                }
            }
            return Ok(format!("unsafe {{ *({} as *mut f64) = {} }}", left_str, right_str));
        }
    }

    if operator == ":" {
        if let AstNode::Lambda { arguments: cond, body: then } = left {
            let arms = vec![
                MatchArm { condition: Some(*cond.clone()), body: *then.clone() },
                MatchArm { condition: None, body: right.clone() },
            ];
            return transpile_match_arms(&arms, layer, in_main, table);
        }
    }

    if ["<", ">", "<=", ">=", "==", "!="].contains(&operator) {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        return Ok(format!("match {} {} {} {{ true => Some(1.0), false => None }}", left_str, operator, right_str));
    }

    if operator == "&" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        return Ok(format!("{}.and({})", left_str, right_str));
    }

    if operator == "|" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        return Ok(format!("{}.or_else(|| {})", left_str, right_str));
    }

    // 中置スペースによる適用/合成の解決
    if operator == " " {
        if name == "resolved" {
            // 関数名と、これまでに適用された全引数リストを抽出
            let mut applied_args = Vec::new();
            if let Some(func_name) = extract_applied_func_and_args(left, &mut applied_args) {
                collect_coproduct_items(right, &mut applied_args);
                
                if let Some(sig) = table.functions.get(&func_name) {
                    // スプレッド展開があるかチェックし、あれば静的脱糖する
                    let mut has_spread = false;
                    let mut spread_var = String::new();
                    let mut spread_idx = 0;
                    for (i, arg) in applied_args.iter().enumerate() {
                        if let AstNode::Postfix { operator, operand, .. } = arg {
                            if operator == "~" {
                                has_spread = true;
                                spread_var = transpile_node(operand, layer, in_main, table)?;
                                spread_idx = i;
                                break;
                            }
                        }
                    }
                    
                    if has_spread {
                        if sig.arity == 2 && sig.rest_idx == Some(1) {
                            let mut final_args = Vec::new();
                            for i in 0..spread_idx {
                                final_args.push(transpile_node(&applied_args[i], layer, in_main, table)?);
                            }
                            if spread_idx == 1 {
                                final_args.push(spread_var.clone());
                            } else {
                                final_args.push(format!("{}[0]", spread_var));
                                final_args.push(format!("{}[1..].to_vec()", spread_var));
                            }
                            let call_code = format!(
                                "if {}.is_empty() {{ 0.0 }} else {{ {}({}) }}",
                                spread_var, func_name, final_args.join(", ")
                            );
                            return Ok(call_code);
                        }
                    }
                    
                    // Rest 引数パッケージング処理
                    let mut applied_args = applied_args;
                    if let Some(r_idx) = sig.rest_idx {
                        if applied_args.len() >= r_idx {
                            let rest_args = applied_args.split_off(r_idx);
                            let pkg_node = AstNode::Coproduct(rest_args);
                            applied_args.push(pkg_node);
                        }
                    }

                    let passed_count = applied_args.len();
                    if passed_count < sig.arity {
                        // 部分適用！ クロージャ (move |y| func(passed, y)) を出力
                        let mut all_args_code = Vec::new();
                        for arg in &applied_args {
                            all_args_code.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        let missing_args = &sig.args[passed_count..];
                        for arg in missing_args {
                            all_args_code.push(arg.clone());
                        }
                        return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args_code.join(", ")));
                    } else {
                        // 完全適用！
                        if !sig.is_recursive {
                            if let Some(body_ast) = &sig.body {
                                let mut mapping = HashMap::new();
                                for (i, arg_name) in sig.args.iter().enumerate() {
                                    mapping.insert(arg_name.clone(), applied_args[i].clone());
                                }
                                let substituted = substitute_args(body_ast, &mapping);
                                return transpile_node(&substituted, layer, in_main, table);
                            }
                        }
                        // 再帰関数の場合は通常の関数呼び出し func(args...)
                        let mut args_code = Vec::new();
                        for arg in &applied_args {
                            args_code.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        return Ok(format!("{}({})", func_name, args_code.join(", ")));
                    }
                }
            }

            // フォールバック：通常の適用
            let left_str = transpile_node(left, layer, in_main, table)?;
            let right_str = transpile_node(right, layer, in_main, table)?;
            return Ok(format!("{}({})", left_str, right_str));
        }

        let mut flat_items = Vec::new();
        collect_coproduct_items(left, &mut flat_items);
        collect_coproduct_items(right, &mut flat_items);
        
        let reduced = resolve_coproduct(&flat_items, table)?;
        return transpile_node(&reduced, layer, in_main, table);
    }

    let left_str = transpile_node(left, layer, in_main, table)?;
    let right_str = transpile_node(right, layer, in_main, table)?;
    
    

    match operator {
        "+" => Ok(format!("({} + {})", left_str, right_str)),
        "-" => Ok(format!("({} - {})", left_str, right_str)),
        "*" => Ok(format!("({} * {})", left_str, right_str)),
        "/" => Ok(format!("({} / {})", left_str, right_str)),
        "," => Ok(format!("vec![{}, {}]", left_str, right_str)),
        _ => Ok(format!("({} {} {})", left_str, operator, right_str)),
    }
}

fn transpile_prefix_op(operator: &str, operand: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if operator == "@" {
        if layer == 0 {
            let op_str = transpile_node(operand, layer, in_main, table)?;
            return Ok(format!("unsafe {{ core::ptr::read_volatile({} as *const f64) }}", op_str));
        } else {
            if let AstNode::Identifier(id) = operand {
                if table.global_allocs.contains(id) {
                    return Ok(format!("{}.with(|cell| *cell.get().unwrap().borrow())", id));
                }
            }
            if let AstNode::Address(_) = operand {
                let op_str = transpile_node(operand, layer, in_main, table)?;
                return Ok(format!("unsafe {{ *({} as *const f64) }}", op_str));
            } else {
                let op_str = transpile_node(operand, layer, in_main, table)?;
                return Ok(format!("{}()", op_str));
            }
        }
    }

    if operator == "$" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("(move || {{ {} }})", op_str));
    }

    if operator == "#" || operator == "##" {
        if layer == 0 {
            return Err("Compile Error: Allocation (#/##) is not allowed in layer 0".to_string());
        }
        let op_str = transpile_node(operand, layer, in_main, table)?;
        let wrapper = if operator == "#" {
            "std::rc::Rc::new(std::cell::RefCell::new"
        } else {
            "std::sync::Arc::new(std::sync::Mutex::new"
        };
        return Ok(format!("{}({}))", wrapper, op_str));
    }

    let op_str = transpile_node(operand, layer, in_main, table)?;
    Ok(format!("{}{}", operator, op_str))
}

fn transpile_postfix_op(operator: &str, operand: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if operator == "~" {
        return transpile_node(operand, layer, in_main, table);
    }
    let op_str = transpile_node(operand, layer, in_main, table)?;
    Ok(format!("{}{}", op_str, operator))
}

fn transpile_block(node: &AstNode, kind: &BlockKind, content: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match kind {
        BlockKind::Indent if is_match_case_block(node) => {
            let mut lines = Vec::new();
            collect_lines_raw(content, &mut lines);
            let mut arms = Vec::new();
            for line in lines {
                if let AstNode::Define { identifier, definition } = line {
                    arms.push(MatchArm { condition: Some(AstNode::Identifier(identifier)), body: *definition });
                } else if let AstNode::BinaryOperation { ref operator, .. } = line {
                    if operator == ":" {
                        if let AstNode::BinaryOperation { left, right, .. } = line {
                            arms.push(MatchArm { condition: Some(*left), body: *right });
                        }
                    } else {
                        arms.push(MatchArm { condition: None, body: line });
                    }
                } else {
                    arms.push(MatchArm { condition: None, body: line });
                }
            }
            transpile_match_arms(&arms, layer, in_main, table)
        }
        BlockKind::Indent => {
            let inner = transpile_node(content, layer, in_main, table)?;
            let mut lines = Vec::new();
            collect_lines(content, &mut lines, layer, in_main, table)?;
            if lines.len() <= 1 {
                Ok(inner)
            } else {
                let last_idx = lines.len() - 1;
                let mut block_body = String::new();
                for i in 0..last_idx {
                    block_body.push_str("    ");
                    block_body.push_str(&lines[i]);
                    block_body.push_str(";\n");
                }
                block_body.push_str("    ");
                block_body.push_str(&lines[last_idx]);
                block_body.push_str("\n");
                Ok(format!("{{\n{}}}", block_body))
            }
        }
        BlockKind::Paren => {
            let inner = transpile_node(content, layer, in_main, table)?;
            Ok(format!("({})", inner))
        }
        BlockKind::Bracket => {
            let inner = transpile_node(content, layer, in_main, table)?;
            Ok(format!("vec![{}]", inner))
        }
        _ => {
            let inner = transpile_node(content, layer, in_main, table)?;
            Ok(inner)
        }
    }
}

fn transpile_lambda(arguments: &AstNode, body: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    let args = collect_args(arguments);
    let args_str = args.iter().map(|arg| format!("{}: f64", arg)).collect::<Vec<_>>().join(", ");
    let body_str = transpile_node(body, layer, in_main, table)?;
    Ok(format!("(move |{}| {})", args_str, body_str))
}

fn transpile_point_free(kind: &PointFreeKind, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match kind {
        PointFreeKind::BinaryOp(op) => {
            let init_val = if op == "+" || op == "-" { "0.0" } else { "1.0" };
            Ok(format!("(move |xs: Vec<f64>| xs.into_iter().fold({}, |acc, x| (acc {} x)))", init_val, op))
        }
        PointFreeKind::BinaryOpMap(op, right_node) => {
            let right_str = transpile_node(right_node, layer, in_main, table)?;
            Ok(format!("(move |xs: Vec<f64>| xs.into_iter().map(|x| (x {} {})).collect::<Vec<_>>())", op, right_str))
        }
        PointFreeKind::PrefixOp(op) => {
            Ok(format!("(move |x: f64| {}x)", op))
        }
        PointFreeKind::PostfixOp(op) => {
            Ok(format!("(move |x: f64| x{})", op))
        }
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

fn transpile_inline_code(code: &str, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    let mut result = String::new();
    let mut chars = code.chars().peekable();
    
    while let Some(c) = chars.next() {
        if c == '@' && chars.peek() == Some(&'{') {
            chars.next(); // '{' を消費
            
            // 閉じる '}' を見つけるまで切り出す
            let mut inner = String::new();
            let mut depth = 1;
            while let Some(ic) = chars.next() {
                if ic == '{' {
                    depth += 1;
                } else if ic == '}' {
                    depth -= 1;
                    if depth == 0 {
                        break;
                    }
                }
                inner.push(ic);
            }
            
            // inner を Sign の式としてパース
            let pre = crate::lexer::preprocess(&inner);
            match crate::parser::sign_parser::expression(&pre) {
                Ok(ast) => {
                    let transpiled = transpile_node(&ast, layer, in_main, table)?;
                    result.push_str(&transpiled);
                }
                Err(e) => {
                    return Err(format!("Parse error in inline code interpolant '{}': {:?}", inner, e));
                }
            }
        } else {
            result.push(c);
        }
    }
    
    Ok(result)
}

fn contains_identifier(node: &AstNode, target_id: &str) -> bool {
    match node {
        AstNode::Scalar(_) | AstNode::Char(_) | AstNode::String(_) | AstNode::Address(_) | AstNode::Unit | AstNode::Hole => false,
        AstNode::Identifier(id) => id == target_id,
        AstNode::Block { content, .. } => contains_identifier(content, target_id),
        AstNode::BinaryOperation { left, right, .. } => {
            contains_identifier(left, target_id) || contains_identifier(right, target_id)
        }
        AstNode::Prefix { operand, .. } => contains_identifier(operand, target_id),
        AstNode::Postfix { operand, .. } => contains_identifier(operand, target_id),
        AstNode::Coproduct(list) => list.iter().any(|item| contains_identifier(item, target_id)),
        AstNode::Product(list) => list.iter().any(|item| contains_identifier(item, target_id)),
        AstNode::Lambda { arguments, body } => {
            if contains_identifier(arguments, target_id) {
                false
            } else {
                contains_identifier(body, target_id)
            }
        }
        AstNode::Define { identifier, definition } => {
            identifier == target_id || contains_identifier(definition, target_id)
        }
        AstNode::MatchCase { cases } => {
            cases.iter().any(|(cond, body)| {
                cond.as_ref().map_or(false, |c| contains_identifier(c, target_id))
                    || contains_identifier(body, target_id)
            })
        }
        AstNode::PointFree(kind) => {
            match kind {
                PointFreeKind::BinaryOpMap(_, right) => contains_identifier(right, target_id),
                _ => false
            }
        }
        _ => false,
    }
}

fn substitute_args(node: &AstNode, mapping: &HashMap<String, AstNode>) -> AstNode {
    match node {
        AstNode::Identifier(id) => {
            if let Some(replacement) = mapping.get(id) {
                replacement.clone()
            } else {
                node.clone()
            }
        }
        AstNode::Block { kind, content } => {
            AstNode::Block {
                kind: kind.clone(),
                content: Box::new(substitute_args(content, mapping)),
            }
        }
        AstNode::BinaryOperation { operator, left, right, name } => {
            AstNode::BinaryOperation {
                operator: operator.clone(),
                left: Box::new(substitute_args(left, mapping)),
                right: Box::new(substitute_args(right, mapping)),
                name: name.clone(),
            }
        }
        AstNode::Prefix { operator, operand, name } => {
            AstNode::Prefix {
                operator: operator.clone(),
                operand: Box::new(substitute_args(operand, mapping)),
                name: name.clone(),
            }
        }
        AstNode::Postfix { operator, operand, name } => {
            AstNode::Postfix {
                operator: operator.clone(),
                operand: Box::new(substitute_args(operand, mapping)),
                name: name.clone(),
            }
        }
        AstNode::Coproduct(list) => {
            let new_list = list.iter().map(|item| substitute_args(item, mapping)).collect();
            AstNode::Coproduct(new_list)
        }
        AstNode::Product(list) => {
            let new_list = list.iter().map(|item| substitute_args(item, mapping)).collect();
            AstNode::Product(new_list)
        }
        AstNode::Lambda { arguments, body } => {
            let args_list = collect_args(arguments);
            let mut sub_mapping = mapping.clone();
            for arg in args_list {
                sub_mapping.remove(&arg);
            }
            AstNode::Lambda {
                arguments: Box::new(substitute_args(arguments, &sub_mapping)),
                body: Box::new(substitute_args(body, &sub_mapping)),
            }
        }
        AstNode::Define { identifier, definition } => {
            let mut sub_mapping = mapping.clone();
            sub_mapping.remove(identifier);
            AstNode::Define {
                identifier: identifier.clone(),
                definition: Box::new(substitute_args(definition, &sub_mapping)),
            }
        }
        AstNode::MatchCase { cases } => {
            let new_cases = cases.iter().map(|(cond, body)| {
                let new_cond = cond.as_ref().map(|c| substitute_args(c, mapping));
                let new_body = substitute_args(body, mapping);
                (new_cond, new_body)
            }).collect();
            AstNode::MatchCase { cases: new_cases }
        }
        AstNode::PointFree(kind) => {
            match kind {
                PointFreeKind::BinaryOpMap(op, right) => {
                    AstNode::PointFree(PointFreeKind::BinaryOpMap(op.clone(), Box::new(substitute_args(right, mapping))))
                }
                _ => node.clone()
            }
        }
        _ => node.clone(),
    }
}

fn has_deref_of_arg(node: &AstNode, arg_name: &str) -> bool {
    match node {
        AstNode::Prefix { operator, operand, .. } if operator == "@" => {
            if let AstNode::Identifier(id) = &**operand {
                if id == arg_name {
                    return true;
                }
            }
            has_deref_of_arg(operand, arg_name)
        }
        AstNode::Block { content, .. } => has_deref_of_arg(content, arg_name),
        AstNode::BinaryOperation { left, right, .. } => {
            has_deref_of_arg(left, arg_name) || has_deref_of_arg(right, arg_name)
        }
        AstNode::Prefix { operand, .. } => has_deref_of_arg(operand, arg_name),
        AstNode::Postfix { operand, .. } => has_deref_of_arg(operand, arg_name),
        AstNode::Coproduct(list) => list.iter().any(|item| has_deref_of_arg(item, arg_name)),
        AstNode::Product(list) => list.iter().any(|item| has_deref_of_arg(item, arg_name)),
        AstNode::Lambda { arguments, body } => {
            if let AstNode::Identifier(id) = &**arguments {
                if id == arg_name {
                    return false;
                }
            }
            has_deref_of_arg(body, arg_name)
        }
        AstNode::Define { definition, .. } => has_deref_of_arg(definition, arg_name),
        _ => false,
    }
}

fn is_high_order_function(sig: &FuncSignature) -> bool {
    if let Some(body) = &sig.body {
        for arg in &sig.args {
            if has_deref_of_arg(body, arg) {
                return true;
            }
        }
    }
    false
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
        assert!(out.contains("unsafe { core::ptr::read_volatile"));
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
