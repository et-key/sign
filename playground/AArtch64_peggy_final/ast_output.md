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
{
  "type": "AddressLiteral",
  "value": "0x10"
}
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
{
  "type": "AddressLiteral",
  "value": "0xFF"
}
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
{
  "type": "RegisterLiteral",
  "value": "0r10"
}
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
{
  "type": "RegisterLiteral",
  "value": "0rFF"
}
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
{
  "type": "UnicodeLiteral",
  "value": "0u0041"
}
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
{
  "type": "PrefixExpression",
  "operator": "\\",
  "argument": {
    "type": "Identifier",
    "name": "a",
    "_semanticType": "Unknown"
  }
}
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
{
  "type": "UnicodeLiteral",
  "value": "0u00f0"
}
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
{
  "type": "BinaryExpression",
  "operator": "=",
  "left": {
    "type": "UnicodeLiteral",
    "value": "0u0041"
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "A",
      "_semanticType": "Unknown"
    }
  }
}
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
{
  "type": "BinaryExpression",
  "operator": "=",
  "left": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "A",
      "_semanticType": "Unknown"
    }
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "A",
      "_semanticType": "Unknown"
    }
  }
}
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
{
  "type": "BinaryExpression",
  "operator": "!=",
  "left": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "a",
      "_semanticType": "Unknown"
    }
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "b",
      "_semanticType": "Unknown"
    }
  }
}
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
{
  "type": "BinaryExpression",
  "operator": "=",
  "left": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "n",
      "_semanticType": "Unknown"
    }
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "n",
      "_semanticType": "Unknown"
    }
  }
}
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
{
  "type": "BinaryExpression",
  "operator": "!=",
  "left": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "t",
      "_semanticType": "Unknown"
    }
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "n",
      "_semanticType": "Unknown"
    }
  }
}
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "=",
      "left": {
        "type": "StringLiteral",
        "value": "abc"
      },
      "right": {
        "type": "StringLiteral",
        "value": "abc"
      }
    }
  ]
}
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
{
  "type": "BinaryExpression",
  "operator": "!=",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "StringLiteral",
        "value": "hello"
      }
    ]
  },
  "right": {
    "type": "StringLiteral",
    "value": "world"
  }
}
```

## Test 15
### Source
```
x : `abc` \
	`def` = `abc` \
	`def`
```
### Preprocessed
```
x : `abc` \`def` = `abc` \`def`
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "x",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "ListConstruct",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "StringLiteral",
        "value": "abc"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "=",
        "left": {
          "type": "PrefixExpression",
          "operator": "\\",
          "argument": {
            "type": "StringLiteral",
            "value": "def"
          }
        },
        "right": {
          "type": "StringLiteral",
          "value": "abc"
        }
      }
    },
    "right": {
      "type": "PrefixExpression",
      "operator": "\\",
      "argument": {
        "type": "StringLiteral",
        "value": "def"
      }
    }
  }
}
```

## Test 16
### Source
```
`abc` \
	`def` = `abc` \
	`def`
```
### Preprocessed
```
`abc` \`def` = `abc` \`def`
```
### AST
```json
{
  "type": "ListConstruct",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "StringLiteral",
      "value": "abc"
    },
    "right": {
      "type": "BinaryExpression",
      "operator": "=",
      "left": {
        "type": "PrefixExpression",
        "operator": "\\",
        "argument": {
          "type": "StringLiteral",
          "value": "def"
        }
      },
      "right": {
        "type": "StringLiteral",
        "value": "abc"
      }
    }
  },
  "right": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "StringLiteral",
      "value": "def"
    }
  }
}
```

## Test 17
### Source
```
(`abc` \
	`def` = `abc` \
	`def`)
```
### Preprocessed
```
(`abc` \`def` = `abc` \`def`)
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "StringLiteral",
          "value": "abc"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "=",
          "left": {
            "type": "PrefixExpression",
            "operator": "\\",
            "argument": {
              "type": "StringLiteral",
              "value": "def"
            }
          },
          "right": {
            "type": "StringLiteral",
            "value": "abc"
          }
        }
      },
      "right": {
        "type": "PrefixExpression",
        "operator": "\\",
        "argument": {
          "type": "StringLiteral",
          "value": "def"
        }
      }
    }
  ]
}
```

## Test 18
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
{
  "type": "BinaryExpression",
  "operator": ",",
  "left": {
    "type": "PrefixExpression",
    "operator": "\\",
    "argument": {
      "type": "Identifier",
      "name": "A",
      "_semanticType": "Unknown"
    }
  },
  "right": {
    "type": "StringLiteral",
    "value": "bc"
  }
}
```

## Test 19
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "ListConstruct",
      "left": {
        "type": "StringLiteral",
        "value": "Result: "
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "123"
      }
    }
  ]
}
```

## Test 20
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "div",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "/",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "div2",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "FunctionCall",
        "left": {
          "type": "FunctionCall",
          "left": {
            "type": "Identifier",
            "name": "div",
            "_semanticType": "Function"
          },
          "right": {
            "type": "Unit"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "div2_type",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "div2",
        "_semanticType": "Variable"
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "Result",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "Identifier",
          "name": "div2",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    }
  ]
}
```

## Test 21
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
{
  "type": "BinaryExpression",
  "operator": "+",
  "left": {
    "type": "IntegerLiteral",
    "value": "0"
  },
  "right": {
    "type": "StringLiteral",
    "value": "123"
  }
}
```

## Test 22
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "x",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "+",
    "left": {
      "type": "StringLiteral",
      "value": "123"
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "0"
    }
  }
}
```

## Test 23
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "x",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "ListConstruct",
    "left": {
      "type": "StringLiteral",
      "value": "123"
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "0"
    }
  }
}
```

## Test 24
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
{
  "type": "BinaryExpression",
  "operator": "&",
  "left": {
    "type": "IntegerLiteral",
    "value": "0"
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "1"
  }
}
```

## Test 25
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
{
  "type": "PrefixExpression",
  "operator": "!",
  "argument": {
    "type": "Unit"
  }
}
```

## Test 26
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
{
  "type": "BinaryExpression",
  "operator": "&",
  "left": {
    "type": "Unit"
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "100"
  }
}
```

