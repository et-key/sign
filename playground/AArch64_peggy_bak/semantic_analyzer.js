export class SemanticAnalyzer {
  constructor() {
    this.scopes = [{}];
  }

  get currentScope() {
    return this.scopes[this.scopes.length - 1];
  }

  enterScope() {
    // JavaScript Object.create naturally handles prototype chaining.
    // If a name is not in the current scope, it falls back to the parent scope.
    // This perfectly and elegantly resolves shadowing rules.
    const newScope = Object.create(this.currentScope);
    this.scopes.push(newScope);
  }

  exitScope() {
    this.scopes.pop();
  }

  defineSymbol(name, type) {
    this.currentScope[name] = type;
  }

  resolveSymbol(name) {
    return this.currentScope[name] || "Unknown";
  }

  analyze(ast) {
    this.scopes = [{}];

    // Pass 1: Global definitions
    this.pass1(ast);

    // Expose global environment for downstream tools
    this.globalEnv = new Map(Object.entries(this.scopes[0]));

    // Pass 2: Lowering and Tagging
    ast = this.pass2(ast);
    return ast;
  }

  // --- PASS 1: Scope Definition Gathering ---
  pass1(node) {
    if (!node || typeof node !== 'object') return;

    if (Array.isArray(node)) {
      node.forEach(n => this.pass1(n));
      return;
    }

    // Register Definitions
    if (node.type === "BinaryExpression" && node.operator === ":") {
      let resolvedType = "Variable";
      if (node.right && node.right.type === "BinaryExpression" && node.right.operator === "?") {
        resolvedType = "Function";
      }

      if (node.left && node.left.type === "Identifier") {
        this.defineSymbol(node.left.name, resolvedType);
      }
    }

    // Do not gather inside new lexical boundaries, wait for pass2 to enter them
    if (node.type === "BinaryExpression" && node.operator === "?") return;
    if (["Block", "BlockExpression", "DictionaryExpression", "MatchCaseExpression"].includes(node.type)) return;

    // Traverse other expressions
    for (let key of ["left", "right", "argument", "elements", "callee", "body"]) {
      if (node[key]) {
        if (Array.isArray(node[key])) node[key].forEach(n => this.pass1(n));
        else this.pass1(node[key]);
      }
    }
  }

  // --- PASS 2: Semantic Tagging and Ast Transformation ---
  pass2(node) {
    if (!node || typeof node !== 'object') return node;

    if (Array.isArray(node)) {
      for (let i = 0; i < node.length; i++) {
        node[i] = this.pass2(node[i]);
      }
      return node;
    }

    switch (node.type) {
      case "Block":
      case "BlockExpression":
      case "DictionaryExpression":
      case "MatchCaseExpression":
        this.enterScope();
        // Mini Pass 1 for block scope hoisting
        if (node.elements) {
          node.elements.forEach(n => this.pass1(n));
          node.elements = node.elements.map(n => this.pass2(n));
        } else if (node.body) {
          node.body.forEach(n => this.pass1(n));
          node.body = node.body.map(n => this.pass2(n));
        }
        this.exitScope();
        break;

      case "BinaryExpression":
        if (node.operator === "?") {
          // Lambda closure scope (Shadowing happens here)
          this.enterScope();

          this._registerParameters(node.left);

          node.left = this.pass2(node.left);
          node.right = this.pass2(node.right);

          this.exitScope();
        } else {
          node.left = this.pass2(node.left);
          node.right = this.pass2(node.right);
        }
        break;

      case "Identifier":
        if (!node._semanticType) {
          node._semanticType = this.resolveSymbol(node.name);
        }
        break;

      case "CoproductExpression":
        node.left = this.pass2(node.left);
        node.right = this.pass2(node.right);

        // Determine if left is callable
        let leftBase = node.left;
        while (leftBase && (leftBase.type === "CoproductExpression" || leftBase.type === "FunctionCall" || leftBase.type === "ListConstruct")) {
          leftBase = leftBase.left;
        }

        let isFunctionCall = false;
        if (leftBase) {
          if (leftBase.type === "Identifier" && (leftBase._semanticType === "Function" || leftBase._semanticType === "Unknown")) {
            isFunctionCall = true;
          } else if (leftBase.type === "BinaryExpression" && leftBase.operator === "?") {
            isFunctionCall = true;
          }
        }

        // AST MUTATION: Finalize ambiguity
        if (isFunctionCall) {
          node.type = "FunctionCall";
        } else {
          node.type = "ListConstruct";
        }
        break;

      default:
        for (let key of ["left", "right", "argument", "elements", "callee", "body"]) {
          if (node[key]) {
            if (Array.isArray(node[key])) {
              for (let i = 0; i < node[key].length; i++) {
                node[key][i] = this.pass2(node[key][i]);
              }
            } else {
              node[key] = this.pass2(node[key]);
            }
          }
        }
        break;
    }

    return node;
  }

  _registerParameters(node) {
    if (!node) return;
    if (node.type === "Identifier") {
      this.defineSymbol(node.name, "Variable");
      node._semanticType = "Variable";
    } else if (node.type === "CoproductExpression" || node.type === "FunctionCall" || node.type === "ListConstruct") {
      this._registerParameters(node.left);
      this._registerParameters(node.right);
    } else if (node.type === "ListExpression" || node.type === "BlockExpression") {
      if (node.elements) {
        node.elements.forEach(n => this._registerParameters(n));
      }
    }
  }
}


