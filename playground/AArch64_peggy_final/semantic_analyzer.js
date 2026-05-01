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
    if (node.type === "Lambda") return "Function";
    if (node.type === "Coproduct") {
        // If it's a partial application (contains _) it returns a Function
        if (node.elements.some(e => e.type === "Atom" && e.dataType === "unit" && e.value === "_")) {
            return "Function";
        }
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

      case "Coproduct":
        // Evaluate elements first
        node.elements = node.elements.map(e => this.pass2(e));

        // Check for partial application (Closure Lifting)
        let unitIndex = -1;
        for (let i = 0; i < node.elements.length; i++) {
           const el = node.elements[i];
           if (el.type === "Atom" && el.dataType === "unit" && el.value === "_") {
               unitIndex = i;
               break;
           }
        }

        let isFunction = false;
        const first = node.elements[0];
        if (first.type === "Atom" && first.dataType === "identifier") {
            if (this.resolveSymbol(first.value) === "Function") {
                isFunction = true;
            }
        } else if (first.type === "Lambda") {
            isFunction = true;
        }

        if (isFunction && unitIndex !== -1) {
            // Transform into Lambda (Closure Lifting)
            const argName = "__p_arg_" + Math.random().toString(36).substr(2, 5);
            const newElements = [...node.elements];
            newElements[unitIndex] = {
                type: "Atom",
                dataType: "identifier",
                value: argName,
                _semanticType: "Variable",
                _tag: "call"
            };

            const innerCall = {
                type: "FunctionCall",
                callee: newElements[0],
                arguments: newElements.slice(1)
            };
            
            return {
                type: "Lambda",
                arguments: {
                    type: "Arguments",
                    style: "inline",
                    items: [{ lazy: false, identifier: argName }]
                },
                body: innerCall
            };
        }

        if (isFunction) {
            // Create a standard FunctionCall node
            return {
                type: "FunctionCall",
                callee: node.elements[0],
                arguments: node.elements.slice(1)
            };
        } else {
            // It's a list construct
            node.type = "ListConstruct";
        }
        break;

      case "Atom":
        if (node.dataType === "identifier") {
           node._semanticType = this.resolveSymbol(node.value);
           // We can add tags if it refers to a function or variable
           if (node._semanticType === "Function") {
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
             node[key] = node[key].map(n => this.pass2(n));
          } else if (typeof node[key] === 'object') {
             node[key] = this.pass2(node[key]);
          }
        }
        break;
    }

    return node;
  }
}