## Test 27
### Source
```
_ | |-4*2+3| + 5 < 0 | 3
```
### Preprocessed
```
_ | |-4*2+3| + 5 < 0 | 3
```
### AST Generation Error
```
Expected ".", "|", [ \t], [!@~], [0-9], or [\n\r] but "*" found.
```

## Test 28
### Source
```
-5*|-4*2+3|/2<0|3
```
### Preprocessed
```
-5*|-4*2+3|/2<0|3
```
### AST Generation Error
```
Expected ".", [ \t], [!@~], [0-9], [\n\r], or end of input but "*" found.
```

## Test 29
### Source
```
-5* |-4*2+3| /2<0 | 3
```
### Preprocessed
```
-5* |-4*2+3| /2<0 | 3
```
### AST Generation Error
```
Expected ".", [ \t], [!@~], [0-9], [\n\r], or end of input but "*" found.
```

## Test 30
### Source
```
-5* |-4*2+3|/2<0 | 3
```
### Preprocessed
```
-5* |-4*2+3|/2<0 | 3
```
### AST Generation Error
```
Expected ".", [ \t], [!@~], [0-9], [\n\r], or end of input but "*" found.
```

## Test 31
### Source
```
-5*|-4*2+3|/2<0 | 3
```
### Preprocessed
```
-5*|-4*2+3|/2<0 | 3
```
### AST Generation Error
```
Expected ".", [ \t], [!@~], [0-9], [\n\r], or end of input but "*" found.
```

## Test 32
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "=",
          "left": {
            "type": "IntegerLiteral",
            "value": "10"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    }
  ]
}
```

## Test 33
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "=",
          "left": {
            "type": "IntegerLiteral",
            "value": "10"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_eq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 34
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_neq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "!=",
          "left": {
            "type": "IntegerLiteral",
            "value": "10"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_neq",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 35
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_gt",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "<",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_gt",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    }
  ]
}
```

## Test 36
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_lt",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ">",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_lt",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "2"
      }
    }
  ]
}
```

## Test 37
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_ge",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "<=",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_ge",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 38
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "pass_le",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ">=",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "pass_le",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 39
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "|",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "100"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "50"
      }
    }
  ]
}
```

## Test 40
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "|",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "100"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "set_default",
        "_semanticType": "Function"
      },
      "right": {
        "type": "Unit"
      }
    }
  ]
}
```

## Test 41
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "&",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "Identifier",
                  "name": "x",
                  "_semanticType": "Variable"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "10"
                }
              }
            ]
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 42
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "&",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": "*",
                "left": {
                  "type": "Identifier",
                  "name": "x",
                  "_semanticType": "Variable"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "10"
                }
              }
            ]
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "calc_if_exists",
        "_semanticType": "Function"
      },
      "right": {
        "type": "Unit"
      }
    }
  ]
}
```

## Test 43
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "PrefixExpression",
          "operator": "!",
          "argument": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "100"
      }
    }
  ]
}
```

## Test 44
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "PrefixExpression",
          "operator": "!",
          "argument": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "is_empty",
        "_semanticType": "Function"
      },
      "right": {
        "type": "Unit"
      }
    }
  ]
}
```

## Test 45
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
{
  "type": "ListConstruct",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "PrefixExpression",
        "operator": "!",
        "argument": {
          "type": "Unit"
        }
      }
    ]
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "IntegerLiteral",
      "value": "5"
    },
    "right": {
      "type": "BlockExpression",
      "elements": [
        {
          "type": "PrefixExpression",
          "operator": "!",
          "argument": {
            "type": "IntegerLiteral",
            "value": "5"
          }
        }
      ]
    }
  }
}
```

## Test 46
### Source
```
[_!] 5 = 5!
```
### Preprocessed
```
[_!] 5 = 5!
```
### AST
```json
{
  "type": "ListConstruct",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "PostfixExpression",
        "operator": "!",
        "argument": {
          "type": "Unit"
        }
      }
    ]
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "=",
    "left": {
      "type": "IntegerLiteral",
      "value": "5"
    },
    "right": {
      "type": "PostfixExpression",
      "operator": "!",
      "argument": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  }
}
```

## Test 47
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
{
  "type": "ListConstruct",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "ListConstruct",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      }
    ]
  },
  "right": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "ListConstruct",
        "left": {
          "type": "IntegerLiteral",
          "value": "3"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      }
    ]
  }
}
```

## Test 48
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "list",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": ",",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "2"
      }
    },
    "right": {
      "type": "ListConstruct",
      "left": {
        "type": "IntegerLiteral",
        "value": "3"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "4"
      }
    }
  }
}
```

## Test 49
### Source
```
[1 2 , 3 4]~
```
### Preprocessed
```
[1 2 , 3 4]~
```
### AST
```json
{
  "type": "PostfixExpression",
  "operator": "~",
  "argument": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        }
      }
    ]
  }
}
```

## Test 50
### Source
```
[[1 2] [3 4]]~
```
### Preprocessed
```
[[1 2] [3 4]]~
```
### AST
```json
{
  "type": "PostfixExpression",
  "operator": "~",
  "argument": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "ListConstruct",
        "left": {
          "type": "BlockExpression",
          "elements": [
            {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            }
          ]
        },
        "right": {
          "type": "BlockExpression",
          "elements": [
            {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "3"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "4"
              }
            }
          ]
        }
      }
    ]
  }
}
```

## Test 51
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "PrefixExpression",
      "operator": "~",
      "argument": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 52
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
{
  "type": "PrefixExpression",
  "operator": "~",
  "argument": {
    "type": "IntegerLiteral",
    "value": "10"
  }
}
```

