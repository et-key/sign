/**
 * Extracts the identifier name from an AST node safely.
 * Removes '<' and '>' markers if present.
 */
export function getIdentName(node) {
    if (!node) return null;
    let nameStr = null;
    if (typeof node === 'string') {
        nameStr = node;
    } else if (node.name) {
        nameStr = node.name;
    }
    if (nameStr) {
        return nameStr.startsWith('<') && nameStr.endsWith('>') ? nameStr.slice(1, -1) : nameStr;
    }
    return null;
}

/**
 * Extracts a list of parameter names from a node tree formed by 'concat' or space operations.
 */
export function extractParams(n) {
    if (!n) return [];
    if (n.type === 'operation' && (n.name === 'concat' || n.operator === ' ')) {
        return [...extractParams(n.left), ...extractParams(n.right)];
    }
    return [getIdentName(n)];
}
