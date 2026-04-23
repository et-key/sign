# Exported ASTs

## Test 1
### Source
```
0x10
```
### Preprocessed
```
0x10
```
### AST
```json
[
  {
    "type": "AddressLiteral",
    "value": "0x10"
  }
]
```

## Test 2
### Source
```
0xFF
```
### Preprocessed
```
0xFF
```
### AST
```json
[
  {
    "type": "AddressLiteral",
    "value": "0xFF"
  }
]
```

## Test 3
### Source
```
0r10
```
### Preprocessed
```
0r10
```
### AST
```json
[
  {
    "type": "RegisterLiteral",
    "value": "0r10"
  }
]
```

## Test 4
### Source
```
0rFF
```
### Preprocessed
```
0rFF
```
### AST
```json
[
  {
    "type": "RegisterLiteral",
    "value": "0rFF"
  }
]
```

## Test 5
### Source
```
0u0041
```
### Preprocessed
```
0u0041
```
### AST
```json
[
  {
    "type": "UnicodeLiteral",
    "value": "0u0041"
  }
]
```

## Test 6
### Source
```
\a
```
### Preprocessed
```
\a
```
### AST
```json
[
  {
    "type": "CharLiteral",
    "value": "\\a"
  }
]
```

## Test 7
### Source
```
0u00f0
```
### Preprocessed
```
0u00f0
```
### AST
```json
[
  {
    "type": "UnicodeLiteral",
    "value": "0u00f0"
  }
]
```

## Test 8
### Source
```
0u0041 = \A
```
### Preprocessed
```
0u0041 = \A
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "UnicodeLiteral",
      "value": "0u0041"
    },
    "right": {
      "type": "CharLiteral",
      "value": "\\A"
    }
  }
]
```

## Test 9
### Source
```
\A = \A
```
### Preprocessed
```
\A = \A
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "CharLiteral",
      "value": "\\A"
    },
    "right": {
      "type": "CharLiteral",
      "value": "\\A"
    }
  }
]
```

## Test 10
### Source
```
\a != \b
```
### Preprocessed
```
\a != \b
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "!=",
    "left": {
      "type": "CharLiteral",
      "value": "\\a"
    },
    "right": {
      "type": "CharLiteral",
      "value": "\\b"
    }
  }
]
```

## Test 11
### Source
```
\n = \n
```
### Preprocessed
```
\n = \n
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "CharLiteral",
      "value": "\\n"
    },
    "right": {
      "type": "CharLiteral",
      "value": "\\n"
    }
  }
]
```

## Test 12
### Source
```
\t != \n
```
### Preprocessed
```
\t != \n
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "!=",
    "left": {
      "type": "CharLiteral",
      "value": "\\t"
    },
    "right": {
      "type": "CharLiteral",
      "value": "\\n"
    }
  }
]
```

## Test 13
### Source
```
(`abc` = `abc`)
```
### Preprocessed
```
(`abc` = `abc`)
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "StringLiteral",
      "value": "`abc`"
    },
    "right": {
      "type": "StringLiteral",
      "value": "`abc`"
    }
  }
]
```

## Test 14
### Source
```
(`hello`) != `world`
```
### Preprocessed
```
(`hello`) != `world`
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "!=",
    "left": {
      "type": "StringLiteral",
      "value": "`hello`"
    },
    "right": {
      "type": "StringLiteral",
      "value": "`world`"
    }
  }
]
```

## Test 15
### Source
```
(`abc` \
 \	 `def` = `abc` \
 \	 `def`)
```
### Preprocessed
```
(`abc` \
 \	 `def` = `abc` \
 \	 `def`)
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "StringLiteral",
        "value": "`abc`"
      },
      {
        "type": "CharLiteral",
        "value": "\\\n"
      },
      {
        "type": "CharLiteral",
        "value": "\\\t"
      },
      {
        "type": "BinaryExpression",
        "operator": "=",
        "left": {
          "type": "StringLiteral",
          "value": "`def`"
        },
        "right": {
          "type": "StringLiteral",
          "value": "`abc`"
        }
      },
      {
        "type": "CharLiteral",
        "value": "\\\n"
      },
      {
        "type": "CharLiteral",
        "value": "\\\t"
      },
      {
        "type": "StringLiteral",
        "value": "`def`"
      }
    ]
  }
]
```

## Test 16
### Source
```
\A , `bc`
```
### Preprocessed
```
\A , `bc`
```
### AST
```json
[
  {
    "type": "Product",
    "elements": [
      {
        "type": "CharLiteral",
        "value": "\\A"
      },
      {
        "type": "StringLiteral",
        "value": "`bc`"
      }
    ]
  }
]
```

## Test 17
### Source
```
(`Result: ` 123)
```
### Preprocessed
```
(`Result: ` 123)
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "StringLiteral",
        "value": "`Result: `"
      },
      {
        "type": "NumberLiteral",
        "value": 123
      }
    ]
  }
]
```

## Test 18
### Source
```
div : x y ? x / y
div2 : div _ 2
div2_type : div2
Result : div2 10
```
### Preprocessed
```
div : x y ? x / y
div2 : div _ 2
div2_type : div2
Result : div2 10
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "div"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          },
          {
            "type": "Identifier",
            "name": "y"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "/",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        },
        "right": {
          "type": "Identifier",
          "name": "y",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "div2"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Identifier",
          "name": "div",
          "_semanticType": "Unknown"
        },
        {
          "type": "Identifier",
          "name": "_",
          "_semanticType": "Unknown"
        },
        {
          "type": "NumberLiteral",
          "value": 2
        }
      ]
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "div2_type"
    },
    "body": {
      "type": "Identifier",
      "name": "div2",
      "_semanticType": "Unknown"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "Result"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Identifier",
          "name": "div2",
          "_semanticType": "Unknown"
        },
        {
          "type": "NumberLiteral",
          "value": 10
        }
      ]
    }
  }
]
```

## Test 19
### Source
```
0 + `123`
```
### Preprocessed
```
0 + `123`
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "+",
    "left": {
      "type": "NumberLiteral",
      "value": 0
    },
    "right": {
      "type": "StringLiteral",
      "value": "`123`"
    }
  }
]
```

