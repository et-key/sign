# Sign Language JavaScript Transpile Strategy

## 1. Overview

The transformation from Sign language to JavaScript is achieved through **staged text replacement** without going through an AST. This approach is a concrete implementation example of "Zero Cost Domain Abstraction," achieving both theoretical elegance and implementation efficiency.

### 1.1 Basic Policy

- **Staged transformation**: Sign notation → Intermediate Sign notation → JavaScript
- **Text-based**: Replacement via regular expressions and pattern matching
- **Order control**: Processing from highest priority syntax in order

### 1.2 Transformation Benefits

| Feature | Description |
|---------|-------------|
| Implementation simplicity | No complex AST parser needed |
| Debugging ease | Direct verification of output at each stage |
| Extensibility | Easy to add new transformation rules |
| Prototyping | Immediate behavior verification |

## 1.5 Relationship Between Sign Language Core Principles and Transformation Strategy

### Three-Stage Token Determination Principle

The Sign language transpile strategy is directly based on the core principles of the language:

| Stage | Determination Criteria | Treatment in Transformation | Implementation Location |
|-------|----------------------|---------------------------|------------------------|
| **First** | String? | Protect with placeholder → Restore in final stage | [2] Literal protection |
| **Second** | Character? | Protect with placeholder → Restore in final stage | [2] Literal protection |
| **Third** | Literal or symbol? | Preserve literals, convert symbols as operators | [5]-[9] Various conversions |

### Correspondence with Staged Transformation

```
Sign source code
  ↓
[Stages 1 & 2] String & character protection
  ↓ [2] Literal protection
Intermediate representation (protected)
  ↓
[Stage 3] Literal and operator identification & conversion
  ↓ [3]-[9] Syntax conversion
Intermediate JavaScript (with placeholders)
  ↓
[Restoration] Restore protected literals
  ↓ [10] Final formatting
JavaScript code
```

### Benefits of This Principle

1. **Clear protection strategy**
   - What needs protection in stages 1 & 2 is self-evident
   - Clear separation from conversion targets (stage 3)

2. **Conversion safety**
   - Completely prevents erroneous conversion within strings/characters
   - Impossible to confuse literals and operators

3. **Debugging ease**
   - Clear what is being processed at each stage
   - Easy to isolate problems

This core principle enables transformation without a complex AST parser.

## 2. Overall Transformation Process

```
Sign source code
  ↓
[1] Preprocessing (Lexer processing)
  ↓
[2] Literal protection
  ↓
[3] Block structure conversion
  ↓
[4] match_case detection and conversion
  ↓
[5] Operator conversion
  ↓
[6] Function definition conversion
  ↓
[7] List operation conversion
  ↓
[8] Special syntax conversion
  ↓
[9] Identifier conversion
  ↓
[10] Final formatting
  ↓
JavaScript code
```

## 3. Basic Conversion Table

### 3.1 Literal Conversion

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `42` | `42` | Numbers as-is |
| `-3.14` | `-3.14` | Floating point likewise |
| `0xAF` | `0xAF` | Hex as-is |
| `0o77` | `0o77` | Octal (ES6+) |
| `0b1010` | `0b1010` | Binary (ES6+) |
| `` `string` `` | `"string"` | Backticks to double quotes |
| `\n` | `"\\n"` | Character to string |
| `_` | `undefined` | Unit to undefined |

### 3.2 Arithmetic Operators

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `x + y` | `x + y` | As-is |
| `x - y` | `x - y` | As-is |
| `x * y` | `x * y` | As-is |
| `x / y` | `x / y` | As-is |
| `x % y` | `x % y` | As-is |
| `x ^ y` | `Math.pow(x, y)` | Power becomes function call |
| `x!` | `factorial(x)` | Factorial becomes function call |
| `\|x\|` | `Math.abs(x)` | Absolute value becomes function call |

### 3.3 Comparison Operators

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `x < y` | `(x < y ? x : undefined)` | Value-returning conversion |
| `x <= y` | `(x <= y ? x : undefined)` | Value-returning conversion |
| `x = y` | `(x === y ? x : undefined)` | Equality uses === |
| `x == y` | `(x === y ? x : undefined)` | Same as above |
| `x >= y` | `(x >= y ? x : undefined)` | Value-returning conversion |
| `x > y` | `(x > y ? x : undefined)` | Value-returning conversion |
| `x != y` | `(x !== y ? x : undefined)` | Inequality uses !== |

