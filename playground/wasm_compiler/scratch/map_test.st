[
  {
    "type": "operation",
    "operator": ":",
    "left": "<map>",
    "right": {
      "type": "operation",
      "operator": "?",
      "left": {
        "type": "operation",
        "operator": " ",
        "left": {
          "type": "operation",
          "operator": " ",
          "left": "<f>",
          "right": "<x>",
          "name": "concat"
        },
        "right": {
          "type": "operation",
          "operator": "~",
          "operand": "<y>",
          "position": "prefix",
          "name": "continuous"
        },
        "name": "concat"
      },
      "right": {
        "type": "operation",
        "operator": ",",
        "left": {
          "type": "operation",
          "operator": " ",
          "left": {
            "type": "operation",
            "operator": "@",
            "operand": "<f>",
            "position": "prefix",
            "name": "input"
          },
          "right": "<x>",
          "name": "concat"
        },
        "right": {
          "type": "operation",
          "operator": " ",
          "left": "<map>",
          "right": {
            "type": "operation",
            "operator": " ",
            "left": "<f>",
            "right": {
              "type": "operation",
              "operator": "~",
              "operand": "<y>",
              "position": "postfix",
              "name": "expand"
            },
            "name": "concat"
          },
          "name": "apply"
        },
        "name": "product"
      },
      "name": "lambda"
    },
    "name": "define",
    "inferredType": {
      "type": "Lambda",
      "returns": {
        "type": "List",
        "elements": [
          {
            "type": "List",
            "elements": [
              {
                "type": "Deref",
                "target": {
                  "type": "Variable",
                  "name": "<f>"
                }
              },
              {
                "type": "Variable",
                "name": "<x>"
              }
            ]
          },
          {
            "type": "Apply",
            "left": {
              "type": "Variable",
              "name": "<map>"
            },
            "right": {
              "type": "List",
              "elements": [
                {
                  "type": "Variable",
                  "name": "<f>"
                },
                {
                  "type": "List"
                }
              ]
            }
          }
        ]
      }
    }
  },
  {
    "type": "operation",
    "operator": " ",
    "left": "<print>",
    "right": {
      "type": "block",
      "kind": "bracket",
      "content": {
        "type": "operation",
        "operator": " ",
        "left": "<map>",
        "right": {
          "type": "operation",
          "operator": " ",
          "left": {
            "type": "operation",
            "operator": " ",
            "left": {
              "type": "operation",
              "operator": " ",
              "left": {
                "type": "operation",
                "operator": " ",
                "left": {
                  "type": "operation",
                  "operator": " ",
                  "left": {
                    "type": "operation",
                    "operator": "$",
                    "operand": {
                      "type": "block",
                      "kind": "bracket",
                      "content": {
                        "type": "operation",
                        "operator": "*",
                        "right": "2",
                        "name": "mul"
                      }
                    },
                    "position": "prefix",
                    "name": "address"
                  },
                  "right": "1",
                  "name": "concat"
                },
                "right": "2",
                "name": "concat"
              },
              "right": "3",
              "name": "concat"
            },
            "right": "4",
            "name": "concat"
          },
          "right": "5",
          "name": "concat"
        },
        "name": "apply"
      }
    },
    "name": "apply",
    "inferredType": {
      "type": "Apply",
      "left": {
        "type": "Variable",
        "name": "<print>"
      },
      "right": {
        "type": "List",
        "elements": [
          {
            "type": "List",
            "elements": [
              {
                "type": "Deref",
                "target": {
                  "type": "List",
                  "elements": [
                    {
                      "type": "List",
                      "elements": [
                        {
                          "type": "List",
                          "elements": [
                            {
                              "type": "List",
                              "elements": [
                                {
                                  "type": "Implicit",
                                  "target": "Lambda"
                                },
                                "Number"
                              ]
                            },
                            "Number"
                          ]
                        },
                        "Number"
                      ]
                    },
                    "Number"
                  ]
                }
              },
              {
                "type": "Variable",
                "name": "<x>"
              }
            ]
          },
          {
            "type": "List",
            "elements": [
              {
                "type": "List",
                "elements": [
                  {
                    "type": "Deref",
                    "target": {
                      "type": "Variable",
                      "name": "<f>"
                    }
                  },
                  {
                    "type": "Variable",
                    "name": "<x>"
                  }
                ]
              },
              {
                "type": "Apply",
                "left": {
                  "type": "Variable",
                  "name": "<map>"
                },
                "right": {
                  "type": "List",
                  "elements": [
                    {
                      "type": "Variable",
                      "name": "<f>"
                    },
                    {
                      "type": "List"
                    }
                  ]
                }
              }
            ]
          }
        ]
      }
    }
  }
]