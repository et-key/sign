// alpha/rust/src/blocks.rs
use crate::ast::{AstNode, BlockKind};
use crate::types::SymbolTable;
use crate::codegen::transpile_node;

// match_case および 三項演算の統一解決用構造体
#[derive(Clone, Debug)]
pub struct MatchArm {
    pub condition: Option<AstNode>,
    pub body: AstNode,
}

pub fn is_match_case_block(node: &AstNode) -> bool {
    match node {
        AstNode::Block { kind: BlockKind::Indent, content } => {
            let mut lines = Vec::new();
            collect_lines_raw(content, &mut lines);
            lines.iter().any(|line| is_case_line(line))
        }
        _ => false,
    }
}

pub fn collect_lines_raw(node: &AstNode, lines: &mut Vec<AstNode>) {
    if let AstNode::BinaryOperation { operator, left, right, name: _name } = node {
        if operator == "\\n" {
            collect_lines_raw(left, lines);
            collect_lines_raw(right, lines);
            return;
        }
    }
    lines.push(node.clone());
}

pub fn is_case_line(node: &AstNode) -> bool {
    match node {
        AstNode::Define { .. } => true,
        AstNode::BinaryOperation { operator, .. } if operator == ":" => true,
        _ => false,
    }
}

pub fn transpile_match_arms(arms: &[MatchArm], layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
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

pub fn transpile_block(node: &AstNode, kind: &BlockKind, content: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
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

pub fn collect_lines(node: &AstNode, lines: &mut Vec<String>, layer: usize, in_main: bool, table: &SymbolTable) -> Result<(), String> {
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
