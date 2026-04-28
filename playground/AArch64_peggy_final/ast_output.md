# Exported ASTs

## Test 1
### Source
```
0x10
```
### Lexed
```
0x10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "address",
      "value": "0x10"
    }
  ]
}
```

## Test 2
### Source
```
0xFF
```
### Lexed
```
0xFF
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "address",
      "value": "0xFF"
    }
  ]
}
```

## Test 3
### Source
```
0r10
```
### Lexed
```
0r10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "register",
      "value": "0r10"
    }
  ]
}
```

## Test 4
### Source
```
0rFF
```
### Lexed
```
0rFF
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "register",
      "value": "0rFF"
    }
  ]
}
```

## Test 5
### Source
```
0u0041
```
### Lexed
```
0u0041
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "unicode",
      "value": "0u0041"
    }
  ]
}
```

## Test 6
### Source
```
\a
```
### Lexed
```
\a
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "charactor",
      "value": "\\a"
    }
  ]
}
```

## Test 7
### Source
```
0u00f0
```
### Lexed
```
0u00f0
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Atom",
      "dataType": "unicode",
      "value": "0u00f0"
    }
  ]
}
```

## Test 8
### Source
```
0u0041 = \A
```
### Lexed
```
0u0041 = \A
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Atom",
        "dataType": "unicode",
        "value": "0u0041"
      },
      "right": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\A"
      }
    }
  ]
}
```

## Test 9
### Source
```
\A = \A
```
### Lexed
```
\A = \A
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\A"
      },
      "right": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\A"
      }
    }
  ]
}
```

## Test 10
### Source
```
\a != \b
```
### Lexed
```
\a != \b
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!=",
      "left": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\a"
      },
      "right": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\b"
      }
    }
  ]
}
```

## Test 11
### Source
```
\n = \n
```
### Lexed
```
\n = \n
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\n"
      },
      "right": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\n"
      }
    }
  ]
}
```

## Test 12
### Source
```
\t != \n
```
### Lexed
```
\t != \n
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!=",
      "left": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\t"
      },
      "right": {
        "type": "Atom",
        "dataType": "charactor",
        "value": "\\n"
      }
    }
  ]
}
```

## Test 13
### Source
```
(`abc` = `abc`)
```
### Lexed
```
(`abc` = `abc`)
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Paren",
      "expressions": [
        {
          "type": "BinaryOperation",
          "operator": "=",
          "left": {
            "type": "Atom",
            "dataType": "string",
            "value": "`abc`"
          },
          "right": {
            "type": "Atom",
            "dataType": "string",
            "value": "`abc`"
          }
        }
      ]
    }
  ]
}
```

## Test 14
### Source
```
(`hello`) != `world`
```
### Lexed
```
(`hello`) != `world`
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!=",
      "left": {
        "type": "Block",
        "style": "Paren",
        "expressions": [
          {
            "type": "Atom",
            "dataType": "string",
            "value": "`hello`"
          }
        ]
      },
      "right": {
        "type": "Atom",
        "dataType": "string",
        "value": "`world`"
      }
    }
  ]
}
```

## Test 15
### Source
```
`x : `abc` \
`	`def` = `abc` \
`	`def`
```
### Lexed
```
`x : `abc` \
`	`def` = `abc` \
`	`def`
```
### AST Generation Error
```
Parse Error at line 1, col 7: Expected " ", "!=", "!==", "&", "&&", "'", ",", ";", ";;", "<<", "<=", "==", ">=", ">>", "\r\n", "^", "||", "~*", "~+", "~-", "~/", "~^", [!@~], [%*/], [+\-], [<->], or [\n\r] but "a" found.
```

## Test 16
### Source
```
`abc` \
`	`def` = `abc` \
`	`def`
```
### Lexed
```
`abc` \
`	`def` = `abc` \
`	`def`
```
### AST Generation Error
```
Parse Error at line 2, col 1: Expected " ", "!=", "!==", "&", "&&", "'", ",", ";", ";;", "<<", "<=", "==", ">=", ">>", "\r\n", "^", "||", [!@~], [%*/], [+\-], [<->], or [\n\r] but "`" found.
```

## Test 17
### Source
```
(`abc` \
 \	 `def` = `abc` \
 \	 `def`)
