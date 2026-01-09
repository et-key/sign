(defparameter square (lambda (x) (* x x)))
(defparameter sum (lambda (x y) (+ x y)))
(defparameter process (list (lambda (x y) (lambda (x) (+ x 1))) (* x y)))