import { getArity, getParamCount } from './coproduct_resolver.js';

export function getParameterNames(node, names = new Set()) {
  if (!node) return names;
  if (typeof node === 'string') {
    names.add(node);
    return names;
  }
  if (node.type === 'block') {
    return getParameterNames(node.content, names);
  }
  if (node.type === 'coproduct_block') {
    (node.statements || []).forEach(stmt => getParameterNames(stmt, names));
    return names;
  }
  if (node.type === 'operation') {
    if (node.operator === ':') {
      getParameterNames(node.left, names);
      return names;
    }
    if (node.operator === '\\n' || node.operator === ' ' || node.operator === ',') {
      getParameterNames(node.left, names);
      getParameterNames(node.right, names);
      return names;
    }
    if (node.operator === '~' && node.position === 'prefix') {
      const innerNames = getParameterNames(node.operand);
      innerNames.forEach(n => names.add(n.startsWith('~') ? n : '~' + n));
      return names;
    }
    if (node.operator === '~' && node.position === 'postfix') {
      const innerNames = getParameterNames(node.operand);
      innerNames.forEach(n => names.add(n.startsWith('~') ? n : '~' + n));
      return names;
    }
    if (node.operator === '~' && node.left && node.right) {
      getParameterNames(node.left, names);
      const innerNames = getParameterNames({ type: 'operation', operator: '~', operand: node.right, position: 'prefix' });
      innerNames.forEach(n => names.add(n.startsWith('~') ? n : '~' + n));
      return names;
    }
  }
  return names;
}

export function inferType(node, env) {
  if (!node) return 'Unit';
  
  if (typeof node === 'string') {
    if (node.startsWith('`') && node.endsWith('`')) return 'List';
    if (node.startsWith('\\') && node.length === 2) return 'Scalar';
    if (node.startsWith('0x') || node.startsWith('0u')) return 'Scalar';
    if (node === '__hole' || node === '_') return 'Unknown';
    if (node === '__unit' || node === '__') return 'Unit';
    if (!isNaN(node)) return 'Scalar';
    
    const clean = node.startsWith('<') && node.endsWith('>') ? node.slice(1, -1) : node;
    if (env && env.has(clean)) {
      const entry = env.get(clean);
      return entry.typeTag || 'Unknown';
    }
    if (env && env.has(`<${clean}>`)) {
      return env.get(`<${clean}>`).typeTag || 'Unknown';
    }
    
    if (['print', 'free', 'reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'].includes(clean)) return 'Lambda';
    return 'Unknown';
  }

  if (node.type === 'Identifier' || node.type === 'Variable') {
    const nodeName = node.name;
    const clean = nodeName.startsWith('<') && nodeName.endsWith('>') ? nodeName.slice(1, -1) : nodeName;
    if (env && env.has(clean)) {
      const entry = env.get(clean);
      return entry.typeTag || 'Unknown';
    }
    if (env && env.has(`<${clean}>`)) {
      return env.get(`<${clean}>`).typeTag || 'Unknown';
    }
    if (['print', 'free', 'reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'].includes(clean)) return 'Lambda';
    return 'Unknown';
  }
  
  if (node.type === 'block') {
    if (node.kind === 'bracket') {
      return 'List';
    }
    return inferType(node.content, env);
  }
  
  if (node.type === 'coproduct_block') {
    if (node.statements && node.statements.length === 1) {
      return inferType(node.statements[0], env);
    }
    return 'List';
  }
  
  if (node.type === 'operation') {
    if (node.operator === ':') {
      return inferType(node.right, env);
    }
    if (node.operator === '?') {
      return 'Lambda';
    }
    if (node.operator === "'") {
      return 'Unknown'; 
    }
    if (node.operator === ',') {
      return 'List';
    }
    if (['+', '-', '*', '/', '%', '^', '<', '>', '<=', '>=', '=', '!='].includes(node.operator)) {
      return 'Scalar';
    }
    if (['&', '|', ';', '&&', '||', ';;', '<<', '>>'].includes(node.operator)) {
      return 'Scalar';
    }
    if (node.position === 'prefix') {
      if (node.operator === '$') return 'Scalar';
      if (node.operator === '@') return 'Unknown';
      if (node.operator === '~') return 'List';
      if (['!', '!!', '-'].includes(node.operator)) return 'Scalar';
    }
    if (node.position === 'postfix') {
      if (node.operator === '~') return 'Unknown';
      if (node.operator === '!') return 'Scalar';
    }
    if (node.operator === ' ') {
      if (node.name === 'concat') {
        const typeL = inferType(node.left, env);
        const typeR = inferType(node.right, env);
        if (typeL === 'Dict' || typeR === 'Dict') return 'Dict';
        return 'List';
      }
      if (node.name === 'compose') return 'Lambda';
      if (node.name === 'apply') {
        const leftType = inferType(node.left, env);
        if (leftType === 'Lambda') {
          const arity = getArity(node.left, env);
          let appliedCount = 1;
          if (node.right && node.right.type === 'coproduct_block') {
            appliedCount = node.right.statements.length;
          }
          if (appliedCount < arity) {
            return 'Lambda';
          }
          const leftName = typeof node.left === 'string' ? node.left : (node.left.name || '');
          const clean = leftName.startsWith('<') && leftName.endsWith('>') ? leftName.slice(1, -1) : leftName;
          if (env && env.has(clean)) {
            const entry = env.get(clean);
            if (entry.returnType) return entry.returnType;
          }
        }
        return 'Unknown';
      }
    }
  }
  
  return 'Unknown';
}

