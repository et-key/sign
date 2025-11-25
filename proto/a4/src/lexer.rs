use nom::{
    IResult, branch::alt, bytes::complete::{tag, take_while1, take_while},
    character::complete::{char, space0, multispace0, digit1}, 
    combinator::{map, opt, recognize},
    multi::many0, sequence::{delimited, preceded, tuple},
};
use crate::types::Token;

fn number(input: &str) -> IResult<&str, Token> {
    // 16進数
    if let Ok((rest, _)) = tag::<_, _, nom::error::Error<&str>>("0x")(input) {
        let (rest, _) = take_while1(|c: char| c.is_ascii_hexdigit())(rest)?;
        let hex = &input[..input.len() - rest.len()];
        return Ok((rest, Token::Number(hex)));
    }
    
    // 8進数
    if let Ok((rest, _)) = tag::<_, _, nom::error::Error<&str>>("0o")(input) {
        let (rest, _) = take_while1(|c: char| c.is_digit(8))(rest)?;
        let oct = &input[..input.len() - rest.len()];
        return Ok((rest, Token::Number(oct)));
    }
    
    // 2進数
    if let Ok((rest, _)) = tag::<_, _, nom::error::Error<&str>>("0b")(input) {
        let (rest, _) = take_while1(|c: char| "01".contains(c))(rest)?;
        let bin = &input[..input.len() - rest.len()];
        return Ok((rest, Token::Number(bin)));
    }
    
    // 通常の数値
    let (input, num) = recognize(tuple((
        opt(char('-')),
        digit1,
        opt(tuple((char('.'), digit1))),
    )))(input)?;
    
    Ok((input, Token::Number(num)))
}

fn ident(input: &str) -> IResult<&str, Token> {
    let (input, id) = take_while1(|c: char| c.is_alphanumeric() || c == '_' || c == '.')(input)?;
    Ok((input, if id == "_" { Token::Unit } else { Token::Ident(id) }))
}

fn placeholder(input: &str) -> IResult<&str, Token> {
    alt((
        map(
            delimited(tag("__STR_"), take_while(|c: char| c.is_ascii_digit()), tag("__")),
            Token::String
        ),
        map(
            delimited(tag("__CHAR_"), take_while(|c: char| c.is_ascii_digit()), tag("__")),
            Token::Char
        ),
    ))(input)
}

// 演算子（位置判定なし、後で決定）
fn operator(input: &str) -> IResult<&str, Token> {
    let (input, op) = take_while1(|c: char| ":#,?~+-*/%^|;&<>=!'@$".contains(c))(input)?;
    Ok((input, Token::Infix(op))) // デフォルトは中置
}

fn block(input: &str) -> IResult<&str, Token> {
    delimited(
        char('['),
        map(many0(preceded(multispace0, token)), Token::Block),
        preceded(multispace0, char(']')),
    )(input)
}

fn token(input: &str) -> IResult<&str, Token> {
    preceded(space0, alt((number, placeholder, block, operator, ident)))(input)
}

pub fn tokenize(input: &str) -> Result<Vec<Token>, String> {
    match many0(token)(input) {
        Ok((rest, tokens)) if rest.trim().is_empty() => {
            // トークン列全体を見て演算子位置を判定
            Ok(determine_operator_positions(tokens))
        },
        Ok((rest, _)) => Err(format!("Unparsed: {}", rest)),
        Err(e) => Err(format!("Parse error: {:?}", e)),
    }
}

// トークン列を見て演算子の位置を判定
fn determine_operator_positions(tokens: Vec<Token>) -> Vec<Token> {
    let mut result = Vec::new();
    
    for i in 0..tokens.len() {
        match &tokens[i] {
            Token::Infix(op) => {
                let has_left = i > 0 && is_operand(&tokens[i - 1]);
                let has_right = i + 1 < tokens.len() && is_operand(&tokens[i + 1]);
                
                let positioned = match (has_left, has_right) {
                    (true, true) => Token::Infix(op),
                    (false, true) => Token::Prefix(op),
                    (true, false) => Token::Postfix(op),
                    (false, false) => Token::Infix(op), // デフォルト
                };
                result.push(positioned);
            }
            other => result.push(other.clone()),
        }
    }
    
    result
}

// オペランドかどうか判定
fn is_operand(token: &Token) -> bool {
    matches!(token, 
        Token::Number(_) | Token::String(_) | Token::Char(_) | 
        Token::Ident(_) | Token::Unit | Token::Block(_)
    )
}