// alpha/rust/src/codegen.rs
use crate::ast::{AstNode, BlockKind, PointFreeKind};
use crate::types::{AtomType, FuncSignature, SymbolTable, infer_atom_type};
use std::collections::{HashMap, HashSet};

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
            if let AstNode::Identifier(id) = &**right {
                if id.chars().next().map(|c| c.is_uppercase()).unwrap_or(false) {
                    collect_arg_nodes(right, res);
                    return;
                }
            }
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

fn collect_destructured_args(node: &AstNode, set: &mut HashSet<String>) {
    match node {
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "~" => {
            if let AstNode::Identifier(obj_name) = &**right {
                if obj_name.chars().next().map(|c| c.is_uppercase()).unwrap_or(false) {
                    if let AstNode::Identifier(var_name) = &**left {
                        set.insert(var_name.clone());
                    }
                }
            }
        }
        AstNode::Coproduct(list) => {
            for item in list {
                collect_destructured_args(item, set);
            }
        }
        _ => {}
    }
}

fn infer_field_type(field: &str, body: &AstNode) -> AtomType {
    match body {
        AstNode::BinaryOperation { operator, left, right, .. } => {
            if let AstNode::Identifier(id) = &**left {
                if id == field {
                    if operator == "==" || operator == "!=" || operator == "===" || operator == "!==" {
                        if let AstNode::String(_) = &**right {
                            return AtomType::String;
                        }
                    }
                }
            }
            if let AstNode::Identifier(id) = &**right {
                if id == field {
                    if operator == "==" || operator == "!=" || operator == "===" || operator == "!==" {
                        if let AstNode::String(_) = &**left {
                            return AtomType::String;
                        }
                    }
                }
            }
            let l_type = infer_field_type(field, left);
            if l_type != AtomType::Unknown {
                return l_type;
            }
            infer_field_type(field, right)
        }
        AstNode::Coproduct(list) => {
            for item in list {
                let t = infer_field_type(field, item);
                if t != AtomType::Unknown {
                    return t;
                }
            }
            AtomType::Unknown
        }
        AstNode::Block { content, .. } => infer_field_type(field, content),
        AstNode::Lambda { arguments, body: l_body } => {
            let arg_t = infer_field_type(field, arguments);
            if arg_t != AtomType::Unknown {
                return arg_t;
            }
            infer_field_type(field, l_body)
        }
        AstNode::Prefix { operand, .. } => infer_field_type(field, operand),
        AstNode::Postfix { operand, .. } => infer_field_type(field, operand),
        _ => AtomType::Unknown,
    }
}

fn find_default_value(node: &AstNode, arg_name: &str) -> Option<AstNode> {
    match node {
        AstNode::Define { identifier, definition } if identifier == arg_name => {
            Some(*definition.clone())
        }
        AstNode::Coproduct(list) => {
            for item in list {
                if let Some(val) = find_default_value(item, arg_name) {
                    return Some(val);
                }
            }
            None
        }
        AstNode::Block { kind, content } if *kind == BlockKind::Paren || *kind == BlockKind::Indent => {
            find_default_value(content, arg_name)
        }
        AstNode::BinaryOperation { left, right, .. } => {
            if let Some(val) = find_default_value(left, arg_name) {
                return Some(val);
            }
            find_default_value(right, arg_name)
        }
        _ => None,
    }
}

fn find_default_value_type(node: &AstNode, arg_name: &str, table: &SymbolTable) -> Option<AtomType> {
    match node {
        AstNode::Define { identifier, definition } if identifier == arg_name => {
            Some(infer_atom_type(definition, table))
        }
        AstNode::Coproduct(list) => {
            for item in list {
                if let Some(t) = find_default_value_type(item, arg_name, table) {
                    return Some(t);
                }
            }
            None
        }
        AstNode::Block { kind, content } if *kind == BlockKind::Paren || *kind == BlockKind::Indent => {
            find_default_value_type(content, arg_name, table)
        }
        _ => None,
    }
}

