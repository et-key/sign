f : Lambda(Number)
map : Lambda([
  (_ <= <x>)
  (<map> <= [
    <g>
    _
  ])
])
result_map1 : [
  (_ <= Number)
  [
    (_ <= <x>)
    (<map> <= [
      <g>
      _
    ])
  ]
]
result_map2 : [
  (_ <= Number)
  [
    (_ <= <x>)
    (<map> <= [
      <g>
      _
    ])
  ]
]
result_sum : (_ <= [
  [
    [
      [
        Number
        Number
      ]
      Number
    ]
    Number
  ]
  Number
])
result_partial : ([
  _
  _
] <= [
  [
    [
      [
        Number
        Number
      ]
      Number
    ]
    Number
  ]
  Number
])
test_array : [
  [
    [
      [
        Number
        Number
      ]
      Number
    ]
    Number
  ]
  Number
]
test_tuple : [
  [
    Number
    <a>
  ]
  Number
]