## Test 20
### Source
```
x : `123` + 0
```
### Preprocessed
```
x : `123` + 0
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "x"
    },
    "body": {
      "type": "BinaryExpression",
      "operator": "+",
      "left": {
        "type": "StringLiteral",
        "value": "`123`"
      },
      "right": {
        "type": "NumberLiteral",
        "value": 0
      }
    }
  }
]
```

## Test 21
### Source
```
x : `123` 0
```
### Preprocessed
```
x : `123` 0
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "x"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "StringLiteral",
          "value": "`123`"
        },
        {
          "type": "NumberLiteral",
          "value": 0
        }
      ]
    }
  }
]
```

## Test 22
### Source
```
0 & 1
```
### Preprocessed
```
0 & 1
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "&",
    "left": {
      "type": "NumberLiteral",
      "value": 0
    },
    "right": {
      "type": "NumberLiteral",
      "value": 1
    }
  }
]
```

## Test 23
### Source
```
!_
```
### Preprocessed
```
!_
```
### AST
```json
[
  {
    "type": "PrefixExpression",
    "operator": "!",
    "expression": {
      "type": "Identifier",
      "name": "_"
    }
  }
]
```

## Test 24
### Source
```
_ & 100
```
### Preprocessed
```
_ & 100
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "&",
    "left": {
      "type": "Identifier",
      "name": "_",
      "_semanticType": "Unknown"
    },
    "right": {
      "type": "NumberLiteral",
      "value": 100
    }
  }
]
```

## Test 25
### Source
```
_ | |-4*2+3| + 5 < 0 | 3
```
### Preprocessed
```
_ | |-4*2+3| + 5 < 0 | 3
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "|",
    "left": {
      "type": "BinaryExpression",
      "operator": "|",
      "left": {
        "type": "Identifier",
        "name": "_",
        "_semanticType": "Unknown"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "<",
        "left": {
          "type": "BinaryExpression",
          "operator": "+",
          "left": {
            "type": "AbsoluteExpression",
            "expression": {
              "type": "BinaryExpression",
              "operator": "+",
              "left": {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "NumberLiteral",
                  "value": -4
                },
                "right": {
                  "type": "NumberLiteral",
                  "value": 2
                }
              },
              "right": {
                "type": "NumberLiteral",
                "value": 3
              }
            }
          },
          "right": {
            "type": "NumberLiteral",
            "value": 5
          }
        },
        "right": {
          "type": "NumberLiteral",
          "value": 0
        }
      }
    },
    "right": {
      "type": "NumberLiteral",
      "value": 3
    }
  }
]
```

## Test 26
### Source
```
-5* |-4*2+3| /2<0 | 3
```
### Preprocessed
```
-5* |-4*2+3| /2<0 | 3
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "|",
    "left": {
      "type": "BinaryExpression",
      "operator": "<",
      "left": {
        "type": "BinaryExpression",
        "operator": "/",
        "left": {
          "type": "BinaryExpression",
          "operator": "*",
          "left": {
            "type": "NumberLiteral",
            "value": -5
          },
          "right": {
            "type": "AbsoluteExpression",
            "expression": {
              "type": "BinaryExpression",
              "operator": "+",
              "left": {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "NumberLiteral",
                  "value": -4
                },
                "right": {
                  "type": "NumberLiteral",
                  "value": 2
                }
              },
              "right": {
                "type": "NumberLiteral",
                "value": 3
              }
            }
          }
        },
        "right": {
          "type": "NumberLiteral",
          "value": 2
        }
      },
      "right": {
        "type": "NumberLiteral",
        "value": 0
      }
    },
    "right": {
      "type": "NumberLiteral",
      "value": 3
    }
  }
]
```

## Test 27
### Source
```
-5* |-4*2+3|/2<0 | 3
```
### Preprocessed
```
-5* |-4*2+3|/2<0 | 3
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "|",
    "left": {
      "type": "BinaryExpression",
      "operator": "<",
      "left": {
        "type": "BinaryExpression",
        "operator": "/",
        "left": {
          "type": "BinaryExpression",
          "operator": "*",
          "left": {
            "type": "NumberLiteral",
            "value": -5
          },
          "right": {
            "type": "AbsoluteExpression",
            "expression": {
              "type": "BinaryExpression",
              "operator": "+",
              "left": {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "NumberLiteral",
                  "value": -4
                },
                "right": {
                  "type": "NumberLiteral",
                  "value": 2
                }
              },
              "right": {
                "type": "NumberLiteral",
                "value": 3
              }
            }
          }
        },
        "right": {
          "type": "NumberLiteral",
          "value": 2
        }
      },
      "right": {
        "type": "NumberLiteral",
        "value": 0
      }
    },
    "right": {
      "type": "NumberLiteral",
      "value": 3
    }
  }
]
```

## Test 28
### Source
```
-5*|-4*2+3|/2<0 | 3
```
### Preprocessed
```
-5*|-4*2+3|/2<0 | 3
```
### AST
```json
[
  {
    "type": "BinaryExpression",
    "operator": "|",
    "left": {
      "type": "BinaryExpression",
      "operator": "<",
      "left": {
        "type": "BinaryExpression",
        "operator": "/",
        "left": {
          "type": "BinaryExpression",
          "operator": "*",
          "left": {
            "type": "NumberLiteral",
            "value": -5
          },
          "right": {
            "type": "AbsoluteExpression",
            "expression": {
              "type": "BinaryExpression",
              "operator": "+",
              "left": {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "NumberLiteral",
                  "value": -4
                },
                "right": {
                  "type": "NumberLiteral",
                  "value": 2
                }
              },
              "right": {
                "type": "NumberLiteral",
                "value": 3
              }
            }
          }
        },
        "right": {
          "type": "NumberLiteral",
          "value": 2
        }
      },
      "right": {
        "type": "NumberLiteral",
        "value": 0
      }
    },
    "right": {
      "type": "NumberLiteral",
      "value": 3
    }
  }
]
```