fn register_definition(table: &mut SymbolTable, id: &str, def: &AstNode) {
    let mut actual_def = def;
    while let AstNode::Block { content, .. } = actual_def {
        actual_def = &**content;
    }
    println!("register_definition for {}: {:?}", id, actual_def);
    if let AstNode::Lambda { arguments, body } = actual_def {
        let args = collect_args(arguments);
        let is_rec = contains_identifier(body, id);
        let rest_idx = find_rest_idx(arguments);
        let mut dest_args = HashSet::new();
        collect_destructured_args(arguments, &mut dest_args);
        let return_type = infer_atom_type(body, table);
        let mut required_arity = 0;
        for arg in &args {
            if find_default_value(arguments, arg).is_none() {
                required_arity += 1;
            }
        }
        table.functions.insert(id.to_string(), FuncSignature {
            arity: required_arity,
            args: args.clone(),
            body: Some(*body.clone()),
            is_recursive: is_rec,
            rest_idx,
            destructured_args: dest_args,
            return_type,
        });
        // Lambda 引数名をスコープマーカーとして atom_types に登録
        // (Unknown = 「定義されているが型はまだ不明」を意味する)
        // transpile_identifier はこれを見て「未定義ではない」と判断する
        for arg in &args {
            table.atom_types.entry(arg.clone()).or_insert(AtomType::Unknown);
        }
        if let Some(first_char) = id.chars().next() {
            if first_char.is_uppercase() {
                let mut obj_fields = Vec::new();
                for arg in &args {
                    let field_type = find_default_value_type(arguments, arg, table)
                        .unwrap_or_else(|| {
                            let inf = infer_field_type(arg, body);
                            if inf == AtomType::Unknown {
                                AtomType::Number
                            } else {
                                inf
                            }
                        });
                    obj_fields.push((arg.clone(), field_type));
                }
                table.objects.insert(id.to_string(), obj_fields);
            }
        }
        let mut list_dests = Vec::new();
        collect_list_destructures(arguments, &mut list_dests);
        for (idx, list_pat) in list_dests {
            let arg_name = if idx == 0 {
                "list_arg".to_string()
            } else {
                format!("list_arg_{}", idx)
            };
            let mut target_obj = None;
            match list_pat {
                AstNode::BinaryOperation { operator, left: _, right, .. } if operator == "~" => {
                    if let AstNode::Identifier(obj_name) = &*right {
                        target_obj = Some(obj_name.clone());
                    }
                }
                AstNode::Identifier(obj_name) => {
                    target_obj = Some(obj_name.clone());
                }
                _ => {}
            }
            if let Some(obj_name) = target_obj {
                if table.objects.contains_key(&obj_name) {
                    table.list_arg_types.insert(arg_name, obj_name);
                }
            }
        }
        // Lambda 自体は atom_types に登録しない (functions テーブルで管理)
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
                let return_type = sig.return_type.clone();
                table.functions.insert(id.to_string(), FuncSignature {
                    arity: missing_args.len(),
                    args: missing_args,
                    body: None,
                    is_recursive: false,
                    rest_idx: new_rest_idx,
                    destructured_args: sig.destructured_args.clone(),
                    return_type,
                });
            } else {
                let return_type = sig.return_type.clone();
                table.atom_types.insert(id.to_string(), return_type);
            }
        }
    } else if let AstNode::Identifier(ref_id) = def {
        if let Some(sig) = table.functions.get(ref_id) {
            table.functions.insert(id.to_string(), sig.clone());
        } else {
            // 識別子参照: 参照先の atom_type を引き継ぐ
            let atom_type = table.atom_types.get(ref_id).cloned().unwrap_or(AtomType::Unknown);
            table.atom_types.insert(id.to_string(), atom_type);
        }
    } else {
        // Atom 定義: atom_type を推論して登録
        let atom_type = infer_atom_type(def, table);
        table.atom_types.insert(id.to_string(), atom_type);
    }

    let mut is_instance_creation = false;
    if let AstNode::Define { identifier: obj_name, .. } = def {
        if table.objects.contains_key(obj_name) {
            is_instance_creation = true;
        }
    }

    if !is_instance_creation && !table.objects.contains_key(id) {
        let mut members = HashSet::new();
        collect_object_members(def, &mut members);
        if !members.is_empty() {
            let mut fields = members.into_iter().map(|m| (m, AtomType::Number)).collect::<Vec<_>>();
            fields.sort_by(|a, b| a.0.cmp(&b.0));
            table.objects.insert(id.to_string(), fields);
        }
    }
}

fn collect_object_members(node: &AstNode, members: &mut HashSet<String>) {
    match node {
        AstNode::Define { identifier, .. } => {
            members.insert(identifier.clone());
        }
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "\\n" || operator == "," => {
            collect_object_members(left, members);
            collect_object_members(right, members);
        }
        AstNode::Coproduct(list) => {
            for item in list {
                collect_object_members(item, members);
            }
        }
        AstNode::Block { kind, content } if *kind == BlockKind::Paren || *kind == BlockKind::Indent => {
            collect_object_members(content, members);
        }
        _ => {}
    }
}

fn collect_member_definitions(node: &AstNode, mapping: &mut HashMap<String, String>, layer: usize, table: &SymbolTable) -> Result<(), String> {
    match node {
        AstNode::Define { identifier, definition } => {
            let val_str = transpile_node(definition, layer, false, table)?;
            mapping.insert(identifier.clone(), val_str);
        }
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "\\n" || operator == "," || operator == " " => {
            collect_member_definitions(left, mapping, layer, table)?;
            collect_member_definitions(right, mapping, layer, table)?;
        }
        AstNode::Coproduct(list) => {
            for item in list {
                collect_member_definitions(item, mapping, layer, table)?;
            }
        }
        AstNode::Block { content, .. } => {
            collect_member_definitions(content, mapping, layer, table)?;
        }
        _ => {}
    }
    Ok(())
}

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

fn collect_args(node: &AstNode) -> Vec<String> {
    collect_args_idx(node, &mut 0)
}

