; ModuleID = 'sign_module'

define i64 @main() {
entry:
  %integer_test_ptr = alloca i64
  store i64 42, i64* %integer_test_ptr
  %float_test_ptr = alloca i64
  store i64 0, i64* %float_test_ptr
  %negative_test_ptr = alloca i64
  store i64 0, i64* %negative_test_ptr
  %hex_test_ptr = alloca i64
  store i64 65280, i64* %hex_test_ptr
  %oct_test_ptr = alloca i64
  store i64 493, i64* %oct_test_ptr
  %bin_test_ptr = alloca i64
  store i64 10, i64* %bin_test_ptr
  %char_test_ptr = alloca i64
  store i64 0, i64* %char_test_ptr
  %newline_test_ptr = alloca i64
  store i64 0, i64* %newline_test_ptr
  %string_test_ptr = alloca i64
  store i64 0, i64* %string_test_ptr
  %empty_string_ptr = alloca i64
  store i64 0, i64* %empty_string_ptr
  %unit_test_ptr = alloca i64
  store i64 0, i64* %unit_test_ptr
  add_tmp = add i64 1, 2
  %add_result_ptr = alloca i64
  store i64 add_tmp, i64* %add_result_ptr
  sub_tmp = sub i64 10, 3
  %sub_result_ptr = alloca i64
  store i64 sub_tmp, i64* %sub_result_ptr
  mul_tmp = mul i64 4, 5
  %mul_result_ptr = alloca i64
  store i64 mul_tmp, i64* %mul_result_ptr
  div_tmp = sdiv i64 20, 4
  %div_result_ptr = alloca i64
  store i64 div_tmp, i64* %div_result_ptr
  %mod_result_ptr = alloca i64
  store i64 0, i64* %mod_result_ptr
  mul_tmp = mul i64 3, 4
  add_tmp = add i64 2, mul_tmp
  %complex1_ptr = alloca i64
  store i64 add_tmp, i64* %complex1_ptr
  mul_tmp = mul i64 0, 4
  %complex2_ptr = alloca i64
  store i64 mul_tmp, i64* %complex2_ptr
  %power_test_ptr = alloca i64
  store i64 0, i64* %power_test_ptr
  %factorial_test_ptr = alloca i64
  store i64 0, i64* %factorial_test_ptr
  %abs_test_ptr = alloca i64
  store i64 0, i64* %abs_test_ptr
  %less_test_ptr = alloca i64
  store i64 0, i64* %less_test_ptr
  %equal_test_ptr = alloca i64
  store i64 0, i64* %equal_test_ptr
  %range_test_ptr = alloca i64
  store i64 0, i64* %range_test_ptr
  %chain_compare_ptr = alloca i64
  store i64 0, i64* %chain_compare_ptr
  %and_test_ptr = alloca i64
  store i64 0, i64* %and_test_ptr
  %or_test_ptr = alloca i64
  store i64 0, i64* %or_test_ptr
  %xor_test_ptr = alloca i64
  store i64 0, i64* %xor_test_ptr
  %not_test_ptr = alloca i64
  store i64 0, i64* %not_test_ptr
  %list_explicit_ptr = alloca i64
  store i64 0, i64* %list_explicit_ptr
  %list_implicit_ptr = alloca i64
  store i64 0, i64* %list_implicit_ptr
  %range_basic_ptr = alloca i64
  store i64 0, i64* %range_basic_ptr
  %range_char_ptr = alloca i64
  store i64 0, i64* %range_char_ptr
  %range_step_ptr = alloca i64
  store i64 0, i64* %range_step_ptr
  %concat_test_ptr = alloca i64
  store i64 0, i64* %concat_test_ptr
  %first_ptr = alloca i64
  store i64 0, i64* %first_ptr
  %last_ptr = alloca i64
  store i64 0, i64* %last_ptr
  %slice_ptr = alloca i64
  store i64 0, i64* %slice_ptr
  %increment_ptr = alloca i64
  store i64 0, i64* %increment_ptr
  %add_ptr = alloca i64
  store i64 0, i64* %add_ptr
  %abs_ptr = alloca i64
  store i64 0, i64* %abs_ptr
  %apply_anon_ptr = alloca i64
  store i64 0, i64* %apply_anon_ptr
  %add_one_ptr = alloca i64
  store i64 0, i64* %add_one_ptr
  %double_ptr = alloca i64
  store i64 0, i64* %double_ptr
  %sum_ptr = alloca i64
  store i64 0, i64* %sum_ptr
  %product_ptr = alloca i64
  store i64 0, i64* %product_ptr
  %double_list_ptr = alloca i64
  store i64 0, i64* %double_list_ptr
  %sum_list_ptr = alloca i64
  store i64 0, i64* %sum_list_ptr
  %map_ptr = alloca i64
  store i64 0, i64* %map_ptr
  %filter_ptr = alloca i64
  store i64 0, i64* %filter_ptr
  %fold_ptr = alloca i64
  store i64 0, i64* %fold_ptr
  %compose_ptr = alloca i64
  store i64 0, i64* %compose_ptr
  %classify_ptr = alloca i64
  store i64 0, i64* %classify_ptr
  %grade_ptr = alloca i64
  store i64 0, i64* %grade_ptr
  %access_check_ptr = alloca i64
  store i64 0, i64* %access_check_ptr
  %person_ptr = alloca i64
  store i64 0, i64* %person_ptr
  %get_name_ptr = alloca i64
  store i64 0, i64* %get_name_ptr
  %get_age_ptr = alloca i64
  store i64 0, i64* %get_age_ptr
  %updated_person_ptr = alloca i64
  store i64 0, i64* %updated_person_ptr
  %sum_all_ptr = alloca i64
  store i64 0, i64* %sum_all_ptr
  %args_ptr = alloca i64
  store i64 0, i64* %args_ptr
  %result_ptr = alloca i64
  store i64 0, i64* %result_ptr
  %head_ptr = alloca i64
  store i64 0, i64* %head_ptr
  %tail_ptr = alloca i64
  store i64 0, i64* %tail_ptr
  %local_value_ptr = alloca i64
  store i64 42, i64* %local_value_ptr
  %local_func_ptr = alloca i64
  store i64 0, i64* %local_func_ptr
  %process_data_ptr = alloca i64
  store i64 0, i64* %process_data_ptr
  %nested_logic_ptr = alloca i64
  store i64 0, i64* %nested_logic_ptr
  %pipeline_ptr = alloca i64
  store i64 0, i64* %pipeline_ptr
  %result_ptr = alloca i64
  store i64 0, i64* %result_ptr
  %transform_ptr = alloca i64
  store i64 0, i64* %transform_ptr
  %apply_transform_ptr = alloca i64
  store i64 0, i64* %apply_transform_ptr
  %factorial_ptr = alloca i64
  store i64 0, i64* %factorial_ptr
  %fibonacci_ptr = alloca i64
  store i64 0, i64* %fibonacci_ptr
  %reverse_ptr = alloca i64
  store i64 0, i64* %reverse_ptr
  %quicksort_ptr = alloca i64
  store i64 0, i64* %quicksort_ptr
  %sum_range_ptr = alloca i64
  store i64 0, i64* %sum_range_ptr
  %conditional_map_ptr = alloca i64
  store i64 0, i64* %conditional_map_ptr
  ret i64 0
}