; ModuleID = 'sign_module'
@.str.1 = global [13 x i8] c"Hello, LLVM!\00"

define i64 @main() {
entry:
  %integer_test_ptr0 = alloca i64
  store i64 42, i64* %integer_test_ptr0
  %negative_test_ptr1 = alloca i64
  store i64 -10, i64* %negative_test_ptr1
  %add_result_ptr2 = alloca i64
  %add_tmp3 = add i64 1, 2
  store i64 %add_tmp3, i64* %add_result_ptr2
  %sub_result_ptr4 = alloca i64
  %sub_tmp5 = sub i64 10, 3
  store i64 %sub_tmp5, i64* %sub_result_ptr4
  %mul_result_ptr6 = alloca i64
  %mul_tmp7 = mul i64 4, 5
  store i64 %mul_tmp7, i64* %mul_result_ptr6
  %div_result_ptr8 = alloca i64
  %div_tmp9 = sdiv i64 20, 4
  store i64 %div_tmp9, i64* %div_result_ptr8
  %complex1_ptr10 = alloca i64
  %mul_tmp11 = mul i64 3, 4
  %add_tmp12 = add i64 2, %mul_tmp11
  store i64 %add_tmp12, i64* %complex1_ptr10
  %less_test_ptr13 = alloca i64
  %cmp_tmp14 = icmp slt i64 3, 5
  %bool_ext15 = zext i1 %cmp_tmp14 to i64
  store i64 %bool_ext15, i64* %less_test_ptr13
  %equal_test_ptr16 = alloca i64
  %cmp_tmp17 = icmp eq i64 5, 5
  %bool_ext18 = zext i1 %cmp_tmp17 to i64
  store i64 %bool_ext18, i64* %equal_test_ptr16
  %greeting_ptr19 = alloca i64
  %str_ptr20 = ptrtoint [13 x i8]* @.str.1 to i64
  store i64 %str_ptr20, i64* %greeting_ptr19
  ret i64 %str_ptr20
}