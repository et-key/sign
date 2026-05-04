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
0u0041 == \A
```
### Lexed
```
0u0041 == \A
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
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
\A == \A
```
### Lexed
```
\A == \A
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
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
\a !== \b
```
### Lexed
```
\a !== \b
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!==",
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
\n == \n
```
### Lexed
```
\n == \n
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
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
\t !== \n
```
### Lexed
```
\t !== \n
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!==",
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
(`abc` == `abc`)
```
### Lexed
```
(`abc` == `abc`)
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
          "operator": "==",
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
(`hello`) !== `world`
```
### Lexed
```
(`hello`) !== `world`
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "!==",
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
(`abc` \
\	 `def` == `abc` \
\	 `def`)
```
### Lexed
```
(`abc` \
\	 `def` == `abc` \
\	 `def`)
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
          "type": "ListConstruct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "string",
              "value": "`abc`"
            },
            {
              "type": "Atom",
              "dataType": "charactor",
              "value": "\\\n"
            }
          ]
        },
        {
          "type": "BinaryOperation",
          "operator": "==",
          "left": {
            "type": "ListConstruct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "charactor",
                "value": "\\\t"
              },
              {
                "type": "Atom",
                "dataType": "string",
                "value": "`def`"
              }
            ]
          },
          "right": {
            "type": "ListConstruct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "string",
                "value": "`abc`"
              },
              {
                "type": "Atom",
                "dataType": "charactor",
                "value": "\\\n"
              }
            ]
          }
        },
        {
          "type": "ListConstruct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "charactor",
              "value": "\\\t"
            },
            {
              "type": "Atom",
              "dataType": "string",
              "value": "`def`"
            }
          ]
        }
      ]
    }
  ]
}
```

## Test 16
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
      "type": "ListConstruct",
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

## Test 17
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
          "type": "ListConstruct",
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

## Test 18
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "y",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "Define",
      "identifier": "div2",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "__p_arg_rc8wn"
            }
          ]
        },
        "body": {
          "type": "FunctionCall",
          "callee": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "div",
            "_semanticType": "Function",
            "_tag": "function_ref"
          },
          "arguments": [
            {
              "type": "Atom",
              "dataType": "identifier",
              "value": "__p_arg_rc8wn",
              "_semanticType": "Variable",
              "_tag": "variable_ref"
            },
            {
              "type": "Atom",
              "dataType": "number",
              "value": "2"
            }
          ]
        }
      }
    },
    {
      "type": "Define",
      "identifier": "div2_type",
      "definition": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "div2",
        "_semanticType": "Function",
        "_tag": "function_ref"
      }
    },
    {
      "type": "Define",
      "identifier": "Result",
      "definition": {
        "type": "FunctionCall",
        "callee": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "div2",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
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

## Test 19
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

## Test 20
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

## Test 21
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
        "type": "ListConstruct",
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

## Test 22
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

## Test 23
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

## Test 24
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

## Test 25
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

## Test 26
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

## Test 27
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

## Test 28
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

## Test 29
### Source
```
pass_eq  : x ? 10 == x
pass_eq 10
```
### Lexed
```
pass_eq  : x ? 10 == x
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
          "operator": "==",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_eq",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 30