## Test 53
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
{
  "type": "PostfixExpression",
  "operator": "~",
  "argument": {
    "type": "IntegerLiteral",
    "value": "10"
  }
}
```

## Test 54
### Source
```
[1 , [2 , 3]~ , 4]
```
### Preprocessed
```
[1 , [2 , 3]~ , 4]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "PostfixExpression",
          "operator": "~",
          "argument": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "2"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "3"
                }
              }
            ]
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      }
    }
  ]
}
```

## Test 55
### Source
```
[1 , [2 , 3]~ 4]
```
### Preprocessed
```
[1 , [2 , 3]~ 4]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "PostfixExpression",
          "operator": "~",
          "argument": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "2"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "3"
                }
              }
            ]
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      }
    }
  ]
}
```

## Test 56
### Source
```
[1 [2 , 3]~ , 4]
```
### Preprocessed
```
[1 [2 , 3]~ , 4]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "PostfixExpression",
          "operator": "~",
          "argument": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "2"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "3"
                }
              }
            ]
          }
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "4"
      }
    }
  ]
}
```

## Test 57
### Source
```
[1 [2 , 3]~ 4]
```
### Preprocessed
```
[1 [2 , 3]~ 4]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "PostfixExpression",
          "operator": "~",
          "argument": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "2"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "3"
                }
              }
            ]
          }
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "4"
      }
    }
  ]
}
```

## Test 58
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
{
  "type": "BinaryExpression",
  "operator": ",",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "IntegerLiteral",
      "value": "1"
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "2"
    }
  },
  "right": {
    "type": "BinaryExpression",
    "operator": ",",
    "left": {
      "type": "BlockExpression",
      "elements": [
        {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        }
      ]
    },
    "right": {
      "type": "BlockExpression",
      "elements": [
        {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "6"
          }
        }
      ]
    }
  }
}
```

## Test 59
### Source
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### Preprocessed
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "IntegerLiteral",
          "value": "2"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ",",
          "left": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "3"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "4"
                }
              }
            ]
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "5"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "6"
                }
              }
            ]
          }
        }
      }
    }
  ]
}
```

## Test 60
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
{
  "type": "BinaryExpression",
  "operator": ",",
  "left": {
    "type": "IntegerLiteral",
    "value": "1"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": ",",
    "left": {
      "type": "IntegerLiteral",
      "value": "2"
    },
    "right": {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "ListConstruct",
            "left": {
              "type": "IntegerLiteral",
              "value": "3"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "4"
            }
          }
        ]
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "ListConstruct",
            "left": {
              "type": "IntegerLiteral",
              "value": "5"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "6"
            }
          }
        ]
      }
    }
  }
}
```

## Test 61
### Source
```
[1 , 2 , [3 4] , [5 6]]
```
### Preprocessed
```
[1 , 2 , [3 4] , [5 6]]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "IntegerLiteral",
          "value": "2"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ",",
          "left": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "ListConstruct",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "3"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "4"
                }
              }
            ]
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "ListConstruct",
                "left": {
                  "type": "IntegerLiteral",
                  "value": "5"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "6"
                }
              }
            ]
          }
        }
      }
    }
  ]
}
```

## Test 62
### Source
```
1 , 2 , [3 , 4] , [5 , 6]
```
### Preprocessed
```
1 , 2 , [3 , 4] , [5 , 6]
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ",",
  "left": {
    "type": "IntegerLiteral",
    "value": "1"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": ",",
    "left": {
      "type": "IntegerLiteral",
      "value": "2"
    },
    "right": {
      "type": "BinaryExpression",
      "operator": ",",
      "left": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "3"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "4"
            }
          }
        ]
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "5"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "6"
            }
          }
        ]
      }
    }
  }
}
```

## Test 63
### Source
```
1 2 , [3 4 , 5 6]
```
### Preprocessed
```
1 2 , [3 4 , 5 6]
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ",",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "IntegerLiteral",
      "value": "1"
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "2"
    }
  },
  "right": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "5"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "6"
          }
        }
      }
    ]
  }
}
```

## Test 64
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "getHead",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "a",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "PrefixExpression",
            "operator": "~",
            "argument": {
              "type": "Identifier",
              "name": "b",
              "_semanticType": "Unknown"
            }
          }
        },
        "right": {
          "type": "Identifier",
          "name": "a",
          "_semanticType": "Variable"
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "getHead",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "1"
            },
            "right": {
              "type": "BinaryExpression",
              "operator": ",",
              "left": {
                "type": "IntegerLiteral",
                "value": "2"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "3"
              }
            }
          }
        ]
      }
    }
  ]
}
```

## Test 65
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "getTail",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "a",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "PrefixExpression",
            "operator": "~",
            "argument": {
              "type": "Identifier",
              "name": "b",
              "_semanticType": "Unknown"
            }
          }
        },
        "right": {
          "type": "Identifier",
          "name": "b",
          "_semanticType": "Unknown"
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "getTail",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "1"
            },
            "right": {
              "type": "BinaryExpression",
              "operator": ",",
              "left": {
                "type": "IntegerLiteral",
                "value": "2"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "3"
              }
            }
          }
        ]
      }
    }
  ]
}
```

## Test 66
### Source
```
1 ~ 5
```
### Preprocessed
```
1 ~ 5
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": "~",
  "left": {
    "type": "IntegerLiteral",
    "value": "1"
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "5"
  }
}
```

## Test 67
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "IntegerLiteral",
        "value": "-2"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    }
  ]
}
```

## Test 68
### Source
```
[1 + 2 - 5 ~ 6]
```
### Preprocessed
```
[1 + 2 - 5 ~ 6]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "-",
        "left": {
          "type": "BinaryExpression",
          "operator": "+",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "6"
      }
    }
  ]
}
```

## Test 69
### Source
```
[10 ~ 5]
```
### Preprocessed
```
[10 ~ 5]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "IntegerLiteral",
        "value": "10"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 70
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~+",
        "left": {
          "type": "IntegerLiteral",
          "value": "0"
        },
        "right": {
          "type": "FloatLiteral",
          "value": "2.5"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    }
  ]
}
```

## Test 71
### Source
```
[0 ~+ 10]
```
### Preprocessed
```
[0 ~+ 10]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~+",
      "left": {
        "type": "IntegerLiteral",
        "value": "0"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    }
  ]
}
```

## Test 72
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~+",
        "left": {
          "type": "IntegerLiteral",
          "value": "10"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "0"
      }
    }
  ]
}
```

