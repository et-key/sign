# Exported ASTs

## Test 1
### Source
```
F : f x ? @f x
Result : F $[+ 2] 3
```
### Lexed
```
F : f x ? @f x
Result : F $[+ 2] 3
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "F",
      "definition": {
        "type": "Lambda",
        "arguments": {
          "type": "Arguments",
          "style": "inline",
          "items": [
            {
              "lazy": false,
              "identifier": "f"
            },
            {
              "lazy": false,
              "identifier": "x"
            }
          ]
        },
        "body": {
          "type": "ListConstruct",
          "elements": [
            {
              "type": "Prefix",
              "operators": [
                "@"
              ],
              "expression": {
                "type": "Atom",
                "dataType": "identifier",
                "value": "f",
                "_semanticType": "Variable",
                "_tag": "variable_ref"
              }
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
          "value": "F",
          "_semanticType": "Function",
          "_tag": "function_ref"
        },
        "arguments": [
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
                  "type": "PointFreeNormal",
                  "target": "2",
                  "infix": "+",
                  "position": "right"
                }
              ]
            }
          },
          {
            "type": "Atom",
            "dataType": "number",
            "value": "3"
          }
        ]
      }
    }
  ]
}
```