### Source
```
pass_eq  : x ? 10 == x
pass_eq 5
```
### Lexed
```
pass_eq  : x ? 10 == x
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
          "operator": "==",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_eq",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 31
### Source
```
pass_neq : x ? 10 !== x
pass_neq 5
```
### Lexed
```
pass_neq : x ? 10 !== x
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
          "operator": "!==",
          "left": {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          },
          "right": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_neq",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 32
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_gt",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_lt",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 34
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_ge",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "pass_le",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 36
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
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
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "set_default",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 37
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
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
      "type": "Lambda",
      "arguments": {
        "type": "Arguments",
        "style": "inline",
        "items": [
          {
            "lazy": false,
            "identifier": "__p_arg_zfxqv"
          }
        ]
      },
      "body": {
        "type": "FunctionCall",
        "callee": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "set_default",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "__p_arg_zfxqv",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        ]
      }
    }
  ]
}
```

## Test 38
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
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
                  "value": "x",
                  "_semanticType": "Variable",
                  "_tag": "variable_ref"
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
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "calc_if_exists",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
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
                  "value": "x",
                  "_semanticType": "Variable",
                  "_tag": "variable_ref"
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
      "type": "Lambda",
      "arguments": {
        "type": "Arguments",
        "style": "inline",
        "items": [
          {
            "lazy": false,
            "identifier": "__p_arg_y6cjl"
          }
        ]
      },
      "body": {
        "type": "FunctionCall",
        "callee": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "calc_if_exists",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "__p_arg_y6cjl",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        ]
      }
    }
  ]
}
```

## Test 40
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "is_empty",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 41
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
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        }
      }
    },
    {
      "type": "Lambda",
      "arguments": {
        "type": "Arguments",
        "style": "inline",
        "items": [
          {
            "lazy": false,
            "identifier": "__p_arg_37f8x"
          }
        ]
      },
      "body": {
        "type": "FunctionCall",
        "callee": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "is_empty",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
          {
            "type": "Atom",
            "dataType": "identifier",
            "value": "__p_arg_37f8x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          }
        ]
      }
    }
  ]
}
```

## Test 42
### Source
```
[!_] 5 == (!5)
```
### Lexed
```
[!_] 5 == (!5)
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
      "left": {
        "type": "ListConstruct",
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
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
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
```

## Test 43
### Source
```
[_!] 5 == 5!
```
### Lexed
```
[_!] 5 == 5!
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
      "left": {
        "type": "ListConstruct",
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
            "type": "Atom",
            "dataType": "number",
            "value": "5"
          }
        ]
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
```

## Test 44
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "ListConstruct",
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
              "type": "ListConstruct",
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

## Test 45
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
        "type": "ListConstruct",
        "elements": [
          {
            "type": "ListConstruct",
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
            "type": "ListConstruct",
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

## Test 46
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
            "type": "ListConstruct",
            "elements": [
              {
                "type": "ListConstruct",
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
                "type": "ListConstruct",
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

## Test 47
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
            "type": "ListConstruct",
            "elements": [
              {
                "type": "Block",
                "style": "Square",
                "expressions": [
                  {
                    "type": "ListConstruct",
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
                    "type": "ListConstruct",
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

## Test 48
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
        "type": "ListConstruct",
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
        "value": "a",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      }
    }
  ]
}
```

## Test 49
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

## Test 50
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

## Test 51
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
          "type": "ListConstruct",
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
                    "type": "ListConstruct",
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

