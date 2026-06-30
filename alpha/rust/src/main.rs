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

` === 値ベースの比較（単位元ルール）と3項チェイン評価のテスト ===
val_cmp_non_unit : 2.0 < 5.0
val_cmp_unit : 1.0 < 5.0
val_cmp_chain : 1.0 < 3.0 < 5.0
val_cmp_chain_fail : 2.0 < 1.0 < 5.0

` === Hole（_）による静的脱糖部分適用のテスト ===
hole_partial : add _ 5.0
hole_partial_result : hole_partial 10.0

hole_op : _ + 100.0
hole_op_result : hole_op 50.0

` === オブジェクト定義と構造体メンバ暗黙抽出のテスト ===
Foo :
	foo : 500.0
	bar : 200.0

extract_foo : foo ~Foo ? @foo + 100.0
struct_extract_success : extract_foo Foo

extract_foo_fail : baz ~Foo ? baz
struct_extract_fail : extract_foo_fail Foo

` === 統合的関数のテスト（オブジェクト、暗黙抽出、可変長再帰、部分適用、3項チェイン） ===
Item :
	price : 0.0

ItemA : Item :
	price : 150.0

ItemB : Item :
	price : 80.0

ItemC : Item :
	price : 300.0

check_limit : limit price ~Item ?
	(@price > limit) & price | __

check_over_100 : item ? check_limit 100.0 item | 0.0

sum_filtered : item ~ys ?
	(check_over_100 item) + (sum_filtered ys~)

total_expensive : sum_filtered ItemA ItemB ItemC

` === リスト分割代入（デストラクト）と参照渡しのテスト ===
g : [x ~y] ?
	x

list_destruct_result : g [10.0 20.0 30.0]

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
"println!(\"hole_partial_result = {}\", @{hole_partial_result})"
"println!(\"hole_op_result = {}\", @{hole_op_result})"
"println!(\"val_cmp_non_unit = {:?}\", @{val_cmp_non_unit})"
"println!(\"val_cmp_unit = {:?}\", @{val_cmp_unit})"
"println!(\"val_cmp_chain = {:?}\", @{val_cmp_chain})"
"println!(\"val_cmp_chain_fail = {:?}\", @{val_cmp_chain_fail})"
"println!(\"struct_extract_success = {:?}\", @{struct_extract_success})"
"println!(\"struct_extract_fail = {:?}\", {struct_extract_fail})"
"println!(\"total_expensive = {}\", @{total_expensive})"
"println!(\"list_destruct_result = {}\", @{list_destruct_result})"
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
