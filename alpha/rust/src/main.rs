// alpha/rust/src/main.rs
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

mul : x y ?
	x * y

` 部分適用のテスト
partial_add : add 10

` 比較と短絡評価のテスト
a : 10.0
b : 20.0

` a が 5 より大きく、かつ b が 15 より大きい場合、Some(1.0) を返す。そうでなければ __ (None)
cond_result : (a > 5.0) & (b > 15.0) | __

` 比較3項演算 (match_case と同じ match 展開で解決される)
ternary_result : (a > 5.0) ? 99.0 : 88.0

` 複数行 of match_case ブロック (同じ match 展開)
match_result :
	a == 5.0 : 50.0
	b == 20.0 : 200.0
	999.0

` ポイントフリー：すべて足し算 (Sum)
sum_result : [+] 1.0 2.0 3.0 4.0 5.0

` ポイントフリー：各要素に2.0を掛ける (Map)
map_result : [* 2.0,] 1.0 2.0 3.0

` === Coproduct Resolver (余積解決器) 全レベルのテスト ===

` 10.3: Atom + Atom -> concat (リスト連接)
concat_result : 1.0 2.0

` 10.2: Lambda + Lambda -> compose (左結合関数合成)
` 10.1: Lambda + Atom -> apply (関数適用)
` 5.0 に (+1.0) して (*2.0) する -> (5 + 1) * 2 = 12.0
compose_result : (add 1.0) (mul 2.0) 5.0

` 10.0: Atom + Lambda -> apply_reverse (逆適用)
` 5.0 に (+1.0) する -> 6.0
reverse_result : 5.0 (add 1.0)

` === 高階関数 ＆ 前置$サスペンド・遅延評価のテスト ===
` 関数 f を受け取って 5.0 を適用する
apply_five : f ?
	(@f) 5.0

` (add 10.0) をサスペンドして高階関数に引数として渡す
high_order_result : apply_five ($(add 10.0))

` === 可変長(Rest)引数とスプレッド展開再帰のテスト ===
c : #0.0
list_loop : x ~y ?
	c # (@c) + 1.0
	list_loop y~

list_loop 1.0 2.0 3.0 4.0 5.0
list_len : @c

` === 4コア（IO/Heap/Stack/Arith）オーバーフロー引き回しパイプラインのテスト ===
` IO領域（0x0001番地）へ入力値 100.0 を送信してカスケード処理を開始する
route_msg 1.0 100.0

` 結果を出力する
"println!(\"partial_add 20 = {}\", @{partial_add 20.0})"
"println!(\"cond_result = {:?}\", @{cond_result})"
"println!(\"ternary_result = {:?}\", @{ternary_result})"
"println!(\"match_result = {:?}\", @{match_result})"
"println!(\"sum_result = {}\", @{sum_result})"
"println!(\"map_result = {:?}\", @{map_result})"
"println!(\"concat_result = {:?}\", @{concat_result})"
"println!(\"compose_result = {}\", @{compose_result})"
"println!(\"reverse_result = {}\", @{reverse_result})"
"println!(\"high_order_result = {}\", @{high_order_result})"
"println!(\"list_len = {}\", @{list_len})"
"println!(\"Result from 4-core pipeline = {}\", res_rx.recv().unwrap())"
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
    // デバッグ出力
    println!("Preprocessed Source:\n{}", pre);
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