## Test 73
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~-",
        "left": {
          "type": "IntegerLiteral",
          "value": "10"
        },
        "right": {
          "type": "FloatLiteral",
          "value": "2.5"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 74
### Source
```
[5 ~- 1]
```
### Preprocessed
```
[5 ~- 1]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~-",
      "left": {
        "type": "IntegerLiteral",
        "value": "5"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 75
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~*",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "16"
      }
    }
  ]
}
```

## Test 76
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~*",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "FloatLiteral",
          "value": "2.5"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "16"
      }
    }
  ]
}
```

## Test 77
### Source
```
[1 ~* 16]
```
### Preprocessed
```
[1 ~* 16]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~*",
      "left": {
        "type": "IntegerLiteral",
        "value": "1"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "16"
      }
    }
  ]
}
```

## Test 78
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~/",
        "left": {
          "type": "IntegerLiteral",
          "value": "16"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 79
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~/",
        "left": {
          "type": "IntegerLiteral",
          "value": "10"
        },
        "right": {
          "type": "FloatLiteral",
          "value": "2.5"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 80
### Source
```
[16 ~/ 2]
```
### Preprocessed
```
[16 ~/ 2]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~/",
      "left": {
        "type": "IntegerLiteral",
        "value": "16"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "2"
      }
    }
  ]
}
```

## Test 81
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
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~^",
        "left": {
          "type": "IntegerLiteral",
          "value": "2"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "256"
      }
    }
  ]
}
```

## Test 82
### Source
```
[2 ~^ 256]
```
### Preprocessed
```
[2 ~^ 256]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~^",
      "left": {
        "type": "IntegerLiteral",
        "value": "2"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "256"
      }
    }
  ]
}
```

## Test 83
### Source
```
[0 ~+ 2 ~ 10 + 4]
```
### Preprocessed
```
[0 ~+ 2 ~ 10 + 4]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~+",
        "left": {
          "type": "IntegerLiteral",
          "value": "0"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "+",
        "left": {
          "type": "IntegerLiteral",
          "value": "10"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      }
    }
  ]
}
```

## Test 84
### Source
```
[0 ~+ 2 - 1 ~ 5]
```
### Preprocessed
```
[0 ~+ 2 - 1 ~ 5]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~+",
        "left": {
          "type": "IntegerLiteral",
          "value": "0"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "-",
          "left": {
            "type": "IntegerLiteral",
            "value": "2"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "1"
          }
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 85
### Source
```
[1 + 2 ~+ 2 ~ 11]
```
### Preprocessed
```
[1 + 2 ~+ 2 ~ 11]
```
### AST
```json
{
  "type": "BlockExpression",
  "elements": [
    {
      "type": "BinaryExpression",
      "operator": "~",
      "left": {
        "type": "BinaryExpression",
        "operator": "~+",
        "left": {
          "type": "BinaryExpression",
          "operator": "+",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "11"
      }
    }
  ]
}
```

## Test 86
### Source
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### Preprocessed
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": "=",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": "~",
        "left": {
          "type": "BinaryExpression",
          "operator": "~+",
          "left": {
            "type": "IntegerLiteral",
            "value": "2"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    ]
  },
  "right": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "IntegerLiteral",
          "value": "2"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ",",
          "left": {
            "type": "IntegerLiteral",
            "value": "4"
          },
          "right": {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "6"
            },
            "right": {
              "type": "BinaryExpression",
              "operator": ",",
              "left": {
                "type": "IntegerLiteral",
                "value": "8"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "10"
              }
            }
          }
        }
      }
    ]
  }
}
```

## Test 87
### Source
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### Preprocessed
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### AST
```json
{
  "type": "BinaryExpression",
  "operator": "=",
  "left": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": "~",
        "left": {
          "type": "BinaryExpression",
          "operator": "~*",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "16"
        }
      }
    ]
  },
  "right": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "IntegerLiteral",
          "value": "1"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": ",",
          "left": {
            "type": "IntegerLiteral",
            "value": "2"
          },
          "right": {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "4"
            },
            "right": {
              "type": "BinaryExpression",
              "operator": ",",
              "left": {
                "type": "IntegerLiteral",
                "value": "8"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "16"
              }
            }
          }
        }
      }
    ]
  }
}
```

## Test 88
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "0"
      }
    }
  ]
}
```

## Test 89
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 90
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": ",",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "1"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "2"
          }
        },
        "right": {
          "type": "ListConstruct",
          "left": {
            "type": "IntegerLiteral",
            "value": "3"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "list",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    }
  ]
}
```

## Test 91
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "myDict",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "StringLiteral",
              "value": "key1"
            },
            "right": {
              "type": "StringLiteral",
              "value": "value_one"
            }
          },
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "StringLiteral",
              "value": "key2"
            },
            "right": {
              "type": "StringLiteral",
              "value": "value_two"
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "target",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "StringLiteral",
        "value": "key2"
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "myDict",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PostfixExpression",
        "operator": "~",
        "argument": {
          "type": "Identifier",
          "name": "target",
          "_semanticType": "Variable"
        }
      }
    }
  ]
}
```

## Test 92
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "complexDict",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "BlockExpression",
              "elements": [
                {
                  "type": "BinaryExpression",
                  "operator": ",",
                  "left": {
                    "type": "IntegerLiteral",
                    "value": "1"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "2"
                  }
                }
              ]
            },
            "right": {
              "type": "StringLiteral",
              "value": "Pattern A"
            }
          },
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "BlockExpression",
              "elements": [
                {
                  "type": "BinaryExpression",
                  "operator": ",",
                  "left": {
                    "type": "IntegerLiteral",
                    "value": "3"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "4"
                  }
                }
              ]
            },
            "right": {
              "type": "StringLiteral",
              "value": "Pattern B"
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "complexDict",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "1"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "2"
            }
          }
        ]
      }
    }
  ]
}
```

## Test 93
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PostfixExpression",
        "operator": "~",
        "argument": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        }
      }
    }
  ]
}
```

## Test 94
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 95
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "car",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "Identifier",
              "name": "brand",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "BinaryExpression",
              "operator": ",",
              "left": {
                "type": "StringLiteral",
                "value": "foo"
              },
              "right": {
                "type": "BinaryExpression",
                "operator": ",",
                "left": {
                  "type": "StringLiteral",
                  "value": "Bar"
                },
                "right": {
                  "type": "StringLiteral",
                  "value": "Baz"
                }
              }
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "BinaryExpression",
        "operator": "'",
        "left": {
          "type": "Identifier",
          "name": "car",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "Identifier",
          "name": "brand",
          "_semanticType": "Unknown"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "0"
      }
    }
  ]
}
```

