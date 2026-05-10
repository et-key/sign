# Exported ASTs

## Test 1
### Source
```
1 2 3 4 5 6 7 8 9 ' [2 4 6]
```
### Lexed
```
1 2 3 4 5 6 7 8 9 ' [2 4 6]
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
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "6"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "7"
        },
        {
          "type": "Atom",
          "dataType": "number",
          "value": "8"
        },
        {
          "type": "Get",
          "target": {
            "type": "Atom",
            "dataType": "number",
            "value": "9"
          },
          "properties": [
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
                      "value": "4"
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

