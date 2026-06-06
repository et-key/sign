[
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "arr"
    },
    "right": {
      "type": "block",
      "kind": "bracket",
      "content": {
        "type": "operation",
        "operator": ",",
        "left": {
          "type": "operation",
          "operator": ",",
          "left": "10",
          "right": "20",
          "name": "product"
        },
        "right": "30",
        "name": "product"
      }
    },
    "name": "define",
    "inferredType": {
      "type": "List",
      "elements": [
        {
          "type": "List",
          "elements": [
            "Number",
            "Number"
          ]
        },
        "Number"
      ]
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "a"
    },
    "right": {
      "type": "operation",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "arr"
      },
      "right": "0",
      "name": "get_prop"
    },
    "name": "define",
    "inferredType": {
      "type": "Deref",
      "target": "Number"
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "b"
    },
    "right": {
      "type": "operation",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "arr"
      },
      "right": "1",
      "name": "get_prop"
    },
    "name": "define",
    "inferredType": {
      "type": "Deref",
      "target": "Number"
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "c"
    },
    "right": {
      "type": "operation",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "arr"
      },
      "right": "2",
      "name": "get_prop"
    },
    "name": "define",
    "inferredType": {
      "type": "Deref",
      "target": "Number"
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "d"
    },
    "right": {
      "type": "operation",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "arr"
      },
      "right": "3",
      "name": "get_prop"
    },
    "name": "define",
    "inferredType": {
      "type": "Deref",
      "target": "Number"
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "arr_y"
    },
    "right": {
      "type": "block",
      "kind": "bracket",
      "content": {
        "type": "operation",
        "operator": "\\n",
        "left": {
          "type": "operation",
          "operator": "\\n",
          "left": "100",
          "right": "200",
          "name": "newline"
        },
        "right": "300",
        "name": "newline"
      }
    },
    "name": "define",
    "inferredType": {
      "type": "Union",
      "types": [
        "Number",
        "Number",
        "Number"
      ]
    }
  },
  {
    "type": "operation",
    "operator": ":",
    "left": {
      "type": "Identifier",
      "name": "e"
    },
    "right": {
      "type": "operation",
      "operator": "'",
      "left": {
        "type": "Identifier",
        "name": "arr_y"
      },
      "right": "1",
      "name": "get_prop"
    },
    "name": "define",
    "inferredType": {
      "type": "Deref",
      "target": "Number"
    }
  },
  {
    "type": "operation",
    "operator": "+",
    "left": {
      "type": "operation",
      "operator": "+",
      "left": {
        "type": "operation",
        "operator": "+",
        "left": {
          "type": "Identifier",
          "name": "a"
        },
        "right": {
          "type": "Identifier",
          "name": "b"
        },
        "name": "add"
      },
      "right": {
        "type": "Identifier",
        "name": "c"
      },
      "name": "add"
    },
    "right": {
      "type": "Identifier",
      "name": "e"
    },
    "name": "add",
    "inferredType": {
      "type": "Unknown"
    }
  }
]