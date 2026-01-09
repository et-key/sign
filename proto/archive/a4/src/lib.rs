pub mod types;
pub mod preprocessor;
pub mod lexer;
pub mod parser;

use preprocessor::Protected;
use types::SExpr;

pub fn compile(code: &str) -> Result<String, String> {
    let Protected { code: prepared, strings, chars } = preprocessor::prepare(code);
    
    let lines: Vec<&str> = prepared.lines()
        .map(|l| l.trim())
        .filter(|l| !l.is_empty())
        .collect();
    
    let mut results = Vec::new();
    
    for (i, line) in lines.iter().enumerate() {
        let tokens = lexer::tokenize(line)
            .map_err(|e| format!("Line {}: {}", i + 1, e))?;
        
        if tokens.is_empty() {
            continue;
        }
        
        let sexpr = parser::parse(tokens, &strings, &chars)
            .map_err(|e| format!("Line {}: {}", i + 1, e))?;
        
        results.push(sexpr);
    }
    
    let output = SExpr::List(results);
    serde_json::to_string_pretty(&output)
        .map_err(|e| format!("JSON error: {}", e))
}