### 3.4 Logical Operators

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `x & y` | `(x && y)` | Short-circuit as-is |
| `x \| y` | `(x \|\| y)` | Short-circuit as-is |
| `x ; y` | `((x \|\| y) && !(x && y))` | XOR expressed as expression |
| `!x` | `(!x)` | As-is |

### 3.5 Function Definitions

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `x ? x + 1` | `x => x + 1` | Arrow function |
| `x y ? x + y` | `x => y => x + y` | Curried |
| `[+ 1]` | `x => x + 1` | Partial application |
| `[+]` | `x => y => x + y` | Operator as function |

### 3.6 Conditional Branching (match_case)

| Sign Notation | JavaScript | Notes |
|--------------|-----------|-------|
| `x ?`<br>`  cond1 : val1`<br>`  cond2 : val2` | `x => {`<br>`  switch (true) {`<br>`    case cond1: return val1;`<br>`    case cond2: return val2;`<br>`  }`<br>`}` | Conditional branching within block |

## 4. Staged Transformation Details

### 4.1 [1] Preprocessing (Lexer Processing)

Already processed by existing lexer.js:
- Control character removal
- Newline normalization
- Comment removal
- Unary operator marking
- Block structure marking

### 4.2 [2] Literal Protection

Stages 1 & 2: String & character protection (see §1.5 for details)

```javascript
// String protection
const strings = [];
code = code.replace(/`([^`]*)`/g, (_, content) =>
  `__STRING_${strings.push(content) - 1}__`
);

// Character protection
const chars = [];
code = code.replace(/\\(.)/g, (_, char) =>
  `__CHAR_${chars.push(char) - 1}__`
);
```

### 4.3 [3] Block Structure Conversion

#### Indent blocks → Braces

```javascript
// Tab indent detection (already marked by lexer)
code = code.replace(/\x1D(.+?)\x1D/g, '{ $1 }');
```

#### Bracket unification

```javascript
// Unify all brackets to parentheses (already processed by lexer)
// [, {, ( → (
// ], }, ) → )
```

### 4.4 [4] match_case Detection and Conversion

#### match_case Syntax Detection

When a `condition : return_value` pattern exists within a function definition block, convert to switch statement:

```javascript
const matchCasePattern = /(\w+(?:\s+\w+)*)\s*\?\s*\{([^}]+)\}/g;

function convertMatchCase(code) {
  return code.replace(matchCasePattern, (match, params, body) => {
    const lines = body.trim().split('\n').map(l => l.trim()).filter(l => l);
    const cases = [];
    let defaultCase = null;

    lines.forEach(line => {
      if (line.includes(':')) {
        const [condition, returnValue] = line.split(':').map(s => s.trim());
        cases.push({ condition, returnValue });
      } else {
        defaultCase = line;
      }
    });

    const paramList = params.split(/\s+/);
    const arrowFn = paramList.join(' => ');

    let switchBody = '  switch (true) {\n';
    cases.forEach(c => {
      switchBody += `    case ${c.condition}: return ${c.returnValue};\n`;
    });
    if (defaultCase) {
      switchBody += `    default: return ${defaultCase};\n`;
    }
    switchBody += '  }';

    return `${arrowFn} => {\n${switchBody}\n}`;
  });
}
```

#### Conversion Example

**Input:**
```sign
classify : x ?
  x < 0 : `negative`
  x = 0 : `zero`
  x > 0 : `positive`
```

**Output:**
```javascript
const classify = x => {
  switch (true) {
    case x < 0: return "negative";
    case x === 0: return "zero";
    case x > 0: return "positive";
  }
}
```

### 4.5 [5] Operator Conversion

```javascript
// Power operator
code = code.replace(/(\w+)\s*\^\s*(\w+)/g, 'Math.pow($1, $2)');

// Factorial operator
code = code.replace(/(\w+)!/g, 'factorial($1)');

// Absolute value
code = code.replace(/\|([^|]+)\|/g, 'Math.abs($1)');