```
### Lexed
```
(`abc` \
<STX>\	 `def` = `abc` \
\	 `def`)
<ETX>
```
### AST Generation Error
```
Parse Error at line 3, col 9: Expected " ", "!!", "!=", "!==", "#", "##", "###", "&", "&&", "'", "(", ",", "-", "0b", "0r", "0u", "0x", ";", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "\x03", "^", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [!@~], [#%-'*-\-/:-@\^|~], [%*/], [+\-], [0-9], [<->], or [a-zA-Z] but ")" found.
```

## Test 18
### Source
```
\A , `bc`
```
### Lexed
```
\A , `bc`
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "charactor",
          "value": "\\A"
        },
        {
          "type": "Atom",
          "dataType": "string",
          "value": "`bc`"
        }
      ]
    }
  ]
}
```

## Test 19
### Source
```
(`Result: ` 123)
```
### Lexed
```
(`Result: ` 123)
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Paren",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "string",
              "value": "`Result: `"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "123"
            }
          ]
        }
      ]
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
### Lexed
```
div : x y ? x / y
div2 : div _ 2
div2_type : div2
Result : div2 10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "div",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            },
            {
              "lazy": false,
              "identifier": "y"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "/",
          "left": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "y"
          }
        }
      }
    },
    {
      "type": "Define",
      "identifier": "div2",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "div"
          },
          {
            "type": "Atom",
            "dataType": "unit",
            "value": "_"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "div2_type",
      "definition": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "div2"
      }
    },
    {
      "type": "Define",
      "identifier": "Result",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "div2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          }
        ]
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
### Lexed
```
0 + `123`
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "+",
      "left": {
        "type": "Atom",
        "dataType": "number",
        "value": "0"
      },
      "right": {
        "type": "Atom",
        "dataType": "string",
        "value": "`123`"
      }
    }
  ]
}
```

## Test 22
### Source
```
x : `123` + 0
```
### Lexed
```
x : `123` + 0
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "x",
      "definition": {
        "type": "BinaryOperation",
        "operator": "+",
        "left": {
          "type": "Atom",
          "dataType": "string",
          "value": "`123`"
        },
        "right": {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      }
    }
  ]
}
```

## Test 23
### Source
```
x : `123` 0
```
### Lexed
```
x : `123` 0
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "x",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "string",
            "value": "`123`"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "0"
          }
        ]
      }
    }
  ]
}
```

## Test 24
### Source
```
0 & 1
```
### Lexed
```
0 & 1
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "&",
      "left": {
        "type": "Atom",
        "dataType": "number",
        "value": "0"
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "1"
      }
    }
  ]
}
```

## Test 25
### Source
```
!_
```
### Lexed
```
!_
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Prefix",
      "operators": [
        "!"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "unit",
        "value": "_"
      }
    }
  ]
}
```

## Test 26
### Source
```
_ & 100
```
### Lexed
```
_ & 100
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "&",
      "left": {
        "type": "Atom",
        "dataType": "unit",
        "value": "_"
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "100"
      }
    }
  ]
}
```

## Test 27
### Source
```
_ | |-4*2+3| + 5 < 0 | 3
```
### Lexed
```
_ | |-4*2+3| + 5 < 0 | 3
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "|",
      "left": {
        "type": "BinaryOperation",
        "operator": "|",
        "left": {
          "type": "Atom",
          "dataType": "unit",
          "value": "_"
        },
        "right": {
          "type": "BinaryOperation",
          "operator": "<",
          "left": {
            "type": "BinaryOperation",
            "operator": "+",
            "left": {
              "type": "Block",
              "style": "Arithmetic",
              "expressions": [
                {
                  "type": "BinaryOperation",
                  "operator": "+",
                  "left": {
                    "type": "BinaryOperation",
                    "operator": "*",
                    "left": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "-4"
                    },
                    "right": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "2"
                    }
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "3"
                  }
                }
              ]
            },
            "right": {
              "type": "Atom",
              "dataType": "number",
              "value": "5"
            }
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "0"
          }
        }
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    }
  ]
}
```

## Test 28
### Source
```
`-5*|-4*2+3|/2<0|3
```
### Lexed
```
`-5*|-4*2+3|/2<0|3
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 29
### Source
```
-5* |-4*2+3| /2<0 | 3
```
### Lexed
```
-5* |-4*2+3| /2<0 | 3
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "|",
      "left": {
        "type": "BinaryOperation",
        "operator": "<",
        "left": {
          "type": "BinaryOperation",
          "operator": "/",
          "left": {
            "type": "BinaryOperation",
            "operator": "*",
            "left": {
              "type": "Atom",
              "dataType": "number",
              "value": "-5"
            },
            "right": {
              "type": "Block",
              "style": "Arithmetic",
              "expressions": [
                {
                  "type": "BinaryOperation",
                  "operator": "+",
                  "left": {
                    "type": "BinaryOperation",
                    "operator": "*",
                    "left": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "-4"
                    },
                    "right": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "2"
                    }
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "3"
                  }
                }
              ]
            }
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          }
        },
        "right": {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    }
  ]
}
```

## Test 30
### Source
```
-5* |-4*2+3|/2<0 | 3
```
### Lexed
```
-5* |-4*2+3|/2<0 | 3
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "|",
      "left": {
        "type": "BinaryOperation",
        "operator": "<",
        "left": {
          "type": "BinaryOperation",
          "operator": "/",
          "left": {
            "type": "BinaryOperation",
            "operator": "*",
            "left": {
              "type": "Atom",
              "dataType": "number",
              "value": "-5"
            },
            "right": {
              "type": "Block",
              "style": "Arithmetic",
              "expressions": [
                {
                  "type": "BinaryOperation",
                  "operator": "+",
                  "left": {
                    "type": "BinaryOperation",
                    "operator": "*",
                    "left": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "-4"
                    },
                    "right": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "2"
                    }
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "3"
                  }
                }
              ]
            }
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          }
        },
        "right": {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    }
  ]
}
```

