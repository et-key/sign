// alpha/rust/src/operators.rs
use crate::ast::{AstNode, BlockKind};
use crate::types::{AtomType, SymbolTable, infer_atom_type};
use crate::ast_helpers::substitute_args;
use crate::symbol_analysis::collect_member_definitions;
use crate::coproduct::{collect_coproduct_items, extract_applied_func_and_args};
use crate::codegen::transpile_node;
use crate::blocks::{transpile_match_arms, MatchArm};
use std::collections::HashMap;

pub fn transpile_three_term_range(start_str: &str, step_str: &str, end_str: &str, mode: &str) -> String {
    match mode {
        "~+" => {
            format!(
                "{{ let start = {}; let step = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if step > 0.0 {{ while cur <= end {{ v.push(cur); cur += step; }} }} else if step < 0.0 {{ while cur >= end {{ v.push(cur); cur += step; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~-" => {
            format!(
                "{{ let start = {}; let step = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if step > 0.0 {{ while cur >= end {{ v.push(cur); cur -= step; }} }} else if step < 0.0 {{ while cur <= end {{ v.push(cur); cur -= step; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~*" => {
            format!(
                "{{ let start = {}; let ratio = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if ratio > 1.0 {{ while cur <= end {{ v.push(cur); cur *= ratio; }} }} else if ratio < 1.0 && ratio > 0.0 {{ while cur >= end {{ v.push(cur); cur *= ratio; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~/" => {
            format!(
                "{{ let start = {}; let ratio = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if ratio > 1.0 {{ while cur >= end {{ v.push(cur); cur /= ratio; }} }} else if ratio < 1.0 && ratio > 0.0 {{ while cur <= end {{ v.push(cur); cur /= ratio; }} }} v }}",
                start_str, step_str, end_str
            )
        }
        "~^" => {
            format!(
                "{{ let start = {}; let exp = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if exp > 1.0 {{ while cur <= end {{ v.push(cur); cur = cur.powf(exp); }} }} else if exp < 1.0 && exp > 0.0 {{ while cur >= end {{ v.push(cur); cur = cur.powf(exp); }} }} v }}",
                start_str, step_str, end_str
            )
        }
        _ => {
            format!(
                "{{ let start = {}; let end = {}; let mut v = Vec::new(); let mut cur = start; if start <= end {{ while cur <= end {{ v.push(cur); cur += 1.0; }} }} else {{ while cur >= end {{ v.push(cur); cur -= 1.0; }} }} v }}",
                start_str, end_str
            )
        }
    }
}

pub fn transpile_binary_op(operator: &str, left: &AstNode, right: &AstNode, name: &str, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    let left_is_unit = matches!(left, AstNode::Unit);
    let right_is_unit = matches!(right, AstNode::Unit);

    if left_is_unit || right_is_unit {
        // 1. 吸収元演算子
        if ["+", "-", "*", "/", "%", "^", "<", ">", "<=", ">=", "==", "!=", "!==", "=", "<<", ">>", "||", ";;", "&&", "@", "'"].contains(&operator) {
            return Ok("None".to_string());
        }

        // 2. 積/連接演算子 `,`
        if operator == "," {
            if left_is_unit && right_is_unit {
                return Ok("None".to_string());
            } else if left_is_unit {
                return transpile_node(right, layer, in_main, table);
            } else {
                return transpile_node(left, layer, in_main, table);
            }
        }

        // 3. 論理演算子 & (and)
        if operator == "&" {
            if left_is_unit {
                return Ok("None".to_string());
            } else {
                let left_str = transpile_node(left, layer, in_main, table)?;
                return Ok(format!("{{ let _ = {}; None }}", left_str));
            }
        }

        // 4. 論理演算子 | (or)
        if operator == "|" {
            if left_is_unit {
                return transpile_node(right, layer, in_main, table);
            } else {
                let left_str = transpile_node(left, layer, in_main, table)?;
                if is_option_type(&left_str, table) {
                    return Ok(left_str);
                } else {
                    return Ok(format!("Option::from({})", left_str));
                }
            }
        }

        // 5. 論理演算子 ; (xor)
        if operator == ";" {
            if left_is_unit && right_is_unit {
                return Ok("None".to_string());
            } else if left_is_unit {
                return transpile_node(right, layer, in_main, table);
            } else {
                return transpile_node(left, layer, in_main, table);
            }
        }
    }

    if ["~", "~+", "~-", "~*", "~/", "~^"].contains(&operator) {
        if let AstNode::BinaryOperation { operator: left_op, left: left_left, right: left_right, .. } = left {
            if ["~+", "~-", "~*", "~/", "~^"].contains(&left_op.as_str()) {
                let start_str = transpile_node(left_left, layer, in_main, table)?;
                let step_str = transpile_node(left_right, layer, in_main, table)?;
                let end_str = transpile_node(right, layer, in_main, table)?;
                return Ok(transpile_three_term_range(&start_str, &step_str, &end_str, left_op));
            }
        }

        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;

        if operator == "~" {
            return Ok(transpile_three_term_range(&left_str, "1.0", &right_str, "~"));
        } else {
            let iter_expr = match operator {
                "~+" => format!("std::iter::successors(Some({}), move |&curr| Some(curr + {}))", left_str, right_str),
                "~-" => format!("std::iter::successors(Some({}), move |&curr| Some(curr - {}))", left_str, right_str),
                "~*" => format!("std::iter::successors(Some({}), move |&curr| Some(curr * {}))", left_str, right_str),
                "~/" => format!("std::iter::successors(Some({}), move |&curr| Some(curr / {}))", left_str, right_str),
                "~^" => format!("std::iter::successors(Some({}), move |&curr| Some(curr.powf({})))", left_str, right_str),
                _ => format!("std::iter::successors(Some({}), move |&curr| Some(curr + 1.0))", left_str),
            };
            return Ok(iter_expr);
        }
    }

    if operator == "#" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        if layer == 0 {
            return Ok(format!("unsafe {{ core::ptr::write_volatile({} as *mut f64, {}) }}", left_str, right_str));
        } else {
            if let AstNode::Identifier(id) = left {
                if table.global_allocs.contains(id) {
                    return Ok(format!("{}.with(|cell| *cell.get().unwrap().borrow_mut() = Option::from({}).unwrap_or(0.0))", id, right_str));
                }
            }
            return Ok(format!("unsafe {{ *({} as *mut f64) = Option::from({}).unwrap_or(0.0) }}", left_str, right_str));
        }
    }

    if operator == ":" {
        if let AstNode::Identifier(id) = left {
            if table.objects.contains_key(id) {
                let mut mapping = HashMap::new();
                collect_member_definitions(right, &mut mapping, layer, table)?;
                let struct_name = format!("{}Struct", id);
                let mut struct_inits = Vec::new();
                let mut sorted_fields = table.objects.get(id).unwrap().clone();
                sorted_fields.sort_by(|a, b| a.0.cmp(&b.0));
                for (field_name, field_type) in sorted_fields {
                    let val = mapping.get(&field_name).cloned().unwrap_or_else(|| {
                        match field_type {
                            AtomType::String => "String::new()".to_string(),
                            _ => "0.0".to_string(),
                        }
                    });
                    struct_inits.push(format!("{}: {}", field_name, val));
                }
                return Ok(format!("{} {{ {} }}", struct_name, struct_inits.join(", ")));
            }
        }

        if let AstNode::Lambda { arguments: cond, body: then } = left {
            let arms = vec![
                MatchArm { condition: Some(*cond.clone()), body: *then.clone() },
                MatchArm { condition: None, body: right.clone() },
            ];
            return transpile_match_arms(&arms, layer, in_main, table);
        }
    }

    if operator == ";" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let wrapped_right = if is_option_type(&right_str, table) {
            right_str
        } else {
            format!("Option::from({})", right_str)
        };
        return Ok(format!("{}.xor({})", left_str, wrapped_right));
    }

    if operator == "'" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        if let AstNode::Identifier(ref id) = *right {
            return Ok(format!("{}.get_{}()", left_str, id));
        } else {
            return Err(format!("Property access key must be an identifier, found {:?}", right));
        }
    }

    if ["<", ">", "<=", ">=", "==", "!=", "!==", "="].contains(&operator) {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let rust_op = if operator == "!==" { "!=" } else if operator == "=" { "==" } else { operator };
        let l_wrap = if is_option_type(&left_str, table) { left_str } else { format!("Option::from({})", left_str) };
        let r_wrap = if is_option_type(&right_str, table) { right_str } else { format!("Option::from({})", right_str) };
        if ["==", "!=="].contains(&operator) {
            return Ok(format!("eval_eq({}, {}, |l, r| l {} r)", l_wrap, r_wrap, rust_op));
        } else {
            return Ok(format!("eval_compare({}, {}, |l, r| l {} r)", l_wrap, r_wrap, rust_op));
        }
    }

    if operator == "&" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let wrapped_right = if is_option_type(&right_str, table) {
            right_str
        } else {
            format!("Option::from({})", right_str)
        };
        return Ok(format!("{}.and({})", left_str, wrapped_right));
    }

    if operator == "|" {
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let l_wrap = if is_option_type(&left_str, table) { left_str } else { format!("Option::from({})", left_str) };
        let r_wrap = if is_option_type(&right_str, table) { right_str } else { format!("Option::from({})", right_str) };
        return Ok(format!("{}.or_else(|| {})", l_wrap, r_wrap));
    }

    // 中置スペースによる適用/合成の解決
    if operator == " " {
        if name == "resolved" {
            // 関数名と、これまでに適用された全引数リストを抽出
            let mut applied_args = Vec::new();
            if let Some(func_name) = extract_applied_func_and_args(left, &mut applied_args) {
                collect_coproduct_items(right, &mut applied_args);
                applied_args.retain(|item| *item != AstNode::Unit);
                
                if let Some(sig) = table.functions.get(&func_name) {
                    // スプレッド展開があるかチェックし、あれば静的脱糖する
                    let mut has_spread = false;
                    let mut spread_var = String::new();
                    let mut spread_idx = 0;
                    for (i, arg) in applied_args.iter().enumerate() {
                        if let AstNode::Postfix { operator, operand, .. } = arg {
                            if operator == "~" {
                                has_spread = true;
                                spread_var = transpile_node(operand, layer, in_main, table)?;
                                spread_idx = i;
                                break;
                            }
                        }
                    }
                    
                    if has_spread {
                        if sig.arity == 2 && sig.rest_idx == Some(1) {
                            let mut final_args = Vec::new();
                            for i in 0..spread_idx {
                                let mut arg_str = transpile_node(&applied_args[i], layer, in_main, table)?;
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                if is_obj && !arg_str.starts_with('&') {
                                    arg_str = format!("&{}", arg_str);
                                }
                                final_args.push(arg_str);
                            }
                            if spread_idx == 1 {
                                final_args.push(spread_var.clone());
                            } else {
                                let head_param = &sig.args[0];
                                let is_head_obj = if let Some(first_char) = head_param.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &head_param[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(head_param)
                                } else {
                                    false
                                };
                                let head_ref = if is_head_obj { "&" } else { "" };
                                final_args.push(format!("{}{}[0]", head_ref, spread_var));
                                final_args.push(format!("&{}[1..]", spread_var));
                            }
                            let call_code = format!(
                                "if {}.is_empty() {{ None }} else {{ {}({}) }}",
                                spread_var, func_name, final_args.join(", ")
                            );
                            return Ok(call_code);
                        }
                    }
                    
                    // Rest 引数パッケージング処理
                    let mut applied_args = applied_args;
                    if let Some(r_idx) = sig.rest_idx {
                        if applied_args.len() >= r_idx {
                            let rest_args = applied_args.split_off(r_idx);
                            let pkg_node = AstNode::Coproduct(rest_args);
                            applied_args.push(pkg_node);
                        }
                    }

                    let passed_count = applied_args.len();
                    if passed_count < sig.arity {
                        // 部分適用！ クロージャ (move |y| func(passed, y)) を出力
                        let mut all_args_code = Vec::new();
                        for (i, arg) in applied_args.iter().enumerate() {
                            let mut arg_str = transpile_node(arg, layer, in_main, table)?;
                            let mut is_ref = false;
                            let mut is_single_object = false;
                            if i < sig.args.len() {
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                is_ref = is_obj || sig.rest_idx == Some(i) || param_name.starts_with("list_arg");
                                if param_name.starts_with("list_arg") {
                                    is_single_object = !matches!(arg, AstNode::Coproduct(_) | AstNode::Block { kind: BlockKind::Bracket, .. });
                                }
                            }
                            if is_ref && !arg_str.starts_with('&') {
                                arg_str = format!("&{}", arg_str);
                            }
                            if is_single_object {
                                let arg_without_ref = if arg_str.starts_with('&') {
                                    &arg_str[1..]
                                } else {
                                    &arg_str
                                };
                                arg_str = format!("std::slice::from_ref({})", arg_without_ref);
                            }
                            all_args_code.push(arg_str);
                        }
                        let missing_args = &sig.args[passed_count..];
                        for arg in missing_args {
                            all_args_code.push(arg.clone());
                        }
                        return Ok(format!("(move |{}| {}({}))", missing_args.join(", "), func_name, all_args_code.join(", ")));
                    } else {
                        // 完全適用！
                        let has_list_arg = sig.args.iter().any(|arg| arg.starts_with("list_arg"));
                        let is_constructor = func_name.chars().next().map(|c| c.is_uppercase()).unwrap_or(false);
                        if !sig.is_recursive && sig.destructured_args.is_empty() && !has_list_arg && !is_constructor && applied_args.len() == sig.args.len() {
                            if let Some(body_ast) = &sig.body {
                                let mut mapping = HashMap::new();
                                for (i, arg_name) in sig.args.iter().enumerate() {
                                    mapping.insert(arg_name.clone(), applied_args[i].clone());
                                }
                                let substituted = substitute_args(body_ast, &mapping);
                                return transpile_node(&substituted, layer, in_main, table);
                            }
                        }
                        // 再帰関数の場合は通常の関数呼び出し func(args...)
                        let mut args_code = Vec::new();
                        let mut option_binds = Vec::new();
                        let mut bind_counter = 0;
                        for (i, arg) in applied_args.iter().enumerate() {
                            let mut arg_str = transpile_node(arg, layer, in_main, table)?;
                            let mut is_ref = false;
                            let mut is_single_object = false;
                            let mut param_is_f64 = false;
                            if i < sig.args.len() {
                                let param_name = &sig.args[i];
                                let is_obj = if let Some(first_char) = param_name.chars().next() {
                                    let cap = format!("{}{}", first_char.to_uppercase(), &param_name[1..]);
                                    table.objects.contains_key(&cap) || table.objects.contains_key(param_name)
                                } else {
                                    false
                                };
                                is_ref = is_obj || sig.rest_idx == Some(i) || param_name.starts_with("list_arg");
                                if param_name.starts_with("list_arg") {
                                    is_single_object = !matches!(arg, AstNode::Coproduct(_) | AstNode::Block { kind: BlockKind::Bracket, .. });
                                }
                                if !is_ref && i < sig.arity {
                                    param_is_f64 = true;
                                }
                            }
                            if is_ref && !arg_str.starts_with('&') {
                                arg_str = format!("&{}", arg_str);
                            }
                            if is_single_object {
                                let arg_without_ref = if arg_str.starts_with('&') {
                                    &arg_str[1..]
                                } else {
                                    &arg_str
                                };
                                arg_str = format!("std::slice::from_ref({})", arg_without_ref);
                            }
                            if param_is_f64 && is_option_type(&arg_str, table) {
                                let var_name = format!("__cv{}", bind_counter);
                                bind_counter += 1;
                                option_binds.push((arg_str.clone(), var_name.clone()));
                                args_code.push(var_name);
                            } else {
                                args_code.push(arg_str);
                            }
                        }
                        // 不足しているデフォルト引数に対して None を補填する
                        for _ in applied_args.len()..sig.args.len() {
                            args_code.push("None".to_string());
                        }
                        let mut call_expr = format!("{}({})", func_name, args_code.join(", "));
                        for (orig_expr, var_name) in option_binds.into_iter().rev() {
                            let val_expr = if is_option_type(&call_expr, table) {
                                call_expr.clone()
                            } else {
                                format!("Option::from({})", call_expr)
                            };
                            call_expr = format!("{}.and_then(|{}| {})", orig_expr, var_name, val_expr);
                        }
                        return Ok(call_expr);
                    }
                }
            }
        }

        // フォールバック：通常の適用
        let left_str = transpile_node(left, layer, in_main, table)?;
        let right_str = transpile_node(right, layer, in_main, table)?;
        let left_opt = is_option_type(&left_str, table);
        let right_opt = is_option_type(&right_str, table);

        if left_opt && right_opt {
            let call = "__func(__val)".to_string();
            let call_wrapped = if is_option_type(&call, table) {
                call
            } else {
                "Some(__func(__val))".to_string()
            };
            return Ok(format!("{}.and_then(|__func| {}.and_then(|__val| {}))", left_str, right_str, call_wrapped));
        } else if left_opt {
            let call = format!("__func({})", right_str);
            let call_wrapped = if is_option_type(&call, table) {
                call
            } else {
                format!("Some(__func({}))", right_str)
            };
            return Ok(format!("{}.and_then(|__func| {})", left_str, call_wrapped));
        } else if right_opt {
            let call = format!("{}(__cv)", left_str);
            let call_wrapped = if is_option_type(&call, table) {
                call
            } else {
                format!("Some({}(__cv))", call)
            };
            return Ok(format!("{}.and_then(|__cv| {})", right_str, call_wrapped));
        }
        return Ok(format!("{}({})", left_str, right_str));
    }

    let left_str = transpile_node(left, layer, in_main, table)?;
    let right_str = transpile_node(right, layer, in_main, table)?;
    let left_type = infer_atom_type(left, table);
    let right_type = infer_atom_type(right, table);
    
    let left_opt = is_option_type(&left_str, table);
    let right_opt = is_option_type(&right_str, table);
    let l_wrap = if left_opt { left_str.clone() } else { format!("Option::from({})", left_str) };
    let r_wrap = if right_opt { right_str.clone() } else { format!("Option::from({})", right_str) };

    match (operator, left_type) {
        // --- 1. 左辺が String (文字列) の場合 ---
        ("+", AtomType::String) => {
            if right_type == AtomType::Number {
                // Number を文字コードポイントとして扱い、結合する
                Ok(format!(
                    "eval_binary({}, {}, |l, r| format!(\"{}{}\", l, (r as u32).try_into().unwrap_or('\\0')))",
                    l_wrap, r_wrap, "{}", "{}"
                ))
            } else {
                Ok(format!(
                    "eval_binary({}, {}, |l, r| format!(\"{}{}\", l, r))",
                    l_wrap, r_wrap, "{}", "{}"
                ))
            }
        }
        ("*", AtomType::String) => {
            Ok(format!(
                "eval_binary({}, {}, |l, r| l.repeat(r as usize))",
                l_wrap, r_wrap
            ))
        }
        
        // --- 2. 左辺が List の場合 ---
        ("+", AtomType::List) => {
            // リストの結合
            Ok(format!(
                "eval_binary({}, {}, |mut l, r| {{ l.extend(r); l }})",
                l_wrap, r_wrap
            ))
        }
        ("*", AtomType::List) => {
            // リストを Number 回複製する
            Ok(format!(
                "eval_binary({}, {}, |l, r| {{ let mut temp = Vec::new(); for _ in 0..(r as usize) {{ temp.extend(l.clone()); }}; temp }})",
                l_wrap, r_wrap
            ))
        }
        ("/", AtomType::List) => {
            // リストを Number 個 of チャンクに分割
            Ok(format!(
                "eval_binary({}, {}, |l, r| l.chunks(r as usize).map(|c| c.to_vec()).collect::<Vec<_>>())",
                l_wrap, r_wrap
            ))
        }
        ("^", AtomType::List) => {
            // 次元を上げて複製
            Ok(format!(
                "eval_binary({}, {}, |l, r| vec![l.clone(); r as usize])",
                l_wrap, r_wrap
            ))
        }

        // --- 3. 左辺が Number (数値) またはその他のデフォルトの場合 ---
        ("+", _) => Ok(format!("eval_binary({}, {}, |l, r| l + r)", l_wrap, r_wrap)),
        ("-", _) => Ok(format!("eval_binary({}, {}, |l, r| l - r)", l_wrap, r_wrap)),
        ("*", _) => Ok(format!("eval_binary({}, {}, |l, r| l * r)", l_wrap, r_wrap)),
        ("/", _) => Ok(format!("eval_binary({}, {}, |l, r| l / r)", l_wrap, r_wrap)),
        ("^", _) => Ok(format!("eval_binary({}, {}, |l, r| l.powf(r))", l_wrap, r_wrap)),
        ("%", _) => Ok(format!("eval_binary({}, {}, |l, r| l % r)", l_wrap, r_wrap)),
        (",", _) => Ok(format!("vec![{}, {}]", left_str, right_str)),
        ("<<", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) << (r as i64)) as f64))", l_wrap, r_wrap)),
        (">>", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) >> (r as i64)) as f64))", l_wrap, r_wrap)),
        ("||", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) | (r as i64)) as f64))", l_wrap, r_wrap)),
        (";;", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) ^ (r as i64)) as f64))", l_wrap, r_wrap)),
        ("&&", _) => Ok(format!("eval_binary({}, {}, |l, r| (((l as i64) & (r as i64)) as f64))", l_wrap, r_wrap)),
        _ => Ok(format!("({} {} {})", left_str, operator, right_str)),
    }
}