// Comparison operators (value-returning)
code = code.replace(/(\w+)\s*<\s*(\w+)/g, '($1 < $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*<=\s*(\w+)/g, '($1 <= $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*=\s*(\w+)/g, '($1 === $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*>=\s*(\w+)/g, '($1 >= $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*>\s*(\w+)/g, '($1 > $2 ? $1 : undefined)');
code = code.replace(/(\w+)\s*!=\s*(\w+)/g, '($1 !== $2 ? $1 : undefined)');

// XOR operator
code = code.replace(/(\w+)\s*;\s*(\w+)/g, '(($1 || $2) && !($1 && $2))');
```

### 4.6 [6] Function Definition Conversion

```javascript
// Lambda: x ? x + 1 → x => x + 1
code = code.replace(/(\w+)\s*\?\s*(.+)/g, '$1 => $2');

// Curried: x y ? x + y → x => y => x + y
code = code.replace(/(\w+(?:\s+\w+)*)\s*\?\s*(.+)/g, (match, params, body) => {
  const paramList = params.split(/\s+/);
  return paramList.reduceRight((acc, p) => `${p} => ${acc}`, body);
});

// Continuous argument list (~prefix)
code = code.replace(/~(\w+)\s*\?/g, '...$1 =>');

// Pointfree notation
code = code.replace(/\[\s*\+\s*(\w+)\s*\]/g, 'x => x + $1');
code = code.replace(/\[\s*\*\s*(\w+)\s*\]/g, 'x => x * $1');
code = code.replace(/\[\s*\+\s*\]/g, '(x, y) => x + y');
code = code.replace(/\[\s*\*\s*\]/g, '(x, y) => x * y');
```

### 4.7 [7] List Operation Conversion

```javascript
// List construction: 1, 2, 3 → [1, 2, 3]
code = code.replace(/(\w+)\s*,\s*(\w+)/g, '[$1, $2]');

// List concatenation (coproduct)
code = code.replace(/\[([^\]]+)\]\s+\[([^\]]+)\]/g, '[$1].concat([$2])');

// Range list: [1 ~ 5] → range(1, 5)
code = code.replace(/\[\s*(\w+)\s*~\s*(\w+)\s*\]/g, 'range($1, $2)');

// MAP: [* 2,] list → list.map(x => x * 2)
code = code.replace(/\[\s*\*\s*(\w+)\s*,\s*\]\s*(\w+)/g, '$2.map(x => x * $1)');
code = code.replace(/\[\s*\+\s*(\w+)\s*,\s*\]\s*(\w+)/g, '$2.map(x => x + $1)');

// FOLD: [+] list → list.reduce((acc, x) => acc + x)
code = code.replace(/\[\s*\+\s*\]\s*(\w+)/g, '$1.reduce((acc, x) => acc + x)');
code = code.replace(/\[\s*\*\s*\]\s*(\w+)/g, '$1.reduce((acc, x) => acc * x)');

// Expand (~postfix): list~ → ...list
code = code.replace(/(\w+)~/g, '...$1');
```

### 4.8 [8] Special Syntax Conversion

```javascript
// Define operator (:): x : 42 → const x = 42
code = code.replace(/(\w+)\s*:\s*(.+)/g, 'const $1 = $2');