## Test 96
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "1"
            },
            "right": {
              "type": "BlockExpression",
              "elements": [
                {
                  "type": "BinaryExpression",
                  "operator": ",",
                  "left": {
                    "type": "IntegerLiteral",
                    "value": "2"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "3"
                  }
                }
              ]
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "b",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ",",
            "left": {
              "type": "IntegerLiteral",
              "value": "1"
            },
            "right": {
              "type": "BlockExpression",
              "elements": [
                {
                  "type": "BinaryExpression",
                  "operator": ",",
                  "left": {
                    "type": "IntegerLiteral",
                    "value": "2"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "3"
                  }
                }
              ]
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "=",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "b",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 97
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "0"
              },
              "right": {
                "type": "StringLiteral",
                "value": "zero"
              }
            },
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "StringLiteral",
                "value": "one"
              }
            },
            {
              "type": "StringLiteral",
              "value": "other"
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "99"
      }
    }
  ]
}
```

## Test 98
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "0"
              },
              "right": {
                "type": "StringLiteral",
                "value": "zero"
              }
            },
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "StringLiteral",
                "value": "one"
              }
            },
            {
              "type": "StringLiteral",
              "value": "other"
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "0"
      }
    }
  ]
}
```

## Test 99
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "0"
              },
              "right": {
                "type": "StringLiteral",
                "value": "zero"
              }
            },
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "StringLiteral",
                "value": "one"
              }
            },
            {
              "type": "StringLiteral",
              "value": "other"
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "myMatch",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "1"
      }
    }
  ]
}
```

## Test 100
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "dict",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "DictionaryExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      },
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "y",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      },
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "z",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "30"
        }
      }
    ]
  }
}
```

