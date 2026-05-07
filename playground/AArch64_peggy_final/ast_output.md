# Exported ASTs

## Test 1
### Source
```
d:
	name: 10
	age: 42
d'age
```
### Lexed
```
d:
<STX>name: 10
age: 42
<ETX>
d'age
```
### AST
```json
{
  "type": "Program",
  "body": [
    {
      "type": "Define",
      "identifier": "d",
      "definition": {
        "type": "Dictionary",
        "entries": [
          {
            "key": "name",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "10"
            }
          },
          {
            "key": "age",
            "value": {
              "type": "Atom",
              "dataType": "number",
              "value": "42"
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
        "value": "d",
        "_semanticType": "Variable",
        "_tag": "variable_ref"
      },
      "properties": [
        {
          "type": "Atom",
          "dataType": "identifier",
          "value": "age",
          "_semanticType": "Variable",
          "_tag": "variable_ref"
        }
      ]
    }
  ]
}
```