## Test 29
### Source
```
pass_eq  : x ? 10 = x
pass_eq 10
```
### Preprocessed
```
pass_eq  : x ? 10 = x
pass_eq 10
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_eq"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "=",
        "left": {
          "type": "NumberLiteral",
          "value": 10
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 10
      }
    ]
  }
]
```

## Test 30
### Source
```
pass_eq  : x ? 10 = x
pass_eq 5
```
### Preprocessed
```
pass_eq  : x ? 10 = x
pass_eq 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_eq"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "=",
        "left": {
          "type": "NumberLiteral",
          "value": 10
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 31
### Source
```
pass_neq : x ? 10 != x
pass_neq 5
```
### Preprocessed
```
pass_neq : x ? 10 != x
pass_neq 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_neq"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "!=",
        "left": {
          "type": "NumberLiteral",
          "value": 10
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_neq",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 32
### Source
```
pass_gt : x ? 5 < x
pass_gt 10
```
### Preprocessed
```
pass_gt : x ? 5 < x
pass_gt 10
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_gt"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "<",
        "left": {
          "type": "NumberLiteral",
          "value": 5
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_gt",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 10
      }
    ]
  }
]
```

## Test 33
### Source
```
pass_lt : x ? 5 > x
pass_lt 2
```
### Preprocessed
```
pass_lt : x ? 5 > x
pass_lt 2
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_lt"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": ">",
        "left": {
          "type": "NumberLiteral",
          "value": 5
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_lt",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 2
      }
    ]
  }
]
```

## Test 34
### Source
```
pass_ge : x ? 5 <= x
pass_ge 5
```
### Preprocessed
```
pass_ge : x ? 5 <= x
pass_ge 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_ge"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "<=",
        "left": {
          "type": "NumberLiteral",
          "value": 5
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_ge",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 35
### Source
```
pass_le : x ? 5 >= x
pass_le 5
```
### Preprocessed
```
pass_le : x ? 5 >= x
pass_le 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "pass_le"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": ">=",
        "left": {
          "type": "NumberLiteral",
          "value": 5
        },
        "right": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "pass_le",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 36
### Source
```
set_default : x ? x | 100
set_default 50
```
### Preprocessed
```
set_default : x ? x | 100
set_default 50
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "set_default"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "|",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        },
        "right": {
          "type": "NumberLiteral",
          "value": 100
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 50
      }
    ]
  }
]
```

## Test 37
### Source
```
set_default : x ? x | 100
set_default _
```
### Preprocessed
```
set_default : x ? x | 100
set_default _
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "set_default"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "|",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        },
        "right": {
          "type": "NumberLiteral",
          "value": 100
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "_",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 38
### Source
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists 5
```
### Preprocessed
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "calc_if_exists"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "&",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "*",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Unknown"
          },
          "right": {
            "type": "NumberLiteral",
            "value": 10
          }
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 39
### Source
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists _
```
### Preprocessed
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists _
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "calc_if_exists"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "BinaryExpression",
        "operator": "&",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Unknown"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "*",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Unknown"
          },
          "right": {
            "type": "NumberLiteral",
            "value": 10
          }
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "_",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 40
### Source
```
is_empty : x ? !x
is_empty 100
```
### Preprocessed
```
is_empty : x ? !x
is_empty 100
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "is_empty"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "PrefixExpression",
        "operator": "!",
        "expression": {
          "type": "Identifier",
          "name": "x"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 100
      }
    ]
  }
]
```

## Test 41
### Source
```
is_empty : x ? !x
is_empty _
```
### Preprocessed
```
is_empty : x ? !x
is_empty _
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "is_empty"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "PrefixExpression",
        "operator": "!",
        "expression": {
          "type": "Identifier",
          "name": "x"
        }
      }
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "_",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 42
### Source
```
[!_] 5 = (!5)
```
### Preprocessed
```
[!_] 5 = (!5)
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "PrefixExpression",
        "operator": "!",
        "expression": {
          "type": "Identifier",
          "name": "_"
        }
      },
      {
        "type": "BinaryExpression",
        "operator": "=",
        "left": {
          "type": "NumberLiteral",
          "value": 5
        },
        "right": {
          "type": "PrefixExpression",
          "operator": "!",
          "expression": {
            "type": "NumberLiteral",
            "value": 5
          }
        }
      }
    ]
  }
]
```

## Test 43
### Source
```
[_!] 5 = 5!
```
### Preprocessed
```
[_!] 5 = 5!
```
### AST Generation Error
```
Expected "," but "]" found.
```

## Test 44
### Source
```
[1 2] [3 4]
```
### Preprocessed
```
[1 2] [3 4]
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 1
          },
          {
            "type": "NumberLiteral",
            "value": 2
          }
        ]
      },
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 3
          },
          {
            "type": "NumberLiteral",
            "value": 4
          }
        ]
      }
    ]
  }
]
```

## Test 45
### Source
```
list : 1 2 , 3 4
```
### Preprocessed
```
list : 1 2 , 3 4
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "list"
    },
    "body": {
      "type": "Product",
      "elements": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "NumberLiteral",
              "value": 1
            },
            {
              "type": "NumberLiteral",
              "value": 2
            }
          ]
        },
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "NumberLiteral",
              "value": 3
            },
            {
              "type": "NumberLiteral",
              "value": 4
            }
          ]
        }
      ]
    }
  }
]
```

