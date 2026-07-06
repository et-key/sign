use crate::ast::AstNode;
use crate::types::SymbolTable;
use crate::codegen::transpile_node;

fn collect_product_items(node: &AstNode, items: &mut Vec<AstNode>) {
    match node {
        AstNode::BinaryOperation { operator, left, right, .. } if operator == "," => {
            collect_product_items(left, items);
            collect_product_items(right, items);
        }
        _ => {
            items.push(node.clone());
        }
    }
}

pub fn transpile_product(
    left: &AstNode,
    right: &AstNode,
    layer: usize,
    in_main: bool,
    table: &SymbolTable,
) -> Result<String, String> {
    // 1. 片方または両方が Unit (None) の場合（単位元ルール）
    let left_is_unit = matches!(left, AstNode::Unit);
    let right_is_unit = matches!(right, AstNode::Unit);

    if left_is_unit && right_is_unit {
        return Ok("None".to_string());
    } else if left_is_unit {
        return transpile_node(right, layer, in_main, table);
    } else if right_is_unit {
        return transpile_node(left, layer, in_main, table);
    }

    // 2. 平坦化（左辺・右辺がさらに `,` の場合にフラットなリストにする）
    let mut flat = Vec::new();
    collect_product_items(left, &mut flat);
    collect_product_items(right, &mut flat);

    let mut parts = Vec::new();
    for item in flat {
        parts.push(transpile_node(&item, layer, in_main, table)?);
    }
    
    Ok(format!("vec![{}]", parts.join(", ")))
}