fn collect_args_idx(node: &AstNode, index: &mut usize) -> Vec<String> {
    match node {
        AstNode::Identifier(id) => {
            *index += 1;
            vec![id.clone()]
        }
        AstNode::Prefix { operator, operand, .. } if operator == "~" => collect_args_idx(operand, index),
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "~" => {
            if let AstNode::Identifier(id) = &**right {
                if id.chars().next().map(|c| c.is_uppercase()).unwrap_or(false) {
                    return collect_args_idx(right, index);
                }
            }
            let mut res = collect_args_idx(left, index);
            res.extend(collect_args_idx(right, index));
            res
        }
        AstNode::Coproduct(list) => {
            let mut res = Vec::new();
            for item in list {
                res.extend(collect_args_idx(item, index));
            }
            res
        }
        AstNode::Block { kind, .. } if *kind == BlockKind::Bracket => {
            let name = if *index == 0 {
                "list_arg".to_string()
            } else {
                format!("list_arg_{}", *index)
            };
            *index += 1;
            vec![name]
        }
        AstNode::Block { kind, content } if *kind == BlockKind::Indent || *kind == BlockKind::Paren => {
            collect_args_idx(content, index)
        }
        AstNode::Define { identifier, .. } => {
            *index += 1;
            vec![identifier.clone()]
        }
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "\\n" || operator == "\n" || operator == "," || operator == " " => {
            let mut res = collect_args_idx(left, index);
            res.extend(collect_args_idx(right, index));
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
    ListOrStruct,
}

fn get_category(node: &AstNode, table: &SymbolTable) -> TypeCategory {
    match node {
        AstNode::Block { kind: BlockKind::Paren, content } => get_category(content, table),
        AstNode::Block { kind: BlockKind::Bracket, .. } => TypeCategory::ListOrStruct,
        AstNode::Prefix { operator, operand, .. } if operator == "~" => get_category(operand, table),
        AstNode::Postfix { operator, operand, .. } if operator == "~" => get_category(operand, table),
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
        (TypeCategory::Atom, TypeCategory::Atom) => 4,           // 10.4: concat (数値などのアトム連接)
        (TypeCategory::Lambda, TypeCategory::Lambda) => 3,       // 10.3: compose
        (TypeCategory::Lambda, TypeCategory::Atom) => 2,         // 10.2: apply
        (TypeCategory::Lambda, TypeCategory::ListOrStruct) => 2,   // 10.2: apply (リスト/構造体適用)
        (TypeCategory::ListOrStruct, TypeCategory::ListOrStruct) => 1, // 10.1: concat_list (List/Struct同士の連接、applyより低い優先度)
        (TypeCategory::Atom, TypeCategory::Lambda) => 0,         // 10.0: apply_reverse
        (TypeCategory::ListOrStruct, TypeCategory::Lambda) => 0,   // 10.0: apply_reverse
        _ => 1,
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

    // 優先度 4 (concat) から 0 (apply_reverse) へ
    for priority in (0..=4).rev() {
        let mut i = 0;
        while i < items.len().saturating_sub(1) {
            let cat_l = get_category(&items[i], table);
            let cat_r = get_category(&items[i + 1], table);
            let p = get_reduction_priority(cat_l, cat_r);
            if p == priority {
                let left = items.remove(i);
                let right = items.remove(i);
                
                let reduced = match priority {
                    4 => {
                        AstNode::BinaryOperation {
                            operator: ",".to_string(),
                            left: Box::new(left),
                            right: Box::new(right),
                            name: "concat".to_string(),
                        }
                    }
                    3 => {
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
                    2 => {
                        AstNode::BinaryOperation {
                            operator: " ".to_string(),
                            left: Box::new(left),
                            right: Box::new(right),
                            name: "resolved".to_string(),
                        }
                    }
                    1 => {
                        AstNode::BinaryOperation {
                            operator: ",".to_string(),
                            left: Box::new(left),
                            right: Box::new(right),
                            name: "concat".to_string(),
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

fn transpile_three_term_range(start_str: &str, step_str: &str, end_str: &str, mode: &str) -> String {
    match mode {
        "~+" => {
            format!(
                "{{ let start = {}; let step = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if step > 0.0 {{ while cur <= end {{ v.push(cur); cur += step; }} }} else if step < 0.0 {{ while cur >= end {{ v.push(cur); cur += step; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~-" => {
            format!(
                "{{ let start = {}; let step = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if step > 0.0 {{ while cur >= end {{ v.push(cur); cur -= step; }} }} else if step < 0.0 {{ while cur <= end {{ v.push(cur); cur -= step; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~*" => {
            format!(
                "{{ let start = {}; let ratio = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if ratio > 1.0 {{ while cur <= end {{ v.push(cur); cur *= ratio; }} }} else if ratio < 1.0 && ratio > 0.0 {{ while cur >= end {{ v.push(cur); cur *= ratio; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~/" => {
            format!(
                "{{ let start = {}; let ratio = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if ratio > 1.0 {{ while cur >= end {{ v.push(cur); cur /= ratio; }} }} else if ratio < 1.0 && ratio > 0.0 {{ while cur <= end {{ v.push(cur); cur /= ratio; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~^" => {
            format!(
                "{{ let start = {}; let exp = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if exp > 1.0 {{ while cur <= end {{ v.push(cur); cur = cur.powf(exp); }} }} else if exp < 1.0 && exp > 0.0 {{ while cur >= end {{ v.push(cur); cur = cur.powf(exp); }} }} v }}",
                start_str, step_str, end_str
            )
        }
        _ => {
            format!(
                "{{ let start = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if start <= end {{ while cur <= end {{ v.push(cur); cur += 1.0; }} }} else {{ while cur >= end {{ v.push(cur); cur -= 1.0; }} }} v }}",
                start_str, end_str
            )
        }
    }
}

fn transpile_binary_op(operator: &str, left: &AstNode, right: &AstNode, name: &str, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if ["~", "~+", "~-", "~*", "~/", "~^"].contains(&operator) {
        if let AstNode::BinaryOperation { operator: left_op, left: left_left, right: left_right, .. } = left {
            if ["~+", "~-", "~*", "~/", "~^"].contains(&left_op.as_str()) {
                let start_str = transpile_node(left_left, layer, in_main, table)?;
                let step_str = transpile_node(left_right, layer, in_main, table)?;
                let end_str = transpile_node(right, layer, in_main, table)?;
                return Ok(transpile_three_term_range(&start_str, &step_str, &end_str, left_op));
            }
        }

        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;

        if operator == "~" {
            return Ok(transpile_three_term_range(&left_str, "1.0", &right_str, "~"));
        } else {
            let iter_expr = match operator {
                "~+" => format!("std::iter::successors(Some({}), move |&curr| Some(curr + {}))", left_str, right_str),
                "~-" => format!("std::iter::successors(Some({}), move |&curr| Some(curr - {}))", left_str, right_str),
                "~*" => format!("std::iter::successors(Some({}), move |&curr| Some(curr * {}))", left_str, right_str),
                "~/" => format!("std::iter::successors(Some({}), move |&curr| Some(curr / {}))", left_str, right_str),
                "~^" => format!("std::iter::successors(Some({}), move |&curr| Some(curr.powf({})))", left_str, right_str),
                _ => format!("std::iter::successors(Some({}), move |&curr| Some(curr + 1.0))", left_str),
            };
            return Ok(iter_expr);
        }
    }

    if operator == "#" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        if layer == 0 {
            return Ok(format!("unsafe {{ core::ptr::write_volatile({} as *mut f64, {}) }}", left_str, right_str));
        } else {
            if let AstNode::Identifier(id) = left {
                if table.global_allocs.contains(id) {
                    return Ok(format!("{}.with(|cell| *cell.get().unwrap().borrow_mut() = Option::from({}).unwrap_or(0.0))", id, right_str));
                }
            }
            return Ok(format!("unsafe {{ *({} as *mut f64) = Option::from({}).unwrap_or(0.0) }}", left_str, right_str));
        }
    }

    if operator == ":" {
        if let AstNode::Identifier(id) = left {
            if table.objects.contains_key(id) {
                let mut mapping = HashMap::new();
                collect_member_definitions(right, &mut mapping, layer, table)?;
                let struct_name = format!("{}Struct", id);
                let mut struct_inits = Vec::new();
                let mut sorted_fields = table.objects.get(id).unwrap().clone();
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
        }

        if let AstNode::Lambda { arguments: cond, body: then } = left {
            let arms = vec![
                MatchArm { condition: Some(*cond.clone()), body: *then.clone() },
                MatchArm { condition: None, body: right.clone() },
            ];
            return transpile_match_arms(&arms, layer, in_main, table);
        }
    }

    if operator == ";" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let wrapped_right = if right_str.starts_with("Option::from") || right_str.starts_with("Some(") || right_str.starts_with("None") || right_str.contains(".and") || right_str.contains("eval_compare") {
            right_str
        } else {
            format!("Option::from({})", right_str)
        };
        return Ok(format!("{}.xor({})", left_str, wrapped_right));
    }

    if operator == "'" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        if let AstNode::Identifier(ref id) = *right {
            return Ok(format!("{}.get_{}()", left_str, id));
        } else {
            return Err(format!("Property access key must be an identifier, found {:?}", right));
        }
    }

    if ["<", ">", "<=", ">=", "==", "!=", "!==", "="].contains(&operator) {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let rust_op = if operator == "!==" { "!=" } else if operator == "=" { "==" } else { operator };
        return Ok(format!("eval_compare(Option::from({}), Option::from({}), |l, r| l {} r)", left_str, right_str, rust_op));
    }

    if operator == "&" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let wrapped_right = if right_str.starts_with("Option::from") || right_str.starts_with("Some(") || right_str.starts_with("None") || right_str.contains(".and") || right_str.contains("eval_compare") {
            right_str
        } else {
            format!("Option::from({})", right_str)
        };
        return Ok(format!("{}.and({})", left_str, wrapped_right));
    }

    if operator == "|" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let l_wrap = if is_option_type(&left_str, table) { left_str } else { format!("Option::from({})", left_str) };
        let r_wrap = if is_option_type(&right_str, table) { right_str } else { format!("Option::from({})", right_str) };
        return Ok(format!("{}.or_else(|| {})", l_wrap, r_wrap));
    }

    // 中置スペースによる適用/合成の解決
    if operator == " " {

        if name == "resolved" {
            // 関数名と、これまでに適用された全引数リストを抽出
            let mut applied_args = Vec::new();
            if let Some(func_name) = extract_applied_func_and_args(left, &mut applied_args) {
                collect_coproduct_items(right, &mut applied_args);
                applied_args.retain(|item| *item != AstNode::Unit);
                
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
                                let mut arg_str = transpile_node(&applied_args[i], layer, in_main, table)?;
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                if is_obj && !arg_str.starts_with('&') {
                                    arg_str = format!("&{}", arg_str);
                                }
                                final_args.push(arg_str);
                            }
                            if spread_idx == 1 {
                                final_args.push(spread_var.clone());
                            } else {
                                let head_param = &sig.args[0];
                                let is_head_obj = if let Some(first_char) = head_param.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &head_param[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(head_param)
                                } else {
                                    false
                                };
                                let head_ref = if is_head_obj { "&" } else { "" };
                                final_args.push(format!("{}{}[0]", head_ref, spread_var));
                                final_args.push(format!("&{}[1..]", spread_var));
                            }
                            let call_code = format!(
                                "if {}.is_empty() {{ None }} else {{ {}({}) }}",
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
                        for (i, arg) in applied_args.iter().enumerate() {
                            let mut arg_str = transpile_node(arg, layer, in_main, table)?;
                            let mut is_ref = false;
                            let mut is_single_object = false;
                            if i < sig.args.len() {
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                is_ref = is_obj || sig.rest_idx == Some(i) || param_name.starts_with("list_arg");
                                if param_name.starts_with("list_arg") {
                                    is_single_object = !matches!(arg, AstNode::Coproduct(_) | AstNode::Block { kind: BlockKind::Bracket, .. });
                                }
                            }
                            if is_ref && !arg_str.starts_with('&') {
                                arg_str = format!("&{}", arg_str);
                            }
                            if is_single_object {
                                let arg_without_ref = if arg_str.starts_with('&') {
                                    &arg_str[1..]
                                } else {
                                    &arg_str
                                };
                                arg_str = format!("std::slice::from_ref({})", arg_without_ref);
                            }
                            all_args_code.push(arg_str);
                        }
                        let missing_args = &sig.args[passed_count..];
                        for arg in missing_args {
                            all_args_code.push(arg.clone());
                        }
                        return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args_code.join(", ")));
                    } else {
                        // 完全適用！
                        let has_list_arg = sig.args.iter().any(|arg| arg.starts_with("list_arg"));
                        let is_constructor = func_name.chars().next().map(|c| c.is_uppercase()).unwrap_or(false);
                        if !sig.is_recursive && sig.destructured_args.is_empty() && !has_list_arg && !is_constructor && applied_args.len() == sig.args.len() {
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
                        let mut option_binds = Vec::new();
                        let mut bind_counter = 0;
                        for (i, arg) in applied_args.iter().enumerate() {
                            let mut arg_str = transpile_node(arg, layer, in_main, table)?;
                            let mut is_ref = false;
                            let mut is_single_object = false;
                            let mut param_is_f64 = false;
                            if i < sig.args.len() {
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                is_ref = is_obj || sig.rest_idx == Some(i) || param_name.starts_with("list_arg");
                                if param_name.starts_with("list_arg") {
                                    is_single_object = !matches!(arg, AstNode::Coproduct(_) | AstNode::Block { kind: BlockKind::Bracket, .. });
                                }
                                if !is_ref && i < sig.arity {
                                    param_is_f64 = true;
                                }
                            }
                            if is_ref && !arg_str.starts_with('&') {
                                arg_str = format!("&{}", arg_str);
                            }
                            if is_single_object {
                                let arg_without_ref = if arg_str.starts_with('&') {
                                    &arg_str[1..]
                                } else {
                                    &arg_str
                                };
                                arg_str = format!("std::slice::from_ref({})", arg_without_ref);
                            }
                            if param_is_f64 && is_option_type(&arg_str, table) {
                                let var_name = format!("__cv{}", bind_counter);
                                bind_counter += 1;
                                option_binds.push((arg_str.clone(), var_name.clone()));
                                args_code.push(var_name);
                            } else {
                                args_code.push(arg_str);
                            }
                        }
                        // 不足しているデフォルト引数に対して None を補填する
                        for _ in applied_args.len()..sig.args.len() {
                            args_code.push("None".to_string());
                        }
                        let mut call_expr = format!("{}({})", func_name, args_code.join(", "));
                        for (orig_expr, var_name) in option_binds.into_iter().rev() {
                            let val_expr = if is_option_type(&call_expr, table) {
                                call_expr.clone()
                            } else {
                                format!("Option::from({})", call_expr)
                            };
                            call_expr = format!("{}.and_then(|{}| {})", orig_expr, var_name, val_expr);
                        }
                        return Ok(call_expr);
                    }
                }
            }

            // フォールバック：通常の適用
            let left_str = transpile_node(left, layer, in_main, table)?;
            let right_str = transpile_node(right, layer, in_main, table)?;
            let left_opt = is_option_type(&left_str, table);
            let right_opt = is_option_type(&right_str, table);

            if left_opt && right_opt {
                let call = "__func(__val)".to_string();
                let call_wrapped = if is_option_type(&call, table) {
                    call
                } else {
                    "Some(__func(__val))".to_string()
                };
                return Ok(format!("{}.and_then(|__func| {}.and_then(|__val| {}))", left_str, right_str, call_wrapped));
            } else if left_opt {
                let call = format!("__func({})", right_str);
                let call_wrapped = if is_option_type(&call, table) {
                    call
                } else {
                    format!("Some(__func({}))", right_str)
                };
                return Ok(format!("{}.and_then(|__func| {})", left_str, call_wrapped));
            } else if right_opt {
                let call = format!("{}(__cv)", left_str);
                let call_wrapped = if is_option_type(&call, table) {
                    call
                } else {
                    format!("Some({}(__cv))", call)
                };
                return Ok(format!("{}.and_then(|__cv| {})", right_str, call_wrapped));
            }
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
    let left_type = infer_atom_type(left, table);
    let right_type = infer_atom_type(right, table);
    
    let left_opt = is_option_type(&left_str, table);
    let right_opt = is_option_type(&right_str, table);
    let l_wrap = if left_opt { left_str.clone() } else { format!("Option::from({})", left_str) };
    let r_wrap = if right_opt { right_str.clone() } else { format!("Option::from({})", right_str) };

    match (operator, left_type) {
        // --- 1. 左辺が String (文字列) の場合 ---
        ("+", AtomType::String) => {
            if right_type == AtomType::Number {
                // Number を文字コードポイントとして扱い、結合する
                Ok(format!("format!(\"{}{}\", {}, ({} as u32).try_into().unwrap_or('\\0'))", "{}", "{}", left_str, right_str))
            } else {
                Ok(format!("format!(\"{}{}\", {}, {})", "{}", "{}", left_str, right_str))
            }
        }
        ("*", AtomType::String) => {
            Ok(format!("{}.repeat({} as usize)", left_str, right_str))
        }
        
        // --- 2. 左辺が List の場合 ---
        ("+", AtomType::List) => {
            // リストの結合
            Ok(format!("{{ let mut temp = {}.clone(); temp.extend({}); temp }}", left_str, right_str))
        }
        ("*", AtomType::List) => {
            // リストを Number 回複製する
            Ok(format!("{{ let mut temp = Vec::new(); for _ in 0..({} as usize) {{ temp.extend({}.clone()); }}; temp }}", right_str, left_str))
        }
        ("/", AtomType::List) => {
            // リストを Number 個 of チャンクに分割
            Ok(format!("{}.chunks({} as usize).map(|c| c.to_vec()).collect::<Vec<_>>()", left_str, right_str))
        }
        ("^", AtomType::List) => {
            // 次元を上げて複製
            Ok(format!("vec![{}.clone(); {} as usize]", left_str, right_str))
        }

        // --- 3. 左辺が Number (数値) またはその他のデフォルトの場合 ---
        ("+", _) => Ok(format!("eval_binary({}, {}, |l, r| l + r)", l_wrap, r_wrap)),
        ("-", _) => Ok(format!("eval_binary({}, {}, |l, r| l - r)", l_wrap, r_wrap)),
        ("*", _) => Ok(format!("eval_binary({}, {}, |l, r| l * r)", l_wrap, r_wrap)),
        ("/", _) => Ok(format!("eval_binary({}, {}, |l, r| l / r)", l_wrap, r_wrap)),
        ("^", _) => Ok(format!("eval_binary({}, {}, |l, r| l.powf(r))", l_wrap, r_wrap)),
        ("%", _) => Ok(format!("eval_binary({}, {}, |l, r| l % r)", l_wrap, r_wrap)),
        (",", _) => Ok(format!("vec![{}, {}]", left_str, right_str)),
        ("<<", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) << (r as i64)) as f64))", l_wrap, r_wrap)),
        (">>", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) >> (r as i64)) as f64))", l_wrap, r_wrap)),
        ("||", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) | (r as i64)) as f64))", l_wrap, r_wrap)),
        (";;", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) ^ (r as i64)) as f64))", l_wrap, r_wrap)),
        ("&&", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) & (r as i64)) as f64))", l_wrap, r_wrap)),
        _ => Ok(format!("({} {} {})", left_str, operator, right_str)),
    }
}

