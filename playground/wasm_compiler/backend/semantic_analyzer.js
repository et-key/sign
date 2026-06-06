import { PropertyRegistry } from './property_registry.js';
import { IRBuilder } from './ir_builder.js';
import { getIdentName, extractParams } from './ast_utils.js';

export function analyzeSemantics(astNodes) {
    const propertyRegistry = new PropertyRegistry();
    const builder = new IRBuilder(propertyRegistry);
    
    // Pass 1: Collect project-level definitions
    for (const node of astNodes) {
        if (node.type === 'operation' && node.operator === ':') {
            const ident = getIdentName(node.left);
            let arity = 0;
            
            // Infer arity by counting parameters if it's a function definition
            if (node.right && (node.right.operator === '?' || node.right.operator === '$' || node.right.operator === '@')) {
                arity = extractParams(node.right.left).filter(Boolean).length;
            }
            
            if (ident) builder.projectEnv.set(ident, { arity, category: arity > 0 ? 'Lambda' : 'Atom' });
        }
    }

    // Pass 2: Generate IR for the main body
    const mainBodyIR = astNodes.map(node => {
        if (node.type === 'operation' && node.operator === ':') {
            const name = getIdentName(node.left);
            const valIR = builder.generateIR(node.right, new Map(), { id: 'main', locals: new Set() });
            return { type: 'ProjectDef', name, value: valIR };
        }
        return builder.generateIR(node, new Map(), { id: 'main', locals: new Set() });
    });

    return {
        functions: builder.functions,
        main: mainBodyIR,
        propertyRegistry // Exporting for debugging or future passes if needed
    };
}