## Test 31
### Source
```
-5*|-4*2+3|/2<0 | 3
```
### Lexed
```
-5*|-4*2+3|/2<0 | 3
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "|",
      "left": {
        "type": "BinaryOperation",
        "operator": "<",
        "left": {
          "type": "BinaryOperation",
          "operator": "/",
          "left": {
            "type": "BinaryOperation",
            "operator": "*",
            "left": {
              "type": "Atom",
              "dataType": "number",
              "value": "-5"
            },
            "right": {
              "type": "Block",
              "style": "Arithmetic",
              "expressions": [
                {
                  "type": "BinaryOperation",
                  "operator": "+",
                  "left": {
                    "type": "BinaryOperation",
                    "operator": "*",
                    "left": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "-4"
                    },
                    "right": {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "2"
                    }
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "3"
                  }
                }
              ]
            }
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          }
        },
        "right": {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      },
      "right": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    }
  ]
}
```

## Test 32
### Source
```
pass_eq  : x ? 10 = x
pass_eq 10
```
### Lexed
```
pass_eq  : x ? 10 = x
pass_eq 10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_eq",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_eq"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "10"
        }
      ]
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
### Lexed
```
pass_eq  : x ? 10 = x
pass_eq 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_eq",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_eq"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
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
### Lexed
```
pass_neq : x ? 10 != x
pass_neq 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_neq",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "!=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_neq"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
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
### Lexed
```
pass_gt : x ? 5 < x
pass_gt 10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_gt",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "<",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_gt"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "10"
        }
      ]
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
### Lexed
```
pass_lt : x ? 5 > x
pass_lt 2
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_lt",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": ">",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_lt"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        }
      ]
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
### Lexed
```
pass_ge : x ? 5 <= x
pass_ge 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_ge",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "<=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_ge"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
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
### Lexed
```
pass_le : x ? 5 >= x
pass_le 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "pass_le",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": ">=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "pass_le"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
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
### Lexed
```
set_default : x ? x | 100
set_default 50
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "set_default",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "|",
          "left": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "100"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "set_default"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "50"
        }
      ]
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
### Lexed
```
set_default : x ? x | 100
set_default _
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "set_default",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "|",
          "left": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          },
          "right": {
            "type": "Atom",
            "dataType": "number",
            "value": "100"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "set_default"
        },
        {
          "type": "Atom",
          "dataType": "unit",
          "value": "_"
        }
      ]
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
### Lexed
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "calc_if_exists",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "&",
          "left": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          },
          "right": {
            "type": "Block",
            "style": "Paren",
            "expressions": [
              {
                "type": "BinaryOperation",
                "operator": "*",
                "left": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "x"
                },
                "right": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "10"
                }
              }
            ]
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "calc_if_exists"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
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
### Lexed
```
calc_if_exists : x ? x & (x * 10)
calc_if_exists _
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "calc_if_exists",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "BinaryOperation",
          "operator": "&",
          "left": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          },
          "right": {
            "type": "Block",
            "style": "Paren",
            "expressions": [
              {
                "type": "BinaryOperation",
                "operator": "*",
                "left": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "x"
                },
                "right": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "10"
                }
              }
            ]
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "calc_if_exists"
        },
        {
          "type": "Atom",
          "dataType": "unit",
          "value": "_"
        }
      ]
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
### Lexed
```
is_empty : x ? !x
is_empty 100
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "is_empty",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "Prefix",
          "operators": [
            "!"
          ],
          "expression": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "is_empty"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "100"
        }
      ]
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
### Lexed
```
is_empty : x ? !x
is_empty _
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "is_empty",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "Prefix",
          "operators": [
            "!"
          ],
          "expression": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x"
          }
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "is_empty"
        },
        {
          "type": "Atom",
          "dataType": "unit",
          "value": "_"
        }
      ]
    }
  ]
}
```

## Test 45
### Source
```
[!_] 5 = (!5)
```
### Lexed
```
[!_] 5 = (!5)
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Prefix",
              "operators": [
                "!"
              ],
              "expression": {
                "type": "Atom",
                "dataType": "unit",
                "value": "_"
              }
            }
          ]
        },
        {
          "type": "BinaryOperation",
          "operator": "=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Block",
            "style": "Paren",
            "expressions": [
              {
                "type": "Prefix",
                "operators": [
                  "!"
                ],
                "expression": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "5"
                }
              }
            ]
          }
        }
      ]
    }
  ]
}
```

## Test 46
### Source
```
[_!] 5 = 5!
```
### Lexed
```
[_!] 5 = 5!
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Postfix",
              "expression": {
                "type": "Atom",
                "dataType": "unit",
                "value": "_"
              },
              "operators": [
                "!"
              ]
            }
          ]
        },
        {
          "type": "BinaryOperation",
          "operator": "=",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          },
          "right": {
            "type": "Postfix",
            "expression": {
              "type": "Atom",
              "dataType": "number",
              "value": "5"
            },
            "operators": [
              "!"
            ]
          }
        }
      ]
    }
  ]
}
```

## Test 47
### Source
```
[1 2] [3 4]
```
### Lexed
```
[1 2] [3 4]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "2"
                }
              ]
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "4"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 48
### Source
```
list : 1 2 , 3 4
```
### Lexed
```
list : 1 2 , 3 4
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "list",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              }
            ]
          },
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "3"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "4"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 49
### Source
```
[1 2 , 3 4]~
```
### Lexed
```
[1 2 , 3 4]~
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Postfix",
      "expression": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Coproduct",
                "elements": [
                  {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "1"
                  },
                  {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "2"
                  }
                ]
              },
              {
                "type": "Coproduct",
                "elements": [
                  {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "3"
                  },
                  {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "4"
                  }
                ]
              }
            ]
          }
        ]
      },
      "operators": [
        "~"
      ]
    }
  ]
}
```

## Test 50
### Source
```
[[1 2] [3 4]]~
```
### Lexed
```
[[1 2] [3 4]]~
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Postfix",
      "expression": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "1"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "2"
                      }
                    ]
                  }
                ]
              },
              {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "3"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "4"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      },
      "operators": [
        "~"
      ]
    }
  ]
}
```

## Test 51
### Source
```
a : 1 2 3 4 5
~a
```
### Lexed
```
a : 1 2 3 4 5
~a
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "a",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Prefix",
      "operators": [
        "~"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a"
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
### Lexed
```
~10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Prefix",
      "operators": [
        "~"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "number",
        "value": "10"
      }
    }
  ]
}
```

## Test 53
### Source
```
10~
```
### Lexed
```
10~
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Postfix",
      "expression": {
        "type": "Atom",
        "dataType": "number",
        "value": "10"
      },
      "operators": [
        "~"
      ]
    }
  ]
}
```

## Test 54
### Source
```
[1 , [2 , 3]~ , 4]
```
### Lexed
```
[1 , [2 , 3]~ , 4]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Postfix",
              "expression": {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "2"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "3"
                      }
                    ]
                  }
                ]
              },
              "operators": [
                "~"
              ]
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "4"
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 55
### Source
```
[1 , [2 , 3]~ 4]
```
### Lexed
```
[1 , [2 , 3]~ 4]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Postfix",
                  "expression": {
                    "type": "Block",
                    "style": "Square",
                    "expressions": [
                      {
                        "type": "Coproduct",
                        "elements": [
                          {
                            "type": "Atom",
                            "dataType": "number",
                            "value": "2"
                          },
                          {
                            "type": "Atom",
                            "dataType": "number",
                            "value": "3"
                          }
                        ]
                      }
                    ]
                  },
                  "operators": [
                    "~"
                  ]
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "4"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 56
### Source
```
[1 [2 , 3]~ , 4]
```
### Lexed
```
[1 [2 , 3]~ , 4]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                },
                {
                  "type": "Postfix",
                  "expression": {
                    "type": "Block",
                    "style": "Square",
                    "expressions": [
                      {
                        "type": "Coproduct",
                        "elements": [
                          {
                            "type": "Atom",
                            "dataType": "number",
                            "value": "2"
                          },
                          {
                            "type": "Atom",
                            "dataType": "number",
                            "value": "3"
                          }
                        ]
                      }
                    ]
                  },
                  "operators": [
                    "~"
                  ]
                }
              ]
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "4"
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 57
### Source
```
[1 [2 , 3]~ 4]
```
### Lexed
```
[1 [2 , 3]~ 4]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Postfix",
              "expression": {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "2"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "3"
                      }
                    ]
                  }
                ]
              },
              "operators": [
                "~"
              ]
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "4"
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 58
### Source
```
1 2 , [3 4] , [5 6]
```
### Lexed
```
1 2 , [3 4] , [5 6]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "4"
                }
              ]
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "5"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "6"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 59
### Source
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### Lexed
```
[1 , 2 , [3 , 4] , [5 , 6]]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Block",
              "style": "Square",
              "expressions": [
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "3"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "4"
                    }
                  ]
                }
              ]
            },
            {
              "type": "Block",
              "style": "Square",
              "expressions": [
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "5"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "6"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 60
### Source
```
1 , 2 , [3 4] , [5 6]
```
### Lexed
```
1 , 2 , [3 4] , [5 6]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "4"
                }
              ]
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "5"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "6"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 61
### Source
```
[1 , 2 , [3 4] , [5 6]]
```
### Lexed
```
[1 , 2 , [3 4] , [5 6]]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Block",
              "style": "Square",
              "expressions": [
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "3"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "4"
                    }
                  ]
                }
              ]
            },
            {
              "type": "Block",
              "style": "Square",
              "expressions": [
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "5"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "6"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 62
### Source
```
1 , 2 , [3 , 4] , [5 , 6]
```
### Lexed
```
1 , 2 , [3 , 4] , [5 , 6]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "4"
                }
              ]
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "5"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "6"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 63
### Source
```
1 2 , [3 4 , 5 6]
```
### Lexed
```
1 2 , [3 4 , 5 6]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Coproduct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "3"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "4"
                    }
                  ]
                },
                {
                  "type": "Coproduct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "5"
                    },
                    {
                      "type": "Atom",
                      "dataType": "number",
                      "value": "6"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 64
### Source
```
getHead : a ~b ? a
getHead [1 , 2 , 3]
```
### Lexed
```
getHead : a ~b ? a
getHead [1 , 2 , 3]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "getHead",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "a"
            },
            {
              "lazy": true,
              "identifier": "b"
            }
          ]
        },
        "body": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "a"
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "getHead"
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "2"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                }
              ]
            }
          ]
        }
      ]
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
### Lexed
```
getTail : a ~b ? b
getTail [1 , 2 , 3]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "getTail",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "a"
            },
            {
              "lazy": true,
              "identifier": "b"
            }
          ]
        },
        "body": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "b"
        }
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "getTail"
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "Coproduct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "2"
                },
                {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "3"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 66
### Source
```
[1 ~ 5]
```
### Lexed
```
[1 ~ 5]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "5"
            }
          ],
          "operators": [
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 67
### Source
```
[-2 ~ 3]
```
### Lexed
```
[-2 ~ 3]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "-2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "3"
            }
          ],
          "operators": [
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 68
### Source
```
`[1 + 2 - 5 ~ 6]
```
### Lexed
```
`[1 + 2 - 5 ~ 6]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 69
### Source
```
`[10 ~ 5]
```
### Lexed
```
`[10 ~ 5]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 70
### Source
```
[0 ~+ 2.5 ~ 10]
```
### Lexed
```
[0 ~+ 2.5 ~ 10]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "0"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2.5"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            }
          ],
          "operators": [
            "~+",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 71
### Source
```
`[0 ~+ 10]
```
### Lexed
```
`[0 ~+ 10]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 72
### Source
```
[10 ~+ 2 ~ 0]
```
### Lexed
```
[10 ~+ 2 ~ 0]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "0"
            }
          ],
          "operators": [
            "~+",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 73
### Source
```
[10 ~- 2.5 ~ 1]
```
### Lexed
```
[10 ~- 2.5 ~ 1]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2.5"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ],
          "operators": [
            "~-",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 74
### Source
```
`[5 ~- 1]
```
### Lexed
```
`[5 ~- 1]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 75
### Source
```
[1 ~* 2 ~ 16]
```
### Lexed
```
[1 ~* 2 ~ 16]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "16"
            }
          ],
          "operators": [
            "~*",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 76
### Source
```
[1 ~* 2.5 ~ 16]
```
### Lexed
```
[1 ~* 2.5 ~ 16]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2.5"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "16"
            }
          ],
          "operators": [
            "~*",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 77
### Source
```
`[1 ~* 16]
```
### Lexed
```
`[1 ~* 16]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 78
### Source
```
[16 ~/ 2 ~ 1]
```
### Lexed
```
[16 ~/ 2 ~ 1]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "16"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ],
          "operators": [
            "~/",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 79
### Source
```
[10 ~/ 2.5 ~ 1]
```
### Lexed
```
[10 ~/ 2.5 ~ 1]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2.5"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ],
          "operators": [
            "~/",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 80
### Source
```
`[16 ~/ 2]
```
### Lexed
```
`[16 ~/ 2]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 81
### Source
```
[2 ~^ 2 ~ 256]
```
### Lexed
```
[2 ~^ 2 ~ 256]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Block",
      "style": "Square",
      "expressions": [
        {
          "type": "Sequence",
          "blocks": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "256"
            }
          ],
          "operators": [
            "~^",
            "~"
          ]
        }
      ]
    }
  ]
}
```

## Test 82
### Source
```
`[2 ~^ 256]
```
### Lexed
```
`[2 ~^ 256]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 83
### Source
```
`[0 ~+ 2 ~ 10 + 4]
```
### Lexed
```
`[0 ~+ 2 ~ 10 + 4]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 84
### Source
```
`[0 ~+ 2 - 1 ~ 5]
```
### Lexed
```
`[0 ~+ 2 - 1 ~ 5]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 85
### Source
```
`[1 + 2 ~+ 2 ~ 11]
```
### Lexed
```
`[1 + 2 ~+ 2 ~ 11]
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 86
### Source
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### Lexed
```
[2 ~+ 2 ~ 10] = [2 , 4 , 6 , 8 , 10]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Sequence",
            "blocks": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "10"
              }
            ],
            "operators": [
              "~+",
              "~"
            ]
          }
        ]
      },
      "right": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "4"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "6"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "8"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "10"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 87
