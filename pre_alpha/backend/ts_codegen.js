// pre_alpha/backend/ts_codegen.js
import { OPERATOR_TYPES } from '../semanticize/operator_types.js';

export function generateTypeScriptDef(astLines, env) {
  let output = `// Auto-generated TypeScript definitions for Sign

declare const __unit: unique symbol;
declare const __hole: unique symbol;
export type Unit = typeof __unit;
export type Hole = typeof __hole;
export type Scalar = number | boolean;
export type String = string;
export type Address = number;
export type Atom = Scalar | String | Hole | Address;
export type List = (Atom | List | Unit)[];
export type Lambda = (...args: SignValue[]) => SignValue;
export type SignValue = Atom | List | Lambda | Unit;

`;

  astLines.forEach(node => {
    if (!node) return;
    if (node.type === 'operation' && node.operator === ':') {
      const defName = getDefineLHS(node.left);
      if (defName) {
        const typeSig = inferTypeSignature(node.right, env);
        output += `export declare const ${defName}: ${typeSig};\n`;
      }
    }
  });

  return output;
}

function getDefineLHS(left) {
  if (typeof left === 'string') {
    return left.startsWith('<') && left.endsWith('>') ? left.slice(1, -1) : left;
  }
  if (left && left.type === 'Identifier') {
    return left.name;
  }
  return null;
}

function inferTypeSignature(node, env) {
  if (!node) return 'SignValue';

  // Function definition (Lambda)
  if (node.type === 'operation' && node.operator === '?') {
    const specs = getParameterSpecs(node.left);
    
    // Infer the inner return type using OPERATOR_TYPES or basic traversal
    const retTypeRaw = inferNodeReturnType(node.right, env);
    const tsRetType = mapToTSType(retTypeRaw);

    if (specs.length === 0) {
      return `() => ${tsRetType}`;
    }

    const typeParams = [];
    const params = [];

    specs.forEach((p, i) => {
      const typeVar = String.fromCharCode(84 + i); // T, U, V, W...
      typeParams.push(`${typeVar} extends SignValue`);
      if (p.isRest) {
        params.push(`...${p.name}: ${typeVar}[]`);
      } else {
        params.push(`${p.name}: ${typeVar} | Hole`);
      }
    });

    const typeParamStr = typeParams.length > 0 ? `<${typeParams.join(', ')}>` : '';
    const paramStr = params.join(', ');
    
    return `${typeParamStr}(${paramStr}) => ${tsRetType}`;
  }

  const retTypeRaw = inferNodeReturnType(node, env);
  return mapToTSType(retTypeRaw);
}

function mapToTSType(raw) {
  if (typeof raw === 'string') {
    if (raw === 'Number') return 'number';
    if (raw === 'String') return 'string';
    if (raw === 'Boolean') return 'boolean';
    if (['Scalar', 'Atom', 'List', 'Lambda', 'Unit', 'Address', 'SignValue'].includes(raw)) {
      return raw;
    }
  }
  if (raw && typeof raw === 'object') {
    if (raw.type === 'List') return 'List';
    if (raw.type === 'Lambda') return 'Lambda';
    if (raw.type === 'Unit') return 'Unit';
    if (raw.type === 'Implicit') return mapToTSType(raw.target);
    if (raw.type === 'Deref') return mapToTSType(raw.target);
  }
  return 'SignValue'; // Fallback
}

function inferNodeReturnType(node, env) {
  if (!node) return 'Unit';
  if (typeof node === 'number') return 'Number';
  if (typeof node === 'boolean') return 'Boolean';
  if (typeof node === 'string') {
    if (node.startsWith('`') && node.endsWith('`')) return 'String';
    if (node.startsWith('0x')) return 'Address';
    return 'Atom';
  }

  if (node.type === 'block') {
    return inferNodeReturnType(node.content, env);
  }

  if (node.type === 'operation') {
    let opKey = node.operator;
    if (node.position === 'prefix') opKey = 'prefix_' + opKey;
    if (node.position === 'postfix') opKey = 'postfix_' + opKey;
    if (node.operator === ' ' && node.name) opKey = node.name; // concat, compose, apply

    const resolver = OPERATOR_TYPES[opKey];
    if (resolver) {
      const L = node.position === 'prefix' ? undefined : inferNodeReturnType(node.left, env);
      const R = node.position === 'postfix' ? undefined : inferNodeReturnType(node.right || node.operand, env);
      
      const res = resolver(L, R);
      return res;
    }
  }

  return 'SignValue';
}

function getParameterSpecs(node) {
  if (!node) return [];
  if (typeof node === 'string') {
    const name = node.startsWith('<') && node.endsWith('>') ? node.slice(1, -1) : node;
    return [{ name, isRest: false }];
  }
  if (node.type === 'block') {
    return getParameterSpecs(node.content);
  }
  if (node.type === 'coproduct_block') {
    return (node.statements || []).flatMap(getParameterSpecs);
  }
  if (node.type === 'operation') {
    if (node.operator === '\\n' || node.operator === ' ' || node.operator === ',') {
      return [...getParameterSpecs(node.left), ...getParameterSpecs(node.right)];
    }
    if (node.operator === ':') {
      const leftSpecs = getParameterSpecs(node.left);
      const name = leftSpecs.length > 0 ? leftSpecs[0].name : (typeof node.left === 'string' ? node.left : String(node.left));
      const isRest = leftSpecs.length > 0 ? leftSpecs[0].isRest : false;
      return [{ name, isRest }];
    }
    if (node.operator === '~' && node.position === 'prefix') {
      return getParameterSpecs(node.operand).map(p => ({ ...p, isRest: true }));
    }
    if (node.operator === '~' && node.position === 'postfix') {
      return getParameterSpecs(node.operand).map(p => ({ ...p, isRest: true }));
    }
    if (node.operator === '~' && node.left && node.right) {
      return [
        ...getParameterSpecs(node.left),
        ...getParameterSpecs({ type: 'operation', operator: '~', operand: node.right, position: 'prefix' })
      ];
    }
  }
  return [{ name: String(node), isRest: false }];
}