## Test 46
### Source
```
[1 2 , 3 4]~
```
### Preprocessed
```
[1 2 , 3 4]~
```
### AST Generation Error
```
Expected " ", "!!", "!=", "&", "&&", "(", "+", "-", "0b", "0r", "0u", "0x", ";", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\r\n", "]", "^", "_", "`", "{", "|", "||", "~", [!$@], [%*/], [0-9], [<->], [\n\r], or [a-zA-Z_] but "," found.
```

## Test 47
### Source
```
[[1 2] [3 4]]~
```
### Preprocessed
```
[[1 2] [3 4]]~
```
### AST Generation Error
```
Expected " ", "!=", "&", "+", ",", ";", "<=", "==", ">=", "\r\n", "^", [%*/], [<->], or [\n\r] but "~" found.
```

## Test 48
### Source
```
a : 1 2 3 4 5
~a
```
### Preprocessed
```
a : 1 2 3 4 5
~a
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "a"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "NumberLiteral",
          "value": 1
        },
        {
          "type": "NumberLiteral",
          "value": 2
        },
        {
          "type": "NumberLiteral",
          "value": 3
        },
        {
          "type": "NumberLiteral",
          "value": 4
        },
        {
          "type": "NumberLiteral",
          "value": 5
        }
      ]
    }
  },
  {
    "type": "PrefixExpression",
    "operator": "~",
    "expression": {
      "type": "Identifier",
      "name": "a"
    }
  }
]
```

## Test 49
### Source
```
~10
```
### Preprocessed
```
~10
```
### AST
```json
[
  {
    "type": "PrefixExpression",
    "operator": "~",
    "expression": {
      "type": "NumberLiteral",
      "value": 10
    }
  }
]
```

## Test 50
### Source
```
10~
```
### Preprocessed
```
10~
```
### AST
```json
[
  {
    "type": "PostfixExpression",
    "operator": "~",
    "expression": {
      "type": "NumberLiteral",
      "value": 10
    }
  }
]
```

## Test 51
### Source
```
[1 , [2 , 3]~ , 4]
```
### Preprocessed
```
[1 , [2 , 3]~ , 4]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "[" found.
```

## Test 52
### Source
```
[1 , [2 , 3]~ 4]
```
### Preprocessed
```
[1 , [2 , 3]~ 4]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "[" found.
```

## Test 53
### Source
```
[1 [2 , 3]~ , 4]
```
### Preprocessed
```
[1 [2 , 3]~ , 4]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "3" found.
```

## Test 54
### Source
```
[1 [2 , 3]~ 4]
```
### Preprocessed
```
[1 [2 , 3]~ 4]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "3" found.
```

## Test 55
### Source
```
1 2 , [3 4] , [5 6]
```
### Preprocessed
```
1 2 , [3 4] , [5 6]
```
### AST
```json
[
  {
    "type": "Product",
    "elements": [
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 1
          },
          {
            "type": "NumberLiteral",
            "value": 2
          }
        ]
      },
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 3
          },
          {
            "type": "NumberLiteral",
            "value": 4
          }
        ]
      },
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 5
          },
          {
            "type": "NumberLiteral",
            "value": 6
          }
        ]
      }
    ]
  }
]
```

## Test 56
### Source
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### Preprocessed
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "2" found.
```

## Test 57
### Source
```
1 , 2 , [3 4] , [5 6]
```
### Preprocessed
```
1 , 2 , [3 4] , [5 6]
```
### AST
```json
[
  {
    "type": "Product",
    "elements": [
      {
        "type": "NumberLiteral",
        "value": 1
      },
      {
        "type": "NumberLiteral",
        "value": 2
      },
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 3
          },
          {
            "type": "NumberLiteral",
            "value": 4
          }
        ]
      },
      {
        "type": "Coproduct",
        "elements": [
          {
            "type": "NumberLiteral",
            "value": 5
          },
          {
            "type": "NumberLiteral",
            "value": 6
          }
        ]
      }
    ]
  }
]
```

## Test 58
### Source
```
[1 , 2 , [3 4] , [5 6]]
```
### Preprocessed
```
[1 , 2 , [3 4] , [5 6]]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "2" found.
```

## Test 59
### Source
```
1 , 2 , [3 , 4] , [5 , 6]
```
### Preprocessed
```
1 , 2 , [3 , 4] , [5 , 6]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "4" found.
```

