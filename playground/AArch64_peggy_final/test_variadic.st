f -> x -> ~y -> x
g -> x -> ~y -> y
h -> x -> ~y -> (x -> ~y -> (x -> ~y -> Variable)(Spread<y>))(Spread<y>)
a -> Number
b -> List<Number>
c -> (Number -> ~List<Number> -> Variable)(Spread<List<Number>>)
map -> f -> x -> ~y -> Tuple<(f)(x), ~y -> Tuple<(f, (x -> ~y -> Variable)(Spread<y>)>)(Spread<y>)>
mapped -> Tuple<(Address<__pf_arg_idwx7 -> __pf_arg_idwx7>)(Number), (Number -> ~List<Number> -> Variable)(Spread<List<Number>>)>
