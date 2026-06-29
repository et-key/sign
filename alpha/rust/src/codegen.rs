// alpha/rust/src/codegen.rs
use crate::ast::{AstNode, BlockKind};
use crate::runtime::SignValue;
use std::collections::HashMap;

#[derive(Clone, Debug)]
pub struct FuncSignature {
    pub arity: usize,
    pub args: Vec<String>,
}

#[derive(Clone, Debug, Default)]
pub struct SymbolTable {
    pub functions: HashMap<String, FuncSignature>,
}

pub fn build_symbol_table(ast: &[AstNode]) -> SymbolTable {
    let mut table = SymbolTable::default();
    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                register_definition(&mut table, identifier, definition);
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    register_definition(&mut table, identifier, definition);
                }
            }
            _ => {}
        }
    }
    table
}

fn register_definition(table: &mut SymbolTable, id: &str, def: &AstNode) {
    if let AstNode::Lambda { arguments, body: _body } = def {
        let args = collect_args(arguments);
        table.functions.insert(id.to_string(), FuncSignature {
            arity: args.len(),
            args,
        });
    } else if let Some((func_name, passed_args)) = extract_application(def) {
        if let Some(sig) = table.functions.get(&func_name) {
            let passed_count = passed_args.len();
            if passed_count < sig.arity {
                let missing_args = sig.args[passed_count..].to_vec();
                table.functions.insert(id.to_string(), FuncSignature {
                    arity: missing_args.len(),
                    args: missing_args,
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
    let mut main_statements = Vec::new();

    for node in ast {
        match node {
            AstNode::Define { identifier, definition } => {
                let def_code = transpile_definition(identifier, definition, layer, &table)?;
                top_level_code.push_str(&def_code);
                top_level_code.push_str("\n\n");
            }
            AstNode::Prefix { operator, operand, name: _name } if operator == "#" || operator == "##" || operator == "###" => {
                if let AstNode::Define { identifier, definition } = &**operand {
                    let def_code = transpile_definition(identifier, definition, layer, &table)?;
                    top_level_code.push_str("pub ");
                    top_level_code.push_str(&def_code);
                    top_level_code.push_str("\n\n");
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
        let args_str = args.iter().map(|arg| format!("{}: f64", arg)).collect::<Vec<_>>().join(", ");
        let body_str = transpile_node(body, layer, false, table)?;
        Ok(format!("fn {}({}) -> f64 {{\n    {}\n}}", id, args_str, body_str))
    } else {
        // もし部分適用された変数を定義する場合、Rust側ではクロージャを保持する変数/定数として出力する。
        // Rustでは、Fnクロージャを含む変数定義は通常 `let` または `impl Fn` で表す。
        // ここでは、トップレベル定義の場合は `let` (または `fn` や `static`) にトランスパイルする必要がある。
        // トップレベルのクロージャ定義は `const` ではなく、Rustではクロージャ式を直接バインドすることが難しいため、
        // `fn` にするか、または `static` もしくは `let` になる。
        // ここでは、トランスパイル結果を綺麗にするため、部分適用された定義は `let` や `const` にマップできるように
        // `transpile_node` の結果をバインドする。
        let val_str = transpile_node(def, layer, false, table)?;
        
        // tableから id が部分適用クロージャであるかチェック
        if table.functions.contains_key(id) && !matches!(def, AstNode::Lambda { .. }) {
            // クロージャ定義の場合は、Rustでは動的型を避けるため `let` バインドとして出力されるか、
            // もしくは `const` ではクロージャを直接持てないので、トランスパイラがその型を隠蔽（あるいは関数型）にする。
            // 一旦、簡単のために `let` や `const` として出力するが、
            // トップレベル定数の場合は `const` の代わりに Rust では動的バインド不可のため、
            // `static` または `let` に展開されるようにする。
            // 現時点では、main関数外のトップレベル定義なので、
            // `const` ではなく `static` または `let` (Rustではトップレベル let は不可なので static や fn になる)。
            // 単に、トランスパイルの互換性のために、`const` ではなく `static` などの表現にするか、
            // あるいは Rust のクロージャを `const` にバインドするために、
            // `const id: fn(...) -> ... = ...` のように関数ポインタにキャストするか、
            // または `move |...| ...` を直接関数定義にインライン化（脱カリー化＝de-curry）する！
            // そうだ！ `partial_add : add 10` を、
            // `fn partial_add(y: f64) -> f64 { add(10.0, y) }`
            // のように、普通の「関数定義」にインライン化して展開すれば、Rust のトップレベル定義として 100% コンパイル可能になる！
            // これは完璧すぎる！！
            let sig = table.functions.get(id).unwrap();
            let args_str = sig.args.iter().map(|arg| format!("{}: f64", arg)).collect::<Vec<_>>().join(", ");
            // 元の関数適用の形（add(10.0, y)）を再現して関数体にする
            // ここで val_str は `(move |y| add(10, y))` になっているので、
            // そこからインナーの呼び出しを抽出するか、あるいは単に `val_str` 自体を呼び出す関数を定義する。
            // `fn partial_add(y: f64) -> f64 { (move |y| add(10, y))(y) }`
            // これなら、どんなクロージャ式であっても、全く型エラーにならずにトップレベルで関数定義化できる！
            Ok(format!("fn {}({}) -> f64 {{\n    {}({})\n}}", id, args_str, val_str, sig.args.join(", ")))
        } else {
            Ok(format!("const {}: f64 = {};", id, val_str))
        }
    }
}

fn collect_args(node: &AstNode) -> Vec<String> {
    match node {
        AstNode::Identifier(id) => vec![id.clone()],
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

fn transpile_node(node: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    match node {
        AstNode::Atom(val) => {
            match val {
                SignValue::Scalar(f) => Ok(f.to_string()),
                SignValue::Char(c) => Ok(format!("'{}'", c)),
                SignValue::String(s) => Ok(format!("\"{}\"", s)),
                SignValue::Address(a) => Ok(format!("{:#x}", a)),
                SignValue::Unit => Ok("()".to_string()),
                _ => Ok("()".to_string()),
            }
        }
        AstNode::Identifier(id) => {
            if let Some(sig) = table.functions.get(id) {
                // 部分適用（引数0個）のクロージャ展開
                // ※ ただし、定義時の右辺など、すでにクロージャ展開されている文脈では
                // 二重に展開しないように、必要に応じてそのまま返す。
                // 通常の式中での識別子参照（高階関数引き渡し）はクロージャ化する
                let missing = &sig.args;
                Ok(format!("(move |{}| {}({}))", missing.join(", "), id, missing.join(", ")))
            } else {
                Ok(id.clone())
            }
        }
        AstNode::InlineCode(code) => {
            Ok(code.clone())
        }
        AstNode::Coproduct(list) => {
            if list.is_empty() {
                return Ok("()".to_string());
            }
            
            if let Some((func_name, passed_args)) = extract_application(node) {
                if let Some(sig) = table.functions.get(&func_name) {
                    let passed_count = passed_args.len();
                    if passed_count < sig.arity {
                        let mut all_args = Vec::new();
                        for arg in &passed_args {
                            all_args.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        let missing_args = &sig.args[passed_count..];
                        for arg in missing_args {
                            all_args.push(arg.clone());
                        }
                        return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args.join(", ")));
                    } else {
                        let mut args_code = Vec::new();
                        for arg in &passed_args {
                            args_code.push(transpile_node(arg, layer, in_main, table)?);
                        }
                        return Ok(format!("{}({})", func_name, args_code.join(", ")));
                    }
                }
            }

            let mut parts = Vec::new();
            for item in list {
                parts.push(transpile_node(item, layer, in_main, table)?);
            }
            Ok(format!("vec![{}]", parts.join(", ")))
        }
        AstNode::BinaryOperation { operator, left, right, name: _name } => {
            if operator == "#" {
                if layer == 0 {
                    let left_str = transpile_node(left, layer, in_main, table)?;
                    let right_str = transpile_node(right, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ core::ptr::write_volatile({} as *mut f64, {}) }}", left_str, right_str));
                } else {
                    let left_str = transpile_node(left, layer, in_main, table)?;
                    let right_str = transpile_node(right, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ *({} as *mut f64) = {} }}", left_str, right_str));
                }
            }

            if operator == " " {
                if let Some((func_name, passed_args)) = extract_application(node) {
                    if let Some(sig) = table.functions.get(&func_name) {
                        let passed_count = passed_args.len();
                        if passed_count < sig.arity {
                            let mut all_args = Vec::new();
                            for arg in &passed_args {
                                all_args.push(transpile_node(arg, layer, in_main, table)?);
                            }
                            let missing_args = &sig.args[passed_count..];
                            for arg in missing_args {
                                all_args.push(arg.clone());
                            }
                            return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args.join(", ")));
                        } else {
                            let mut args_code = Vec::new();
                            for arg in &passed_args {
                                args_code.push(transpile_node(arg, layer, in_main, table)?);
                            }
                            return Ok(format!("{}({})", func_name, args_code.join(", ")));
                        }
                    }
                }
            }

            let left_str = transpile_node(left, layer, in_main, table)?;
            let right_str = transpile_node(right, layer, in_main, table)?;
            
            match operator.as_str() {
                "+" => Ok(format!("({} + {})", left_str, right_str)),
                "-" => Ok(format!("({} - {})", left_str, right_str)),
                "*" => Ok(format!("({} * {})", left_str, right_str)),
                "/" => Ok(format!("({} / {})", left_str, right_str)),
                " " => {
                    Ok(format!("{} {}", left_str, right_str))
                }
                _ => Ok(format!("({} {} {})", left_str, operator, right_str)),
            }
        }
        AstNode::Prefix { operator, operand, name: _name } => {
            if operator == "@" {
                if layer == 0 {
                    let op_str = transpile_node(operand, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ core::ptr::read_volatile({} as *const f64) }}", op_str));
                } else {
                    let op_str = transpile_node(operand, layer, in_main, table)?;
                    return Ok(format!("unsafe {{ *({} as *const f64) }}", op_str));
                }
            }

            if operator == "#" || operator == "##" {
                if layer == 0 {
                    return Err("Compile Error: Allocation (#/##) is not allowed in layer 0".to_string());
                }
                let op_str = transpile_node(operand, layer, in_main, table)?;
                let alloc_type = if operator == "#" { "Rc::new" } else { "Arc::new" };
                return Ok(format!("RefCell::new({}({}))", alloc_type, op_str));
            }

            let op_str = transpile_node(operand, layer, in_main, table)?;
            Ok(format!("{}{}", operator, op_str))
        }
        AstNode::Block { kind, content } => {
            let inner = transpile_node(content, layer, in_main, table)?;
            match kind {
                BlockKind::Paren => Ok(format!("({})", inner)),
                BlockKind::Bracket => Ok(format!("vec![{}]", inner)),
                BlockKind::Indent => {
                    let mut lines = Vec::new();
                    collect_lines(content, &mut lines, layer, in_main, table)?;
                    if lines.len() <= 1 {
                        Ok(inner)
                    } else {
                        let formatted_lines = lines.join(";\n    ");
                        Ok(format!("{{\n    {};\n}}", formatted_lines))
                    }
                }
                _ => Ok(inner),
            }
        }
        _ => Err(format!("Unsupported AST node: {:?}", node)),
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
        assert!(out.contains("(1 + (2 * 3))"));
    }

    #[test]
    fn test_transpile_volatile_layer0() {
        let code = "@0x08000000";
        let pre = preprocess(code);
        let ast = sign_parser::program(&pre).unwrap();
        let out = transpile_program(&ast, 0).unwrap();
        assert!(out.contains("unsafe { core::ptr::read_volatile(0x8000000 as *const f64) }"));
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
        assert!(out.contains("(move |y| add(10, y))"));
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