fn transpile_prefix_op(operator: &str, operand: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if operator == "!!" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Option::from({}).map(|op| (((!(op as i64)) as f64)))", op_str));
    }

    if operator == "!" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("if Option::from({}).is_none() {{ Some(0.0) }} else {{ None }}", op_str));
    }

    if operator == "-" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Option::from({}).map(|op| -op)", op_str));
    }

    if operator == "~" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("{{ let end = {}; let mut v = Vec::new(); let mut cur = 0.0; if cur <= end {{ while cur <= end {{ v.push(cur); cur += 1.0; }} }} else {{ while cur >= end {{ v.push(cur); cur -= 1.0; }} }} v }}", op_str));
    }

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
                if is_option_type(&op_str, table) || op_str == "None" {
                    let call = "f()".to_string();
                    let call_wrapped = if is_option_type(&call, table) {
                        call
                    } else {
                        "Some(f())".to_string()
                    };
                    return Ok(format!("{}.and_then(|f| {})", op_str, call_wrapped));
                } else {
                    return Ok(format!("{}()", op_str));
                }
            }
        }
    }

    if operator == "$" {
        if let AstNode::Identifier(id) = operand {
            if id == "__" {
                return Ok("None".to_string());
            }
        }
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Some(move || {{ {} }})", op_str));
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
    if operator == "!" {
        return Ok(format!("factorial({})", op_str));
    }
    if operator == "@" {
        return Err("Compile Error: Module Import is not implemented".to_string());
    }
    Ok(format!("{}{}", op_str, operator))
}