pub fn transpile_prefix_op(operator: &str, operand: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if let AstNode::Unit = operand {
        match operator {
            "!" => return Ok("Some(0.0)".to_string()),
            "!!" | "-" | "@" | "~" | "><" => return Ok("None".to_string()),
            _ => {}
        }
    }

    if operator == "!!" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Option::from({}).map(|op| (((!(op as i64)) as f64)))", op_str));
    }

    if operator == "!" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("if Option::from({}).is_none() {{ Some(0.0) }} else {{ None }}", op_str));
    }

    if operator == "-" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Option::from({}).map(|op| -op)", op_str));
    }

    if operator == "~" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("{{ let end = {}; let mut v = Vec::new(); let mut cur = 0.0; if cur <= end {{ while cur <= end {{ v.push(cur); cur += 1.0; }} }} else {{ while cur >= end {{ v.push(cur); cur -= 1.0; }} }} v }}", op_str));
    }

    if operator == "@" {
        if layer == 0 {
            let op_str = transpile_node(operand, layer, in_main, table)?;
            return Ok(format!("unsafe {{ core::ptr::read_volatile({} as *const f64) }}", op_str));
        } else {
            if let AstNode::Identifier(id) = operand {
                if table.global_allocs.contains(id) {
                    return Ok(format!("{}.with(|cell| *cell.get().unwrap().borrow())", id));
                }
            }
            if let AstNode::Address(_) = operand {
                let op_str = transpile_node(operand, layer, in_main, table)?;
                return Ok(format!("unsafe {{ *({} as *const f64) }}", op_str));
            } else {
                let op_str = transpile_node(operand, layer, in_main, table)?;
                if is_option_type(&op_str, table) || op_str == "None" {
                    let call = "f()".to_string();
                    let call_wrapped = if is_option_type(&call, table) {
                        call
                    } else {
                        "Some(f())".to_string()
                    };
                    return Ok(format!("{}.and_then(|f| {})", op_str, call_wrapped));
                } else {
                    return Ok(format!("{}()", op_str));
                }
            }
        }
    }

    if operator == "$" {
        let op_str = transpile_node(operand, layer, in_main, table)?;
        return Ok(format!("Some(move || {{ {} }})", op_str));
    }

    if operator == "#" || operator == "##" {
        if layer == 0 {
            return Err("Compile Error: Allocation (#/##) is not allowed in layer 0".to_string());
        }
        let op_str = transpile_node(operand, layer, in_main, table)?;
        let wrapper = if operator == "#" {
            "std::rc::Rc::new(std::cell::RefCell::new"
        } else {
            "std::sync::Arc::new(std::sync::Mutex::new"
        };
        return Ok(format!("{}({}))", wrapper, op_str));
    }

    let op_str = transpile_node(operand, layer, in_main, table)?;
    Ok(format!("{}{}", operator, op_str))
}

