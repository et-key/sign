// alpha/rust/src/symbol_analysis.rs
use crate::ast::{AstNode, BlockKind};
use crate::types::{AtomType, FuncSignature, SymbolTable, infer_atom_type};
use crate::ast_helpers::{collect_args, contains_identifier, extract_application, collect_list_destructures};
use crate::codegen::transpile_node;
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

pub fn find_default_value(node: &AstNode, arg_name: &str) -> Option<AstNode> {
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

pub fn find_default_value_type(node: &AstNode, arg_name: &str, table: &SymbolTable) -> Option<AtomType> {
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
        for (i, arg) in args.iter().enumerate() {
            let t = if rest_idx == Some(i) { AtomType::List } else { AtomType::Unknown };
            table.atom_types.entry(arg.clone()).or_insert(t);
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

pub fn collect_member_definitions(node: &AstNode, mapping: &mut HashMap<String, String>, layer: usize, table: &SymbolTable) -> Result<(), String> {
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
