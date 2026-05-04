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

  // --- Pipeline Reduction Helpers ---
  
  isFunctionNode(node) {
      if (!node) return false;
      if (node.type === "Lambda") return true;
      if (node.type === "Atom" && node.dataType === "identifier") {
          const def = this.resolveSymbol(node.value);
          if (def === "Function") return true;
          return false;
      }
      if (node.type === "Prefix" && node.operators.includes("@")) return true;
      return false; // FunctionCall, ListConstruct, Get, etc. are values.
  }

  reduceCoproduct(elements) {
      let pipeline = [];
      let args = [];

      for (let e of elements) {
          if (this.isFunctionNode(e)) {
              if (args.length > 0 && pipeline.length > 0) {
                  // Evaluate current pipeline and set result as first arg for next
                  let res = this.applyPipeline(pipeline, args);
                  args = [res];
                  pipeline = [e];
              } else if (args.length > 0 && pipeline.length === 0) {
                  // Value followed by function: x f -> f(x)
                  pipeline.push(e);
              } else {
                  // Function followed by function: f g -> pipeline [f, g]
                  pipeline.push(e);
              }
          } else {
              // It's a value
              args.push(e);
          }
      }

      let result = null;
      if (pipeline.length > 0) {
          if (args.length > 0) {
              result = this.applyPipeline(pipeline, args);
          } else {
              result = this.composePipeline(pipeline);
          }
      } else {
          if (args.length === 1) {
              result = args[0];
          } else if (args.length > 1) {
              result = { type: "ListConstruct", elements: args };
          }
      }

      return this.liftClosure(result);
  }

  applyPipeline(pipeline, args) {
      // Apply f to args -> f(args)
      let res = { type: "FunctionCall", callee: pipeline[0], arguments: args };
      res = this.liftClosure(res); // Early lifting for nested calls if needed

      for (let i = 1; i < pipeline.length; i++) {
          res = { type: "FunctionCall", callee: pipeline[i], arguments: [res] };
          res = this.liftClosure(res);
      }
      return res;
  }

  composePipeline(pipeline) {
      if (pipeline.length === 1) return pipeline[0];
      const argName = "__comp_arg_" + Math.random().toString(36).substr(2, 5);
      let body = { type: "Atom", dataType: "identifier", value: argName };
      body = this.applyPipeline(pipeline, [body]);
      return {
          type: "Lambda",
          arguments: {
              type: "Arguments",
              style: "inline",
              items: [{ lazy: false, identifier: argName }]
          },
          body: body
      };
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
