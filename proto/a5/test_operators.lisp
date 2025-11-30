(defun print-sign (str) (format t "~a" str))
(print-sign "--- 1. Define演算子 (:) - 優先順位2 ---
")
(defparameter x 10)
(print-sign "x = ")
(print-sign x)
(print-sign "
")
(defparameter y 20)
(print-sign "y = ")
(print-sign y)
(print-sign "
")
(defparameter name "hello")
(print-sign "name = ")
(print-sign name)
(print-sign "
")
(print-sign "--- 2. Output演算子 (#) 中置 - 優先順位3 ---
")
(defparameter result (+ x y))
(print-sign "result = x + y = ")
(print-sign result)
(print-sign "
")
(print-sign "result # _ (標準出力): ")
(format t "~a" result)
(print-sign "
")
(print-sign "--- 3. Export演算子 (#) 前置 - 優先順位1 ---
")
; EXPORTED
(defparameter exported_value 42)
(print-sign "exported_value = ")
(print-sign exported_value)
(print-sign "
")
(print-sign "--- 4. Lambda演算子 (?) - 優先順位7 ---
")
(defun add (x y) (+ x y))
(print-sign "add 5 3 = ")
(print-sign (add 5 3))
(print-sign "
")
(defun square (n) (* n n))
(print-sign "square 7 = ")
(print-sign (square 7))
(print-sign "
")
(defun identity-sign (x) x)
(print-sign "identity 100 = ")
(print-sign (identity-sign 100))
(print-sign "
")
(print-sign "--- 5. Product演算子 (,) - 優先順位4 ---
")
(defparameter list1 (list 1 2 3))
(print-sign "list1 = ")
(print-sign list1)
(print-sign "
")
(defparameter coords (list 10 20 30))
(print-sign "coords = ")
(print-sign coords)
(print-sign "
")
(print-sign "--- 7. 算術演算子 - 優先順位14-16 ---
")
(defparameter sum (+ 5 3))
(print-sign "5 + 3 = ")
(print-sign sum)
(print-sign "
")
(defparameter diff (- 10 4))
(print-sign "10 - 4 = ")
(print-sign diff)
(print-sign "
")
(defparameter prod (* 6 7))
(print-sign "6 * 7 = ")
(print-sign prod)
(print-sign "
")
(defparameter quot (/ 20 4))
(print-sign "20 / 4 = ")
(print-sign quot)
(print-sign "
")
(defparameter mod_result (mod 17 5))
(print-sign "17 % 5 = ")
(print-sign mod_result)
(print-sign "
")
(defparameter power (expt 2 8))
(print-sign "2 ^ 8 = ")
(print-sign power)
(print-sign "
")
(print-sign "--- 8. 比較演算子 - 優先順位13 ---
")
(defparameter is_less (< 5 10))
(print-sign "5 < 10 = ")
(print-sign is_less)
(print-sign "
")
(defparameter is_less_eq (<= 5 5))
(print-sign "5 <= 5 = ")
(print-sign is_less_eq)
(print-sign "
")
(defparameter is_equal (= 10 10))
(print-sign "10 = 10 = ")
(print-sign is_equal)
(print-sign "
")
(defparameter is_more_eq (>= 15 10))
(print-sign "15 >= 10 = ")
(print-sign is_more_eq)
(print-sign "
")
(defparameter is_more (> 20 10))
(print-sign "20 > 10 = ")
(print-sign is_more)
(print-sign "
")
(defparameter is_not_eq (/= 5 10))
(print-sign "5 != 10 = ")
(print-sign is_not_eq)
(print-sign "
")
(print-sign "--- 9. 論理演算子 - 優先順位10-12 ---
")
(defparameter bool1 (not 0))
(print-sign "!0 = ")
(print-sign bool1)
(print-sign "
")
(defparameter bool2 1)
(print-sign "1 = ")
(print-sign bool2)
(print-sign "
")
(defparameter and_result (and 1 1))
(print-sign "1 & 1 = ")
(print-sign and_result)
(print-sign "
")
(defparameter or_result (or 0 1))
(print-sign "0 | 1 = ")
(print-sign or_result)
(print-sign "
")
(print-sign "--- 12. ポイントフリー記法 ---
")
(defparameter fold_add (lambda (lst) (reduce #'+ lst)))
(print-sign "fold_add (DirectFold [+]) = ")
(print-sign fold_add)
(print-sign "
")
(defparameter add_one (lambda (x) (+ x 1)))
(print-sign "add_one (右部分適用 [+ 1]) = ")
(print-sign add_one)
(print-sign "
")
(defparameter sub_from_10 (lambda (x) (- 10 x)))
(print-sign "sub_from_10 (左部分適用 [10 -]) = ")
(print-sign sub_from_10)
(print-sign "
")
(defparameter double_all (lambda (lst) (mapcar (lambda (x) (* x 2)) lst)))
(print-sign "double_all (map用 [* 2,]) = ")
(print-sign double_all)
(print-sign "
")
(print-sign "--- 13. 複合的な式 ---
")
(defparameter complex1 (+ 2 (* 3 4)))
(print-sign "2 + 3 * 4 = ")
(print-sign complex1)
(print-sign "
")
(defparameter complex2 (- 10 (expt 2 3)))
(print-sign "10 - 2 ^ 3 = ")
(print-sign complex2)
(print-sign "
")
(defparameter complex3 (list (+ 1 2) (+ 3 4)))
(print-sign "(1 + 2, 3 + 4) = ")
(print-sign complex3)
(print-sign "
")
(defun calc (a b) (+ (* a 2) (* b 3)))
(print-sign "calc 5 7 = ")
(print-sign (calc 5 7))
(print-sign "
")
(defparameter nested (* (+ 1 2) (+ 3 4)))
(print-sign "(1 + 2) * (3 + 4) = ")
(print-sign nested)
(print-sign "
")
(print-sign "--- テスト完了 ---
")