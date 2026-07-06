use crate::ast::AstNode;
use crate::types::SymbolTable;
use crate::codegen::transpile_node;

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

    // 2. 通常の直積構築 (vec![l, r])
    let left_str = transpile_node(left, layer, in_main, table)?;
    let right_str = transpile_node(right, layer, in_main, table)?;
    Ok(format!("vec![{}, {}]", left_str, right_str))
}