### Source
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### Lexed
```
[1 ~* 2 ~ 16] = [1 , 2 , 4 , 8 , 16]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Sequence",
            "blocks": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "16"
              }
            ],
            "operators": [
              "~*",
              "~"
            ]
          }
        ]
      },
      "right": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "4"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "8"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "16"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 88
### Source
```
list : 1 2 , 3 4
list ' 0
```
### Lexed
```
list : 1 2 , 3 4
list ' 0
```
### AST Generation Error
```
Parse Error at line 2, col 8: Expected " ", "_", "`", or [a-zA-Z] but "0" found.
```

## Test 89
### Source
```
list : 1 2 , 3 4
list ' 1
```
### Lexed
```
list : 1 2 , 3 4
list ' 1
```
### AST Generation Error
```
Parse Error at line 2, col 8: Expected " ", "_", "`", or [a-zA-Z] but "1" found.
```

## Test 90
### Source
```
list : 1 2 , 3 4
list ' 3
```
### Lexed
```
list : 1 2 , 3 4
list ' 3
```
### AST Generation Error
```
Parse Error at line 2, col 8: Expected " ", "_", "`", or [a-zA-Z] but "3" found.
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
### Lexed
```
myDict :
<STX>`key1` : `value_one`
`key2` : `value_two`
<ETX>target : `key2`
myDict ' target~
```
### AST Generation Error
```
Parse Error at line 1, col 9: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
```

