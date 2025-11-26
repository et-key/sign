use nom::{
    IResult,
    branch::alt,
    combinator::map,
    multi::{many0, many1},
    error::{Error, ErrorKind},
};
use crate::types::{Token, SExpr, precedence, is_right_assoc};

pub type TokenInput<'a> = &'a [Token<'a>];

// --- Basic Token Parsers ---

fn any_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    if input.is_empty() {
        Err(nom::Err::Error(Error::new(input, ErrorKind::Eof)))
    } else {
        Ok((&input[1..], &input[0]))
    }
}

fn satisfy<'a, F>(cond: F) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, &'a Token<'a>>
where
    F: Fn(&Token<'a>) -> bool,
{
    move |input: TokenInput<'a>| {
        let (input, t) = any_token(input)?;
        if cond(t) {
            Ok((input, t))
        } else {
            Err(nom::Err::Error(Error::new(input, ErrorKind::Verify)))
        }
    }
}

fn number_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Number(_)))(input)
}

fn ident_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Ident(_)))(input)
}

fn unit_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Unit))(input)
}

fn string_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::String(_)))(input)
}

fn char_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Char(_)))(input)
}

fn infix_token<'a>(op: &'a str) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, &'a Token<'a>> {
    move |input: TokenInput<'a>| {
        satisfy(|t| matches!(t, Token::Infix(o) if *o == op))(input)
    }
}

fn any_infix_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Infix(_)))(input)
}

fn prefix_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Prefix(_)))(input)
}

fn postfix_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Postfix(_)))(input)
}

fn block_token(input: TokenInput) -> IResult<TokenInput, &Token> {
    satisfy(|t| matches!(t, Token::Block(_)))(input)
}

// --- Helper Functions ---

fn token_to_atom(token: &Token) -> SExpr {
    match token {
        Token::Number(n) => SExpr::atom(*n),
        Token::Ident(id) => SExpr::atom(*id),
        Token::Unit => SExpr::atom("_"),
        // String and Char need context to resolve, but for now we assume they are resolved later or we pass context
        // Wait, the original parser resolves strings/chars using the lookup tables.
        // We need to pass strings/chars to the parser or resolve them here.
        // The original token_to_sexpr does this. We should probably do it here too.
        _ => panic!("Unexpected token for atom: {:?}", token),
    }
}

// We need to pass context (strings, chars) to the parser functions.
// To avoid passing them everywhere, we can create a struct or closure, 
// but for nom functions it's easier to just resolve them at the end or use a context object.
// Let's stick to the signature `parse(tokens, strings, chars)` and pass them down or use a closure.
// Since nom parsers are functions, we can't easily pass extra arguments without closures.
// Let's define the parser functions inside `parse` or make them take the context.

// Actually, the SExpr::Atom just holds a String. We can resolve the index to string content right away.
// But the Token holds the index as &str.
// Let's make a helper that takes the context.

fn resolve_string(token: &Token, strings: &[String]) -> SExpr {
    if let Token::String(idx_str) = token {
        let idx: usize = idx_str.parse().unwrap_or(0);
        let content = strings.get(idx).unwrap_or(&String::new()).clone();
        SExpr::atom(format!("\"{}\"", content))
    } else {
        SExpr::atom("")
    }
}

fn resolve_char(token: &Token, chars: &[String]) -> SExpr {
    if let Token::Char(idx_str) = token {
        let idx: usize = idx_str.parse().unwrap_or(0);
        let content = chars.get(idx).unwrap_or(&String::new()).clone();
        SExpr::atom(format!("'{}'", content))
    } else {
        SExpr::atom("")
    }
}

// --- Expression Parsers ---

// Context struct to pass around lookup tables
struct Context<'a> {
    strings: &'a [String],
    chars: &'a [String],
}

fn lambda_expr<'a>(ctx: &'a Context<'a>) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        let (input, params) = many1(ident_token)(input)?;
        let (input, _) = infix_token("?")(input)?;
        let (input, body) = expression(ctx)(input)?;
        
        Ok((input, build_curried_lambda(params, body)))
    }
}

fn build_curried_lambda(params: Vec<&Token>, body: SExpr) -> SExpr {
    // x y ? body -> [?, x, [?, y, body]]
    // params are [x, y]
    // reverse: [y, x]
    // fold:
    // acc = body
    // 1. param = y -> [?, y, body]
    // 2. param = x -> [?, x, [?, y, body]]
    
    params.iter().rev().fold(body, |acc, param| {
        SExpr::List(vec![
            SExpr::atom("?"),
            token_to_atom(param),
            acc,
        ])
    })
}

