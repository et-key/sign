# Exported ASTs

## Test 1
### Source
```
identity : x ? x
add : x y ? x + y
```
### Lexed
```
identity : x ? x
add : x y ? x + y
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "identity",
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
          "type": "Atom",
          "dataType": "identifier",
          "value": "x",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      }
    },
    {
      "type": "Define",
      "identifier": "add",
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
  ]
}
```

