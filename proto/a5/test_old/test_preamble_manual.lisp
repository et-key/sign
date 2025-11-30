;; --- Sign Language Runtime Preamble ---
(defun xor (a b) 
  "Logical XOR: true if exactly one argument is true"
  (if a (not b) b))

(defun range (start end &optional (step 1))
  "Generate a list from start to end (inclusive) with the given step"
  (loop for i from start to end by step collect i))
;; --------------------------------------

(defparameter range1 (range 1 10))
(format t "range1 = ~a~%" range1)

(defparameter xor_test (xor 1 0))
(format t "xor_test (1 xor 0) = ~a~%" xor_test)
