// alpha/rust/src/destructuring.rs
use crate::ast::{AstNode, BlockKind};
use crate::types::SymbolTable;
use crate::ast_helpers::{collect_args, collect_list_destructures};

pub fn desugar_destructuring(node: &AstNode, table: &SymbolTable) -> AstNode {
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
