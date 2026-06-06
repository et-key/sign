[
  {
    "type": "operation",
    "operator": ":",
    "left": "<maker>",
    "right": {
      "type": "operation",
      "operator": "?",
      "left": "<a>",
      "right": {
        "type": "operation",
        "operator": "$",
        "operand": {
          "type": "block",
          "kind": "bracket",
          "content": {
            "type": "operation",
            "operator": "?",
            "left": "<x>",
            "right": {
              "type": "operation",
              "operator": "+",
              "left": "<x>",
              "right": "<a>",
              "name": "add"
            },
            "name": "lambda"
          }
        },
        "position": "prefix",
        "name": "address"
      },
      "name": "lambda"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Implicit",
        "target": "Lambda"
      }
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": "<f>",
    "right": {
      "type": "operation",
      "operator": " ",
      "left": "<maker>",
      "right": "10",
      "name": "apply"
    },
    "name": "define",
    "inferredType": {
      "type": "Implicit",
      "target": "Lambda"
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": "<b>",
    "right": {
      "type": "operation",
      "operator": " ",
      "left": {
        "type": "operation",
        "operator": "@",
        "operand": "<f>",
        "position": "prefix",
        "name": "input"
      },
      "right": "5",
      "name": "concat"
    },
    "name": "define",
    "inferredType": {
      "type": "List",
      "elements": [
        {
          "type": "Deref",
          "target": {
            "type": "Implicit",
            "target": "Lambda"
          }
        },
        "Number"
      ]
    }
  },
  {
    "type": "Identifier",
    "name": "<b>",
    "inferredType": {
      "type": "List",
      "elements": [
        {
          "type": "Deref",
          "target": {
            "type": "Implicit",
            "target": "Lambda"
          }
        },
        "Number"
      ]
    }
  }
]