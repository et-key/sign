// alpha/rust/src/main.rs
pub mod runtime;
pub mod ast;
pub mod lexer;
pub mod parser;
pub mod codegen;

use lexer::preprocess;
use parser::sign_parser;
use codegen::transpile_program;
use std::fs;
use std::process::Command;

fn main() {
    let source_code_std = r#"
` テストコード (stdレイヤー)
add : x y ?
	x + y

` 部分適用のテスト
partial_add : add 10

` 比較と短絡評価のテスト
a : 10.0
b : 20.0

` a が 5 より大きく、かつ b が 15 より大きい場合、Some(1.0) を返す。そうでなければ __ (None)
cond_result : (a > 5.0) & (b > 15.0) | __

` 比較3項演算 (match_case と同じ match 展開で解決される)
ternary_result : (a > 5.0) ? 99.0 : 88.0

` 複数行の match_case ブロック (同じ match 展開)
match_result :
	a == 5.0 : 50.0
	b == 20.0 : 200.0
	999.0

` 結果を出力する
"println!(\"partial_add 20 = {}\", partial_add(20.0))"
"println!(\"cond_result = {:?}\", cond_result)"
"println!(\"ternary_result = {:?}\", ternary_result)"
"println!(\"match_result = {:?}\", match_result)"
"#;

    let source_code_bare = r#"
` テストコード (bareレイヤー)
register_addr : 0x08000000

@register_addr
register_addr # 100
"#;

    println!("=== Testing Layer 2 (OS Std) ===");
    run_transpile(source_code_std, 2, "output_std");

    println!("\n=== Testing Layer 0 (Bare Metal) ===");
    run_transpile(source_code_bare, 0, "output_bare");
}

fn run_transpile(source: &str, layer: usize, name: &str) {
    let pre = preprocess(source);
    match sign_parser::program(&pre) {
        Ok(ast) => {
            match transpile_program(&ast, layer) {
                Ok(rust_code) => {
                    // 1. ファイル書き出し
                    let rs_filename = format!("{}.rs", name);
                    if let Err(e) = fs::write(&rs_filename, &rust_code) {
                        println!("Failed to write file {}: {}", rs_filename, e);
                        return;
                    }
                    println!("Saved to {}", rs_filename);

                    // 2. rustc によるコンパイル
                    let exe_filename = if cfg!(target_os = "windows") {
                        format!("{}.exe", name)
                    } else {
                        name.to_string()
                    };

                    println!("Compiling {} ...", rs_filename);
                    let compile_status = Command::new("rustc")
                        .arg(&rs_filename)
                        .arg("-o")
                        .arg(&exe_filename)
                        .status();

                    match compile_status {
                        Ok(status) if status.success() => {
                            println!("Compilation successful! Created {}", exe_filename);

                            // 3. バイナリの実行
                            if layer == 2 {
                                println!("Running {} ...", exe_filename);
                                let run_output = Command::new(format!("./{}", name)).output();
                                match run_output {
                                    Ok(output) => {
                                        println!("--- Execution Output ---");
                                        print!("{}", String::from_utf8_lossy(&output.stdout));
                                        if !output.stderr.is_empty() {
                                            println!("--- Execution Error ---");
                                            print!("{}", String::from_utf8_lossy(&output.stderr));
                                        }
                                    }
                                    Err(e) => {
                                        println!("Failed to run binary: {}", e);
                                    }
                                }
                            } else {
                                println!("Skip running (Layer 0 program may crash on OS due to volatile raw pointer access).");
                            }
                        }
                        Ok(status) => {
                            println!("Compilation failed with status: {}", status);
                        }
                        Err(e) => {
                            println!("Failed to execute rustc: {}", e);
                        }
                    }
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
