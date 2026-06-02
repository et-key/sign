const fs = require('fs');

let wasm = fs.readFileSync('backend/wasm.js', 'utf8');

// 1. generateModule: add bump_alloc
wasm = wasm.replace(
  `  (type $func_sig (func (param f64) (result f64)))\n\n`,
  `  (type $func_sig (func (param f64) (result f64)))\n\n` +
  `  (func $bump_alloc (param $size i32) (result i32)\n` +
  `    (local $old_ptr i32)\n` +
  `    global.get $__heap_ptr\n` +
  `    local.set $old_ptr\n` +
  `    global.get $__heap_ptr\n` +
  `    local.get $size\n` +
  `    i32.add\n` +
  `    global.set $__heap_ptr\n` +
  `    global.get $__heap_ptr\n` +
  `    memory.size\n` +
  `    i32.const 16\n` +
  `    i32.shl\n` +
  `    i32.ge_u\n` +
  `    if\n` +
  `      i32.const 1\n` +
  `      memory.grow\n` +
  `      drop\n` +
  `    end\n` +
  `    local.get $old_ptr\n` +
  `  )\n\n`
);

// 2. generateFunction: implicit lambdas
wasm = wasm.replace(
  `    if (body && body.type === 'operation' && body.operator === '?') {\n      this.extractParams(body.left, params, defaults);\n      body = body.right;\n    } else {\n      this.extractParams(node.left, params, defaults);\n    }`,
  `    if (body && body.type === 'operation' && body.operator === '?') {\n      this.extractParams(body.left, params, defaults);\n      body = body.right;\n    } else if (body && body.type === 'block' && body.content && body.content.type === 'operation') {\n      const opNode = body.content;\n      const isPrefix = opNode.position === 'prefix';\n      const isPostfix = opNode.position === 'postfix';\n      const isBinary = !isPrefix && !isPostfix;\n\n      if (isBinary) {\n        if (opNode.left === undefined) { \n          params.push('__p0'); defaults.push(false); \n          opNode.left = '__p0'; \n        }\n        if (opNode.right === undefined) { \n          params.push('__p1'); defaults.push(false); \n          opNode.right = '__p1'; \n        }\n      } else {\n        if (opNode.operand === undefined) { \n          params.push('__p0'); defaults.push(false); \n          opNode.operand = '__p0'; \n        }\n      }\n    }`
);

// 3. getIdentName: [object Object] fix
wasm = wasm.replace(
  `      if (node.type === 'operation' && node.operator === '?') return this.getIdentName(node.left);\n      if (node.name) return node.name;`,
  `      if (node.type === 'operation' && node.operator === '?') return this.getIdentName(node.left);\n      if (node.name) return node.name;\n      if (node.type === 'operation' && node.operator) return \`op_\${node.operator.trim() || 'space'}\`;\n      if (node.type === 'block') return \`block_\${node.kind}_\${this.getIdentName(node.content)}\`;\n      return \`unknown\`;`
);

// 4. ~+ operator
wasm = wasm.replace(
  `      if (node.operator === '~+') {\n        const baseName = this.getIdentName(node.left);\n        this.out.push(\`    local.get $\${baseName}_current\`);\n        return;\n      }`,
  `      if (node.operator === '~+') {\n        this.out.push(\`    i32.const 24\`);\n        this.out.push(\`    call $bump_alloc\`);\n        this.out.push(\`    local.set $__stream_ptr\`);\n        this.out.push(\`    local.get $__stream_ptr\`);\n        this.generateExpression(node.left, env);\n        this.out.push(\`    f64.store\`);\n        this.out.push(\`    local.get $__stream_ptr\`);\n        this.generateExpression(node.right, env);\n        this.out.push(\`    f64.store offset=8\`);\n        this.out.push(\`    local.get $__stream_ptr\`);\n        this.out.push(\`    f64.const inf\`);\n        this.out.push(\`    f64.store offset=16\`);\n        this.out.push(\`    local.get $__stream_ptr\`);\n        this.out.push(\`    f64.convert_i32_u\`);\n        return;\n      }`
);

// 5. ~ postfix operator
wasm = wasm.replace(
  `      if (node.operator === '~' && node.position === 'postfix') {\n        const baseName = this.getIdentName(node.operand);\n        this.out.push(\`    local.get $\${baseName}_current\`);\n        this.out.push(\`    local.get $\${baseName}_step\`);\n        this.out.push(\`    f64.add\`); // Extracted element (next value)\n        \n        this.out.push(\`    local.get $\${baseName}_current\`);\n        this.out.push(\`    local.get $\${baseName}_step\`);\n        this.out.push(\`    f64.add\`); // New stream current value\n        \n        this.out.push(\`    local.get $\${baseName}_step\`);\n        this.out.push(\`    local.get $\${baseName}_limit\`);\n        return;\n      }`,
  `      if (node.operator === '~' && node.position === 'postfix') {\n        const baseName = this.getIdentName(node.operand);\n        this.out.push(\`    local.get $\${baseName}\`);\n        this.out.push(\`    i32.trunc_f64_s\`);\n        this.out.push(\`    f64.load\`);\n        \n        this.out.push(\`    local.get $\${baseName}\`);\n        this.out.push(\`    i32.trunc_f64_s\`);\n        this.out.push(\`    local.get $\${baseName}\`);\n        this.out.push(\`    i32.trunc_f64_s\`);\n        this.out.push(\`    f64.load\`);\n        this.out.push(\`    local.get $\${baseName}\`);\n        this.out.push(\`    i32.trunc_f64_s\`);\n        this.out.push(\`    f64.load offset=8\`);\n        this.out.push(\`    f64.add\`);\n        this.out.push(\`    f64.store\`);\n        \n        this.out.push(\`    local.get $\${baseName}\`);\n        return;\n      }`
);

// 6. count 4 -> 2 in apply
wasm = wasm.replaceAll(
  `                    providedArgs.push({ type: 'node', node: argNode, count: 4 });\n                    paramIdx += 4;`,
  `                    providedArgs.push({ type: 'node', node: argNode, count: 2 });\n                    paramIdx += 2;`
);

// 7. extractParams ~
wasm = wasm.replace(
  `      params.push(\`\${baseName}_current\`); defaults.push(hasDefault);\n      params.push(\`\${baseName}_step\`); defaults.push(hasDefault);\n      params.push(\`\${baseName}_limit\`); defaults.push(hasDefault);`,
  `      params.push(baseName); defaults.push(hasDefault);`
);

fs.writeFileSync('backend/wasm.js', wasm);
