// alpha/rust/src/coproduct.rs
use crate::ast::{AstNode, BlockKind};
use crate::types::SymbolTable;

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum TypeCategory {
    Lambda,
    Atom,
    ListOrStruct,
}

pub fn get_category(node: &AstNode, table: &SymbolTable) -> TypeCategory {
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

pub fn get_reduction_priority(left: TypeCategory, right: TypeCategory) -> usize {
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

pub fn collect_coproduct_items(node: &AstNode, items: &mut Vec<AstNode>) {
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

pub fn resolve_coproduct(list: &[AstNode], table: &SymbolTable) -> Result<AstNode, String> {
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

pub fn extract_applied_func_and_args(node: &AstNode, args: &mut Vec<AstNode>) -> Option<String> {
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