## Test 92
### Source
```
complexDict :
	[ 1 , 2 ] : `Pattern A`
	[ 3 , 4 ] : `Pattern B`
complexDict ' [ 1 , 2 ]
```
### Lexed
```
complexDict :
<STX>[ 1 , 2 ] : `Pattern A`
[ 3 , 4 ] : `Pattern B`
<ETX>complexDict ' [ 1 , 2 ]
```
### AST Generation Error
```
Parse Error at line 1, col 14: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
```

## Test 93
### Source
```
x : 3
a : 1 2 3 4 5
a ' x~
```
### Lexed
```
x : 3
a : 1 2 3 4 5
a ' x~
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "x",
      "definition": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    },
    {
      "type": "Define",
      "identifier": "a",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a"
      },
      "properties": [
        "x~"
      ]
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
### Lexed
```
x : 3
a : 1 2 3 4 5
a ' x
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "x",
      "definition": {
        "type": "Atom",
        "dataType": "number",
        "value": "3"
      }
    },
    {
      "type": "Define",
      "identifier": "a",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a"
      },
      "properties": [
        "x"
      ]
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
### Lexed
```
car :
<STX>brand : `foo` , `Bar` , `Baz`
<ETX>car ' brand ' 0
```
### AST Generation Error
```
Parse Error at line 1, col 6: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
```

