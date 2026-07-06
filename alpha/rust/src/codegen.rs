// alpha/rust/src/codegen.rs
use crate::ast::{AstNode, PointFreeKind};
use crate::types::{AtomType, SymbolTable};
use crate::ast_helpers::{collect_args, desugar_holes, has_hole, is_high_order_function};
use crate::symbol_analysis::{build_symbol_table, collect_member_definitions, find_default_value};
use crate::coproduct::{resolve_coproduct, get_category, TypeCategory, collect_coproduct_items};
use crate::destructuring::desugar_destructuring;
use crate::operators::{transpile_binary_op, transpile_prefix_op, transpile_postfix_op};
use crate::blocks::{transpile_block, collect_lines};
use std::collections::HashMap;

pub fn transpile_program(ast: &[AstNode], layer: usize) -> Result<String, String> {
    // 1. Hole の静的脱糖
    let hole_desugared: Vec<AstNode> = ast.iter().map(|node| desugar_holes(node)).collect();
    // 2. シンボルテーブルの構築
    let table = build_symbol_table(&hole_desugared);
    // 3. 暗黙メンバ抽出の静的脱糖
    let mut desugared_ast: Vec<AstNode> = hole_desugared.iter().map(|node| desugar_destructuring(node, &table)).collect();
    
    // Quick Fix to restore destroyed arguments
    for node in &mut desugared_ast {
        if let AstNode::Define { identifier, definition } = node {
            if let AstNode::Lambda { arguments, body: _ } = &mut **definition {
                if let AstNode::Identifier(arg_id) = &**arguments {
                    if arg_id == identifier {
                        if let Some(sig) = table.functions.get(identifier) {
                            let mut orig_args = Vec::new();
                            for arg in &sig.args {
                                orig_args.push(AstNode::Identifier(arg.clone()));
                            }
                            let new_args_node = if orig_args.len() == 1 {
                                orig_args[0].clone()
                            } else {
                                AstNode::Coproduct(orig_args)
                            };
                            *arguments = Box::new(new_args_node);
                        }
                    }
                }
            }
        }
    }

    let mut top_level_code = String::new();
    
    let mut all_members = std::collections::HashSet::new();
    for members in table.objects.values() {
        for m in members {
            all_members.insert(m.0.clone());
        }
    }
    for sig in table.functions.values() {
        for m in &sig.destructured_args {
            all_members.insert(m.clone());
        }
    }
    
    if layer == 2 {
        top_level_code.push_str("#![allow(unused_parens)]\n#![allow(unused_variables)]\n#![allow(non_upper_case_globals)]\n#![allow(dead_code)]\n#![allow(non_snake_case)]\n\n");
        let eval_compare_decl = r#"fn eval_compare<F>(lhs: Option<f64>, rhs: Option<f64>, op: F) -> Option<f64>
where
    F: Fn(f64, f64) -> bool,
{
    let l_val = lhs?;
    let r_val = rhs?;
    if op(l_val, r_val) {
        if l_val == 0.0 || l_val == 1.0 {
            Some(r_val)
        } else {
            Some(l_val)
        }
    } else {
        None
    }
}

fn eval_binary<F>(lhs: Option<f64>, rhs: Option<f64>, op: F) -> Option<f64>
where
    F: Fn(f64, f64) -> f64,
{
    match (lhs, rhs) {
        (Some(l), Some(r)) => Some(op(l, r)),
        _ => None,
    }
}

fn factorial(n: f64) -> f64 {
    if n <= 1.0 {
        1.0
    } else {
        n * factorial(n - 1.0)
    }
}

"#;
        top_level_code.push_str(eval_compare_decl);

        // HasMemberトレイト定義の自動生成
        for mem in &all_members {
            let cap_mem = if let Some(c) = mem.chars().next() {
                format!("{}{}", c.to_uppercase(), &mem[1..])
            } else {
                mem.clone()
            };
            top_level_code.push_str(&format!(
                "pub trait HasMember{} {{\n    type Output;\n    fn get_{}(&self) -> Option<Self::Output>;\n}}\n\n",
                cap_mem, mem
            ));
            top_level_code.push_str(&format!(
                "impl<'a, T: HasMember{}> HasMember{} for &'a T {{\n    type Output = <T as HasMember{}>::Output;\n    fn get_{}(&self) -> Option<Self::Output> {{\n        (**self).get_{}()\n    }}\n}}\n\n",
                cap_mem, cap_mem, cap_mem, mem, mem
            ));
            top_level_code.push_str(&format!(
                "impl<T: HasMember{}> HasMember{} for Option<T> {{\n    type Output = <T as HasMember{}>::Output;\n    fn get_{}(&self) -> Option<Self::Output> {{\n        self.as_ref().and_then(|x| x.get_{}())\n    }}\n}}\n\n",
                cap_mem, cap_mem, cap_mem, mem, mem
            ));
        }

        // 各オブジェクト構造体に対するすべてのトレイトの実装
        for obj in table.objects.keys() {
            let sorted_fields = table.objects.get(obj).unwrap();
            for mem in &all_members {
                let cap_mem = if let Some(c) = mem.chars().next() {
                    format!("{}{}", c.to_uppercase(), &mem[1..])
                } else {
                    mem.clone()
                };
                let opt_field = sorted_fields.iter().find(|f| &f.0 == mem);
                let (output_type, impl_body) = if let Some(field) = opt_field {
                    let o_type = match field.1 {
                        AtomType::String => "String",
                        _ => "f64",
                    };
                    let body = match field.1 {
                        AtomType::String => format!("Some(self.{}.clone())", mem),
                        _ => format!("Some(self.{})", mem),
                    };
                    (o_type.to_string(), body)
                } else {
                    ("f64".to_string(), "None".to_string())
                };
                top_level_code.push_str(&format!(
                    "impl HasMember{} for {}Struct {{\n    type Output = {};\n    fn get_{}(&self) -> Option<Self::Output> {{\n        {}\n    }}\n}}\n\n",
                    cap_mem, obj, output_type, mem, impl_body
                ));
            }
        }
    }
    
    let mut main_statements = Vec::new();
    for node in &desugared_ast {
        match node {
            AstNode::Define { identifier, definition } => {
                if table.objects.contains_key(identifier) {
                    let def_code = transpile_definition(identifier, definition, layer, &table)?;
                    top_level_code.push_str(&def_code);
                    top_level_code.push_str("\n\n");
                } else if let AstNode::Lambda { .. } = &**definition {
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
                    let mut val_str = transpile_node(definition, layer, true, &table)?;
                    let is_obj_instance = table.objects.keys().any(|obj| identifier.starts_with(obj));
                    if is_obj_instance && (val_str.contains("Some") || val_str.contains("None") || val_str.contains("if ") || val_str.contains("Item(")) {
                        val_str = format!("({}).unwrap()", val_str);
                    }
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
    if table.objects.contains_key(id) {
        let struct_name = format!("{}Struct", id);
        let mut struct_fields = Vec::new();
        
        let mut sorted_fields = table.objects.get(id).unwrap().clone();
        sorted_fields.sort_by(|a, b| a.0.cmp(&b.0));
        
        for (field_name, field_type) in &sorted_fields {
            let rust_type = match field_type {
                AtomType::String => "String",
                _ => "f64",
            };
            struct_fields.push(format!("    pub {}: {},", field_name, rust_type));
        }

        let mut actual_def = def;
        while let AstNode::Block { content, .. } = actual_def {
            actual_def = &**content;
        }
        println!("actual_def for {}: {:?}", id, actual_def);
        if let AstNode::Lambda { arguments, body: _ } = actual_def {
            let args = collect_args(arguments);
            let args_decl = args.iter().map(|arg| {
                let field_type = sorted_fields.iter().find(|f| &f.0 == arg).map(|f| &f.1).unwrap_or(&AtomType::Number);
                let rust_type = match field_type {
                    AtomType::String => "&str",
                    _ => "f64",
                };
                format!("{}: {}", arg, rust_type)
            }).collect::<Vec<_>>().join(", ");
            
            let mut struct_inits = Vec::new();
            for (field_name, field_type) in &sorted_fields {
                let init_expr = match field_type {
                    AtomType::String => format!("{}.to_string()", field_name),
                    _ => field_name.clone(),
                };
                struct_inits.push(format!("        {}: {},", field_name, init_expr));
            }
            
            let struct_decl = format!(
                "#[derive(Clone, Debug, PartialEq)]\npub struct {} {{\n{}\n}}\n\nfn {}({}) -> Option<{}> {{\n    Some({} {{\n{}\n    }})\n}}",
                struct_name,
                struct_fields.join("\n"),
                id,
                args_decl,
                struct_name,
                struct_name,
                struct_inits.join("\n")
            );
            return Ok(struct_decl);
        } else {
            let mut mapping = HashMap::new();
            collect_member_definitions(def, &mut mapping, layer, table)?;
            
            let mut struct_inits = Vec::new();
            for (field_name, field_type) in &sorted_fields {
                let val = mapping.get(field_name).cloned().unwrap_or_else(|| {
                    match field_type {
                        AtomType::String => "String::new()".to_string(),
                        _ => "0.0".to_string(),
                    }
                });
                struct_inits.push(format!("    {}: {},", field_name, val));
            }
            
            let struct_decl = format!(
                "#[derive(Clone, Debug, PartialEq)]\npub struct {} {{\n{}\n}}\n\npub const {}: {} = {} {{\n{}\n}};",
                struct_name,
                struct_fields.join("\n"),
                id,
                struct_name,
                struct_name,
                struct_inits.join("\n")
            );
            return Ok(struct_decl);
        }
    }

    if let AstNode::Lambda { arguments, body } = def {
        let sig = table.functions.get(id);
        let args = if let Some(s) = sig {
            s.args.clone()
        } else {
            collect_args(arguments)
        };
        let mut generics = Vec::new();
        let args_str = args.iter().enumerate().map(|(i, arg)| {
            if arg.starts_with("list_arg") {
                let elem_type = if let Some(obj_name) = table.list_arg_types.get(arg) {
                    format!("{}Struct", obj_name)
                } else {
                    "f64".to_string()
                };
                return format!("{}: &[{}]", arg, elem_type);
            }

            let opt_obj_type = if let Some(first_char) = arg.chars().next() {
                let capitalized = format!("{}{}", first_char.to_uppercase(), &arg[1..]);
                if table.objects.contains_key(&capitalized) {
                    Some(capitalized)
                } else if table.objects.contains_key(arg) {
                    Some(arg.clone())
                } else {
                    None
                }
            } else {
                None
            };

            if let Some(s) = sig {
                if s.rest_idx == Some(i) {
                    let mut elem_type = "f64".to_string();
                    for other_arg in &s.args {
                        let other_obj_type = if let Some(fc) = other_arg.chars().next() {
                            let cap = format!("{}{}", fc.to_uppercase(), &other_arg[1..]);
                            if table.objects.contains_key(&cap) {
                                Some(cap)
                            } else if table.objects.contains_key(other_arg) {
                                Some(other_arg.clone())
                            } else {
                                None
                            }
                        } else {
                            None
                        };
                        if let Some(obj) = other_obj_type {
                            elem_type = format!("{}Struct", obj);
                            break;
                        }
                    }
                    return format!("{}: &[{}]", arg, elem_type);
                }
            }

            if let Some(obj_type) = opt_obj_type {
                let mut bounds = Vec::new();
                if let Some(s) = sig {
                    if let Some(members) = table.objects.get(&obj_type) {
                        let mut sorted_dest: Vec<_> = s.destructured_args.iter().collect();
                        sorted_dest.sort();
                        for dest_arg in sorted_dest {
                            if members.iter().any(|f| &f.0 == dest_arg) {
                                let cap_dest = if let Some(c) = dest_arg.chars().next() {
                                    format!("{}{}", c.to_uppercase(), &dest_arg[1..])
                                } else {
                                    dest_arg.clone()
                                };
                                let field_type = members.iter().find(|f| &f.0 == dest_arg).map(|f| &f.1).unwrap_or(&AtomType::Number);
                                let output_type = match field_type {
                                    AtomType::String => "String",
                                    _ => "f64",
                                };
                                bounds.push(format!("HasMember{}<Output = {}>", cap_dest, output_type));
                            }
                        }
                    }
                }
                
                if bounds.is_empty() {
                    if arg == &obj_type {
                        return format!("_{}: &{}Struct", arg, arg);
                    } else {
                        return format!("{}: &{}Struct", arg, obj_type);
                    }
                } else {
                    let cap_arg = if let Some(c) = arg.chars().next() {
                        format!("{}{}", c.to_uppercase(), &arg[1..])
                    } else {
                        arg.clone()
                    };
                    let g_name = format!("T{}", cap_arg);
                    generics.push(format!("{}: {}", g_name, bounds.join(" + ")));
                    if arg == &obj_type {
                        return format!("_{}: &{}", arg, g_name);
                    } else {
                        return format!("{}: &{}", arg, g_name);
                    }
                }
            }
            if find_default_value(arguments, arg).is_some() {
                format!("{}: Option<f64>", arg)
            } else {
                format!("{}: f64", arg)
            }
        }).collect::<Vec<_>>().join(", ");
        let body_str = transpile_node(body, layer, false, table)?;
        let mut prepend_code = String::new();
        for arg in &args {
            if let Some(default_node) = find_default_value(arguments, arg) {
                let default_str = transpile_node(&default_node, layer, false, table)?;
                prepend_code.push_str(&format!(
                    "    let {} = {}.or(Option::from({})).unwrap_or(0.0);\n",
                    arg, arg, default_str
                ));
            }
        }
        let body_str = if prepend_code.is_empty() {
            body_str
        } else {
            format!("{}{}", prepend_code, body_str)
        };
        let ret_type = if body_str.contains("vec!") || body_str.contains("Vec<") {
            "Vec<f64>"
        } else {
            let last_line = body_str.lines()
                .map(|s| s.trim())
                .filter(|s| !s.is_empty() && *s != "}")
                .last()
                .unwrap_or("");
            let is_unwrap = {
                let trimmed = last_line.trim_end_matches(';').trim_end_matches(')').trim();
                let pos_unwrap = trimmed.rfind("unwrap()");
                let pos_unwrap_or = trimmed.rfind("unwrap_or(");
                let pos_unwrap_default = trimmed.rfind("unwrap_or_default()");
                let last_unwrap_pos = pos_unwrap.max(pos_unwrap_or).max(pos_unwrap_default);
                if let Some(pos) = last_unwrap_pos {
                    let suffix = &trimmed[pos..];
                    !suffix.contains(',') && !suffix.contains('+') && !suffix.contains('-') && !suffix.contains('*') && !suffix.contains('/') &&
                    !suffix.contains(".map(") && !suffix.contains(".zip(") && !suffix.contains(".and(") && !suffix.contains(".or_else(") && !suffix.contains(".and_then(")
                } else {
                    false
                }
            };
            if (body_str.contains("Some") || body_str.contains("None") || body_str.contains("Option::from") || body_str.contains(".and(") || body_str.contains(".get_") || body_str.contains("eval_binary")) && !is_unwrap {
                "Option<f64>"
            } else {
                "f64"
            }
        };
        let body_str = body_str;
        let generics_str = if generics.is_empty() {
            String::new()
        } else {
            format!("<{}>", generics.join(", "))
        };
        Ok(format!("fn {}{}({}) -> {} {{\n    {}\n}}", id, generics_str, args_str, ret_type, body_str))
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







pub fn transpile_node(node: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if has_hole(node) {
        let desugared = desugar_holes(node);
        if &desugared != node {
            return transpile_node(&desugared, layer, in_main, table);
        }
    }

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
        AstNode::Register(r) => Ok(format!("{}.0", r)),
        AstNode::Unit => Ok("None".to_string()),
        AstNode::Hole => Ok("None".to_string()),
        AstNode::Identifier(id) => transpile_identifier(id, table),
        AstNode::InlineCode(code) => transpile_inline_code(code, layer, in_main, table),
        AstNode::Coproduct(list) => transpile_coproduct(node, list, layer, in_main, table),
        AstNode::Define { identifier, definition } => {
            if table.objects.contains_key(identifier) {
                let mut mapping = HashMap::new();
                collect_member_definitions(definition, &mut mapping, layer, table)?;
                let struct_name = format!("{}Struct", identifier);
                let mut struct_inits = Vec::new();
                let mut sorted_fields = table.objects.get(identifier).unwrap().clone();
                sorted_fields.sort_by(|a, b| a.0.cmp(&b.0));
                for (field_name, field_type) in sorted_fields {
                    let val = mapping.get(&field_name).cloned().unwrap_or_else(|| {
                        match field_type {
                            AtomType::String => "String::new()".to_string(),
                            _ => "0.0".to_string(),
                        }
                    });
                    struct_inits.push(format!("{}: {}", field_name, val));
                }
                return Ok(format!("{} {{ {} }}", struct_name, struct_inits.join(", ")));
            }
            let val_str = transpile_node(definition, layer, in_main, table)?;
            Ok(format!("let {} = {}", identifier, val_str))
        }
        AstNode::BinaryOperation { operator, left, right, name } => {
            if operator == "\\n" {
                let mut lines = Vec::new();
                collect_lines(node, &mut lines, layer, in_main, table)?;
                if lines.len() <= 1 {
                    Ok(lines.first().cloned().unwrap_or_else(|| "None".to_string()))
                } else {
                    let last_idx = lines.len() - 1;
                    let mut block_body = String::new();
                    for i in 0..last_idx {
                        block_body.push_str("    ");
                        block_body.push_str(&lines[i]);
                        if !lines[i].ends_with(';') && (!lines[i].ends_with('}') || lines[i].contains("Struct {") || lines[i].starts_with("let ")) {
                            block_body.push_str(";");
                        }
                        block_body.push_str("\n");
                    }
                    block_body.push_str("    ");
                    block_body.push_str(&lines[last_idx]);
                    Ok(format!("{{\n{}\n}}", block_body))
                }
            } else {
                transpile_binary_op(operator, left, right, name, layer, in_main, table)
            }
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
    // Lambda (関数) として登録済み
    if let Some(sig) = table.functions.get(id) {
        let missing = &sig.args;
        Ok(format!("(move |{}| {}({}))", missing.join(", "), id, missing.join(", ")))
    // Atom として登録済み (スコープ内の変数・引数を含む)
    } else if table.atom_types.contains_key(id) {
        Ok(id.to_string())
    // 特殊ケース (後方互換)
    } else if id == "env" || id == "args" {
        Ok("None".to_string())
    } else if id.starts_with("comp_arg") || id.starts_with("list_arg") {
        Ok(id.to_string())
    } else {
        // C-1: 未定義識別子 → Unit 収束 (None)
        // Sign 仕様: 「スコープにない識別子はすべて __unit として評価される」
        Ok("None".to_string())
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
    flat_items.retain(|item| *item != AstNode::Unit);
    
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





fn transpile_lambda(arguments: &AstNode, body: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    let args = collect_args(arguments);
    let args_str = args.iter().map(|arg| {
        let opt_obj_type = if let Some(first_char) = arg.chars().next() {
            let capitalized = format!("{}{}", first_char.to_uppercase(), &arg[1..]);
            if table.objects.contains_key(&capitalized) {
                Some(capitalized)
            } else if table.objects.contains_key(arg) {
                Some(arg.clone())
            } else {
                None
            }
        } else {
            None
        };

        if let Some(obj_type) = opt_obj_type {
            if arg == &obj_type {
                format!("_{}: {}Struct", arg, arg)
            } else {
                format!("{}: {}Struct", arg, obj_type)
            }
        } else {
            if find_default_value(arguments, arg).is_some() {
                format!("{}: Option<f64>", arg)
            } else {
                format!("{}: f64", arg)
            }
        }
    }).collect::<Vec<_>>().join(", ");
    let body_str = transpile_node(body, layer, in_main, table)?;
    let mut prepend_code = String::new();
    for arg in &args {
        if let Some(default_node) = find_default_value(arguments, arg) {
            let default_str = transpile_node(&default_node, layer, in_main, table)?;
            prepend_code.push_str(&format!(
                "let {} = {}.or(Option::from({})).unwrap_or(0.0); ",
                arg, arg, default_str
            ));
        }
    }
    let body_str = if prepend_code.is_empty() {
        body_str
    } else {
        format!("{{ {}{} }}", prepend_code, body_str)
    };
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
        // 右辺 (2 * 3) はすでに Option<f64> を返すので Option::from で二重に包まない
        assert!(out.contains("eval_binary(Option::from(1.0), eval_binary(Option::from(2.0), Option::from(3.0), |l, r| l * r), |l, r| l + r)"));
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

    #[test]
    fn test_transpile_p0_fixes() {
        // 1. XOR (;)
        let code = "a ; b";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains(".xor("));

        // 2. get_prop (')
        let code = "Point : x y ? x\np : Point 10 20\np ' x";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("p.get_x()"));

        // 3. equal (=)
        let code = "a = b";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("eval_compare("));
        assert!(out.contains("=="));

        // 4. absolute value (|...|)
        let code = "|x|";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains(".abs()"));

        // 5. factorial (!)
        let code = "5!";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("factorial(5.0)"));
        assert!(out.contains("fn factorial("));

        // 6. import (@)
        let code = "file@";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2);
        assert!(out.is_err());
        assert!(out.unwrap_err().contains("Module Import is not implemented"));
    }

    #[test]
    fn test_transpile_unit_propagation() {
        // 1. 中置の算術演算 (zip.map)
        // 静的最適化により、__ (None) が吸収元として機能し、式全体が None になる
        let code = "__ + 5";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("None"));

        // 2. 中置のマイナス演算 (zip.map)
        let code = "val_a : 10\nval_b : 20\nval_a - val_b";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("eval_binary(Option::from(val_a), Option::from(val_b), |l, r| l - r)"));

        // 3. 中置のビット演算
        let code = "val_a : 10\nval_b : 20\nval_a || val_b";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("eval_binary(Option::from(val_a), Option::from(val_b), |l, r| (((l as i64) | (r as i64)) as f64))"));

        // 4. 前置否定 (!)
        // 静的最適化により、!__ が Some(0.0) に直接変換される
        let code = "!__";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("Some(0.0)"));

        // 5. 前置ビット否定 (!!)
        // 静的最適化により、!!__ が None に直接変換される
        let code = "!!__";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("None"));
    }

    #[test]
    fn test_transpile_default_args() {
        let code = "g :\n\t\tx\n\t\ty : x + 1\n\t\tz : y + 1\n? x y z\nres1 : g 1\nres2 : g 1 (3 < 2)";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        
        assert!(out.contains("fn g(x: f64, y: Option<f64>, z: Option<f64>) -> Vec<f64>"));
        assert!(out.contains("let y = y.or(Option::from(eval_binary(Option::from(x), Option::from(1.0), |l, r| l + r))).unwrap_or(0.0);"));
        assert!(out.contains("let z = z.or(Option::from(eval_binary(Option::from(y), Option::from(1.0), |l, r| l + r))).unwrap_or(0.0);"));
        assert!(out.contains("g(1.0, None, None)"));
        assert!(out.contains("g(1.0, (eval_compare("));
    }

    #[test]
    fn test_transpile_coproduct_priority() {
        // 1. f [1 2] [3 4] -> apply 優先 (2つの引数が個別に渡される)
        let code = "f : [x ~xs] [y ~ys] ? x\nres : f [1 2] [3 4]";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("f(&vec![1.0, 2.0], &vec![3.0, 4.0])"));

        // 2. F (Point [x: 10]) (Point [y: 20]) -> apply 優先 (2つの構造体インスタンスが個別に渡される)
        let code = "Point : x y ? x\nF : a b ? a\nres : F (Point [x: 10]) (Point [y: 20])";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("F("));

        // 3. f [[1 2] [3 4]] -> concat 優先 (カッコ内で連接され、1つの引数になる)
        let code = "f : [x ~xs] ? x\nres : f [[1 2] [3 4]]";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("f(&vec![vec![1.0, 2.0], vec![3.0, 4.0]])"));
    }
}