fn prefix_expr<'a>(ctx: &'a Context<'a>) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        let (input, op_token) = prefix_token(input)?;
        let (input, operand) = expression_bp(ctx, 99)(input)?; // High precedence for prefix
        
        let op_str = if let Token::Prefix(op) = op_token { *op } else { unreachable!() };
        Ok((input, SExpr::List(vec![SExpr::atom(op_str), operand])))
    }
}

fn block_expr<'a>(ctx: &'a Context<'a>) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        let (input, token) = block_token(input)?;
        if let Token::Block(inner_tokens) = token {
            // Recursively parse the block content
            // Note: inner_tokens is Vec<Token>, we need slice
            match parse_tokens(inner_tokens, ctx.strings, ctx.chars) {
                Ok(sexpr) => Ok((input, sexpr)),
                Err(_) => Err(nom::Err::Failure(Error::new(input, ErrorKind::Fail))),
            }
        } else {
            unreachable!()
        }
    }
}

fn primary<'a>(ctx: &'a Context<'a>) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        alt((
            lambda_expr(ctx), // Try lambda first (ident ... ? expr)
            map(number_token, |t| token_to_atom(t)),
            map(string_token, |t| resolve_string(t, ctx.strings)),
            map(char_token, |t| resolve_char(t, ctx.chars)),
            map(ident_token, |t| token_to_atom(t)),
            map(unit_token, |_| SExpr::atom("_")),
            prefix_expr(ctx),
            block_expr(ctx),
        ))(input)
    }
}

fn expression<'a>(ctx: &'a Context<'a>) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        expression_bp(ctx, 0)(input)
    }
}

fn expression_bp<'a>(ctx: &'a Context<'a>, min_bp: u8) -> impl Fn(TokenInput<'a>) -> IResult<TokenInput<'a>, SExpr> {
    move |input: TokenInput<'a>| {
        let (mut input, mut lhs) = primary(ctx)(input)?;
        
        loop {
            // Check for postfix operator
            if let Ok((rest, op_token)) = postfix_token(input) {
                let op_str = if let Token::Postfix(op) = op_token { *op } else { unreachable!() };
                // Postfix binding power is high, usually handles immediately
                // For simplicity, let's say it binds tighter than anything except maybe field access
                // In Pratt parsing, postfix is often handled in the loop
                let l_bp = 20; // High binding power for postfix
                if l_bp < min_bp {
                    break;
                }
                input = rest;
                lhs = SExpr::List(vec![lhs, SExpr::atom(op_str)]);
                continue;
            }

            // Check for infix operator
            let (rest, op_token) = match any_infix_token(input) {
                Ok(res) => res,
                Err(_) => break,
            };
            
            let op_str = if let Token::Infix(op) = op_token { *op } else { unreachable!() };
            let p = precedence(op_str);
            let (l_bp, r_bp) = if is_right_assoc(op_str) {
                // Right associative: right binds same as left
                (p, p)
            } else {
                (p, p + 1)
            };
            
            if l_bp < min_bp {
                break;
            }
            
            input = rest;
            let (rest, rhs) = expression_bp(ctx, r_bp)(input)?;
            input = rest;
            
            lhs = SExpr::List(vec![SExpr::atom(op_str), lhs, rhs]);
        }
        
        Ok((input, lhs))
    }
}

// --- Main Entry Point ---

fn parse_tokens(tokens: &[Token], strings: &[String], chars: &[String]) -> Result<SExpr, String> {
    let ctx = Context { strings, chars };
    
    // Parse multiple expressions until EOF
    // Use many0 to consume all expressions
    let mut parser = many0(expression(&ctx));
    
    match parser(tokens) {
        Ok((rest, mut exprs)) => {
            if !rest.is_empty() {
                return Err(format!("Unparsed tokens: {:?}", rest));
            }
            
            if exprs.len() == 1 {
                Ok(exprs.pop().unwrap())
            } else if exprs.is_empty() {
                Ok(SExpr::List(vec![]))
            } else {
                Ok(SExpr::List(exprs))
            }
        }
        Err(e) => Err(format!("Parse error: {:?}", e)),
    }
}

pub fn parse(tokens: Vec<Token>, strings: &[String], chars: &[String]) -> Result<SExpr, String> {
    parse_tokens(&tokens, strings, chars)
}