export function buildEnvironment(node, env = new Map()) {
  if (!node) return env;
  if (Array.isArray(node)) {
    node.forEach(n => buildEnvironment(n, env));
    return env;
  }
  if (typeof node === 'object') {
    let currentEnv = env;
    if (node.type === 'block' && (node.kind === 'indent' || node.kind === 'abs')) {
      currentEnv = new Map(env);
      node.env = currentEnv;
    }
    if (node.type === 'operation' && node.operator === '?') {
      currentEnv = new Map(env);
      node.env = currentEnv;
      
      const paramNames = getParameterNames(node.left);
      paramNames.forEach(name => {
        let typeTag = 'Scalar';
        let cleanName = name;
        if (name.startsWith('<') && name.endsWith('>')) {
          cleanName = name.slice(1, -1);
        }
        let strippedName = cleanName;
        if (cleanName.startsWith('~')) {
          typeTag = 'List';
          strippedName = cleanName.slice(1);
        }
        
        currentEnv.set(name, { category: 'Atom', arity: 1, typeTag });
        currentEnv.set(cleanName, { category: 'Atom', arity: 1, typeTag });
        if (strippedName !== cleanName) {
          currentEnv.set(strippedName, { category: 'Atom', arity: 1, typeTag });
          currentEnv.set(`<${strippedName}>`, { category: 'Atom', arity: 1, typeTag });
        }
      });
      
      buildEnvironment(node.left, currentEnv);
      buildEnvironment(node.right, currentEnv);
      
      const retType = inferType(node.right, currentEnv);
      node.returnType = retType;
      
      return env;
    }
    if (node.type === 'operation' && node.operator === ':') {
      let identName = typeof node.left === 'string' ? node.left : (node.left.name || String(node.left));
      if (node.left && node.left.type === 'block' && node.left.kind === 'bracket') {
        const content = node.left.content;
        if (content && content.type === 'operation') {
          identName = `[${content.operator}]`;
        }
      }
      let rightCat = getInitialCategory(node.right, currentEnv);
      let arity = getArity(node.right, currentEnv);
      if (arity > 0) {
        rightCat = 'Lambda';
      }
      
      const typeTag = inferType(node.right, currentEnv);
      let isRealFunction = false;
      let targetR = node.right;
      while (targetR && targetR.type === 'block') {
        targetR = targetR.content;
      }
      let requiredLength = arity;
      if (targetR && targetR.type === 'operation' && targetR.operator === '?') {
        isRealFunction = true;
        arity = getParameterNames(targetR.left).size;
        requiredLength = getParamCount(targetR.left);
      } else if (targetR && targetR.type === 'inline_code') {
        isRealFunction = true;
      }
      const entry = { category: rightCat, arity: arity, requiredLength, typeTag, isRealFunction };
      if (node.right && node.right.returnType) {
        entry.returnType = node.right.returnType;
      }
      
      currentEnv.set(identName, entry);
      if (identName.startsWith('<') && identName.endsWith('>')) {
        currentEnv.set(identName.slice(1, -1), entry);
      }
    }
    for (const key of Object.keys(node)) {
      if (key !== 'type' && key !== 'name' && key !== 'operator' && key !== 'kind' && key !== 'env') {
        buildEnvironment(node[key], currentEnv);
      }
    }
  }
  return env;
}

