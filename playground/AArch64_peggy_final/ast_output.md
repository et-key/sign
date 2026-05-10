# Exported ASTs

## Test 1
### Source
```
f : x ~y ? x
g : x ~y ? y
h : x ~y ? h y~
```
### Lexed
```
f : x ~y ? x
g : x ~y ? y
h : x ~y ? h y~
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
              "lazy": true,
              "identifier": "y"
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
              "lazy": true,
              "identifier": "y"
            }
          ]
        },
        "body": {
          "type": "Atom",
          "dataType": "identifier",
          "value": "y",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      }
    },
    {
      "type": "Define",
      "identifier": "h",
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
              "lazy": true,
              "identifier": "y"
            }
          ]
        },
        "body": {
          "type": "FunctionCall",
          "callee": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "h",
            "_semanticType": "x -> ~y -> List<Variant>",
            "_tag": "variable_ref"
          },
          "arguments": [
            {
              "type": "Postfix",
              "expression": {
                "type": "Atom",
                "dataType": "identifier",
                "value": "y",
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
    }
  ]
}
```

## Test 2
### Source
```
a : f 1 2 3 4 5
b : g 1 2 3 4 5
c : h 1 2 3 4 5
```
### Lexed
```
a : f 1 2 3 4 5
b : g 1 2 3 4 5
c : h 1 2 3 4 5
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
        "type": "FunctionCall",
        "callee": {
          "type": "FunctionCall",
          "callee": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "f",
            "_semanticType": "x -> ~y -> x",
            "_tag": "variable_ref"
          },
          "arguments": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ]
        },
        "arguments": [
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
    },
    {
      "type": "Define",
      "identifier": "b",
      "definition": {
        "type": "FunctionCall",
        "callee": {
          "type": "FunctionCall",
          "callee": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "g",
            "_semanticType": "x -> ~y -> y",
            "_tag": "variable_ref"
          },
          "arguments": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ]
        },
        "arguments": [
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
    },
    {
      "type": "Define",
      "identifier": "c",
      "definition": {
        "type": "FunctionCall",
        "callee": {
          "type": "FunctionCall",
          "callee": {
            "type": "Atom",
            "dataType": "identifier",
            "value": "h",
            "_semanticType": "x -> ~y -> List<Variant>",
            "_tag": "variable_ref"
          },
          "arguments": [
            {
              "type": "Atom",
              "dataType": "number",
              "value": "1"
            }
          ]
        },
        "arguments": [
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