## Test 96
### Source
```
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a = b
```
### Lexed
```
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a = b
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "a",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "2"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "3"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "b",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "Coproduct",
                    "elements": [
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "2"
                      },
                      {
                        "type": "Atom",
                        "dataType": "number",
                        "value": "3"
                      }
                    ]
                  }
                ]
              }
            ]
          }
        ]
      }
    },
    {
      "type": "BinaryOperation",
      "operator": "=",
      "left": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a"
      },
      "right": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "b"
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
### Lexed
```
myMatch : x ?
<STX>0 : `zero`
1 : `one`
`other`
<ETX>myMatch 99
```
### AST Generation Error
```
Parse Error at line 4, col 8: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", "~*", "~+", "~-", "~/", "~^", [!@~], [%*/], [+\-], or [<->] but "\n" found.
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
### Lexed
```
myMatch : x ?
<STX>0 : `zero`
1 : `one`
`other`
<ETX>myMatch 0
```
### AST Generation Error
```
Parse Error at line 4, col 8: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", "~*", "~+", "~-", "~/", "~^", [!@~], [%*/], [+\-], or [<->] but "\n" found.
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
### Lexed
```
myMatch : x ?
<STX>0 : `zero`
1 : `one`
`other`
<ETX>myMatch 1
```
### AST Generation Error
```
Parse Error at line 4, col 8: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", "~*", "~+", "~-", "~/", "~^", [!@~], [%*/], [+\-], or [<->] but "\n" found.
```

## Test 100
### Source
```
dict :
	x : 10
	y : 5
	z : 30
```
### Lexed
```
dict :
<STX>x : 10
y : 5
z : 30
<ETX>
```
### AST Generation Error
```
Parse Error at line 1, col 7: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
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
### Lexed
```
f : foo ? 
<STX>foo~
<STX>x > 0 :
<STX>xy : x * y
xz : x * z
<ETX>x < 1 :
<STX>x # |x| + 5
f foo
<ETX><ETX><ETX>
```
### AST Generation Error
```
Parse Error at line 2, col 6: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], or [<->] but "\n" found.
```

## Test 102
### Source
```
f dict
```
### Lexed
```
f dict
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "f"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "dict"
        }
      ]
    }
  ]
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
### Lexed
```
dict :
<STX>x : -10
y : 5
z : 30
<ETX>
```
### AST Generation Error
```
Parse Error at line 1, col 7: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
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
### Lexed
```
f : foo ? 
<STX>foo~
<STX>x > 0 :
<STX>xy : x * y
xz : x * z
<ETX>x < 1 :
<STX>x # |x| + 5
f foo
<ETX><ETX><ETX>
```
### AST Generation Error
```
Parse Error at line 2, col 6: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], or [<->] but "\n" found.
```

## Test 105
### Source
```
f dict
```
### Lexed
```
f dict
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "f"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "dict"
        }
      ]
    }
  ]
}
```

