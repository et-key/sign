f : Lambda(Number)
map : Lambda([
  (@<g> <= <x>)
  (<map> <= [
    <g>
    []
  ])
])
result_map1 : [
  (@[
    [
      [
        [
          Implicit(Lambda)
          Number
        ]
        Number
      ]
      Number
    ]
    Number
  ] <= Number)
  [
    (@<g> <= <x>)
    (<map> <= [
      <g>
      []
    ])
  ]
]
result_map2 : [
  (@[
    [
      [
        [
          Implicit(Lambda)
          Number
        ]
        Number
      ]
      Number
    ]
    Number
  ] <= Number)
  [
    (@<g> <= <x>)
    (<map> <= [
      <g>
      []
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