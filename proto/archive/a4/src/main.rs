use std::fs;
use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();
    
    if args.len() < 2 {
        eprintln!("Usage: {} <input.sn> [output.json]", args[0]);
        std::process::exit(1);
    }
    
    let input_path = &args[1];
    let output_path = args.get(2).map(|s| s.as_str()).unwrap_or("result.json");
    
    // 入力読み込み
    let code = fs::read_to_string(input_path)
        .unwrap_or_else(|e| {
            eprintln!("Failed to read {}: {}", input_path, e);
            std::process::exit(1);
        });
    
    // コンパイル
    let json = sign_parser::compile(&code)
        .unwrap_or_else(|e| {
            eprintln!("Compile error: {}", e);
            std::process::exit(1);
        });
    
    // 出力
    fs::write(output_path, json)
        .unwrap_or_else(|e| {
            eprintln!("Failed to write {}: {}", output_path, e);
            std::process::exit(1);
        });
    
    println!("✓ Compiled {} -> {}", input_path, output_path);
}