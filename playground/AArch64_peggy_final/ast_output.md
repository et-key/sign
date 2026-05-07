# Exported ASTs

## Test 1
### Source
```
f : x ?
	x = 1 : 10
	x = 2 : 20
	30
```
### Lexed
```
f : x ?
<STX>x = 1 : 10
x = 2 : 20
30
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
            }
          ]
        },
        "body": {
          "type": "MatchCase",
          "cases": [
            {
              "condition": {
                "type": "BinaryOperation",
                "operator": "=",
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
                "type": "Atom",
                "dataType": "number",
                "value": "10"
              }
            },
            {
              "condition": {
                "type": "BinaryOperation",
                "operator": "=",
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
                  "value": "2"
                }
              },
              "body": {
                "type": "Atom",
                "dataType": "number",
                "value": "20"
              }
            },
            {
              "condition": null,
              "body": {
                "type": "Atom",
                "dataType": "number",
                "value": "30"
              }
            }
          ]
        }
      }
    }
  ]
}
```

## Test 2
### Source
```
f 2
```
### Lexed
```
f 2
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
        "_semanticType": "Function:1",
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