## Test 52
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
          "type": "ListConstruct",
          "elements": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            },
            {
              "type": "ListConstruct",
              "elements": [
                {
                  "type": "Postfix",
                  "expression": {
                    "type": "Block",
                    "style": "Square",
                    "expressions": [
                      {
                        "type": "ListConstruct",
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

## Test 53
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
          "type": "ListConstruct",
          "elements": [
            {
              "type": "ListConstruct",
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
                        "type": "ListConstruct",
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

## Test 54
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
          "type": "ListConstruct",
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
                    "type": "ListConstruct",
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "ListConstruct",
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
              "type": "ListConstruct",
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
              "type": "ListConstruct",
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

## Test 56
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
          "type": "ListConstruct",
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
                  "type": "ListConstruct",
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
                  "type": "ListConstruct",
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

## Test 57
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
      "type": "ListConstruct",
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
              "type": "ListConstruct",
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
              "type": "ListConstruct",
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

## Test 58
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
          "type": "ListConstruct",
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
                  "type": "ListConstruct",
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
                  "type": "ListConstruct",
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

## Test 59
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
      "type": "ListConstruct",
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
              "type": "ListConstruct",
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
              "type": "ListConstruct",
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

## Test 60
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "ListConstruct",
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
              "type": "ListConstruct",
              "elements": [
                {
                  "type": "ListConstruct",
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
                  "type": "ListConstruct",
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

## Test 61
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
          "value": "a",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "getHead",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "ListConstruct",
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

## Test 62
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
          "value": "b",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "getTail",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Block",
          "style": "Square",
          "expressions": [
            {
              "type": "ListConstruct",
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

## Test 63
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

## Test 64
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

## Test 65
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

## Test 66
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

## Test 67
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

## Test 68
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

## Test 69
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

## Test 70
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

## Test 71
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

## Test 72
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

## Test 73
### Source
```
[2 ~+ 2 ~ 10] == 2 , 4 , 6 , 8 , 10
```
### Lexed
```
[2 ~+ 2 ~ 10] == 2 , 4 , 6 , 8 , 10
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
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
        "type": "ListConstruct",
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
    }
  ]
}
```

## Test 74
### Source
```
[1 ~* 2 ~ 16] == 1 , 2 , 4 , 8 , 16
```
### Lexed
```
[1 ~* 2 ~ 16] == 1 , 2 , 4 , 8 , 16
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "BinaryOperation",
      "operator": "==",
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
        "type": "ListConstruct",
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
    }
  ]
}
```

## Test 75
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
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "list",
      "definition": {
        "type": "ListConstruct",
        "elements": [
          {
            "type": "ListConstruct",
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
            "type": "ListConstruct",
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
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "list",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      ]
    }
  ]
}
```

## Test 76
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
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "list",
      "definition": {
        "type": "ListConstruct",
        "elements": [
          {
            "type": "ListConstruct",
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
            "type": "ListConstruct",
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
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "list",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        }
      ]
    }
  ]
}
```

## Test 77
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
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "list",
      "definition": {
        "type": "ListConstruct",
        "elements": [
          {
            "type": "ListConstruct",
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
            "type": "ListConstruct",
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
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "list",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "3"
        }
      ]
    }
  ]
}
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
### Lexed
```
myDict :
<STX>`key1` : `value_one`
`key2` : `value_two`
<ETX>
target : `key2`
myDict ' target~
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "myDict",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "`key1`",
            "value": {
              "type": "Atom",
              "dataType": "string",
              "value": "`value_one`"
            }
          },
          {
            "key": "`key2`",
            "value": {
              "type": "Atom",
              "dataType": "string",
              "value": "`value_two`"
            }
          }
        ]
      }
    },
    {
      "type": "Define",
      "identifier": "target",
      "definition": {
        "type": "Atom",
        "dataType": "string",
        "value": "`key2`"
      }
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "myDict",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Postfix",
          "expression": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "target",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          },
          "operators": [
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
        "type": "ListConstruct",
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
        "value": "a",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Postfix",
          "expression": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "x",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          },
          "operators": [
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
        "type": "ListConstruct",
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
        "value": "a",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "x",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      ]
    }
  ]
}
```

## Test 81
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
<ETX>
car ' brand ' 0
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "car",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "brand",
            "value": {
              "type": "ListConstruct",
              "elements": [
                {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`foo`"
                },
                {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`Bar`"
                },
                {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`Baz`"
                }
              ]
            }
          }
        ]
      }
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "car",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Get",
          "target": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "brand",
            "_semanticType": "Variable",
            "_tag": "variable_ref"
          },
          "properties": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "0"
            }
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
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a == b
```
### Lexed
```
a : [1 , [2 , 3]]
b : [1 , [2 , 3]]
a == b
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
            "type": "ListConstruct",
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
                    "type": "ListConstruct",
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
            "type": "ListConstruct",
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
                    "type": "ListConstruct",
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
      "operator": "==",
      "left": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "a",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "right": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "b",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      }
    }
  ]
}
```

## Test 83
### Source
```
myMatch : x ?
	0 : `zero`
	1 : `one`
	`other`