## Test 101
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
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "f",
    "_semanticType": "Function"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "?",
    "left": {
      "type": "Identifier",
      "name": "foo",
      "_semanticType": "Variable"
    },
    "right": {
      "type": "MatchCaseExpression",
      "elements": [
        {
          "type": "ListConstruct",
          "left": {
            "type": "PostfixExpression",
            "operator": "~",
            "argument": {
              "type": "Identifier",
              "name": "foo",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ":",
                "left": {
                  "type": "BinaryExpression",
                  "operator": ">",
                  "left": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Unknown"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "0"
                  }
                },
                "right": {
                  "type": "DictionaryExpression",
                  "elements": [
                    {
                      "type": "BinaryExpression",
                      "operator": ":",
                      "left": {
                        "type": "Identifier",
                        "name": "xy",
                        "_semanticType": "Variable"
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
                          "type": "Identifier",
                          "name": "y",
                          "_semanticType": "Unknown"
                        }
                      }
                    },
                    {
                      "type": "BinaryExpression",
                      "operator": ":",
                      "left": {
                        "type": "Identifier",
                        "name": "xz",
                        "_semanticType": "Variable"
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
                          "type": "Identifier",
                          "name": "z",
                          "_semanticType": "Unknown"
                        }
                      }
                    }
                  ]
                }
              },
              {
                "type": "BinaryExpression",
                "operator": ":",
                "left": {
                  "type": "BinaryExpression",
                  "operator": "<",
                  "left": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Unknown"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "1"
                  }
                },
                "right": {
                  "type": "DictionaryExpression",
                  "elements": [
                    {
                      "type": "OutputExpression",
                      "operator": "#",
                      "left": {
                        "type": "Identifier",
                        "name": "x",
                        "_semanticType": "Unknown"
                      },
                      "right": {
                        "type": "BinaryExpression",
                        "operator": "+",
                        "left": {
                          "type": "AbsoluteExpression",
                          "argument": {
                            "type": "Identifier",
                            "name": "x",
                            "_semanticType": "Unknown"
                          }
                        },
                        "right": {
                          "type": "IntegerLiteral",
                          "value": "5"
                        }
                      }
                    },
                    {
                      "type": "FunctionCall",
                      "left": {
                        "type": "Identifier",
                        "name": "f",
                        "_semanticType": "Function"
                      },
                      "right": {
                        "type": "Identifier",
                        "name": "foo",
                        "_semanticType": "Variable"
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

## Test 102
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
{
  "type": "FunctionCall",
  "left": {
    "type": "Identifier",
    "name": "f",
    "_semanticType": "Unknown"
  },
  "right": {
    "type": "Identifier",
    "name": "dict",
    "_semanticType": "Unknown"
  }
}
```

## Test 103
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "dict",
    "_semanticType": "Variable"
  },
  "right": {
    "type": "DictionaryExpression",
    "elements": [
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "-10"
        }
      },
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "y",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      },
      {
        "type": "BinaryExpression",
        "operator": ":",
        "left": {
          "type": "Identifier",
          "name": "z",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "30"
        }
      }
    ]
  }
}
```

## Test 104
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
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "f",
    "_semanticType": "Function"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "?",
    "left": {
      "type": "Identifier",
      "name": "foo",
      "_semanticType": "Variable"
    },
    "right": {
      "type": "MatchCaseExpression",
      "elements": [
        {
          "type": "ListConstruct",
          "left": {
            "type": "PostfixExpression",
            "operator": "~",
            "argument": {
              "type": "Identifier",
              "name": "foo",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "BlockExpression",
            "elements": [
              {
                "type": "BinaryExpression",
                "operator": ":",
                "left": {
                  "type": "BinaryExpression",
                  "operator": ">",
                  "left": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Unknown"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "0"
                  }
                },
                "right": {
                  "type": "DictionaryExpression",
                  "elements": [
                    {
                      "type": "BinaryExpression",
                      "operator": ":",
                      "left": {
                        "type": "Identifier",
                        "name": "xy",
                        "_semanticType": "Variable"
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
                          "type": "Identifier",
                          "name": "y",
                          "_semanticType": "Unknown"
                        }
                      }
                    },
                    {
                      "type": "BinaryExpression",
                      "operator": ":",
                      "left": {
                        "type": "Identifier",
                        "name": "xz",
                        "_semanticType": "Variable"
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
                          "type": "Identifier",
                          "name": "z",
                          "_semanticType": "Unknown"
                        }
                      }
                    }
                  ]
                }
              },
              {
                "type": "BinaryExpression",
                "operator": ":",
                "left": {
                  "type": "BinaryExpression",
                  "operator": "<",
                  "left": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Unknown"
                  },
                  "right": {
                    "type": "IntegerLiteral",
                    "value": "1"
                  }
                },
                "right": {
                  "type": "DictionaryExpression",
                  "elements": [
                    {
                      "type": "OutputExpression",
                      "operator": "#",
                      "left": {
                        "type": "Identifier",
                        "name": "x",
                        "_semanticType": "Unknown"
                      },
                      "right": {
                        "type": "BinaryExpression",
                        "operator": "+",
                        "left": {
                          "type": "AbsoluteExpression",
                          "argument": {
                            "type": "Identifier",
                            "name": "x",
                            "_semanticType": "Unknown"
                          }
                        },
                        "right": {
                          "type": "IntegerLiteral",
                          "value": "5"
                        }
                      }
                    },
                    {
                      "type": "FunctionCall",
                      "left": {
                        "type": "Identifier",
                        "name": "f",
                        "_semanticType": "Function"
                      },
                      "right": {
                        "type": "Identifier",
                        "name": "foo",
                        "_semanticType": "Variable"
                      }
                    }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
```

## Test 105
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
{
  "type": "FunctionCall",
  "left": {
    "type": "Identifier",
    "name": "f",
    "_semanticType": "Unknown"
  },
  "right": {
    "type": "Identifier",
    "name": "dict",
    "_semanticType": "Unknown"
  }
}
```

## Test 106
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "f",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "BinaryExpression",
          "operator": "?",
          "left": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "BinaryExpression",
            "operator": "+",
            "left": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Variable"
            }
          }
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "addTen",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "FunctionCall",
        "left": {
          "type": "Identifier",
          "name": "f",
          "_semanticType": "Function"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "Identifier",
        "name": "addTen",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "20"
      }
    }
  ]
}
```

## Test 107
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
{
  "type": "ListConstruct",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "PointFreeCore",
            "operator": "+"
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "1"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "4"
    }
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "5"
  }
}
```

## Test 108
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
{
  "type": "ListConstruct",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "PointFreeCore",
            "operator": ",",
            "left": {
              "type": "PointFreeCore",
              "operator": "*",
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "1"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "4"
    }
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "5"
  }
}
```

## Test 109
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
{
  "type": "ListConstruct",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "PointFreeCore",
              "operator": ",",
              "left": {
                "type": "PointFreeCore",
                "operator": "*",
                "right": {
                  "type": "IntegerLiteral",
                  "value": "2"
                }
              }
            },
            "right": {
              "type": "PointFreeCore",
              "operator": "+"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "1"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "3"
      }
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "4"
    }
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "5"
  }
}
```

## Test 110
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "+",
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "bar",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "*",
        "right": {
          "type": "IntegerLiteral",
          "value": "3"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "baz",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "2"
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "Identifier",
          "name": "foo",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "Identifier",
          "name": "bar",
          "_semanticType": "Variable"
        }
      },
      "right": {
        "type": "Identifier",
        "name": "baz",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 111
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "add_ten",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "+",
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "mul_two",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "*",
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "sub_five",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "-",
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "add_ten",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "Identifier",
            "name": "mul_two",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "Identifier",
          "name": "sub_five",
          "_semanticType": "Variable"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 112
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
{
  "type": "ListConstruct",
  "left": {
    "type": "ListConstruct",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "PointFreeCore",
        "operator": "+",
        "right": {
          "type": "IntegerLiteral",
          "value": "4"
        }
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "*",
        "right": {
          "type": "IntegerLiteral",
          "value": "3"
        }
      }
    },
    "right": {
      "type": "PointFreeCore",
      "operator": "/",
      "right": {
        "type": "IntegerLiteral",
        "value": "2"
      }
    }
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "10"
  }
}
```

## Test 113
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "double",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "*",
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "square",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "^",
        "right": {
          "type": "IntegerLiteral",
          "value": "2"
        }
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "ListConstruct",
        "left": {
          "type": "Identifier",
          "name": "double",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "Identifier",
          "name": "square",
          "_semanticType": "Variable"
        }
      },
      "right": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": "+",
            "left": {
              "type": "IntegerLiteral",
              "value": "3"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "2"
            }
          }
        ]
      }
    }
  ]
}
```

## Test 114
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "fact",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "Identifier",
          "name": "n",
          "_semanticType": "Variable"
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "BinaryExpression",
                "operator": "=",
                "left": {
                  "type": "Identifier",
                  "name": "n",
                  "_semanticType": "Variable"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "0"
                }
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "1"
              }
            },
            {
              "type": "BinaryExpression",
              "operator": "*",
              "left": {
                "type": "BlockExpression",
                "elements": [
                  {
                    "type": "FunctionCall",
                    "left": {
                      "type": "Identifier",
                      "name": "fact",
                      "_semanticType": "Function"
                    },
                    "right": {
                      "type": "BlockExpression",
                      "elements": [
                        {
                          "type": "BinaryExpression",
                          "operator": "-",
                          "left": {
                            "type": "Identifier",
                            "name": "n",
                            "_semanticType": "Variable"
                          },
                          "right": {
                            "type": "IntegerLiteral",
                            "value": "1"
                          }
                        }
                      ]
                    }
                  }
                ]
              },
              "right": {
                "type": "Identifier",
                "name": "n",
                "_semanticType": "Variable"
              }
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "Identifier",
        "name": "fact",
        "_semanticType": "Function"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    }
  ]
}
```

## Test 115
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "gcd1",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "Identifier",
            "name": "r",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "BinaryExpression",
                "operator": "=",
                "left": {
                  "type": "Identifier",
                  "name": "r",
                  "_semanticType": "Variable"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "0"
                }
              },
              "right": {
                "type": "Identifier",
                "name": "y",
                "_semanticType": "Variable"
              }
            },
            {
              "type": "FunctionCall",
              "left": {
                "type": "FunctionCall",
                "left": {
                  "type": "FunctionCall",
                  "left": {
                    "type": "Identifier",
                    "name": "gcd1",
                    "_semanticType": "Function"
                  },
                  "right": {
                    "type": "Identifier",
                    "name": "y",
                    "_semanticType": "Variable"
                  }
                },
                "right": {
                  "type": "Identifier",
                  "name": "r",
                  "_semanticType": "Variable"
                }
              },
              "right": {
                "type": "BlockExpression",
                "elements": [
                  {
                    "type": "BinaryExpression",
                    "operator": "%",
                    "left": {
                      "type": "Identifier",
                      "name": "y",
                      "_semanticType": "Variable"
                    },
                    "right": {
                      "type": "Identifier",
                      "name": "r",
                      "_semanticType": "Variable"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "gcd",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "FunctionCall",
              "left": {
                "type": "FunctionCall",
                "left": {
                  "type": "FunctionCall",
                  "left": {
                    "type": "Identifier",
                    "name": "gcd1",
                    "_semanticType": "Function"
                  },
                  "right": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Variable"
                  }
                },
                "right": {
                  "type": "Identifier",
                  "name": "y",
                  "_semanticType": "Variable"
                }
              },
              "right": {
                "type": "BlockExpression",
                "elements": [
                  {
                    "type": "BinaryExpression",
                    "operator": "%",
                    "left": {
                      "type": "Identifier",
                      "name": "x",
                      "_semanticType": "Variable"
                    },
                    "right": {
                      "type": "Identifier",
                      "name": "y",
                      "_semanticType": "Variable"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "FunctionCall",
        "left": {
          "type": "Identifier",
          "name": "gcd",
          "_semanticType": "Function"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "18"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "9"
      }
    }
  ]
}
```

