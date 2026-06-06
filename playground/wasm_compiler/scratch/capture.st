[
  {
    "type": "operation",
    "operator": ":",
    "left": "<f>",
    "right": {
      "type": "operation",
      "operator": "?",
      "left": "<x>",
      "right": {
        "type": "block",
        "kind": "bracket",
        "content": {
          "type": "operation",
          "operator": "\\n",
          "left": {
            "type": "operation",
            "operator": ":",
            "left": "<g>",
            "right": {
              "type": "operation",
              "operator": "?",
              "left": "<y>",
              "right": {
                "type": "operation",
                "operator": "+",
                "left": "<x>",
                "right": "<y>",
                "name": "add"
              },
              "name": "lambda"
            },
            "name": "define"
          },
          "right": {
            "type": "operation",
            "operator": " ",
            "left": "<g>",
            "right": "5",
            "name": "apply"
          },
          "name": "newline"
        }
      },
      "name": "lambda"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Union",
        "types": [
          {
            "type": "Lambda",
            "returns": "Number"
          },
          "Number"
        ]
      }
    }
  },
  {
    "type": "operation",
    "operator": " ",
    "left": "<f>",
    "right": "10",
    "name": "apply",
    "inferredType": {
      "type": "Union",
      "types": [
        {
          "type": "Lambda",
          "returns": "Number"
        },
        {
          "type": "Variable",
          "name": "Number"
        }
      ]
    }
  }
]