fn transpile_block(node: &AstNode, kind: &BlockKind, content: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match kind {
        BlockKind::Abs => {
            let inner = transpile_node(content, layer, in_main, table)?;
            Ok(format!("({}).abs()", inner))
        }
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
            let is_already_list = inner.starts_with("vec![") || inner.starts_with("{") || match content {
                AstNode::BinaryOperation { operator, .. } => ["~", "~+", "~-", "~*", "~/", "~^"].contains(&operator.as_str()),
                _ => false,
            };
            if is_already_list {
                Ok(inner)
            } else {
                Ok(format!("vec![{}]", inner))
            }
        }
        _ => {
            let inner = transpile_node(content, layer, in_main, table)?;
            Ok(inner)
        }
    }
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
            if sig.destructured_args.contains(arg) {
                continue;
            }
            if has_deref_of_arg(body, arg) {
                return true;
            }
        }
    }
    false
}

fn has_hole(node: &AstNode) -> bool {
    match node {
        AstNode::Hole => true,
        AstNode::Coproduct(list) => list.iter().any(has_hole),
        AstNode::Block { content, .. } => has_hole(content),
        AstNode::Prefix { operand, .. } => has_hole(operand),
        AstNode::Postfix { operand, .. } => has_hole(operand),
        AstNode::BinaryOperation { left, right, .. } => has_hole(left) || has_hole(right),
        AstNode::Lambda { body, .. } => has_hole(body),
        AstNode::Define { definition, .. } => has_hole(definition),
        _ => false,
    }
}

