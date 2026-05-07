export class SemanticAnalyzer {
  constructor() {
    this.scopes = [{}];
    this.globalEnv = new Map();
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
    return this.currentScope[name] || "Variable";
  }

  analyze(ast) {
    if (this.scopes.length === 0) {
        this.scopes = [{}];
    }
    
    // Pass 1: Global definitions
    this.pass1(ast);
    this.globalEnv = new Map(Object.entries(this.scopes[0]));

    // Pass 2: Lowering and Tagging
    return this.pass2(ast);
  }

  inferType(node) {
    if (!node) return "Variable";
    
    if (node.type === "Lambda") {
        let arity = node.arguments && node.arguments.items ? node.arguments.items.length : 1;
        // Check if body is another Lambda for curried arity
        let bodyNode = node.body;
        while (bodyNode && bodyNode.type === "Lambda") {
            arity += bodyNode.arguments && bodyNode.arguments.items ? bodyNode.arguments.items.length : 1;
            bodyNode = bodyNode.body;
        }
        return `Function:${arity}`;
    }
    
    if (node.type === "Coproduct") {
        let firstType = this.inferType(node.elements[0]);
        if (typeof firstType === "string" && firstType.startsWith("Function")) {
            let parts = firstType.split(":");
            let arity = parts.length > 1 ? parseInt(parts[1], 10) : 1;
            let argsGiven = node.elements.length - 1; // Everything after the first element is an argument
            if (arity > argsGiven) {
                return `Function:${arity - argsGiven}`;
            }
        }
        // Fallback for explicit _ unit application
        if (node.elements.some(e => e.type === "Atom" && e.dataType === "unit" && e.value === "_")) {
            return "Function:1";
        }
        return "Variable";
    }

    if (node.type === "FunctionCall") {
        let calleeType = this.inferType(node.callee);
        if (typeof calleeType === "string" && calleeType.startsWith("Function")) {
            let parts = calleeType.split(":");
            let arity = parts.length > 1 ? parseInt(parts[1], 10) : 1;
            let argsGiven = node.arguments ? node.arguments.length : 1;
            if (arity > argsGiven) {
                return `Function:${arity - argsGiven}`;
            }
        }
        return "Variable";
    }
    
    if (node.type === "Prefix" && node.operators.includes("@")) {
        return "Function:Unknown"; // @ dereferences a closure, making it callable
    }
    
    if (node.type === "Atom" && node.dataType === "identifier") {
        return this.resolveSymbol(node.value);
    }
    
    return "Variable";
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

      let result = elements[0];
      
      for (let i = 1; i < elements.length; i++) {
          let e = elements[i];
          let typeOfResult = this.inferType(result);
          let typeOfE = this.inferType(e);

          let resultIsFunc = typeof typeOfResult === "string" && typeOfResult.startsWith("Function");
          let eIsFunc = typeof typeOfE === "string" && typeOfE.startsWith("Function");

          if (resultIsFunc && eIsFunc) {
              // Function Composition: e ∘ result
              let arity = parseInt(typeOfResult.split(":")[1] || "1", 10);
              let args = [];
              let callA = result;
              
              for(let k = 0; k < arity; k++) {
                  let id = `__carg_${Math.random().toString(36).substr(2, 5)}_${k}`;
                  args.push({ lazy: false, identifier: id });
                  callA = {
                      type: "FunctionCall",
                      callee: callA,
                      arguments: [{ type: "Atom", dataType: "identifier", value: id, _semanticType: "Variable", _tag: "variable_ref" }]
                  };
              }
              
              result = {
                  type: "Lambda",
                  arguments: { type: "Arguments", style: "inline", items: args },
                  body: {
                      type: "FunctionCall",
                      callee: e,
                      arguments: [callA]
                  }
              };
          } else if (resultIsFunc && !eIsFunc) {
              // Function Application: result(e) (strict left-associative curried application)
              result = {
                  type: "FunctionCall",
                  callee: result,
                  arguments: [e]
              };
          } else {
              // Value followed by anything -> Product (Flatten 1 level deep)
              const extractElements = (node) => {
                  if (node.type === "ListConstruct") return node.elements;
                  if (node.type === "Block" && node.expressions && node.expressions.length === 1 && node.expressions[0].type === "ListConstruct") {
                      return node.expressions[0].elements;
                  }
                  return [node];
              };

              let leftElements = extractElements(result);
              let rightElements = extractElements(e);

              result = { type: "ListConstruct", elements: leftElements.concat(rightElements) };
          }
      }

      return this.liftClosure(result);
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
}