```
### Lexed
```
myMatch : x ?
<STX>0 : `zero`
1 : `one`
`other`
<ETX>
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "myMatch",
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
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "0"
                },
                "body": {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`zero`"
                }
              },
              {
                "condition": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                },
                "body": {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`one`"
                }
              },
              {
                "condition": null,
                "body": {
                  "type": "Atom",
                  "dataType": "string",
                  "value": "`other`"
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 84
### Source
```
myMatch 99
```
### Lexed
```
myMatch 99
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "myMatch",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "99"
        }
      ]
    }
  ]
}
```

## Test 85
### Source
```
myMatch 0
```
### Lexed
```
myMatch 0
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "myMatch",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "0"
        }
      ]
    }
  ]
}
```

## Test 86
### Source
```
myMatch 1
```
### Lexed
```
myMatch 1
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "myMatch",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "1"
        }
      ]
    }
  ]
}
```

## Test 87
### Source
```
dictP :
	x : 10
	y : 5
	z : 30
```
### Lexed
```
dictP :
<STX>x : 10
y : 5
z : 30
<ETX>
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "dictP",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "x",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            }
          },
          {
            "key": "y",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "5"
            }
          },
          {
            "key": "z",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "30"
            }
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
dictN :
	x : -10
	y : 5
	z : 30
```
### Lexed
```
dictN :
<STX>x : -10
y : 5
z : 30
<ETX>
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "dictN",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "x",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "-10"
            }
          },
          {
            "key": "y",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "5"
            }
          },
          {
            "key": "z",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "30"
            }
          }
        ]
      }
    }
  ]
}
```

## Test 89
### Source
```
f : [
	dict
	x : dict ' x
	y : dict ' y
	z : dict ' z
] ? 
		x > 0 : [
			xy : x * y
			xz : x * z
		]
		x < 1 : [
			xy : (|x| + 5) * y
			xz : |x + 5| * z
		]
```
### Lexed
```
f : [
<STX>dict
x : dict ' x
y : dict ' y
z : dict ' z
<ETX>
] ? 
<STX>x > 0 : [
<STX>xy : x * y
xz : x * z
<ETX>
]
x < 1 : [
<STX>xy : (|x| + 5) * y
xz : |x + 5| * z
<ETX>
]
<ETX>
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
          "style": "bracket",
          "items": [
            {
              "lazy": false,
              "identifier": "dict",
              "defaultValue": null
            },
            {
              "lazy": false,
              "identifier": "x",
              "defaultValue": {
                "type": "Get",
                "target": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "dict"
                },
                "properties": [
                  {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "x"
                  }
                ]
              }
            },
            {
              "lazy": false,
              "identifier": "y",
              "defaultValue": {
                "type": "Get",
                "target": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "dict"
                },
                "properties": [
                  {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "y"
                  }
                ]
              }
            },
            {
              "lazy": false,
              "identifier": "z",
              "defaultValue": {
                "type": "Get",
                "target": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "dict"
                },
                "properties": [
                  {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "z"
                  }
                ]
              }
            }
          ]
        },
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": {
                  "type": "BinaryOperation",
                  "operator": ">",
                  "left": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "x",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "0"
                  }
                },
                "body": {
                  "type": "Block",
                  "style": "Square",
                  "expressions": [
                    {
                      "type": "Dictionary",
                      "entries": [
                        {
                          "key": "xy",
                          "value": {
                            "type": "BinaryOperation",
                            "operator": "*",
                            "left": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "x",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            },
                            "right": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "y",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            }
                          }
                        },
                        {
                          "key": "xz",
                          "value": {
                            "type": "BinaryOperation",
                            "operator": "*",
                            "left": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "x",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            },
                            "right": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "z",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            }
                          }
                        }
                      ]
                    }
                  ]
                }
              },
              {
                "condition": {
                  "type": "BinaryOperation",
                  "operator": "<",
                  "left": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "x",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "1"
                  }
                },
                "body": {
                  "type": "Block",
                  "style": "Square",
                  "expressions": [
                    {
                      "type": "Dictionary",
                      "entries": [
                        {
                          "key": "xy",
                          "value": {
                            "type": "BinaryOperation",
                            "operator": "*",
                            "left": {
                              "type": "Block",
                              "style": "Paren",
                              "expressions": [
                                {
                                  "type": "BinaryOperation",
                                  "operator": "+",
                                  "left": {
                                    "type": "Block",
                                    "style": "Arithmetic",
                                    "expressions": [
                                      {
                                        "type": "Atom",
                                        "dataType": "identifier",
                                        "value": "x",
                                        "_semanticType": "Variable",
                                        "_tag": "variable_ref"
                                      }
                                    ]
                                  },
                                  "right": {
                                    "type": "Atom",
                                    "dataType": "number",
                                    "value": "5"
                                  }
                                }
                              ]
                            },
                            "right": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "y",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            }
                          }
                        },
                        {
                          "key": "xz",
                          "value": {
                            "type": "BinaryOperation",
                            "operator": "*",
                            "left": {
                              "type": "Block",
                              "style": "Arithmetic",
                              "expressions": [
                                {
                                  "type": "BinaryOperation",
                                  "operator": "+",
                                  "left": {
                                    "type": "Atom",
                                    "dataType": "identifier",
                                    "value": "x",
                                    "_semanticType": "Variable",
                                    "_tag": "variable_ref"
                                  },
                                  "right": {
                                    "type": "Atom",
                                    "dataType": "number",
                                    "value": "5"
                                  }
                                }
                              ]
                            },
                            "right": {
                              "type": "Atom",
                              "dataType": "identifier",
                              "value": "z",
                              "_semanticType": "Variable",
                              "_tag": "variable_ref"
                            }
                          }
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 90
### Source
```
f dictP !_ !_ !_
```
### Lexed
```
f dictP !_ !_ !_
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "f",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "dictP",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
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
        },
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
        },
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
  ]
}
```

## Test 91
### Source
```
f dictN !_ !_ !_
```
### Lexed
```
f dictN !_ !_ !_
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "f",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "dictN",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
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
        },
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
        },
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
  ]
}
```

## Test 92
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
              "value": "x",
              "_semanticType": "Variable",
              "_tag": "variable_ref"
            },
            "right": {
              "type": "Atom",
              "dataType": "identifier",
              "value": "y",
              "_semanticType": "Variable",
              "_tag": "variable_ref"
            }
          }
        }
      }
    },
    {
      "type": "Define",
      "identifier": "addTen",
      "definition": {
        "type": "FunctionCall",
        "callee": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "f",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
          {
            "type": "Atom",
            "dataType": "number",
            "value": "10"
          }
        ]
      }
    },
    {
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "addTen",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
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

## Test 93
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
      "type": "ListConstruct",
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

## Test 94
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
      "type": "ListConstruct",
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

## Test 95
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
      "type": "ListConstruct",
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

## Test 96
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "foo",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "bar",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "baz",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      ]
    }
  ]
}
```

