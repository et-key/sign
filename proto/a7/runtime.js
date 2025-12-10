
// Basic Types
const Unit = undefined; // Sign 'Unit' is equivalent to JS undefined/null often, or a singleton.
// In Sign, empty list is also falsey.
// Let's use a specific symbol or just JS null/undefined handling.
// Sign says: "_ is unit".
// "0 is true, _/[] is false".

// Helper to check truthiness according to Sign
function isTruthy(val) {
    if (val === undefined || val === null) return false;
    if (Array.isArray(val) && val.length === 0) return false; // Empty list
    if (typeof val === 'function' && !val.evaluated) return false; // Unevaluated lambda? (Maybe too complex for now)
    return true;
}

const Runtime = {
    isTruthy,

    // Operators implementation
    ops: {
        '+': (a, b) => a + b,
        '-': (a, b) => a - b,
        '*': (a, b) => a * b,
        '/': (a, b) => a / b,
        '%': (a, b) => a % b,
        '^': (a, b) => Math.pow(a, b),

        // Logical (Short-circuiting handled in interpreter usually, but here for values)
        '&': (a, b) => isTruthy(a) ? b : Unit,
        '|': (a, b) => isTruthy(a) ? a : b,

        // Comparison (Sign returns value if true, Unit if false)
        '<': (a, b) => a < b ? a : Unit,
        '<=': (a, b) => a <= b ? a : Unit,
        '=': (a, b) => a === b ? a : Unit,
        '==': (a, b) => a === b ? a : Unit,
        '>=': (a, b) => a >= b ? a : Unit,
        '>': (a, b) => a > b ? a : Unit,
        '!=': (a, b) => a !== b ? a : Unit,

        // List Construction
        ',': (a, b) => {
            // If a is list, append b? No, ',' is cons/append.
            // Sign: 1, 2 = [1, 2]
            // If we use JS arrays:
            if (Array.isArray(a)) return [...a, b];
            return [a, b];
            // Wait, right associative? 1, (2, 3) -> [1, 2, 3]?
            // If b is array: [a, ...b]
            // Let's handle simple case first.
        },

        // Debug
        '#': (a, b) => {
            console.log('OUTPUT:', b);
            return b;
        }
    }
};

module.exports = { Runtime, Unit };