## Test 106
### Source
```
f : x ? y ? x + y
addTen : f 10
addTen 20
```
### Lexed
```
f : x ? y ? x + y
addTen : f 10
addTen 20
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "f",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "Lambda",
          "arguments": {
            "type": "Arguments",
            "style": "inline",
            "items": [
              {
                "lazy": false,
                "identifier": "y"
              }
            ]
          },
          "body": {
            "type": "BinaryOperation",
            "operator": "+",
            "left": {
              "type": "Atom",
              "dataType": "identifier",
              "value": "x"
            },
            "right": {
              "type": "Atom",
              "dataType": "identifier",
              "value": "y"
            }
          }
        }
      }
    },
    {
      "type": "Define",
      "identifier": "addTen",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "f"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          }
        ]
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "addTen"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "20"
        }
      ]
    }
  ]
}
```

## Test 107
### Source
```
[+] 1 2 3 4 5
```
### Lexed
```
[+] 1 2 3 4 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "DirectFold",
              "infix": "+"
            }
          ]
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "3"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "4"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    }
  ]
}
```

## Test 108
### Source
```
[* 2,] 1 2 3 4 5
```
### Lexed
```
[* 2,] 1 2 3 4 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "DirectMap",
              "target": "2",
              "infix": "*",
              "position": "right"
            }
          ]
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "3"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "4"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    }
  ]
}
```

## Test 109
### Source
```
[* 2,] [+] 1 2 3 4 5
```
### Lexed
```
[* 2,] [+] 1 2 3 4 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "DirectMap",
              "target": "2",
              "infix": "*",
              "position": "right"
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "DirectFold",
              "infix": "+"
            }
          ]
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "3"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "4"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    }
  ]
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
### Lexed
```
foo : [+ 4]
bar : [* 3]
baz : 2
foo bar baz
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "foo",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "4",
            "infix": "+",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "bar",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "3",
            "infix": "*",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "baz",
      "definition": {
        "type": "Atom",
        "dataType": "number",
        "value": "2"
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "foo"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "bar"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "baz"
        }
      ]
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
### Lexed
```
add_ten : [+ 10]
mul_two : [* 2]
sub_five : [- 5]
add_ten mul_two sub_five 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "add_ten",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "10",
            "infix": "+",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "mul_two",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "2",
            "infix": "*",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "sub_five",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "5",
            "infix": "-",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "add_ten"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "mul_two"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "sub_five"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    }
  ]
}
```

## Test 112
### Source
```
[+ 4] [* 3] [/ 2] 10
```
### Lexed
```
[+ 4] [* 3] [/ 2] 10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "PointFreeNormal",
              "target": "4",
              "infix": "+",
              "position": "right"
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "PointFreeNormal",
              "target": "3",
              "infix": "*",
              "position": "right"
            }
          ]
        },
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "PointFreeNormal",
              "target": "2",
              "infix": "/",
              "position": "right"
            }
          ]
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "10"
        }
      ]
    }
  ]
}
```

## Test 113
### Source
```
double : [* 2]
square : [^ 2]
double square (3 + 2)
```
### Lexed
```
double : [* 2]
square : [^ 2]
double square (3 + 2)
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "double",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "2",
            "infix": "*",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "square",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "2",
            "infix": "^",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "double"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "square"
        },
        {
          "type": "Block",
          "style": "Paren",
          "expressions": [
            {
              "type": "BinaryOperation",
              "operator": "+",
              "left": {
                "type": "Atom",
                "dataType": "number",
                "value": "3"
              },
              "right": {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              }
            }
          ]
        }
      ]
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
### Lexed
```
fact : n ?
<STX>n = 0 : 1
(fact (n - 1)) * n
<ETX>fact 5
```
### AST Generation Error
```
Parse Error at line 3, col 19: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], [<->], or [a-zA-Z0-9_] but "\n" found.
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
### Lexed
```
gcd1 : x y r ?
<STX>r = 0 : y
gcd1  y r  (y % r)
<ETX>gcd : x y ?
<STX>gcd1  x y (x % y)
<ETX>gcd 18 9
```
### AST Generation Error
```
Parse Error at line 3, col 19: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], or [<->] but "\n" found.
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
### Lexed
```
gcd1 : x y r ?
<STX>r = 0 : y  
gcd1  y r  (y % r)
<ETX>gcd : x y ?
<STX>gcd1  x y (x % y)
<ETX>gcd 18 12
```
### AST Generation Error
```
Parse Error at line 2, col 13: Expected " ", "&&", "'", ";;", "<<", ">>", "^", "||", [%*/], or [+\-] but "\n" found.
```

## Test 117
### Source
```
f : x y ?
	y > 20 : y
	g x y
```
### Lexed
```
f : x y ?
<STX>y > 20 : y
g x y
<ETX>
```
### AST Generation Error
```
Parse Error at line 3, col 6: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], [<->], or [a-zA-Z0-9_] but "\r" found.
```

## Test 118
### Source
```
g : x y ?
	f x x + y