// Export operator (#prefix): #x : 42 → export const x = 42
code = code.replace(/#(\w+)\s*:\s*(.+)/g, 'export const $1 = $2');

// Get operator ('infix): obj ' key → obj.key or obj[key]
code = code.replace(/(\w+)\s*'\s*(\w+)/g, '$1.$2');
code = code.replace(/(\w+)\s*'\s*(\d+)/g, '$1[$2]');

// Get operator (@infix): key @ obj → obj.key
code = code.replace(/(\w+)\s*@\s*(\w+)/g, '$2.$1');

// Address ($prefix): $x → (() => x)
code = code.replace(/\$(\w+)/g, '(() => $1)');

// Input (@prefix): @address → readMemory(address)
code = code.replace(/@(0x[0-9A-Fa-f]+)/g, 'readMemory($1)');
code = code.replace(/@(\w+)/g, 'readMemory($1)');

// Output (#infix): address # data → writeMemory(address, data)
code = code.replace(/(\w+)\s*#\s*(\w+)/g, 'writeMemory($1, $2)');

// Import (@postfix): module@ → require('module')
code = code.replace(/(\w+)@/g, "require('$1')");
```

### 4.9 [9] Identifier Conversion

```javascript
// Unit (_): _ → undefined
code = code.replace(/\b_\b/g, 'undefined');

// Avoid JavaScript reserved words
const jsReserved = ['class', 'const', 'let', 'var', 'function', 'return', 'if', 'else', 'for', 'while'];
jsReserved.forEach(word => {
  code = code.replace(new RegExp(`\\b${word}\\b`, 'g'), `${word}_`);
});
```

### 4.10 [10] Final Formatting

```javascript
// Restore strings
code = code.replace(/__STRING_(\d+)__/g, (match, index) => {
  return `"${strings[index]}"`;
});

// Restore characters
code = code.replace(/__CHAR_(\d+)__/g, (match, index) => {
  return `"${chars[index]}"`;
});

// Insert semicolons
code = code.replace(/\n/g, ';\n');

// Format indentation
code = formatIndentation(code);
```

## 5. Helper Function Implementations

Helper functions required by transpiled code:

### 5.1 Range Generation

```javascript
function range(start, end, step = 1) {
  const result = [];
  if (step > 0) {
    for (let i = start; i <= end; i += step) result.push(i);
  } else {
    for (let i = start; i >= end; i += step) result.push(i);
  }
  return result;
}
```

### 5.2 Factorial

```javascript
function factorial(n) {
  if (n <= 1) return 1;
  return n * factorial(n - 1);
}
```

### 5.3 Memory Access (Simulation)

```javascript
const memory = new Map();
function readMemory(address) { return memory.get(address); }
function writeMemory(address, data) { memory.set(address, data); return address; }
```

## 6. Conversion Examples

### 6.1 Basic Arithmetic

**Sign:**
```sign
x : 10
y : 20
result : x + y * 2
```

**JavaScript:**
```javascript
const x = 10;
const y = 20;
const result = x + y * 2;
```

### 6.2 Function Definition and Application

**Sign:**
```sign
add : x y ? x + y
result : add 3 5
```

**JavaScript:**
```javascript
const add = x => y => x + y;
const result = add(3)(5);
```

### 6.3 List Operations

**Sign:**
```sign
numbers : 1, 2, 3, 4, 5
doubled : [* 2,] numbers
sum : [+] doubled
```

**JavaScript:**
```javascript
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(x => x * 2);
const sum = doubled.reduce((acc, x) => acc + x);
```

### 6.4 Conditional Branching (match_case)

**Sign:**
```sign
classify : x ?
  x < 0 : `negative`
  x = 0 : `zero`
  x > 0 : `positive`
```

**JavaScript:**
```javascript
const classify = x => {
  switch (true) {
    case x < 0: return "negative";
    case x === 0: return "zero";
    case x > 0: return "positive";
  }
};
```

## 7. Limitations and Workarounds

| Limitation | Reason | Workaround |
|-----------|--------|-----------|
| No full type inference | JavaScript's dynamic typing | Separate route converting to TypeScript |
| No direct memory manipulation | JavaScript spec | Insert simulation layer |
| No true TCO | JS implementation dependent | Add trampoline conversion |
| Limited multithreading | Worker API only | Alternative strategy needed |

## 8. Implementation Roadmap

### Phase 1: Basic Conversion (Current)
- ✅ Lexer implemented
- ✅ Literal conversion
- ✅ Basic operator conversion
- ✅ match_case conversion (switch statements)
- 🔄 Function definition conversion (in progress)

### Phase 2: Advanced Features
- ⏳ Full list operation support
- ⏳ Higher-order function optimization
- ⏳ Pattern matching conversion

### Phase 3: Optimization
- ⏳ Inline expansion
- ⏳ Constant folding
- ⏳ Dead code elimination

### Phase 4: Extensions
- ⏳ TypeScript output support
- ⏳ SourceMap generation
- ⏳ Error message improvement

## 9. Summary

### 9.1 Strengths of This Approach

1. **Implementation simplicity**: Rapid development without AST parser
2. **Debugging ease**: Each stage can be visualized
3. **Extensibility**: Easy to add new rules
4. **Prototyping**: Immediate behavior verification

### 9.2 Future Outlook

- **Native compiler**: Direct conversion to C/AArch64
- **LLVM IR**: More advanced optimization
- **Self-hosting**: Implementing Sign language in Sign language
- **Multiple targets**: WebAssembly, FPGA, etc.

### 9.3 Realization of Design Philosophy

This transpile strategy embodies the core design philosophy of Sign language:

- **Zero Cost Domain Abstraction**: Achieving both theoretical elegance and implementation efficiency
- **Syntax = Type**: Ensuring type safety through text transformation alone
- **Staged transformation**: Sign → Sign → Target language
- **Invisible strength**: Hiding complex transformations from the programmer

This JavaScript transpile implementation is the first step in proving the practicality of Sign language and serves as a bridge to more advanced future implementations.
