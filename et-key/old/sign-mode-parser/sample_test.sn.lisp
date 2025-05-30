;;; Generated LISP code from Sign language source: .\sample_test.sn
;;; Generated on: 2025-05-03T02:12:29.227Z
;;; Processor version: 0.1.0

(defvar x 10)

(defvar y 20)

(defvar z (+ x y))

(defvar hello "Hello")

(defvar world "World")

(defvar greeting (hello \  world \!))

(defvar sum (+ x y))

(defvar product (* x y))

(defvar power (expt x 2))

(defvar factorial 5!)

(defvar is_valid (and (>= x 0) (<= y 100)))

(defvar range (range 1 10))

(defvar group_calc (* (+ x y) (- z 5)))

(defun add (a b) (+ a b))

(defun multiply (a b) (* a b))

(defun power_fn (base exp_sign) (expt base exp_sign))

(defun calc (x y) (+ (+ (+ x y) (- x y)) (* x y)))

(defun matchTest (x y) (cond ((< x y) x) ((equal x y) y) (t (+ x y))))

(defvar result1 (add 5 10))

(defvar result2 (multiply 4 8))

(defvar list1 (list 1 2 3 4 5))

(defvar list2 (, 1 (, 2 (, 3 (, 4 5)))))

(defvar combined (list1 list2))

(defvar neg !true)

(defvar spread &rest combined)

(defun tail (x &rest y) y)

(defvar factorials (3! 4! 5!))

(defvar reduced_sum ; PointFreeApplication型はまだ実装されていません)

(defvar range_list (range 1 5))

(defun rest_args (a &rest args) (list* a args))

(defun abs_sign (x) (cond ((>= x 0) x) ((< x 0) -x)))