## Test 97
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "add_ten",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "mul_two",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "sub_five",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
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

## Test 98
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
      "type": "ListConstruct",
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

## Test 99
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "double",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "square",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
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

## Test 100
### Source
```
fact : n ?
	n == 0 : 1
	(fact (n - 1)) * n
fact 5
```
### Lexed
```
fact : n ?
<STX>n == 0 : 1
(fact (n - 1)) * n
<ETX>
fact 5
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "fact",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "n"
            }
          ]
        },
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": {
                  "type": "BinaryOperation",
                  "operator": "==",
                  "left": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "n",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "0"
                  }
                },
                "body": {
                  "type": "Atom",
                  "dataType": "number",
                  "value": "1"
                }
              },
              {
                "condition": null,
                "body": {
                  "type": "BinaryOperation",
                  "operator": "*",
                  "left": {
                    "type": "Block",
                    "style": "Paren",
                    "expressions": [
                      {
                        "type": "FunctionCall",
                        "callee": {
                          "type": "Atom",
                          "dataType": "identifier",
                          "value": "fact",
                          "_semanticType": "Function",
                          "_tag": "function_ref"
                        },
                        "arguments": [
                          {
                            "type": "Block",
                            "style": "Paren",
                            "expressions": [
                              {
                                "type": "BinaryOperation",
                                "operator": "-",
                                "left": {
                                  "type": "Atom",
                                  "dataType": "identifier",
                                  "value": "n",
                                  "_semanticType": "Variable",
                                  "_tag": "variable_ref"
                                },
                                "right": {
                                  "type": "Atom",
                                  "dataType": "number",
                                  "value": "1"
                                }
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "n",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  }
                }
              }
            ]
          }
        ]
      }
    },
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "fact",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 101
### Source
```
gcd1 : x y r ?
	r == 0 : y
	gcd1  y r  (y % r)
