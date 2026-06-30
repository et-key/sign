// alpha/rust/src/lexer.rs

pub fn preprocess(input: &str) -> String {
    let marked = mark_block(input);
    separate_infix(&marked)
}

fn mark_block(input: &str) -> String {
    let lines: Vec<&str> = input.split('\n').collect();
    let mut indent_stack = vec![0];
    let mut result = Vec::new();
    let mut last_content_line_idx: Option<usize> = None;

    for line in lines {
        let line_trimmed_cr = line.trim_end_matches('\r');
        if line_trimmed_cr.trim().is_empty() {
            result.push(line_trimmed_cr.to_string());
            continue;
        }

        let mut current_indent = 0;
        for c in line_trimmed_cr.chars() {
            if c == '\t' {
                current_indent += 1;
            } else {
                break;
            }
        }

        let content = &line_trimmed_cr[current_indent..];
        let content_trimmed = content.trim();
        let is_continuation = is_continuation_line(content_trimmed);

        if is_continuation {
            if let Some(idx) = last_content_line_idx {
                result[idx].push(' ');
                result[idx].push_str(content);
            } else {
                result.push(content.to_string());
                last_content_line_idx = Some(result.len() - 1);
            }
        } else {
            while indent_stack.len() > 1 && current_indent < *indent_stack.last().unwrap() {
                indent_stack.pop();
                if let Some(idx) = last_content_line_idx {
                    result[idx].push('\x03'); // DEDENT
                }
            }

            if current_indent > *indent_stack.last().unwrap() {
                indent_stack.push(current_indent);
                if let Some(idx) = last_content_line_idx {
                    result[idx].push('\x02'); // INDENT
                    result[idx].push_str(content);
                } else {
                    let mut s = String::new();
                    s.push('\x02');
                    s.push_str(content);
                    result.push(s);
                    last_content_line_idx = Some(result.len() - 1);
                }
            } else {
                result.push(content.to_string());
                last_content_line_idx = Some(result.len() - 1);
            }
        }
    }

    while indent_stack.len() > 1 {
        indent_stack.pop();
        if let Some(idx) = last_content_line_idx {
            result[idx].push('\x03'); // DEDENT
        }
    }

    result.join("\n")
}

fn is_continuation_line(s: &str) -> bool {
    if s.is_empty() {
        return false;
    }
    let first_char = s.chars().next().unwrap();
    if "?+*/.,=<>;%&^".contains(first_char) {
        return true;
    }
    if s.starts_with("!=") || s.starts_with("||") {
        return true;
    }
    if first_char == '~' {
        if s.len() > 1 {
            let next_char = s.chars().nth(1).unwrap();
            if next_char.is_whitespace() || "+*/^-".contains(next_char) {
                return true;
            }
        }
    }
    if first_char == '|' {
        if s.len() > 1 {
            let next_char = s.chars().nth(1).unwrap();
            if next_char.is_whitespace() || next_char == '|' {
                return true;
            }
        }
    }
    false
}

fn separate_infix(input: &str) -> String {
    let chars: Vec<char> = input.chars().collect();
    let mut i = 0;
    let mut result = String::new();

    let long_infix = vec![
        "!==", "===", "~+", "~-", "~*", "~/", "~^",
        "||", ";;", "&&", "<<", ">>", "!=", "==", "<=", ">="
    ];
    let short_infix = vec![
        ':', '?', ',', ';', '<', '=', '>', '+', '-', '*', '/', '%', '^', '\''
    ];

    while i < chars.len() {
        if chars[i] == '`' {
            result.push(chars[i]);
            i += 1;
            while i < chars.len() && chars[i] != '\n' && chars[i] != '\r' {
                if chars[i] == '`' {
                    result.push(chars[i]);
                    i += 1;
                    break;
                }
                result.push(chars[i]);
                i += 1;
            }
            continue;
        }

        if chars[i] == '"' {
            result.push(chars[i]);
            i += 1;
            while i < chars.len() {
                if chars[i] == '\\' && i + 1 < chars.len() {
                    result.push(chars[i]);
                    result.push(chars[i+1]);
                    i += 2;
                } else if chars[i] == '"' {
                    result.push(chars[i]);
                    i += 1;
                    break;
                } else {
                    result.push(chars[i]);
                    i += 1;
                }
            }
            continue;
        }

        if chars[i] == '\\' && i + 1 < chars.len() {
            result.push(chars[i]);
            result.push(chars[i+1]);
            i += 2;
            continue;
        }

        if i + 1 < chars.len() && chars[i] == '!' && chars[i+1] == '!' {
            result.push('!');
            result.push('!');
            i += 2;
            continue;
        }

        let mut matched_long = false;
        for op in &long_infix {
            let op_len = op.len();
            if i + op_len <= chars.len() {
                let chunk: String = chars[i..i+op_len].iter().collect();
                if chunk == *op {
                    result.push(' ');
                    result.push_str(op);
                    result.push(' ');
                    i += op_len;
                    matched_long = true;
                    break;
                }
            }
        }
        if matched_long {
            continue;
        }

        if short_infix.contains(&chars[i]) {
            result.push(' ');
            result.push(chars[i]);
            result.push(' ');
            i += 1;
            continue;
        }

        result.push(chars[i]);
        i += 1;
    }

    result
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_mark_block() {
        let input = "main :\n\t1 + 2\n\t3 * 4";
        let out = mark_block(input);
        assert!(out.contains("\x02"));
        assert!(out.contains("\x03"));
    }

    #[test]
    fn test_separate_infix() {
        let input = "1+2*3";
        let out = separate_infix(input);
        assert_eq!(out, "1 + 2 * 3");
    }
}
