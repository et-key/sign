import { getArity } from './coproduct_resolver.js';

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
    if (node.type === 'operation' && node.operator === ':') {
      const identName = typeof node.left === 'string' ? node.left : (node.left.name || String(node.left));
      let rightCat = getInitialCategory(node.right, currentEnv);
      const arity = getArity(node.right);
      if (arity > 0) {
        rightCat = 'Lambda';
      }
      currentEnv.set(identName, { category: rightCat, arity: arity });
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

export function collectIdentifiers(node, set) {
  if (!node) return;
  if (typeof node === 'string') {
    if (node.startsWith('<') && node.endsWith('>')) {
      const name = node.slice(1, -1);
      // Ignore numeric strings or anything like numbers
      if (isNaN(name)) {
        set.add(name);
      }
    }
    return;
  }
  if (Array.isArray(node)) {
    node.forEach(n => collectIdentifiers(n, set));
    return;
  }
  if (typeof node === 'object') {
    for (const key of Object.keys(node)) {
      if (key !== 'env') {
        collectIdentifiers(node[key], set);
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
