export function formatTypeObj(t, genericMap = new Map(), genericCounter = { val: 0 }) {
  if (!t) return "unknown";
  if (typeof t === 'string') return t; // fallback

  if (t.type === 'type_primitive') return t.name;
  if (t.type === 'type_unit') return 'unit';
  if (t.type === 'type_ref') {
    if (!genericMap.has(t.name)) {
       genericMap.set(t.name, String.fromCharCode(84 + genericCounter.val++)); // T, U, V...
    }
    return genericMap.get(t.name);
  }
  if (t.type === 'type_tuple') {
    return t.elements.map(e => formatTypeObj(e, genericMap, genericCounter)).join(' * ');
  }
  if (t.type === 'type_array') {
    return `[${formatTypeObj(t.elementType, genericMap, genericCounter)}; ${t.length}]`;
  }
  if (t.type === 'type_address') {
    return `Address<${formatTypeObj(t.target, genericMap, genericCounter)}>`;
  }
  if (t.type === 'type_deref') {
    return `Deref<${formatTypeObj(t.target, genericMap, genericCounter)}>`;
  }
  if (t.type === 'type_list') {
    return `List<${t.name}>`;
  }
  if (t.type === 'type_coproduct') {
    return t.variants.map(v => formatTypeObj(v, genericMap, genericCounter)).join(' | ');
  }
  if (t.type === 'type_function') {
    const argsStr = t.args.map(a => {
       if (a.default_type) {
          return `${a.name}: ${formatTypeObj(a.default_type, genericMap, genericCounter)}`;
       } else {
          return `${a.name}: ${formatTypeObj(a, genericMap, genericCounter)}`;
       }
    }).join(', ');
    const retStr = formatTypeObj(t.returnType, genericMap, genericCounter);
    return `(${argsStr}) -> ${retStr}`;
  }
  return 'unknown';
}

export function extractSignature(name, rightNode) {
  if (!rightNode) return `value ${name} : unknown\n`;
  
  const t = rightNode.type_detail;
  if (t && t.type === 'type_function') {
    const genericMap = new Map();
    const genericCounter = { val: 0 };
    
    const argsStr = t.args.map(a => {
       if (a.default_type) {
          return `${a.name}: ${formatTypeObj(a.default_type, genericMap, genericCounter)}`;
       } else {
          return `${a.name}: ${formatTypeObj(a, genericMap, genericCounter)}`;
       }
    }).join(', ');
    
    const retStr = formatTypeObj(t.returnType, genericMap, genericCounter);
    return `type ${name} : (${argsStr}) -> ${retStr}\n`;
  } else {
    const genericMap = new Map();
    const genericCounter = { val: 0 };
    const typeStr = formatTypeObj(t, genericMap, genericCounter);
    return `value ${name} : ${typeStr}\n`;
  }
}

export function generateST(astTrees, lambdas) {
  let stOutput = "// Auto-generated type signature file\n\n";

  // Process top-level definitions in AST
  for (const tree of astTrees) {
    if (tree && tree.type === 'operation' && tree.operator === ':') {
      let name = tree.left;
      if (typeof name === 'string' && name.startsWith('<')) name = name.slice(1, -1);
      stOutput += extractSignature(name, tree.right);
    }
  }

  // Process hoisted lambdas
  if (lambdas && lambdas.length > 0) {
    stOutput += "\n// Hoisted anonymous functions\n";
    for (const lambda of lambdas) {
      if (lambda.type === 'operation' && lambda.operator === ':') {
        let name = lambda.left;
        if (typeof name === 'string' && name.startsWith('"')) name = name.slice(1, -1);
        stOutput += extractSignature(name, lambda.right);
      }
    }
  }

  return stOutput;
}