fn desugar_holes(node: &AstNode) -> AstNode {
    if !has_hole(node) {
        return node.clone();
    }

    if let AstNode::Define { identifier, definition } = node {
        return AstNode::Define {
            identifier: identifier.clone(),
            definition: Box::new(desugar_holes(definition)),
        };
    }

    if let AstNode::Lambda { arguments, body } = node {
        return AstNode::Lambda {
            arguments: arguments.clone(),
            body: Box::new(desugar_holes(body)),
        };
    }

    let mut vars = Vec::new();
    let desugared_body = replace_holes_with_vars(node, &mut vars);
    
    if vars.is_empty() {
        return desugared_body;
    }

    let args_node = if vars.len() == 1 {
        AstNode::Identifier(vars[0].clone())
    } else {
        AstNode::Coproduct(vars.into_iter().map(AstNode::Identifier).collect())
    };

    AstNode::Lambda {
        arguments: Box::new(args_node),
        body: Box::new(desugared_body),
    }
}

fn replace_holes_with_vars(node: &AstNode, vars: &mut Vec<String>) -> AstNode {
    match node {
        AstNode::Hole => {
            let var_name = format!("_p{}", vars.len());
            vars.push(var_name.clone());
            AstNode::Identifier(var_name)
        }
        AstNode::Coproduct(list) => {
            let mut new_list = Vec::new();
            for item in list {
                new_list.push(replace_holes_with_vars(item, vars));
            }
            AstNode::Coproduct(new_list)
        }
        AstNode::Block { kind, content } => {
            AstNode::Block {
                kind: kind.clone(),
                content: Box::new(replace_holes_with_vars(content, vars)),
            }
        }
        AstNode::Prefix { operator, operand, name } => {
            AstNode::Prefix {
                operator: operator.clone(),
                operand: Box::new(replace_holes_with_vars(operand, vars)),
                name: name.clone(),
            }
        }
        AstNode::Postfix { operator, operand, name } => {
            AstNode::Postfix {
                operator: operator.clone(),
                operand: Box::new(replace_holes_with_vars(operand, vars)),
                name: name.clone(),
            }
        }
        AstNode::BinaryOperation { operator, left, right, name } => {
            AstNode::BinaryOperation {
                operator: operator.clone(),
                left: Box::new(replace_holes_with_vars(left, vars)),
                right: Box::new(replace_holes_with_vars(right, vars)),
                name: name.clone(),
            }
        }
        AstNode::Lambda { .. } => {
            // ネストした Lambda はこのレベルでは置換せず、脱糖して丸ごと返す
            desugar_holes(node)
        }
        AstNode::Define { identifier, definition } => {
            AstNode::Define {
                identifier: identifier.clone(),
                definition: Box::new(replace_holes_with_vars(definition, vars)),
            }
        }
        _ => node.clone(),
    }
}

