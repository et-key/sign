export class SemanticAnalyzer {
  constructor() {
    this.scopes = [{}];
    this.globalEnv = new Map();
    this.typeRegistry = [];
    this.dictDefinitions = new Map();
  }

  get currentScope() {
    return this.scopes[this.scopes.length - 1];
  }

  enterScope() {
    this.scopes.push(Object.create(this.currentScope));
  }

  exitScope() {
    this.scopes.pop();
  }

  defineSymbol(name, type) {
    this.currentScope[name] = type;
  }

  resolveSymbol(name) {
    if (this.dictDefinitions && this.dictDefinitions.has(name)) {
        return name;
    }
    return this.currentScope[name] || name;
  }

  analyze(ast) {
    if (this.scopes.length === 0) {
        this.scopes = [{}];
    }
    this.typeRegistry = [];
    this.dictDefinitions = new Map();
    
    // Pass 1: Global definitions
    this.pass1(ast);
    this.globalEnv = new Map(Object.entries(this.scopes[0]));

    // Pass 2: Lowering and Tagging
    return this.pass2(ast);
  }

  getArity(typeStr) {
      if (typeof typeStr !== "string") return 0;
      if (typeStr.startsWith("Function:")) {
          let parts = typeStr.split(":");
          return parts.length > 1 ? parseInt(parts[1], 10) : 1;
      }
      if (typeStr.includes("->")) {
          return typeStr.split("->").length - 1;
      }
      return 0;
  }

  inferType(node) {
    if (!node) return "Variable";
    
    if (node.type === "Lambda") {
        return this.inferCurriedType(node);
    }
    
    if (node.type === "Block") {
        if (node.expressions && node.expressions.length > 0) {
            return this.inferType(node.expressions[node.expressions.length - 1]);
        }
        return "Variable";
    }
    
    if (node.type === "Coproduct" || node.type === "ListConstruct" || node.type === "Product") {
        let reduced = node.type === "Coproduct" ? this.reduceCoproduct(node.elements) : node;
        
        if (reduced && (reduced.type === "Product" || reduced.type === "ListConstruct")) {
            let types = reduced.elements.map(e => this.inferType(e));
            return types.join(" , ");
        }
        return this.inferType(reduced);
    }

    if (node.type === "FunctionCall") {
        let calleeType = this.inferCurriedType(node.callee);
        let arity = this.getArity(calleeType);
        let argsGiven = node.arguments ? node.arguments.length : 1;
        
        if (calleeType.includes("->")) {
            let parts = calleeType.split("->").map(s => s.trim());
            
            let mappings = new Map();
            if (node.arguments) {
                for (let i = 0; i < argsGiven && i < parts.length - 1; i++) {
                    mappings.set(parts[i], this.inferType(node.arguments[i]));
                }
            }
            
            let remainingParts = parts.slice(argsGiven).map(p => mappings.has(p) ? mappings.get(p) : p);
            
            if (remainingParts.length > 1) {
                return remainingParts.join(" -> ");
            }
            return remainingParts[0] || "Variable";
        }
        
        if (arity > argsGiven) {
            return `Function:${arity - argsGiven}`;
        }
        return "Variable";
    }
    
    if (node.type === "Prefix" && node.operators.includes("@")) {
        let baseType = this.inferType(node.expression);
        if (baseType.startsWith("Address<") && baseType.endsWith(">")) {
            return baseType.substring(8, baseType.length - 1);
        }
        return "Function:Unknown"; // @ dereferences a closure, making it callable
    }
    if (node.type === "Prefix" && node.operators.includes("$")) {
        let baseType = this.inferType(node.expression);
        return `Address<${baseType}>`;
    }
    if (node.type === "BinaryOperation") {
        const cmpOps = ["=", "!=", "<", "<=", ">", ">="];
        if (!cmpOps.includes(node.operator)) {
            return this.inferType(node.left);
        }
    }
    
    if (node.type === "Atom") {
        if (node.dataType === "number") return "Number";
        if (node.dataType === "string") return "String";
        if (node.dataType === "unit") return "Unit";
        if (node.dataType === "address") return "Address";
        if (node.dataType === "register") return "Register";
        if (node.dataType === "identifier") {
            let resolved = this.resolveSymbol(node.value);
            return resolved ? resolved : node.value;
        }
    }
    
    if (node.type === "Get") {
        let baseType = this.inferType(node.target);
        if (this.dictDefinitions.has(baseType)) {
            let fields = this.dictDefinitions.get(baseType);
            let prop = node.properties && node.properties.length > 0 ? node.properties[0] : null;
            if (prop && prop.type === "Atom" && prop.dataType === "identifier") {
                let propName = prop.value;
                if (fields.has(propName)) {
                    return fields.get(propName);
                }
            }
        }
        return "Variant";
    }
    
    return "Variable";
  }

  inferCurriedType(node) {
      if (!node) return "Variable";
      if (node.type === "Lambda") {
          let str = "";
          let current = node;
          while (current && current.type === "Lambda") {
              if (current.arguments && current.arguments.items) {
                  current.arguments.items.forEach(arg => {
                      str += `${arg.identifier} -> `;
                  });
              } else {
                  str += "_ -> ";
              }
              if (current.body && current.body.type === "Lambda") {
                  current = current.body;
              } else if (current.body && current.body.type === "MatchCase") {
                  str += "MatchCase";
                  break;
              } else {
                  let bodyType = "Variable";
                  if (current.body && current.body.type === "Atom" && current.body.dataType === "number") bodyType = "Number";
                  else if (current.body && current.body.type === "Atom" && current.body.dataType === "string") bodyType = "String";
                  else if (current.body && current.body.type === "Atom" && current.body.dataType === "unit") bodyType = "Unit";
                  else bodyType = this.inferType(current.body);
                  str += bodyType;
                  break;
              }
          }
          return str;
      }
      return this.inferType(node);
  }

  pass1(node) {
    if (!node || typeof node !== 'object') return;
    if (Array.isArray(node)) {
      node.forEach(n => this.pass1(n));
      return;
    }

    if (node.type === "Define") {
      const type = this.inferType(node.definition);
      this.defineSymbol(node.identifier, type);
      this.extractStructuralTypes(node.identifier, node.definition);
    }

    // Continue traversing for other definitions
    for (let key of Object.keys(node)) {
      if (key === "type") continue;
      if (node.type === "Define" && key === "identifier") continue;
      // Do not enter Lambda body during pass 1
      if (node.type === "Lambda" && key === "body") continue;

      if (Array.isArray(node[key])) {
        node[key].forEach(n => this.pass1(n));
      } else if (typeof node[key] === 'object') {
        this.pass1(node[key]);
      }
    }
  }

  pass2(node) {
    if (!node || typeof node !== 'object') return node;

    if (Array.isArray(node)) {
      for (let i = 0; i < node.length; i++) {
        node[i] = this.pass2(node[i]);
      }
      return node;
    }

    switch (node.type) {
      case "Lambda":
        this.enterScope();
        if (node.arguments && node.arguments.items) {
           node.arguments.items.forEach(arg => {
              this.defineSymbol(arg.identifier, "Variable");
           });
        }
        node.body = this.pass2(node.body);
        this.exitScope();
        break;

      case "Product":
        node.elements = node.elements.map(e => this.pass2(e));
        node.type = "ListConstruct";
        break;

      case "Coproduct":
        const elements = node.elements.map(e => this.pass2(e));
        return this.reduceCoproduct(elements);

      case "Sequence": {
          let startNode = null, stepNode = null, endNode = null;
          let mainOp = node.operators[0];

          if (mainOp === "~_postfix") {
              startNode = this.pass2(node.blocks[0]);
              stepNode = { type: "Atom", dataType: "number", value: "1" };
              endNode = { type: "Atom", dataType: "number", value: "9223372036854775807" }; // Max Int as Infinity
          } else if (mainOp === "~_prefix") {
              startNode = { type: "Atom", dataType: "number", value: "0" };
              stepNode = { type: "Atom", dataType: "number", value: "1" };
              endNode = this.pass2(node.blocks[0]);
          } else if (mainOp === "~") {
              startNode = this.pass2(node.blocks[0]);
              stepNode = { type: "Atom", dataType: "number", value: "1" };
              endNode = this.pass2(node.blocks[1]);
              mainOp = "~+"; // Treat default ~ as addition
          } else if (node.operators.length === 2 && node.operators[1] === "~") {
              // 1 ~+ 2 ~ 10
              startNode = this.pass2(node.blocks[0]);
              stepNode = this.pass2(node.blocks[1]);
              endNode = this.pass2(node.blocks[2]);
          } else {
              // 1 ~+ 2 (infinite sequence with step)
              startNode = this.pass2(node.blocks[0]);
              stepNode = this.pass2(node.blocks[1]);
              endNode = { type: "Atom", dataType: "number", value: "9223372036854775807" };
          }

          return {
              type: "RangeObject",
              operator: mainOp,
              start: startNode,
              step: stepNode,
              end: endNode
          };
      }

      case "PointFreeNormal":
        const argName = "__pf_arg_" + Math.random().toString(36).substr(2, 5);
        let body;
        
        let targetNode = node.target;
        if (typeof node.target === "string") {
            if (node.target.startsWith("0x")) targetNode = { type: "Atom", dataType: "address", value: node.target };
            else if (node.target.startsWith("0r") || node.target.startsWith("0b")) targetNode = { type: "Atom", dataType: "register", value: node.target };
            else targetNode = { type: "Atom", dataType: "number", value: node.target };
        }

        if (node.position === "right") {
            // x + target
            body = {
                type: "BinaryOperation",
                operator: node.infix,
                left: { type: "Atom", dataType: "identifier", value: argName, _semanticType: "Variable", _tag: "variable_ref" },
                right: this.pass2(targetNode)
            };
        } else {
            // target + x
            body = {
                type: "BinaryOperation",
                operator: node.infix,
                left: this.pass2(targetNode),
                right: { type: "Atom", dataType: "identifier", value: argName, _semanticType: "Variable", _tag: "variable_ref" }
            };
        }
        
        return {
            type: "Lambda",
            arguments: {
                type: "Arguments",
                style: "inline",
                items: [{ lazy: false, identifier: argName }]
            },
            body: body
        };

      case "Atom":
        if (node.dataType === "identifier") {
           node._semanticType = this.resolveSymbol(node.value);
           // We can add tags if it refers to a function or variable
           if (typeof node._semanticType === "string" && node._semanticType.startsWith("Function")) {
               node._tag = "function_ref";
           } else {
               node._tag = "variable_ref";
           }
        }
        break;

      default:
        for (let key of Object.keys(node)) {
          if (key === "type") continue;
          if (Array.isArray(node[key])) {
             node[key] = node[key].map(n => this.pass2(n)).filter(n => n !== null);
          } else if (typeof node[key] === 'object') {
             node[key] = this.pass2(node[key]);
          }
        }
        break;
    }

    return node;
  }

  // --- Pipeline Reduction Helpers ---
  
  isFunctionNode(node) {
      if (!node) return false;
      if (node.type === "Lambda") return true;
      if (node.type === "Atom" && node.dataType === "identifier") {
          const def = this.resolveSymbol(node.value);
          if (typeof def === "string" && def.startsWith("Function")) return true;
          return false;
      }
      if (node.type === "Prefix" && node.operators.includes("@")) return true;
      return false; // FunctionCall, ListConstruct, Get, etc. are values.
  }

  reduceCoproduct(elements) {
      if (!elements || elements.length === 0) return null;

      let finalElements = [];
      let acc = elements[0];
      
      for (let i = 1; i < elements.length; i++) {
          let e = elements[i];
          let arityAcc = this.getArity(this.inferCurriedType(acc));
          let arityE = this.getArity(this.inferCurriedType(e));

          if (arityAcc > 0) {
              if (arityE > 0) {
                  // Function Composition: acc ~> e
                  let newArity = arityAcc + arityE - 1;
                  let args = [];
                  let callA = acc;
                  
                  // Arguments for acc
                  for(let k = 0; k < arityAcc; k++) {
                      let id = `__cargA_${Math.random().toString(36).substr(2, 5)}_${k}`;
                      args.push({ lazy: false, identifier: id });
                      callA = {
                          type: "FunctionCall",
                          callee: callA,
                          arguments: [{ type: "Atom", dataType: "identifier", value: id, _semanticType: "Variable", _tag: "variable_ref" }]
                      };
                  }
                  
                  let callB = e;
                  // First argument to e is the result of callA
                  callB = {
                      type: "FunctionCall",
                      callee: callB,
                      arguments: [callA]
                  };
                  
                  // Remaining arguments for e
                  for(let k = 1; k < arityE; k++) {
                      let id = `__cargB_${Math.random().toString(36).substr(2, 5)}_${k}`;
                      args.push({ lazy: false, identifier: id });
                      callB = {
                          type: "FunctionCall",
                          callee: callB,
                          arguments: [{ type: "Atom", dataType: "identifier", value: id, _semanticType: "Variable", _tag: "variable_ref" }]
                      };
                  }
                  
                  acc = {
                      type: "Lambda",
                      arguments: { type: "Arguments", style: "inline", items: args },
                      body: callB
                  };
              } else {
                  // Function Application: acc(e)
                  acc = {
                      type: "FunctionCall",
                      callee: acc,
                      arguments: [e]
                  };
              }
          } else {
              // acc is fully applied (Value), e is pushed to next iteration
              finalElements.push(acc);
              acc = e;
          }
      }
      
      finalElements.push(acc);
      
      if (finalElements.length === 1) {
          return this.liftClosure(finalElements[0]);
      }
      
      // Flatten 1 level deep if there are nested ListConstructs
      const extractElements = (node) => {
          if (node.type === "ListConstruct") return node.elements;
          if (node.type === "Block" && node.expressions && node.expressions.length === 1 && node.expressions[0].type === "ListConstruct") {
              return node.expressions[0].elements;
          }
          return [node];
      };
      
      let flatElements = [];
      finalElements.forEach(e => {
          flatElements.push(...extractElements(e));
      });
      
      return this.liftClosure({ type: "ListConstruct", elements: flatElements });
  }

  liftClosure(node) {
      let unitNodeInfo = null;

      const findUnit = (n, parent, index) => {
          if (!n || typeof n !== 'object') return;
          if (n.type === "Atom" && n.dataType === "unit" && n.value === "_") {
              unitNodeInfo = { parent, index };
              return;
          }
          if (n.type === "FunctionCall") {
              n.arguments.forEach((arg, i) => findUnit(arg, n.arguments, i));
          }
      };

      findUnit(node, null, -1);

      if (unitNodeInfo) {
          const argName = "__p_arg_" + Math.random().toString(36).substr(2, 5);
          unitNodeInfo.parent[unitNodeInfo.index] = {
              type: "Atom",
              dataType: "identifier",
              value: argName,
              _semanticType: "Variable",
              _tag: "variable_ref"
          };
          return {
              type: "Lambda",
              arguments: {
                  type: "Arguments",
                  style: "inline",
                  items: [{ lazy: false, identifier: argName }]
              },
              body: node
          };
      }
      return node;
  }

  extractStructuralTypes(prefix, node) {
    if (!node || typeof node !== 'object') return;
    
    if (node.type === "Dictionary") {
      let fields = new Map();
      node.entries.forEach(entry => {
        const key = entry.key;
        let valueType = "Variable";
        if (entry.value.type === "Dictionary") {
           // Basic nested support, just mark as Dictionary for now
           valueType = "Dictionary";
        } else if (entry.value.type === "Atom" && entry.value.dataType === "number") {
           valueType = "Number";
        } else if (entry.value.type === "Atom" && entry.value.dataType === "string") {
           valueType = "String";
        } else if (entry.value.type === "Atom" && entry.value.dataType === "unit") {
           valueType = "Unit";
        } else {
           valueType = this.inferType(entry.value);
        }
        fields.set(key, valueType);
      });
      this.dictDefinitions.set(prefix, fields);
      
    } else if (node.type === "Lambda") {
        let curriedArgs = "";
        let targetBody = node;
        
        while (targetBody && targetBody.type === "Lambda") {
            if (targetBody.arguments && targetBody.arguments.items) {
                targetBody.arguments.items.forEach(arg => {
                    curriedArgs += `${arg.identifier} -> `;
                });
            } else {
                curriedArgs += "_ -> ";
            }
            if (targetBody.body && targetBody.body.type === "Lambda") {
                targetBody = targetBody.body;
            } else {
                targetBody = targetBody.body;
                break;
            }
        }
        
        let newPrefix = prefix;
        if (curriedArgs.length > 0) {
            newPrefix = `${prefix} -> ${curriedArgs.slice(0, -4)}`;
        }
        
        if (targetBody && targetBody.type === "MatchCase") {
            let fields = new Map();
            targetBody.cases.forEach(c => {
                let key = "_";
                if (c.condition && c.condition.type === "BinaryOperation" && c.condition.operator === "=") {
                    if (c.condition.right && c.condition.right.type === "Atom") {
                        key = c.condition.right.value;
                    } else if (c.condition.right && c.condition.right.type === "FunctionCall") {
                        // Sometimes types are parsed as function calls or identifiers if they are not primitives
                        key = c.condition.right.value || "Type";
                    } else if (c.condition.right && c.condition.right.identifier) {
                        key = c.condition.right.identifier;
                    }
                }
                
                let valueType = "Variable";
                if (c.body.type === "Atom" && c.body.dataType === "number") {
                    valueType = "Number";
                } else if (c.body.type === "Atom" && c.body.dataType === "string") {
                    valueType = "String";
                } else if (c.body.type === "Atom" && c.body.dataType === "unit") {
                    valueType = "Unit";
                } else {
                    valueType = this.inferType(c.body);
                }
                fields.set(key, valueType);
            });
            this.dictDefinitions.set(newPrefix, fields);
        } else {
            this.typeRegistry.push(`${prefix} -> ${this.inferCurriedType(node)}`);
        }
    } else if (node.type === "Product" || node.type === "Coproduct" || node.type === "Logical_Or" || node.type === "Logical_And" || node.type === "Logical_Xor") {
      let fields = new Map();
      
      const elements = node.elements || [node.left, node.right].filter(Boolean);
      elements.forEach(elem => {
          if (elem.type === "Atom" && elem.dataType === "identifier") {
              const existing = this.dictDefinitions.get(elem.value);
              if (existing) {
                  existing.forEach((valType, k) => fields.set(k, valType));
              }
          }
      });
      if (fields.size > 0) {
          this.dictDefinitions.set(prefix, fields);
      } else {
          let valueType = this.inferType(node);
          this.typeRegistry.push(`${prefix} -> ${valueType}`);
      }
    } else {
       let valueType = "Variable";
       if (node.type === "Atom" && node.dataType === "number") {
           valueType = "Number";
       } else if (node.type === "Atom" && node.dataType === "string") {
           valueType = "String";
       } else if (node.type === "Atom" && node.dataType === "unit") {
           valueType = "Unit";
       } else {
           valueType = this.inferType(node);
       }
       console.log(`extractStructuralTypes: ${prefix} -> ${valueType}`);
       this.typeRegistry.push(`${prefix} -> ${valueType}`);
    }
  }

  generateTypeSignature() {
    let lines = [...this.typeRegistry];
    this.dictDefinitions.forEach((fields, prefix) => {
        lines.push(`${prefix} ->`);
        fields.forEach((valType, key) => {
            lines.push(`\t${key} -> ${valType}`);
        });
    });
    return lines.join("\n") + "\n";
  }
}