## Test 116
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "gcd1",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "Identifier",
            "name": "r",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "BinaryExpression",
              "operator": ":",
              "left": {
                "type": "BinaryExpression",
                "operator": "=",
                "left": {
                  "type": "Identifier",
                  "name": "r",
                  "_semanticType": "Variable"
                },
                "right": {
                  "type": "IntegerLiteral",
                  "value": "0"
                }
              },
              "right": {
                "type": "Identifier",
                "name": "y",
                "_semanticType": "Variable"
              }
            },
            {
              "type": "FunctionCall",
              "left": {
                "type": "FunctionCall",
                "left": {
                  "type": "FunctionCall",
                  "left": {
                    "type": "Identifier",
                    "name": "gcd1",
                    "_semanticType": "Function"
                  },
                  "right": {
                    "type": "Identifier",
                    "name": "y",
                    "_semanticType": "Variable"
                  }
                },
                "right": {
                  "type": "Identifier",
                  "name": "r",
                  "_semanticType": "Variable"
                }
              },
              "right": {
                "type": "BlockExpression",
                "elements": [
                  {
                    "type": "BinaryExpression",
                    "operator": "%",
                    "left": {
                      "type": "Identifier",
                      "name": "y",
                      "_semanticType": "Variable"
                    },
                    "right": {
                      "type": "Identifier",
                      "name": "r",
                      "_semanticType": "Variable"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "gcd",
        "_semanticType": "Function"
      },
      "right": {
        "type": "BinaryExpression",
        "operator": "?",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "Identifier",
            "name": "x",
            "_semanticType": "Variable"
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        },
        "right": {
          "type": "MatchCaseExpression",
          "elements": [
            {
              "type": "FunctionCall",
              "left": {
                "type": "FunctionCall",
                "left": {
                  "type": "FunctionCall",
                  "left": {
                    "type": "Identifier",
                    "name": "gcd1",
                    "_semanticType": "Function"
                  },
                  "right": {
                    "type": "Identifier",
                    "name": "x",
                    "_semanticType": "Variable"
                  }
                },
                "right": {
                  "type": "Identifier",
                  "name": "y",
                  "_semanticType": "Variable"
                }
              },
              "right": {
                "type": "BlockExpression",
                "elements": [
                  {
                    "type": "BinaryExpression",
                    "operator": "%",
                    "left": {
                      "type": "Identifier",
                      "name": "x",
                      "_semanticType": "Variable"
                    },
                    "right": {
                      "type": "Identifier",
                      "name": "y",
                      "_semanticType": "Variable"
                    }
                  }
                ]
              }
            }
          ]
        }
      }
    },
    {
      "type": "FunctionCall",
      "left": {
        "type": "FunctionCall",
        "left": {
          "type": "Identifier",
          "name": "gcd",
          "_semanticType": "Function"
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "18"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "12"
      }
    }
  ]
}
```

## Test 117
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
### AST
```json
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "f",
    "_semanticType": "Function"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "?",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "y",
        "_semanticType": "Variable"
      }
    },
    "right": {
      "type": "MatchCaseExpression",
      "elements": [
        {
          "type": "BinaryExpression",
          "operator": ":",
          "left": {
            "type": "BinaryExpression",
            "operator": ">",
            "left": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "20"
            }
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        },
        {
          "type": "FunctionCall",
          "left": {
            "type": "FunctionCall",
            "left": {
              "type": "Identifier",
              "name": "g",
              "_semanticType": "Unknown"
            },
            "right": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "Identifier",
            "name": "y",
            "_semanticType": "Variable"
          }
        }
      ]
    }
  }
}
```

## Test 118
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
{
  "type": "BinaryExpression",
  "operator": ":",
  "left": {
    "type": "Identifier",
    "name": "g",
    "_semanticType": "Function"
  },
  "right": {
    "type": "BinaryExpression",
    "operator": "?",
    "left": {
      "type": "ListConstruct",
      "left": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "y",
        "_semanticType": "Variable"
      }
    },
    "right": {
      "type": "MatchCaseExpression",
      "elements": [
        {
          "type": "FunctionCall",
          "left": {
            "type": "FunctionCall",
            "left": {
              "type": "Identifier",
              "name": "f",
              "_semanticType": "Unknown"
            },
            "right": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            }
          },
          "right": {
            "type": "BinaryExpression",
            "operator": "+",
            "left": {
              "type": "Identifier",
              "name": "x",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "Identifier",
              "name": "y",
              "_semanticType": "Variable"
            }
          }
        }
      ]
    }
  }
}
```

