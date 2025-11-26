use regex::Regex;

pub struct Protected {
    pub code: String,
    pub strings: Vec<String>,
    pub chars: Vec<String>,
}

pub fn prepare(code: &str) -> Protected {
    let mut strings = Vec::new();
    let mut chars = Vec::new();
    
    let code = code.chars()
        .filter(|c| !c.is_control() || matches!(c, '\n' | '\r' | '\t'))
        .collect::<String>();
    
    let re_line_cont = Regex::new(r"\\(\r\n|\r|\n)").unwrap();
    let code = re_line_cont.replace_all(&code, " ");
    
    let re_comment = Regex::new(r"(?m)^`[^\r\n]*").unwrap();
    let code = re_comment.replace_all(&code, "");
    
    let re_str = Regex::new(r"`([^`\r\n]*)`").unwrap();
    let code = re_str.replace_all(&code, |caps: &regex::Captures| {
        let idx = strings.len();
        strings.push(caps[1].to_string());
        format!("__STR_{}__", idx)
    });
    
    let re_char = Regex::new(r"\\(.)").unwrap();
    let code = re_char.replace_all(&code, |caps: &regex::Captures| {
        let idx = chars.len();
        chars.push(caps[1].to_string());
        format!("__CHAR_{}__", idx)
    });
    
    let code = code.to_string()
        .replace(['{', '('], "[")
        .replace(['}', ')'], "]");
    
    let code = process_indent_blocks(&code);
    
    Protected { code, strings, chars }
}

fn process_indent_blocks(code: &str) -> String {
    let lines: Vec<&str> = code.lines().collect();
    let mut result = Vec::new();
    let mut i = 0;
    
    while i < lines.len() {
        let line = lines[i];
        let indent = line.chars().take_while(|c| *c == '\t').count();
        let trimmed = line.trim();
        
        if trimmed.is_empty() {
            i += 1;
            continue;
        }
        
        let mut line_result = trimmed.to_string();
        
        if i + 1 < lines.len() {
            let next_indent = lines[i + 1].chars().take_while(|c| *c == '\t').count();
            
            if next_indent > indent {
                line_result.push_str(" [");
                let (content, end) = collect_block(&lines, i + 1, next_indent);
                line_result.push_str(&content);
                line_result.push(']');
                i = end;
            } else {
                i += 1;
            }
        } else {
            i += 1;
        }
        
        result.push(line_result);
    }
    
    result.join("\n")
}

fn collect_block(lines: &[&str], start: usize, base: usize) -> (String, usize) {
    let mut result = String::new();
    let mut i = start;
    
    while i < lines.len() {
        let indent = lines[i].chars().take_while(|c| *c == '\t').count();
        let trimmed = lines[i].trim();
        
        if trimmed.is_empty() {
            i += 1;
            continue;
        }
        
        if indent < base { break; }
        
        if !result.is_empty() && !result.ends_with(' ') {
            result.push(' ');
        }
        result.push_str(trimmed);
        
        if i + 1 < lines.len() {
            let next = lines[i + 1].chars().take_while(|c| *c == '\t').count();
            if next > indent {
                result.push_str(" [");
                let (content, end) = collect_block(lines, i + 1, next);
                result.push_str(&content);
                result.push(']');
                i = end;
            } else {
                i += 1;
            }
        } else {
            i += 1;
        }
    }
    
    (result, i)
}