pub fn transpile_postfix_op(operator: &str, operand: &AstNode, layer: usize, in_main: bool, table: &SymbolTable) -> Result<String, String> {
    if operator == "~" {
        return transpile_node(operand, layer, in_main, table);
    }
    let op_str = transpile_node(operand, layer, in_main, table)?;
    if operator == "!" {
        return Ok(format!("factorial({})", op_str));
    }
    if operator == "@" {
        return Err("Compile Error: Module Import is not implemented".to_string());
    }
    Ok(format!("{}{}", op_str, operator))
}

pub fn strip_outer_parens(s: &str) -> &str {
    let mut current = s.trim();
    while current.starts_with('(') && current.ends_with(')') {
        let mut depth = 0;
        let mut matching_idx = None;
        for (i, c) in current.chars().enumerate() {
            if c == '(' {
                depth += 1;
            } else if c == ')' {
                depth -= 1;
                if depth == 0 {
                    matching_idx = Some(i);
                    break;
                }
            }
        }
        if let Some(idx) = matching_idx {
            if idx == current.len() - 1 {
                current = &current[1..current.len() - 1].trim();
            } else {
                break;
            }
        } else {
            break;
        }
    }
    current
}

pub fn is_pure_closure(trimmed: &str) -> bool {
    let stripped = strip_outer_parens(trimmed);
    stripped.starts_with("move |") || stripped.starts_with("move||")
}

