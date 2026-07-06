// alpha/rust/src/ast_helpers.rs
use crate::ast::{AstNode, BlockKind, PointFreeKind};
use crate::types::FuncSignature;
use std::collections::HashMap;

pub fn contains_identifier(node: &AstNode, target_id: &str) -> bool {
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

pub fn substitute_args(node: &AstNode, mapping: &HashMap<String, AstNode>) -> AstNode {
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

pub fn has_deref_of_arg(node: &AstNode, arg_name: &str) -> bool {
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

pub fn is_high_order_function(sig: &FuncSignature) -> bool {
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

pub fn has_hole(node: &AstNode) -> bool {
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

pub fn desugar_holes(node: &AstNode) -> AstNode {
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

pub fn collect_args(node: &AstNode) -> Vec<String> {
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

pub fn extract_application(node: &AstNode) -> Option<(String, Vec<AstNode>)> {
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

pub fn collect_list_destructures(node: &AstNode, res: &mut Vec<(usize, AstNode)>) {
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
