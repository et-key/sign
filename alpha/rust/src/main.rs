// alpha/rust/src/main.rs
pub mod runtime;
pub mod ast;
pub mod lexer;
pub mod parser;

use lexer::preprocess;
use parser::sign_parser;

fn main() {
    let source_code = r#"
` テストコード
add : x y ?
	x + y

#main :
	add 10 20
"#;

    println!("=== Original Source ===");
    println!("{}", source_code);

    println!("=== Preprocessed ===");
    let pre = preprocess(source_code);
    println!("{}", pre);

    println!("=== AST ===");
    match sign_parser::program(&pre) {
        Ok(ast) => {
            for node in ast {
                println!("{:#?}", node);
            }
        }
        Err(e) => {
            println!("Parse Error: {:?}", e);
        }
    }
}
