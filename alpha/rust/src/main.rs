// alpha/rust/src/main.rs
pub mod runtime;
pub mod ast;
pub mod lexer;
pub mod parser;
pub mod codegen;

use lexer::preprocess;
use parser::sign_parser;
use codegen::transpile_program;

fn main() {
    let source_code_std = r#"
` テストコード (stdレイヤー)
add : x y ?
	x + y

` 部分適用のテスト
partial_add : add 10

` 0個引数（高階関数引き渡し）のテスト
alias_add : add

` 実行
partial_add 20
"#;

    let source_code_bare = r#"
` テストコード (bareレイヤー)
register_addr : 0x08000000

@register_addr
register_addr # 100
"#;

    println!("=== Testing Layer 2 (OS Std) ===");
    run_transpile(source_code_std, 2);

    println!("\n=== Testing Layer 0 (Bare Metal) ===");
    run_transpile(source_code_bare, 0);
}

fn run_transpile(source: &str, layer: usize) {
    let pre = preprocess(source);
    match sign_parser::program(&pre) {
        Ok(ast) => {
            match transpile_program(&ast, layer) {
                Ok(rust_code) => {
                    println!("--- Generated Rust Code ---");
                    println!("{}", rust_code);
                }
                Err(e) => {
                    println!("Transpilation Error: {}", e);
                }
            }
        }
        Err(e) => {
            println!("Parse Error: {:?}", e);
        }
    }
}