## Test 60
### Source
```
1 2 , [3 4 , 5 6]
```
### Preprocessed
```
1 2 , [3 4 , 5 6]
```
### AST Generation Error
```
Expected " ", "!!", "!=", "&", "&&", "(", "+", "-", "0b", "0r", "0u", "0x", ";", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\r\n", "]", "^", "_", "`", "{", "|", "||", "~", [!$@], [%*/], [0-9], [<->], [\n\r], or [a-zA-Z_] but "," found.
```

## Test 61
### Source
```
getHead : a ~b ? a
getHead [1 , 2 , 3]
```
### Preprocessed
```
getHead : a ~b ? a
getHead [1 , 2 , 3]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "2" found.
```

## Test 62
### Source
```
getTail : a ~b ? b
getTail [1 , 2 , 3]
```
### Preprocessed
```
getTail : a ~b ? b
getTail [1 , 2 , 3]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "2" found.
```

## Test 63
### Source
```
[1 ~ 5]
```
### Preprocessed
```
[1 ~ 5]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceRange",
      "left": {
        "type": "NumberLiteral",
        "value": 1
      },
      "right": {
        "type": "NumberLiteral",
        "value": 5
      }
    },
    "bracket": "[]"
  }
]
```

## Test 64
### Source
```
[-2 ~ 3]
```
### Preprocessed
```
[-2 ~ 3]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceRange",
      "left": {
        "type": "NumberLiteral",
        "value": -2
      },
      "right": {
        "type": "NumberLiteral",
        "value": 3
      }
    },
    "bracket": "[]"
  }
]
```

## Test 65
### Source
```
[0 ~+ 2.5 ~ 10]
```
### Preprocessed
```
[0 ~+ 2.5 ~ 10]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 0
      },
      "operator": "~+",
      "right": {
        "type": "NumberLiteral",
        "value": 2.5
      },
      "step": {
        "type": "NumberLiteral",
        "value": 10
      }
    },
    "bracket": "[]"
  }
]
```

## Test 66
### Source
```
[10 ~+ 2 ~ 0]
```
### Preprocessed
```
[10 ~+ 2 ~ 0]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 10
      },
      "operator": "~+",
      "right": {
        "type": "NumberLiteral",
        "value": 2
      },
      "step": {
        "type": "NumberLiteral",
        "value": 0
      }
    },
    "bracket": "[]"
  }
]
```

## Test 67
### Source
```
[10 ~- 2.5 ~ 1]
```
### Preprocessed
```
[10 ~- 2.5 ~ 1]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 10
      },
      "operator": "~-",
      "right": {
        "type": "NumberLiteral",
        "value": 2.5
      },
      "step": {
        "type": "NumberLiteral",
        "value": 1
      }
    },
    "bracket": "[]"
  }
]
```

## Test 68
### Source
```
[1 ~* 2 ~ 16]
```
### Preprocessed
```
[1 ~* 2 ~ 16]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 1
      },
      "operator": "~*",
      "right": {
        "type": "NumberLiteral",
        "value": 2
      },
      "step": {
        "type": "NumberLiteral",
        "value": 16
      }
    },
    "bracket": "[]"
  }
]
```

## Test 69
### Source
```
[1 ~* 2.5 ~ 16]
```
### Preprocessed
```
[1 ~* 2.5 ~ 16]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 1
      },
      "operator": "~*",
      "right": {
        "type": "NumberLiteral",
        "value": 2.5
      },
      "step": {
        "type": "NumberLiteral",
        "value": 16
      }
    },
    "bracket": "[]"
  }
]
```

## Test 70
### Source
```
[16 ~/ 2 ~ 1]
```
### Preprocessed
```
[16 ~/ 2 ~ 1]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 16
      },
      "operator": "~/",
      "right": {
        "type": "NumberLiteral",
        "value": 2
      },
      "step": {
        "type": "NumberLiteral",
        "value": 1
      }
    },
    "bracket": "[]"
  }
]
```

## Test 71
### Source
```
[10 ~/ 2.5 ~ 1]
```
### Preprocessed
```
[10 ~/ 2.5 ~ 1]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 10
      },
      "operator": "~/",
      "right": {
        "type": "NumberLiteral",
        "value": 2.5
      },
      "step": {
        "type": "NumberLiteral",
        "value": 1
      }
    },
    "bracket": "[]"
  }
]
```

## Test 72
### Source
```
[2 ~^ 2 ~ 256]
```
### Preprocessed
```
[2 ~^ 2 ~ 256]
```
### AST
```json
[
  {
    "type": "Sequence",
    "inner": {
      "type": "SequenceGenerator",
      "left": {
        "type": "NumberLiteral",
        "value": 2
      },
      "operator": "~^",
      "right": {
        "type": "NumberLiteral",
        "value": 2
      },
      "step": {
        "type": "NumberLiteral",
        "value": 256
      }
    },
    "bracket": "[]"
  }
]
```

## Test 73
### Source
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### Preprocessed
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### AST Generation Error
```
Expected " ", "!!", "(", ",", "-", "0b", "0r", "0u", "0x", "[", "\\", "\r\n", "_", "`", "{", "|", "~", [!$@], [0-9], [\n\r], or [a-zA-Z_] but "=" found.
```

## Test 74
### Source
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### Preprocessed
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### AST Generation Error
```
Expected " ", "!!", "(", ",", "-", "0b", "0r", "0u", "0x", "[", "\\", "\r\n", "_", "`", "{", "|", "~", [!$@], [0-9], [\n\r], or [a-zA-Z_] but "=" found.
```

## Test 75
### Source
```
list : 1 2 , 3 4
list ' 0
```
### Preprocessed
```
list : 1 2 , 3 4
list ' 0
```
### AST Generation Error
```
Expected " ", "`", or [a-zA-Z_] but "0" found.
```

## Test 76
### Source
```
list : 1 2 , 3 4
list ' 1
```
### Preprocessed
```
list : 1 2 , 3 4
list ' 1
```
### AST Generation Error
```
Expected " ", "`", or [a-zA-Z_] but "1" found.
```

## Test 77
### Source
```
list : 1 2 , 3 4
list ' 3
```
### Preprocessed
```
list : 1 2 , 3 4
list ' 3
```
### AST Generation Error
```
Expected " ", "`", or [a-zA-Z_] but "3" found.
```

## Test 78
### Source
```
myDict :
	`key1` : `value_one`
	`key2` : `value_two`
target : `key2`
myDict ' target~
```
### Preprocessed
```
myDict : {
`key1` : `value_one`
`key2` : `value_two`
}
target : `key2`
myDict ' target~
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "myDict"
    },
    "body": {
      "type": "Dictionary",
      "pairs": [
        {
          "key": {
            "type": "StringLiteral",
            "value": "`key1`"
          },
          "value": {
            "type": "StringLiteral",
            "value": "`value_one`"
          }
        },
        {
          "key": {
            "type": "StringLiteral",
            "value": "`key2`"
          },
          "value": {
            "type": "StringLiteral",
            "value": "`value_two`"
          }
        }
      ]
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "target"
    },
    "body": {
      "type": "StringLiteral",
      "value": "`key2`"
    }
  },
  {
    "type": "GetExpression",
    "target": {
      "type": "Identifier",
      "name": "myDict"
    },
    "steps": [
      [
        {
          "type": "Identifier",
          "name": "target"
        },
        "~"
      ]
    ]
  }
]
```

## Test 79
### Source
```
complexDict :
	[ 1 , 2 ] : `Pattern A`
	[ 3 , 4 ] : `Pattern B`
complexDict ' [ 1 , 2 ]
```
### Preprocessed
```
complexDict : {
[ 1 , 2 ] : `Pattern A`
[ 3 , 4 ] : `Pattern B`
}
complexDict ' [ 1 , 2 ]
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "2" found.
```

## Test 80
### Source
```
x : 3
a : 1 2 3 4 5
a ' x~
```
### Preprocessed
```
x : 3
a : 1 2 3 4 5
a ' x~
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "x"
    },
    "body": {
      "type": "NumberLiteral",
      "value": 3
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "a"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "NumberLiteral",
          "value": 1
        },
        {
          "type": "NumberLiteral",
          "value": 2
        },
        {
          "type": "NumberLiteral",
          "value": 3
        },
        {
          "type": "NumberLiteral",
          "value": 4
        },
        {
          "type": "NumberLiteral",
          "value": 5
        }
      ]
    }
  },
  {
    "type": "GetExpression",
    "target": {
      "type": "Identifier",
      "name": "a"
    },
    "steps": [
      [
        {
          "type": "Identifier",
          "name": "x"
        },
        "~"
      ]
    ]
  }
]
```

## Test 81
### Source
```
x : 3
a : 1 2 3 4 5
a ' x
```
### Preprocessed
```
x : 3
a : 1 2 3 4 5
a ' x
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "x"
    },
    "body": {
      "type": "NumberLiteral",
      "value": 3
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "a"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "NumberLiteral",
          "value": 1
        },
        {
          "type": "NumberLiteral",
          "value": 2
        },
        {
          "type": "NumberLiteral",
          "value": 3
        },
        {
          "type": "NumberLiteral",
          "value": 4
        },
        {
          "type": "NumberLiteral",
          "value": 5
        }
      ]
    }
  },
  {
    "type": "GetExpression",
    "target": {
      "type": "Identifier",
      "name": "a"
    },
    "steps": [
      [
        {
          "type": "Identifier",
          "name": "x"
        },
        null
      ]
    ]
  }
]
```

## Test 82
### Source
```
car :
	brand : `foo` , `Bar` , `Baz`
