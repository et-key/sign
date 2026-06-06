[
  {
    "type": "operation",
    "operator": ":",
    "left": "<f>",
    "right": {
      "type": "operation",
      "operator": "?",
      "left": "<x>",
      "right": "<x>",
      "name": "lambda"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": "<a>",
    "right": {
      "type": "operation",
      "operator": "|",
      "left": "<f>",
      "right": "1",
      "name": "or"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": "<b>",
    "right": {
      "type": "operation",
      "operator": "&",
      "left": "<f>",
      "right": "1",
      "name": "and"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": "<c>",
    "right": {
      "type": "operation",
      "operator": "!",
      "operand": "<f>",
      "position": "prefix",
      "name": "not"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "Identifier",
    "name": "<a>",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "Identifier",
    "name": "<b>",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  },
  {
    "type": "Identifier",
    "name": "<c>",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "Variable",
        "name": "<x>"
      }
    }
  }
]