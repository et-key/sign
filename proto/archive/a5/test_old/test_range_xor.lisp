;; --- Sign Language Runtime Preamble ---
(defun xor (a b) 
  "Logical XOR: true if exactly one argument is true"
  (if a (not b) b))

(defun range (start end &optional (step 1))
  "Generate a list from start to end (inclusive) with the given step"
  (loop for i from start to end by step collect i))
;; --------------------------------------

(defparameter range1 (range 1 10))
(defparameter xlor_test (xor 1 0))
(defun print-sign (str) (format t "~a" str))
(print-sign "range1 = ")
(print-sign range1)
(print-sign "
")
(print-sign "xor_test (1 ; 0) = ")
(print-sign xor_test)
(print-sign "
")