```
### Lexed
```
gcd1 : x y r ?
<STX>r == 0 : y
gcd1  y r  (y % r)
<ETX>
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "gcd1",
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
            },
            {
              "lazy": false,
              "identifier": "r"
            }
          ]
        },
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": {
                  "type": "BinaryOperation",
                  "operator": "==",
                  "left": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "r",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "0"
                  }
                },
                "body": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "y",
                  "_semanticType": "Variable",
                  "_tag": "variable_ref"
                }
              },
              {
                "condition": null,
                "body": {
                  "type": "FunctionCall",
                  "callee": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "gcd1",
                    "_semanticType": "Function",
                    "_tag": "function_ref"
                  },
                  "arguments": [
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "y",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "r",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Block",
                      "style": "Paren",
                      "expressions": [
                        {
                          "type": "BinaryOperation",
                          "operator": "%",
                          "left": {
                            "type": "Atom",
                            "dataType": "identifier",
                            "value": "y",
                            "_semanticType": "Variable",
                            "_tag": "variable_ref"
                          },
                          "right": {
                            "type": "Atom",
                            "dataType": "identifier",
                            "value": "r",
                            "_semanticType": "Variable",
                            "_tag": "variable_ref"
                          }
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 102
### Source
```
gcd : x y ?
	gcd1  x y (x % y)
```
### Lexed
```
gcd : x y ?
<STX>gcd1  x y (x % y)
<ETX>
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "gcd",
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
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": null,
                "body": {
                  "type": "FunctionCall",
                  "callee": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "gcd1",
                    "_semanticType": "Function",
                    "_tag": "function_ref"
                  },
                  "arguments": [
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "x",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "y",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Block",
                      "style": "Paren",
                      "expressions": [
                        {
                          "type": "BinaryOperation",
                          "operator": "%",
                          "left": {
                            "type": "Atom",
                            "dataType": "identifier",
                            "value": "x",
                            "_semanticType": "Variable",
                            "_tag": "variable_ref"
                          },
                          "right": {
                            "type": "Atom",
                            "dataType": "identifier",
                            "value": "y",
                            "_semanticType": "Variable",
                            "_tag": "variable_ref"
                          }
                        }
                      ]
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 103
### Source
```
gcd 18 9
```
### Lexed
```
gcd 18 9
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "gcd",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "18"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "9"
        }
      ]
    }
  ]
}
```

## Test 104
### Source
```
gcd 18 12
```
### Lexed
```
gcd 18 12
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "gcd",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "18"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "12"
        }
      ]
    }
  ]
}
```

## Test 105
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
            },
            {
              "lazy": false,
              "identifier": "y"
            }
          ]
        },
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": {
                  "type": "BinaryOperation",
                  "operator": ">",
                  "left": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "y",
                    "_semanticType": "Variable",
                    "_tag": "variable_ref"
                  },
                  "right": {
                    "type": "Atom",
                    "dataType": "number",
                    "value": "20"
                  }
                },
                "body": {
                  "type": "Atom",
                  "dataType": "identifier",
                  "value": "y",
                  "_semanticType": "Variable",
                  "_tag": "variable_ref"
                }
              },
              {
                "condition": null,
                "body": {
                  "type": "ListConstruct",
                  "elements": [
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "g",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "x",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "y",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 106
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
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "g",
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
        "body": [
          {
            "type": "MatchCase",
            "cases": [
              {
                "condition": null,
                "body": {
                  "type": "FunctionCall",
                  "callee": {
                    "type": "Atom",
                    "dataType": "identifier",
                    "value": "f",
                    "_semanticType": "Function",
                    "_tag": "function_ref"
                  },
                  "arguments": [
                    {
                      "type": "Atom",
                      "dataType": "identifier",
                      "value": "x",
                      "_semanticType": "Variable",
                      "_tag": "variable_ref"
                    },
                    {
                      "type": "BinaryOperation",
                      "operator": "+",
                      "left": {
                        "type": "Atom",
                        "dataType": "identifier",
                        "value": "x",
                        "_semanticType": "Variable",
                        "_tag": "variable_ref"
                      },
                      "right": {
                        "type": "Atom",
                        "dataType": "identifier",
                        "value": "y",
                        "_semanticType": "Variable",
                        "_tag": "variable_ref"
                      }
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  ]
}
```

