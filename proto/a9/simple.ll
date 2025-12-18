; ModuleID = 'sign_module'
source_filename = "sign_module"
target datalayout = "e-m:w-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-windows-msvc"

declare i32 @printf(i8*, ...)
@formatStr = private constant [4 x i8] c"%d\0A\00"

define i32 @main() {
entry:
  %x = alloca i32
  store i32 10, i32* %x
  %y = alloca i32
  store i32 20, i32* %y
  %t0 = load i32, i32* %x
  %t1 = load i32, i32* %y
  %t2 = add i32 %t0, %t1
  %t3 = getelementptr [4 x i8], [4 x i8]* @formatStr, i64 0, i64 0
  call i32 (i8*, ...) @printf(i8* %t3, i32 %t2)
  ret i32 0
}