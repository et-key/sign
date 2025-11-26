use crate::types::{Token, SExpr, precedence, is_right_assoc};

pub fn parse(tokens: Vec<Token>, strings: &[String], chars: &[String]) -> Result<SExpr, String> {
    if tokens.is_empty() { 
        return Ok(SExpr::List(vec![])); 
    }
    
    // ラムダ式の前処理
    let tokens = preprocess_lambda(tokens)?;
    
    // 単項演算子の処理
    let tokens = process_unary_operators(tokens, strings, chars)?;
    
    // Shunting Yardで優先順位処理
    shunting_yard(tokens, strings, chars)
}

/// ラムダ式（x ? body）をブロック化
fn preprocess_lambda<'a>(tokens: Vec<Token<'a>>) -> Result<Vec<Token<'a>>, String> {
    // ? の位置を探す
    let lambda_pos = match tokens.iter().position(|t| matches!(t, Token::Infix(op) if *op == "?")) {
        Some(pos) => pos,
        None => return Ok(tokens), // ラムダなし
    };
    
    // : の位置を探す（定義文かどうか）
    let define_pos = tokens[..lambda_pos].iter()
        .position(|t| matches!(t, Token::Infix(op) if *op == ":"));
    
    // 引数の開始位置を決定
    let param_start = define_pos.map(|p| p + 1).unwrap_or(0);
    
    // 引数を集める（? の直前まで）
    let params: Vec<Token> = tokens[param_start..lambda_pos]
        .iter()
        .filter(|t| matches!(t, Token::Ident(_)))
        .cloned()
        .collect();
    
    if params.is_empty() {
        return Err("Lambda ? without parameters".to_string());
    }
    
    // ? の後のボディを集める
    let body: Vec<Token> = tokens[lambda_pos + 1..].to_vec();
    
    if body.is_empty() {
        return Err("Lambda ? without body".to_string());
    }
    
    // ボディ内のラムダも再帰的に処理
    let body = preprocess_lambda(body)?;
    
    // カリー化されたラムダを構築
    let lambda = build_curried_lambda(params, body);
    
    // 結果を構築
    let mut result: Vec<Token> = tokens[..param_start].to_vec();
    result.push(lambda);
    
    Ok(result)
}

/// カリー化されたラムダを構築: x y ? body → [? x [? y body]]
fn build_curried_lambda<'a>(params: Vec<Token<'a>>, body: Vec<Token<'a>>) -> Token<'a> {
    if params.is_empty() {
        panic!("Cannot build lambda without parameters");
    }
    
    if params.len() == 1 {
        // 最後のパラメータ: [? param body]
        Token::Block(vec![
            Token::Infix("?"),
            params[0].clone(),
            Token::Block(body),
        ])
    } else {
        // 複数パラメータ: [? param [? ...]]
        let inner = build_curried_lambda(params[1..].to_vec(), body);
        Token::Block(vec![
            Token::Infix("?"),
            params[0].clone(),
            inner,
        ])
    }
}

/// 単項演算子（前置・後置）を[op operand]の形にブロック化
fn process_unary_operators<'a>(
    tokens: Vec<Token<'a>>, 
    strings: &[String], 
    chars: &[String]
) -> Result<Vec<Token<'a>>, String> {
    let mut result = Vec::new();
    let mut i = 0;
    
    while i < tokens.len() {
        match &tokens[i] {
            // 前置演算子の処理
            Token::Prefix(op) => {
                if i + 1 >= tokens.len() {
                    return Err(format!("Prefix operator {} without operand", op));
                }
                
                let operand = if let Token::Block(inner) = &tokens[i + 1] {
                    // ラムダブロックは再処理しない（[? param body]の形）
                    if inner.len() == 3 && matches!(&inner[0], Token::Infix(op) if *op == "?") {
                        tokens[i + 1].clone()
                    } else {
                        // 通常のブロックは再帰的に処理
                        Token::Block(process_unary_operators(inner.clone(), strings, chars)?)
                    }
                } else {
                    tokens[i + 1].clone()
                };
                
                result.push(Token::Block(vec![
                    Token::Prefix(op),
                    operand,
                ]));
                i += 2;
            }
            
            // 後置演算子をチェック
            token => {
                if i + 1 < tokens.len() {
                    if let Token::Postfix(op) = &tokens[i + 1] {
                        let operand = if let Token::Block(inner) = token {
                            // ラムダブロックは再処理しない
                            if inner.len() == 3 && matches!(&inner[0], Token::Infix(op) if *op == "?") {
                                token.clone()
                            } else {
                                Token::Block(process_unary_operators(inner.clone(), strings, chars)?)
                            }
                        } else {
                            token.clone()
                        };
                        
                        result.push(Token::Block(vec![
                            operand,
                            Token::Postfix(op),
                        ]));
                        i += 2;
                        continue;
                    }
                }
                
                // ブロック内も処理
                if let Token::Block(inner) = token {
                    // ラムダブロックは再処理しない
                    if inner.len() == 3 && matches!(&inner[0], Token::Infix(op) if *op == "?") {
                        result.push(token.clone());
                    } else {
                        result.push(Token::Block(process_unary_operators(inner.clone(), strings, chars)?));
                    }
                } else {
                    result.push(token.clone());
                }
                i += 1;
            }
        }
    }
    
    Ok(result)
}