## Test 107
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
      "type": "FunctionCall",
      "callee": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "f",
        "_semanticType": "Function",
        "_tag": "function_ref"
      },
      "arguments": [
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

## Test 108
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
        "value": "10"
      }
    },
    {
      "type": "Output",
      "target": {
        "type": "Prefix",
        "operators": [
          "$"
        ],
        "expression": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "x",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      },
      "calls": [
        {
          "type": "Atom",
          "dataType": "number",
          "value": "20"
        }
      ]
    },
    {
      "type": "Atom",
      "dataType": "identifier",
      "value": "x",
      "_semanticType": "Variable",
      "_tag": "variable_ref"
    }
  ]
}
```

## Test 109
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
            "type": "ListConstruct",
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

## Test 110
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
        "type": "ListConstruct",
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
            "type": "ListConstruct",
            "elements": [
              {
                "type": "Atom",
                "dataType": "identifier",
                "value": "foo",
                "_semanticType": "Variable",
                "_tag": "variable_ref"
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

## Test 111
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
        "type": "ListConstruct",
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
              "value": "foo",
              "_semanticType": "Variable",
              "_tag": "variable_ref"
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

## Test 112
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
        "type": "ListConstruct",
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
        "value": "foo",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      }
    }
  ]
}
```

## Test 113
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
<ETX>
myGreet ' hello
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "myGreet",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "hello",
            "value": {
              "type": "Atom",
              "dataType": "string",
              "value": "`hello,`"
            }
          },
          {
            "key": "welcome",
            "value": {
              "type": "Atom",
              "dataType": "string",
              "value": "`welcome,`"
            }
          }
        ]
      }
    },
    {
      "type": "Get",
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "myGreet",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "hello",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      ]
    }
  ]
}
```

## Test 114
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
      "target": {
        "type": "Atom",
        "dataType": "identifier",
        "value": "ptr",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
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
        "value": "ptr",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      }
    }
  ]
}
```

## Test 115
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

## Test 116
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
          "value": "a",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
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
        "value": "a_address",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      }
    }
  ]
}
```

## Test 117
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
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "foo",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "5"
        }
      ]
    },
    {
      "type": "ListConstruct",
      "elements": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "bar",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
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