pub fn is_option_type(expr: &str, table: &SymbolTable) -> bool {
    let trimmed = strip_outer_parens(expr);
    if is_pure_closure(trimmed) {
        return false;
    }
    if trimmed.starts_with("__func(") || trimmed.starts_with("__val(") || trimmed.starts_with("__cv") {
        return true;
    }
    if trimmed.starts_with("Some(") || trimmed.starts_with("None") || trimmed.contains("Option::from") || trimmed.contains(".and(") || trimmed.contains(".and_then(") || trimmed.contains(".zip(") || trimmed.contains(".map(") || trimmed.contains("eval_compare") || trimmed.contains("eval_binary") || trimmed.contains("eval_eq") || trimmed.contains("eval_split") {
        let is_unwrap = {
            let pos_unwrap = trimmed.rfind("unwrap()");
            let pos_unwrap_or = trimmed.rfind("unwrap_or(");
            let pos_unwrap_default = trimmed.rfind("unwrap_or_default()");
            let last_unwrap_pos = pos_unwrap.max(pos_unwrap_or).max(pos_unwrap_default);
            if let Some(pos) = last_unwrap_pos {
                let suffix = &trimmed[pos..];
                !suffix.contains(',') && !suffix.contains('+') && !suffix.contains('-') && !suffix.contains('*') && !suffix.contains('/') &&
                !suffix.contains(".map(") && !suffix.contains(".zip(") && !suffix.contains(".and(") && !suffix.contains(".or_else(") && !suffix.contains(".and_then(")
            } else {
                false
            }
        };
        return !is_unwrap;
    }
    for func_name in table.functions.keys() {
        if let Some(idx) = trimmed.find(func_name) {
            let before = if idx > 0 { trimmed.chars().nth(idx - 1) } else { None };
            let after = trimmed.chars().nth(idx + func_name.len());
            let before_is_ident = before.map(|c| c.is_alphanumeric() || c == '_').unwrap_or(false);
            let after_is_ident = after.map(|c| c.is_alphanumeric() || c == '_').unwrap_or(false);
            if !before_is_ident && !after_is_ident {
                if let Some(sig) = table.functions.get(func_name) {
                    if sig.return_type != AtomType::List {
                        let is_unwrap = {
                            let pos_unwrap = trimmed.rfind("unwrap()");
                            let pos_unwrap_or = trimmed.rfind("unwrap_or(");
                            let pos_unwrap_default = trimmed.rfind("unwrap_or_default()");
                            let last_unwrap_pos = pos_unwrap.max(pos_unwrap_or).max(pos_unwrap_default);
                            if let Some(pos) = last_unwrap_pos {
                                let suffix = &trimmed[pos..];
                                !suffix.contains(',') && !suffix.contains('+') && !suffix.contains('-') && !suffix.contains('*') && !suffix.contains('/') &&
                                !suffix.contains(".map(") && !suffix.contains(".zip(") && !suffix.contains(".and(") && !suffix.contains(".or_else(") && !suffix.contains(".and_then(")
                            } else {
                                false
                            }
                        };
                        return !is_unwrap;
                    }
                }
            }
        }
    }
    false
}