car ' brand ' 0
```
### Preprocessed
```
car : {
brand : `foo` , `Bar` , `Baz`
}
car ' brand ' 0
```
### AST Generation Error
```
Expected " ", "`", or [a-zA-Z_] but "0" found.
```

## Test 83
### Source
```
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a = b
```
### Preprocessed
```
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a = b
```
### AST Generation Error
```
Expected " ", "\r\n", "]", or [\n\r] but "[" found.
```

## Test 84
### Source
```
myMatch : x ?
	0 : `zero`
	1 : `one`
	`other`
myMatch 99
```
### Preprocessed
```
myMatch : x ? {
0 : `zero`
1 : `one`
`other`
}
myMatch 99
```
### AST Generation Error
```
Expected " ", "!=", "&", "&&", "+", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], or [<->] but "\n" found.
```

## Test 85
### Source
```
myMatch : x ?
	0 : `zero`
	1 : `one`
	`other`
myMatch 0
```
### Preprocessed
```
myMatch : x ? {
0 : `zero`
1 : `one`
`other`
}
myMatch 0
```
### AST Generation Error
```
Expected " ", "!=", "&", "&&", "+", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], or [<->] but "\n" found.
```

## Test 86
### Source
```
myMatch : x ?
	0 : `zero`
	1 : `one`
	`other`
myMatch 1
```
### Preprocessed
```
myMatch : x ? {
0 : `zero`
1 : `one`
`other`
}
myMatch 1
```
### AST Generation Error
```
Expected " ", "!=", "&", "&&", "+", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], or [<->] but "\n" found.
```

## Test 87
### Source
```
dict :
	x : 10
	y : 5
	z : 30