## Test 119
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
{
  "type": "FunctionCall",
  "left": {
    "type": "FunctionCall",
    "left": {
      "type": "Identifier",
      "name": "f",
      "_semanticType": "Unknown"
    },
    "right": {
      "type": "IntegerLiteral",
      "value": "2"
    }
  },
  "right": {
    "type": "IntegerLiteral",
    "value": "2"
  }
}
```

## Test 120
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "x",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    },
    {
      "type": "OutputExpression",
      "operator": "#",
      "left": {
        "type": "OutputExpression",
        "operator": "$",
        "argument": {
          "type": "Identifier",
          "name": "x",
          "_semanticType": "Variable"
        }
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "20"
      }
    },
    {
      "type": "Identifier",
      "name": "x",
      "_semanticType": "Variable"
    }
  ]
}
```

## Test 121
### Source
```
0x1000 : 10
0x1000 # 20
@0x1000
```
### Preprocessed
```
0x1000 : 10
0x1000 # 20
@0x1000
```
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "AddressLiteral",
        "value": "0x1000"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    },
    {
      "type": "OutputExpression",
      "operator": "#",
      "left": {
        "type": "AddressLiteral",
        "value": "0x1000"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "20"
      }
    },
    {
      "type": "OutputExpression",
      "operator": "@",
      "argument": {
        "type": "AddressLiteral",
        "value": "0x1000"
      }
    }
  ]
}
```

## Test 122
### Source
```
0x100 # 777 
@0x100
```
### Preprocessed
```
0x100 # 777
@0x100
```
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "OutputExpression",
      "operator": "#",
      "left": {
        "type": "AddressLiteral",
        "value": "0x100"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "777"
      }
    },
    {
      "type": "OutputExpression",
      "operator": "@",
      "argument": {
        "type": "AddressLiteral",
        "value": "0x100"
      }
    }
  ]
}
```

## Test 123
### Source
```
$[1 2 3 4 5]
```
### Preprocessed
```
$[1 2 3 4 5]
```
### AST
```json
{
  "type": "OutputExpression",
  "operator": "$",
  "argument": {
    "type": "BlockExpression",
    "elements": [
      {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    ]
  }
}
```

## Test 124
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "OutputExpression",
      "operator": "$",
      "argument": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "ListConstruct",
            "left": {
              "type": "Identifier",
              "name": "foo",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "6"
            }
          }
        ]
      }
    }
  ]
}
```

## Test 125
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
### AST
```json
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "OutputExpression",
      "operator": "$",
      "argument": {
        "type": "BlockExpression",
        "elements": [
          {
            "type": "PostfixExpression",
            "operator": "~",
            "argument": {
              "type": "Identifier",
              "name": "foo",
              "_semanticType": "Variable"
            }
          }
        ]
      }
    }
  ]
}
```

## Test 126
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "ListConstruct",
        "left": {
          "type": "ListConstruct",
          "left": {
            "type": "ListConstruct",
            "left": {
              "type": "ListConstruct",
              "left": {
                "type": "IntegerLiteral",
                "value": "1"
              },
              "right": {
                "type": "IntegerLiteral",
                "value": "2"
              }
            },
            "right": {
              "type": "IntegerLiteral",
              "value": "3"
            }
          },
          "right": {
            "type": "IntegerLiteral",
            "value": "4"
          }
        },
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "OutputExpression",
      "operator": "$",
      "argument": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 127
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "myGreet",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "DictionaryExpression",
        "elements": [
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "Identifier",
              "name": "hello",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "StringLiteral",
              "value": "hello,"
            }
          },
          {
            "type": "BinaryExpression",
            "operator": ":",
            "left": {
              "type": "Identifier",
              "name": "welcome",
              "_semanticType": "Variable"
            },
            "right": {
              "type": "StringLiteral",
              "value": "welcome,"
            }
          }
        ]
      }
    },
    {
      "type": "BinaryExpression",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "myGreet",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "Identifier",
        "name": "hello",
        "_semanticType": "Unknown"
      }
    }
  ]
}
```

## Test 128
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "ptr",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "OutputExpression",
        "operator": "$",
        "argument": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    },
    {
      "type": "OutputExpression",
      "operator": "#",
      "left": {
        "type": "Identifier",
        "name": "ptr",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "99"
      }
    },
    {
      "type": "OutputExpression",
      "operator": "@",
      "argument": {
        "type": "Identifier",
        "name": "ptr",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 129
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
{
  "type": "OutputExpression",
  "operator": "@",
  "argument": {
    "type": "OutputExpression",
    "operator": "$",
    "argument": {
      "type": "IntegerLiteral",
      "value": "10"
    }
  }
}
```

## Test 130
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "10"
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "a_address",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "OutputExpression",
        "operator": "$",
        "argument": {
          "type": "Identifier",
          "name": "a",
          "_semanticType": "Variable"
        }
      }
    },
    {
      "type": "OutputExpression",
      "operator": "@",
      "argument": {
        "type": "Identifier",
        "name": "a_address",
        "_semanticType": "Variable"
      }
    }
  ]
}
```

## Test 131
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
{
  "type": "Block",
  "body": [
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "+",
        "right": {
          "type": "IntegerLiteral",
          "value": "10"
        }
      }
    },
    {
      "type": "BinaryExpression",
      "operator": ":",
      "left": {
        "type": "Identifier",
        "name": "bar",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "PointFreeCore",
        "operator": "*",
        "right": {
          "type": "IntegerLiteral",
          "value": "5"
        }
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "Identifier",
        "name": "foo",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "5"
      }
    },
    {
      "type": "ListConstruct",
      "left": {
        "type": "Identifier",
        "name": "bar",
        "_semanticType": "Variable"
      },
      "right": {
        "type": "IntegerLiteral",
        "value": "4"
      }
    }
  ]
}
```

## Test 132
### Source
```
f : s t ?
	s :
	@s \
	@t
f $`Hello` $`Sign`
```
### Preprocessed
```
f : s t ? {
s :
@s \@t
}
f $`Hello` $`Sign`
```
### AST Generation Error
```
Expected [ \t] but "\n" found.
```