```
### Lexed
```
g : x y ?
<STX>f x x + y
<ETX>
```
### AST Generation Error
```
Parse Error at line 2, col 11: Expected " ", "!=", "!==", "&", "&&", "'", ",", ":", ";", ";;", "<<", "<=", "==", ">=", ">>", "^", "||", [!@~], [%*/], [+\-], [<->], or [a-zA-Z0-9_] but "\r" found.
```

## Test 119
### Source
```
f 2 2
```
### Lexed
```
f 2 2
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "f"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "2"
        }
      ]
    }
  ]
}
```

## Test 120
### Source
```
x : 10
$x # 20
x
```
### Lexed
```
x : 10
$x # 20
x
```
### AST Generation Error
```
Parse Error at line 2, col 4: Expected " ", "!!", "!=", "!==", "&", "&&", "'", "(", ",", "-", "0b", "0r", "0u", "0x", ";", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "^", "_", "`", "{", "|", "||", "~", [!$@], [%*/], [+\-], [0-9], [<->], or [a-zA-Z] but "#" found.
```

## Test 121
### Source
```
`0x1000 # 20
`@0x1000
```
### Lexed
```
`0x1000 # 20
`@0x1000
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 122
### Source
```
`0x100 # 777 
`@0x100
```
### Lexed
```
`0x100 # 777 
`@0x100
```
### AST
```json
{
  "type": "Program",
  "body": []
}
```

## Test 123
### Source
```
$[1 2 3 4 5]
```
### Lexed
```
$[1 2 3 4 5]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Prefix",
      "operators": [
        "$"
      ],
      "expression": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "number",
                "value": "1"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "2"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "3"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "4"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "5"
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 124
### Source
```
foo : 1 2 3 4 5
$[foo 6]
```
### Lexed
```
foo : 1 2 3 4 5
$[foo 6]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "foo",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Prefix",
      "operators": [
        "$"
      ],
      "expression": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Coproduct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "identifier",
                "value": "foo"
              },
              {
                "type": "Atom",
                "dataType": "number",
                "value": "6"
              }
            ]
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
### Lexed
```
foo : 1 2 3 4 5
$[foo~]
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "foo",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Prefix",
      "operators": [
        "$"
      ],
      "expression": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "Postfix",
            "expression": {
              "type": "Atom",
              "dataType": "identifier",
              "value": "foo"
            },
            "operators": [
              "~"
            ]
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
### Lexed
```
foo : 1 2 3 4 5
$foo
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "foo",
      "definition": {
        "type": "Coproduct",
        "elements": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "1"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "2"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "4"
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
      }
    },
    {
      "type": "Prefix",
      "operators": [
        "$"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "foo"
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
### Lexed
```
myGreet :
<STX>hello : `hello,`
welcome : `welcome,`
<ETX>myGreet ' hello
```
### AST Generation Error
```
Parse Error at line 1, col 10: Expected " ", "!!", "!=", "!==", "&&", "(", "-", "0b", "0r", "0u", "0x", ";;", "<<", "<=", "==", ">=", ">>", "[", "\\", "\x02", "_", "`", "{", "|", "||", "~", "~*", "~+", "~-", "~/", "~^", [!$@], [#%-'*-\-/:-@\^|~], [0-9], or [a-zA-Z] but "\n" found.
```

## Test 128
### Source
```
ptr : $10
ptr # 99
@ptr
```
### Lexed
```
ptr : $10
ptr # 99
@ptr
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "ptr",
      "definition": {
        "type": "Prefix",
        "operators": [
          "$"
        ],
        "expression": {
          "type": "Atom",
          "dataType": "number",
          "value": "10"
        }
      }
    },
    {
      "type": "Output",
      "target": "ptr",
      "calls": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "99"
        }
      ]
    },
    {
      "type": "Prefix",
      "operators": [
        "@"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "ptr"
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
### Lexed
```
@$10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Prefix",
      "operators": [
        "@",
        "$"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "number",
        "value": "10"
      }
    }
  ]
}
```

## Test 130
### Source
```
a : 10
a_address : $a
@a_address
```
### Lexed
```
a : 10
a_address : $a
@a_address
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "a",
      "definition": {
        "type": "Atom",
        "dataType": "number",
        "value": "10"
      }
    },
    {
      "type": "Define",
      "identifier": "a_address",
      "definition": {
        "type": "Prefix",
        "operators": [
          "$"
        ],
        "expression": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "a"
        }
      }
    },
    {
      "type": "Prefix",
      "operators": [
        "@"
      ],
      "expression": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a_address"
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
### Lexed
```
foo : [+ 10]
bar : [* 5]
foo 5
bar 4
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "foo",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "10",
            "infix": "+",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "bar",
      "definition": {
        "type": "Block",
        "style": "Square",
        "expressions": [
          {
            "type": "PointFreeNormal",
            "target": "5",
            "infix": "*",
            "position": "right"
          }
        ]
      }
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "foo"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    },
    {
      "type": "Coproduct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "bar"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "4"
        }
      ]
    }
  ]
}
```

## Test 132
### Source
```
`f : s t ?
`	s :
`	@s \
`	@t
`f $`Hello` $`Sign`
```
### Lexed
```
`f : s t ?
`	s :
`	@s \
`	@t
`f $`Hello` $`Sign`
```
### AST Generation Error
```
Parse Error at line 5, col 6: Expected " ", "!=", "!==", "&", "&&", "'", ",", ";", ";;", "<<", "<=", "==", ">=", ">>", "\r\n", "^", "||", "~*", "~+", "~-", "~/", "~^", [!@~], [%*/], [+\-], [<->], or [\n\r] but "H" found.
```