/// トークンをS式に変換
fn token_to_sexpr(token: &Token, strings: &[String], chars: &[String]) -> Result<SExpr, String> {
    match token {
        Token::Number(n) => Ok(SExpr::atom(*n)),
        Token::String(idx_str) => {
            let idx: usize = idx_str.parse().map_err(|_| "Invalid string index")?;
            let content = strings.get(idx).ok_or("String index out of bounds")?;
            Ok(SExpr::atom(format!("\"{}\"", content)))
        }
        Token::Char(idx_str) => {
            let idx: usize = idx_str.parse().map_err(|_| "Invalid char index")?;
            let content = chars.get(idx).ok_or("Char index out of bounds")?;
            Ok(SExpr::atom(format!("'{}'", content)))
        }
        Token::Ident(id) => Ok(SExpr::atom(*id)),
        Token::Unit => Ok(SExpr::atom("_")),
        Token::Block(inner) => {
            // ラムダブロックの場合はpreprocess_lambdaをスキップ
            if inner.len() == 3 && matches!(&inner[0], Token::Infix(op) if *op == "?") {
                // process_unary_operatorsとshunting_yardのみ実行
                let processed = process_unary_operators(inner.clone(), strings, chars)?;
                shunting_yard(processed, strings, chars)
            } else {
                // 通常のブロックは全パイプラインで処理
                parse(inner.clone(), strings, chars)
            }
        }
        _ => Err(format!("Cannot convert {:?} to S-expression", token)),
    }
}

/// Shunting Yardアルゴリズムで優先順位処理
fn shunting_yard(tokens: Vec<Token>, strings: &[String], chars: &[String]) -> Result<SExpr, String> {
    let mut output: Vec<SExpr> = Vec::new();
    let mut operators: Vec<&str> = Vec::new();
    
    for token in &tokens {
        match token {
            // オペランド: 出力に追加
            Token::Number(_) | Token::String(_) | Token::Char(_) | Token::Ident(_) | Token::Unit => {
                output.push(token_to_sexpr(token, strings, chars)?);
            }
            
            // ブロック: 再帰的に処理
            Token::Block(inner) => {
                // ラムダ式かチェック: [? param body]
                if inner.len() == 3 
                    && matches!(&inner[0], Token::Infix(op) if *op == "?") 
                {
                    let param_sexpr = token_to_sexpr(&inner[1], strings, chars)?;
                    let body_sexpr = token_to_sexpr(&inner[2], strings, chars)?;
                    
                    output.push(SExpr::List(vec![
                        SExpr::atom("?"),
                        param_sexpr,
                        body_sexpr,
                    ]));
                    continue;
                }
                
                // 単項演算チェック: [op operand]
                if inner.len() == 2 {
                    match (&inner[0], &inner[1]) {
                        (Token::Prefix(op), operand) => {
                            let operand_sexpr = token_to_sexpr(operand, strings, chars)?;
                            output.push(SExpr::List(vec![SExpr::atom(*op), operand_sexpr]));
                            continue;
                        }
                        (operand, Token::Postfix(op)) => {
                            let operand_sexpr = token_to_sexpr(operand, strings, chars)?;
                            output.push(SExpr::List(vec![SExpr::atom(*op), operand_sexpr]));
                            continue;
                        }
                        _ => {}
                    }
                }
                
                // 通常のブロック: 再帰的にパース
                output.push(parse(inner.clone(), strings, chars)?);
            }
            
            // 中置演算子: 優先順位処理
            Token::Infix(op) => {
                let prec = precedence(op);
                let is_right = is_right_assoc(op);
                
                // スタック上の高優先度演算子を処理
                while let Some(&stack_op) = operators.last() {
                    let stack_prec = precedence(stack_op);
                    
                    if stack_prec > prec || (stack_prec == prec && !is_right) {
                        operators.pop();
                        apply_binary_op(&mut output, stack_op)?;
                    } else {
                        break;
                    }
                }
                
                operators.push(op);
            }
            
            _ => return Err(format!("Unexpected token in shunting yard: {:?}", token)),
        }
    }
    
    // 残りの演算子を処理
    while let Some(op) = operators.pop() {
        apply_binary_op(&mut output, op)?;
    }
    
    // 結果を返す
    if output.len() == 1 {
        Ok(output.pop().unwrap())
    } else if output.is_empty() {
        Ok(SExpr::List(vec![]))
    } else {
        // 複数の式がある場合はリストとして返す
        Ok(SExpr::List(output))
    }
}

/// 二項演算子を適用
fn apply_binary_op(output: &mut Vec<SExpr>, op: &str) -> Result<(), String> {
    if output.len() < 2 {
        return Err(format!("Not enough operands for operator {}", op));
    }
    
    let right = output.pop().unwrap();
    let left = output.pop().unwrap();
    
    output.push(SExpr::List(vec![
        SExpr::atom(op),
        left,
        right,
    ]));
    
    Ok(())
}