```
### Preprocessed
```
dict : {
x : 10
y : 5
z : 30
}
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "dict"
    },
    "body": {
      "type": "Dictionary",
      "pairs": [
        {
          "key": [
            {
              "type": "Identifier",
              "name": "x"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": 10
          }
        },
        {
          "key": [
            {
              "type": "Identifier",
              "name": "y"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": 5
          }
        },
        {
          "key": [
            {
              "type": "Identifier",
              "name": "z"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": 30
          }
        }
      ]
    }
  }
]
```

## Test 88
### Source
```
f : foo ? 
	foo~
		x > 0 :
			xy : x * y
			xz : x * z
		x < 1 :
			x # |x| + 5
			f foo
```
### Preprocessed
```
f : foo ? {
foo~ {
x > 0 : {
xy : x * y
xz : x * z
}
x < 1 : {
x # |x| + 5
f foo
}
}
}
```
### AST Generation Error
```
Expected " " or ":" but "{" found.
```

## Test 89
### Source
```
f dict
```
### Preprocessed
```
f dict
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "f",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "dict",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 90
### Source
```
dict :
	x : -10
	y : 5
	z : 30
```
### Preprocessed
```
dict : {
x : -10
y : 5
z : 30
}
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "dict"
    },
    "body": {
      "type": "Dictionary",
      "pairs": [
        {
          "key": [
            {
              "type": "Identifier",
              "name": "x"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": -10
          }
        },
        {
          "key": [
            {
              "type": "Identifier",
              "name": "y"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": 5
          }
        },
        {
          "key": [
            {
              "type": "Identifier",
              "name": "z"
            },
            null
          ],
          "value": {
            "type": "NumberLiteral",
            "value": 30
          }
        }
      ]
    }
  }
]
```

## Test 91
### Source
```
f : foo ? 
	foo~
		x > 0 :
			xy : x * y
			xz : x * z
		x < 1 :
			x # |x| + 5
			f foo
```
### Preprocessed
```
f : foo ? {
foo~ {
x > 0 : {
xy : x * y
xz : x * z
}
x < 1 : {
x # |x| + 5
f foo
}
}
}
```
### AST Generation Error
```
Expected " " or ":" but "{" found.
```

## Test 92
### Source
```
f dict
```
### Preprocessed
```
f dict
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "f",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "dict",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 93
### Source
```
f : x ? y ? x + y
addTen : f 10
addTen 20
```
### Preprocessed
```
f : x ? y ? x + y
addTen : f 10
addTen 20
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "f"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          }
        ]
      },
      "body": {
        "type": "Lambda",
        "arguments": {
          "type": "ArgumentsInline",
          "args": [
            {
              "type": "Identifier",
              "name": "y"
            }
          ]
        },
        "body": {
          "type": "BinaryExpression",
          "operator": "+",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Unknown"
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Unknown"
          }
        }
      }
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "addTen"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Identifier",
          "name": "f",
          "_semanticType": "Unknown"
        },
        {
          "type": "NumberLiteral",
          "value": 10
        }
      ]
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "addTen",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 20
      }
    ]
  }
]
```

## Test 94
### Source
```
[+] 1 2 3 4 5
```
### Preprocessed
```
[+] 1 2 3 4 5
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "PointFreeFold",
        "operator": "+"
      },
      {
        "type": "NumberLiteral",
        "value": 1
      },
      {
        "type": "NumberLiteral",
        "value": 2
      },
      {
        "type": "NumberLiteral",
        "value": 3
      },
      {
        "type": "NumberLiteral",
        "value": 4
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 95
### Source
```
[* 2,] 1 2 3 4 5
```
### Preprocessed
```
[* 2,] 1 2 3 4 5
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "PointFreeMap",
        "position": "infix_left",
        "argument": {
          "type": "NumberLiteral",
          "value": 2
        },
        "operator": "*"
      },
      {
        "type": "NumberLiteral",
        "value": 1
      },
      {
        "type": "NumberLiteral",
        "value": 2
      },
      {
        "type": "NumberLiteral",
        "value": 3
      },
      {
        "type": "NumberLiteral",
        "value": 4
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 96
### Source
```
[* 2,] [+] 1 2 3 4 5
```
### Preprocessed
```
[* 2,] [+] 1 2 3 4 5
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "PointFreeMap",
        "position": "infix_left",
        "argument": {
          "type": "NumberLiteral",
          "value": 2
        },
        "operator": "*"
      },
      {
        "type": "PointFreeFold",
        "operator": "+"
      },
      {
        "type": "NumberLiteral",
        "value": 1
      },
      {
        "type": "NumberLiteral",
        "value": 2
      },
      {
        "type": "NumberLiteral",
        "value": 3
      },
      {
        "type": "NumberLiteral",
        "value": 4
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 97
### Source
```
foo : [+ 4]
bar : [* 3]
baz : 2
foo bar baz
```
### Preprocessed
```
foo : [+ 4]
bar : [* 3]
baz : 2
foo bar baz
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "foo"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 4
      },
      "operator": "+"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "bar"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 3
      },
      "operator": "*"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "baz"
    },
    "body": {
      "type": "NumberLiteral",
      "value": 2
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "bar",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "baz",
        "_semanticType": "Unknown"
      }
    ]
  }
]
```

## Test 98
### Source
```
add_ten : [+ 10]
mul_two : [* 2]
sub_five : [- 5]
add_ten mul_two sub_five 5
```
### Preprocessed
```
add_ten : [+ 10]
mul_two : [* 2]
sub_five : [- 5]
add_ten mul_two sub_five 5
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "add_ten"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 10
      },
      "operator": "+"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "mul_two"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 2
      },
      "operator": "*"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "sub_five"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 5
      },
      "operator": "-"
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "add_ten",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "mul_two",
        "_semanticType": "Unknown"
      },
      {
        "type": "Identifier",
        "name": "sub_five",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  }
]
```

## Test 99
### Source
```
[+ 4] [* 3] [/ 2] 10
```
### Preprocessed
```
[+ 4] [* 3] [/ 2] 10
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "PointFreeNormal",
        "position": "infix_left",
        "argument": {
          "type": "NumberLiteral",
          "value": 4
        },
        "operator": "+"
      },
      {
        "type": "PointFreeNormal",
        "position": "infix_left",
        "argument": {
          "type": "NumberLiteral",
          "value": 3
        },
        "operator": "*"
      },
      {
        "type": "PointFreeNormal",
        "position": "infix_left",
        "argument": {
          "type": "NumberLiteral",
          "value": 2
        },
        "operator": "/"
      },
      {
        "type": "NumberLiteral",
        "value": 10
      }
    ]
  }
]
```

## Test 100
### Source
```
double : [* 2]
square : [^ 2]
double square (3 + 2)
```
### Preprocessed
```
double : [* 2]
square : [^ 2]
double square (3 + 2)
```
### AST Generation Error
```
Expected " ", ")", "\r\n", or [\n\r] but "2" found.
```

## Test 101
### Source
```
fact : n ?
	n = 0 : 1
	(fact (n - 1)) * n
fact 5
```
### Preprocessed
```
fact : n ? {
n = 0 : 1
(fact (n - 1)) * n
}
fact 5
```
### AST Generation Error
```
Expected [0-9] but " " found.
```

## Test 102
### Source
```
gcd1 : x y r ?
	r = 0 : y
	gcd1  y r  (y % r)
gcd : x y ?
	gcd1  x y (x % y)
gcd 18 9
```
### Preprocessed
```
gcd1 : x y r ? {
r = 0 : y
gcd1  y r  (y % r)
}
gcd : x y ? {
gcd1  x y (x % y)
}
gcd 18 9
```
### AST Generation Error
```
Expected " ", "!=", "&", "'", "+", ":", ";", "<=", "==", ">=", "^", "|", [%*/], or [<->] but "y" found.
```

## Test 103
### Source
```
gcd1 : x y r ?
	r = 0 : y  
	gcd1  y r  (y % r)
gcd : x y ?
	gcd1  x y (x % y)
gcd 18 12
```
### Preprocessed
```
gcd1 : x y r ? {
r = 0 : y
gcd1  y r  (y % r)
}
gcd : x y ? {
gcd1  x y (x % y)
}
gcd 18 12
```
### AST Generation Error
```
Expected " ", "!=", "&", "'", "+", ":", ";", "<=", "==", ">=", "^", "|", [%*/], or [<->] but "y" found.
```

## Test 104
### Source
```
f : x y ?
	y > 20 : y
	g x y
```
### Preprocessed
```
f : x y ? {
y > 20 : y
g x y
}
```
### AST Generation Error
```
Expected " ", "!=", "&", "'", "+", ":", ";", "<=", "==", ">=", "^", "|", [%*/], or [<->] but "x" found.
```

## Test 105
### Source
```
g : x y ?
	f x x + y
```
### Preprocessed
```
g : x y ? {
f x x + y
}
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "g"
    },
    "body": {
      "type": "Lambda",
      "arguments": {
        "type": "ArgumentsInline",
        "args": [
          {
            "type": "Identifier",
            "name": "x"
          },
          {
            "type": "Identifier",
            "name": "y"
          }
        ]
      },
      "body": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Identifier",
            "name": "f",
            "_semanticType": "Unknown"
          },
          {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Unknown"
          },
          {
            "type": "BinaryExpression",
            "operator": "+",
            "left": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Unknown"
            },
            "right": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Unknown"
            }
          }
        ]
      }
    }
  }
]
```

## Test 106
### Source
```
f 2 2
```
### Preprocessed
```
f 2 2
```
### AST
```json
[
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "f",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 2
      },
      {
        "type": "NumberLiteral",
        "value": 2
      }
    ]
  }
]
```

## Test 107
### Source
```
x : 10
$x # 20
x
```
### Preprocessed
```
x : 10
$x # 20
x
```
### AST Generation Error
```
Expected " ", "!!", "!=", "&", "&&", "(", "+", ",", "-", "0b", "0r", "0u", "0x", ";", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\r\n", "^", "_", "`", "{", "|", "||", "~", [!$@], [%*/], [0-9], [<->], [\n\r], or [a-zA-Z_] but "#" found.
```

## Test 108
### Source
```
$[1 2 3 4 5]
```
### Preprocessed
```
$[1 2 3 4 5]
```
### AST Generation Error
```
Expected "!!", "-", "0b", "0r", "0u", "0x", "\\", "_", "`", "~", [!$@], [0-9], or [a-zA-Z_] but "[" found.
```

## Test 109
### Source
```
foo : 1 2 3 4 5
$[foo 6]
```
### Preprocessed
```
foo : 1 2 3 4 5
$[foo 6]
```
### AST Generation Error
```
Expected "!!", "-", "0b", "0r", "0u", "0x", "\\", "_", "`", "~", [!$@], [0-9], or [a-zA-Z_] but "[" found.
```

## Test 110
### Source
```
foo : 1 2 3 4 5
$[foo~]
```
### Preprocessed
```
foo : 1 2 3 4 5
$[foo~]
```
### AST Generation Error
```
Expected "!!", "-", "0b", "0r", "0u", "0x", "\\", "_", "`", "~", [!$@], [0-9], or [a-zA-Z_] but "[" found.
```

## Test 111
### Source
```
foo : 1 2 3 4 5
$foo
```
### Preprocessed
```
foo : 1 2 3 4 5
$foo
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "foo"
    },
    "body": {
      "type": "Coproduct",
      "elements": [
        {
          "type": "NumberLiteral",
          "value": 1
        },
        {
          "type": "NumberLiteral",
          "value": 2
        },
        {
          "type": "NumberLiteral",
          "value": 3
        },
        {
          "type": "NumberLiteral",
          "value": 4
        },
        {
          "type": "NumberLiteral",
          "value": 5
        }
      ]
    }
  },
  {
    "type": "PrefixExpression",
    "operator": "$",
    "expression": {
      "type": "Identifier",
      "name": "foo"
    }
  }
]
```

## Test 112
### Source
```
myGreet :
	hello : `hello,`
	welcome : `welcome,`