fn collect_list_destructures(node: &AstNode, res: &mut Vec<(usize, AstNode)>) {
    collect_list_destructures_rec(node, res, &mut 0);
}

fn collect_list_destructures_rec(node: &AstNode, res: &mut Vec<(usize, AstNode)>, index: &mut usize) {
    match node {
        AstNode::Block { kind, content } if *kind == BlockKind::Bracket => {
            res.push((*index, *content.clone()));
            *index += 1;
        }
        AstNode::Coproduct(list) => {
            for item in list {
                collect_list_destructures_rec(item, res, index);
            }
        }
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "," || operator == " " => {
            collect_list_destructures_rec(left, res, index);
            collect_list_destructures_rec(right, res, index);
        }
        _ => {
            *index += 1;
        }
    }
}

fn desugar_destructuring(node: &AstNode, table: &SymbolTable) -> AstNode {
    match node {
        AstNode::Lambda { arguments, body } => {
            let mut list_destructures = Vec::new();
            collect_list_destructures(arguments, &mut list_destructures);

            let mut destructures = Vec::new();
            let new_args = rewrite_destructuring_args(arguments, &mut destructures, table);
            
            let mut desugared_body = desugar_destructuring(body, table);

            // 1. リストデストラクト展開
            for (index, list_pat) in list_destructures.into_iter().rev() {
                let arg_name = if index == 0 {
                    "list_arg".to_string()
                } else {
                    format!("list_arg_{}", index)
                };
                
                if let AstNode::BinaryOperation { operator, left, right, .. } = &list_pat {
                    if operator == "~" {
                        if let AstNode::Identifier(head_var) = &**left {
                            if let AstNode::Identifier(tail_var) = &**right {
                                if tail_var.chars().next().map(|c| c.is_uppercase()).unwrap_or(false) {
                                    // 構造体メンバー抽出
                                    let member_def = AstNode::InlineCode(format!("{}[0].{}", arg_name, head_var));
                                    desugared_body = AstNode::BinaryOperation {
                                        operator: "\\n".to_string(),
                                        left: Box::new(AstNode::Define {
                                            identifier: head_var.clone(),
                                            definition: Box::new(member_def),
                                        }),
                                        right: Box::new(desugared_body),
                                        name: "newline".to_string(),
                                    };
                                } else {
                                    // 通常の head/tail 展開
                                    let head_def = AstNode::InlineCode(format!("{}[0]", arg_name));
                                    let tail_def = AstNode::InlineCode(format!("&{}[1..]", arg_name));
                                    
                                    desugared_body = AstNode::BinaryOperation {
                                        operator: "\\n".to_string(),
                                        left: Box::new(AstNode::Define {
                                            identifier: tail_var.clone(),
                                            definition: Box::new(tail_def),
                                        }),
                                        right: Box::new(desugared_body),
                                        name: "newline".to_string(),
                                    };
                                    
                                    desugared_body = AstNode::BinaryOperation {
                                        operator: "\\n".to_string(),
                                        left: Box::new(AstNode::Define {
                                            identifier: head_var.clone(),
                                            definition: Box::new(head_def),
                                        }),
                                        right: Box::new(desugared_body),
                                        name: "newline".to_string(),
                                    };
                                }
                            }
                        }
                    }
                }
            }

            // 2. オブジェクトデストラクト展開
            for (var_name, obj_name) in destructures.into_iter().rev() {
                desugared_body = replace_destructured_reads(&desugared_body, &var_name);
                let definition = AstNode::InlineCode(format!("_{}.get_{}()", obj_name, var_name));
                
                desugared_body = AstNode::BinaryOperation {
                    operator: "\\n".to_string(),
                    left: Box::new(AstNode::Define {
                        identifier: var_name,
                        definition: Box::new(definition),
                    }),
                    right: Box::new(desugared_body),
                    name: "newline".to_string(),
                };
            }
            
            AstNode::Lambda {
                arguments: Box::new(new_args),
                body: Box::new(desugared_body),
            }
        }
        AstNode::Define { identifier, definition } => {
            AstNode::Define {
                identifier: identifier.clone(),
                definition: Box::new(desugar_destructuring(definition, table)),
            }
        }
        AstNode::Coproduct(list) => {
            AstNode::Coproduct(list.iter().map(|item| desugar_destructuring(item, table)).collect())
        }
        AstNode::Block { kind, content } => {
            AstNode::Block {
                kind: kind.clone(),
                content: Box::new(desugar_destructuring(content, table)),
            }
        }
        AstNode::BinaryOperation { operator, left, right, name } => {
            AstNode::BinaryOperation {
                operator: operator.clone(),
                left: Box::new(desugar_destructuring(left, table)),
                right: Box::new(desugar_destructuring(right, table)),
                name: name.clone(),
            }
        }
        AstNode::Prefix { operator, operand, name } => {
            AstNode::Prefix {
                operator: operator.clone(),
                operand: Box::new(desugar_destructuring(operand, table)),
                name: name.clone(),
            }
        }
        AstNode::Postfix { operator, operand, name } => {
            AstNode::Postfix {
                operator: operator.clone(),
                operand: Box::new(desugar_destructuring(operand, table)),
                name: name.clone(),
            }
        }
        _ => node.clone(),
    }
}

fn rewrite_destructuring_args(node: &AstNode, destructures: &mut Vec<(String, String)>, table: &SymbolTable) -> AstNode {
    rewrite_destructuring_args_idx(node, destructures, table, &mut 0)
}