export function getInitialCategory(node, env) {
  if (!node) return 'Atom';
  if (node.isLambda) return 'Lambda';
  if (node.type === 'inline_code') return 'Lambda';
  if (typeof node === 'string') {
    if (env && env.has(node)) {
      const entry = env.get(node);
      return typeof entry === 'string' ? entry : (entry.category || 'Atom');
    }
    if (['print', '<print>', '_'].includes(node)) return 'Lambda';
    return 'Atom';
  }
  if (node.type === 'operation') {
    if (node.operator === '?') return 'Lambda';
    if (node.name === 'compose') return 'Lambda';
    if (node.name === 'apply') return getInitialCategory(node.left, env);
    if (node.name === 'get_prop' || node.name === 'get_at') return 'Lambda';
    return 'Atom';
  }
  if (node.type === 'block') {
    return getInitialCategory(node.content, env);
  }
  if (node.type === 'coproduct_block' && Array.isArray(node.statements) && node.statements.length > 0) {
    return getInitialCategory(node.statements[node.statements.length - 1], env);
  }
  return 'Atom';
}

export function collectIdentifiers(node, set, env = new Map()) {
  if (!node) return;

  let currentEnv = env;
  if (node && node.env) {
    currentEnv = node.env;
  }

  if (typeof node === 'string') {
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      // Ignore numeric strings or anything like numbers
      if (isNaN(name)) {
        const hasDef = currentEnv.has(node) || currentEnv.has(`<${name}>`) || currentEnv.has(name);
        if (!hasDef) {
          set.add(name);
        }
      }
    }
    return;
  }
  if (Array.isArray(node)) {
    node.forEach(n => collectIdentifiers(n, set, currentEnv));
    return;
  }
  if (typeof node === 'object') {
    if (node.type === 'operation' && node.operator === "'") {
      collectIdentifiers(node.left, set, currentEnv);
      return;
    }
    if (node.type === 'operation' && node.operator === "@" && node.position !== 'postfix') {
      collectIdentifiers(node.right, set, currentEnv);
      return;
    }
    for (const key of Object.keys(node)) {
      if (key !== 'env') {
        collectIdentifiers(node[key], set, currentEnv);
      }
    }
  }
}

export function desugarHoles(node) {
  if (!node) return node;
  if (typeof node !== 'object') return node;
  if (Array.isArray(node)) {
    return node.map(desugarHoles);
  }

  if (node.type === 'coproduct_block' && node.statements) {
    const holeIndices = [];
    node.statements.forEach((stmt, idx) => {
      if (stmt === '_') {
        holeIndices.push(idx);
      }
    });

    if (holeIndices.length > 0) {
      const paramNames = holeIndices.map((_, i) => `<$p${i}>`);
      const newStatements = [...node.statements];
      holeIndices.forEach((stmtIdx, i) => {
        newStatements[stmtIdx] = paramNames[i];
      });

      const lambdaLHS = paramNames.length === 1
        ? paramNames[0]
        : { type: 'coproduct_block', statements: paramNames };

      const lambdaRHS = {
        type: 'coproduct_block',
        statements: newStatements
      };

      const lambdaNode = {
        type: 'operation',
        operator: '?',
        left: lambdaLHS,
        right: lambdaRHS,
        name: 'lambda'
      };

      return desugarHoles(lambdaNode);
    }
  }

  const newNode = { ...node };
  for (const key of Object.keys(newNode)) {
    if (key !== 'env') {
      newNode[key] = desugarHoles(newNode[key]);
    }
  }
  return newNode;
}