myGreet ' hello
```
### Preprocessed
```
myGreet : {
hello : `hello,`
welcome : `welcome,`
}
myGreet ' hello
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "myGreet"
    },
    "body": {
      "type": "Dictionary",
      "pairs": [
        {
          "key": [
            {
              "type": "Identifier",
              "name": "hello"
            },
            null
          ],
          "value": {
            "type": "StringLiteral",
            "value": "`hello,`"
          }
        },
        {
          "key": [
            {
              "type": "Identifier",
              "name": "welcome"
            },
            null
          ],
          "value": {
            "type": "StringLiteral",
            "value": "`welcome,`"
          }
        }
      ]
    }
  },
  {
    "type": "GetExpression",
    "target": {
      "type": "Identifier",
      "name": "myGreet"
    },
    "steps": [
      [
        {
          "type": "Identifier",
          "name": "hello"
        },
        null
      ]
    ]
  }
]
```

## Test 113
### Source
```
ptr : $10
ptr # 99
@ptr
```
### Preprocessed
```
ptr : $10
ptr # 99
@ptr
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "ptr"
    },
    "body": {
      "type": "PrefixExpression",
      "operator": "$",
      "expression": {
        "type": "NumberLiteral",
        "value": 10
      }
    }
  },
  {
    "type": "Output",
    "target": {
      "type": "Identifier",
      "name": "ptr"
    },
    "calls": [
      {
        "type": "NumberLiteral",
        "value": 99
      }
    ]
  },
  {
    "type": "PrefixExpression",
    "operator": "@",
    "expression": {
      "type": "Identifier",
      "name": "ptr"
    }
  }
]
```

## Test 114
### Source
```
@$10
```
### Preprocessed
```
@$10
```
### AST
```json
[
  {
    "type": "PrefixExpression",
    "operator": "@",
    "expression": {
      "type": "PrefixExpression",
      "operator": "$",
      "expression": {
        "type": "NumberLiteral",
        "value": 10
      }
    }
  }
]
```

## Test 115
### Source
```
a : 10
a_address : $a
@a_address
```
### Preprocessed
```
a : 10
a_address : $a
@a_address
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "a"
    },
    "body": {
      "type": "NumberLiteral",
      "value": 10
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "a_address"
    },
    "body": {
      "type": "PrefixExpression",
      "operator": "$",
      "expression": {
        "type": "Identifier",
        "name": "a"
      }
    }
  },
  {
    "type": "PrefixExpression",
    "operator": "@",
    "expression": {
      "type": "Identifier",
      "name": "a_address"
    }
  }
]
```

## Test 116
### Source
```
foo : [+ 10]
bar : [* 5]
foo 5
bar 4
```
### Preprocessed
```
foo : [+ 10]
bar : [* 5]
foo 5
bar 4
```
### AST
```json
[
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "foo"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 10
      },
      "operator": "+"
    }
  },
  {
    "type": "Define",
    "identifier": {
      "type": "Identifier",
      "name": "bar"
    },
    "body": {
      "type": "PointFreeNormal",
      "position": "infix_left",
      "argument": {
        "type": "NumberLiteral",
        "value": 5
      },
      "operator": "*"
    }
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 5
      }
    ]
  },
  {
    "type": "Coproduct",
    "elements": [
      {
        "type": "Identifier",
        "name": "bar",
        "_semanticType": "Unknown"
      },
      {
        "type": "NumberLiteral",
        "value": 4
      }
    ]
  }
]
```

