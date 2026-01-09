(begin
  (define fold_add (fold +))
  (define add_one (+ _ 1))
  (define subtract_from_five (- 5 _))
  (define double_map (map (* _ 2)))
  (define negate (fold !)))