fn rewrite_destructuring_args_idx(node: &AstNode, destructures: &mut Vec<(String, String)>, table: &SymbolTable, index: &mut usize) -> AstNode {
    match node {
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "~" => {
            if let (AstNode::Identifier(var_name), AstNode::Identifier(obj_name)) = (&**left, &**right) {
                if table.objects.contains_key(obj_name) {
                    destructures.push((var_name.clone(), obj_name.clone()));
                    AstNode::Identifier(obj_name.clone())
                } else {
                    node.clone()
                }
            } else {
                node.clone()
            }
        }
        AstNode::Coproduct(list) => {
            let mut new_list = Vec::new();
            for item in list {
                new_list.push(rewrite_destructuring_args_idx(item, destructures, table, index));
            }
            AstNode::Coproduct(new_list)
        }
        AstNode::BinaryOperation { operator, left, right, name } if operator == "," || operator == " " => {
            let new_left = rewrite_destructuring_args_idx(left, destructures, table, index);
            let new_right = rewrite_destructuring_args_idx(right, destructures, table, index);
            AstNode::BinaryOperation {
                operator: operator.clone(),
                left: Box::new(new_left),
                right: Box::new(new_right),
                name: name.clone(),
            }
        }
        AstNode::Block { kind, .. } if *kind == BlockKind::Bracket => {
            let name = if *index == 0 {
                "list_arg".to_string()
            } else {
                format!("list_arg_{}", *index)
            };
            *index += 1;
            AstNode::Identifier(name)
        }
        _ => {
            *index += 1;
            node.clone()
        }
    }
}

fn replace_destructured_reads(node: &AstNode, var_name: &str) -> AstNode {
    match node {
        AstNode::Prefix { operator, operand, .. } if operator == "@" => {
            if let AstNode::Identifier(id) = &**operand {
                if id == var_name {
                    return AstNode::InlineCode(format!("{}.unwrap()", var_name));
                }
            }
            AstNode::Prefix {
                operator: operator.clone(),
                operand: Box::new(replace_destructured_reads(operand, var_name)),
                name: "deref".to_string(),
            }
        }
        AstNode::Coproduct(list) => {
            AstNode::Coproduct(list.iter().map(|item| replace_destructured_reads(item, var_name)).collect())
        }
        AstNode::Block { kind, content } => {
            AstNode::Block {
                kind: kind.clone(),
                content: Box::new(replace_destructured_reads(content, var_name)),
            }
        }
        AstNode::BinaryOperation { operator, left, right, name } => {
            AstNode::BinaryOperation {
                operator: operator.clone(),
                left: Box::new(replace_destructured_reads(left, var_name)),
                right: Box::new(replace_destructured_reads(right, var_name)),
                name: name.clone(),
            }
        }
        AstNode::Define { identifier, definition } => {
            AstNode::Define {
                identifier: identifier.clone(),
                definition: Box::new(replace_destructured_reads(definition, var_name)),
            }
        }
        AstNode::Lambda { arguments, body } => {
            let shadowed = collect_args(arguments).contains(&var_name.to_string());
            if shadowed {
                node.clone()
            } else {
                AstNode::Lambda {
                    arguments: arguments.clone(),
                    body: Box::new(replace_destructured_reads(body, var_name)),
                }
            }
        }
        _ => node.clone(),
    }
}

fn strip_outer_parens(s: &str) -> &str {
    let mut current = s.trim();
    while current.starts_with('(') && current.ends_with(')') {
        let mut depth = 0;
        let mut matching_idx = None;
        for (i, c) in current.chars().enumerate() {
            if c == '(' {
                depth += 1;
            } else if c == ')' {
                depth -= 1;
                if depth == 0 {
                    matching_idx = Some(i);
                    break;
                }
            }
        }
        if let Some(idx) = matching_idx {
            if idx == current.len() - 1 {
                current = &current[1..current.len() - 1].trim();
            } else {
                break;
            }
        } else {
            break;
        }
    }
    current
}

fn is_pure_closure(trimmed: &str) -> bool {
    let stripped = strip_outer_parens(trimmed);
    stripped.starts_with("move |") || stripped.starts_with("move||")
}

fn is_option_type(expr: &str, table: &SymbolTable) -> bool {
    let trimmed = strip_outer_parens(expr);
    if is_pure_closure(trimmed) {
        return false;
    }
    if trimmed.starts_with("__func(") || trimmed.starts_with("__val(") || trimmed.starts_with("__cv") {
        return true;
    }
    if trimmed.starts_with("Some(") || trimmed.starts_with("None") || trimmed.contains("Option::from") || trimmed.contains(".and(") || trimmed.contains(".and_then(") || trimmed.contains(".zip(") || trimmed.contains(".map(") || trimmed.contains("eval_compare") || trimmed.contains("eval_binary") {
        let is_unwrap = {
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
        return !is_unwrap;
    }
    for func_name in table.functions.keys() {
        if let Some(idx) = trimmed.find(func_name) {
            let before = if idx > 0 { trimmed.chars().nth(idx - 1) } else { None };
            let after = trimmed.chars().nth(idx + func_name.len());
            let before_is_ident = before.map(|c| c.is_alphanumeric() || c == '_').unwrap_or(false);
            let after_is_ident = after.map(|c| c.is_alphanumeric() || c == '_').unwrap_or(false);
            if !before_is_ident && !after_is_ident {
                if let Some(sig) = table.functions.get(func_name) {
                    if sig.return_type != AtomType::List {
                        let is_unwrap = {
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
                        return !is_unwrap;
                    }
                }
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
        // __ は None として評価済みの Option なので Option::from で二重に包まない
        let code = "__ + 5";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("eval_binary(None, Option::from(5.0), |l, r| l + r)"));

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
        let code = "!__";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("if Option::from(None).is_none() { Some(0.0) } else { None }"));

        // 5. 前置ビット否定 (!!)
        let code = "!!__";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 2).unwrap();
        assert!(out.contains("Option::from(None).map(|op| (((!(op as i64)) as f64)))"));
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
