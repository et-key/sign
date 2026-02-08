// 入力コードを正規化する

const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(/^`[^\r\n]*(\r\n|[\r\n])/gm, '')
  .replace(/(\r\n|[\r\n])/g, '\r')                                  // Normalize line endings to \r
  .replace(/\\\r/g, '\\\n')                                       // Escaped \\\r to \\\n


const markSeparator = code => code
  // ブロック内の改行をひとまず区切らないようにする？ Regex above didn't really do that.
  // 1. Separate Brackets: [ ] { } ( ) -> surround with \x1F
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)([\{\(\[])|(?<!\\)([\}\)\]])/g,
    (_, $1, $2, $3, $4) => ($1 || $2) || ($3 && '\x1F[\x1F') || ($4 && '\x1F]\x1F')
  )
  // 2. Separate Commas, Colons, Semicolons if not already separated?
  // User's lexer didn't do this, implying strict space usage or maybe it should?
  // "x," token suggests comma is attached. We should split it.
  // Operators: , : ; ? ! etc.
  // Be careful not to split inside strings or escaped chars.
  // Regex: Match operators that are NOT spaces.
  // Sign operators are symbols.
  // We want `x,` -> `x` `,`
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)([,\:;])/g,
    (_, $1, $2, $3) => ($1 || $2) || ($3 && `\x1F${$3}\x1F`)
  )
  // 3. Separate Spaces
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\) /g,
    (_, $1, $2, $3) => ($1 || $2) || ($3 && `\x1F`)
  )
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|([\r])|([\t])/g,
    (_, e, s, $1, $2) => (e || s) || ($1 && `\x1F\n\x1F`) || ($2 && `\x1F\t\x1F`)
  );

const toSExpr = code => {
  const marked = markSeparator(prepare(code));
  const rawTokens = marked.split('\x1F').filter(t => t !== '');

  // Stack for nesting
  // We need to handle:
  // 1. Indentation (Tabs) -> Block structure
  // 2. Brackets [ ] -> In-line lists/blocks
  // 3. Lines -> Expressions?

  // Structure:
  // Root = Block
  // Block = [Line, Line, ...]
  // Line = [Atom, Atom, ...]

  // However, indentation levels are tricky with just a flat list.
  // We need to track indentation at the start of lines.

  let root = { type: 'block', body: [] };
  let stack = [{ node: root, indent: 0 }]; // Stack of blocks
  let currentLine = [];

  // We need to group tokens by line first to handle indentation?
  // Or process stream?

  let lineIndent = 0;
  let isLineStart = true;

  for (let i = 0; i < rawTokens.length; i++) {
    const token = rawTokens[i];

    if (token === '\n') {
      if (currentLine.length > 0) {
        stack[stack.length - 1].node.body.push(currentLine);
        currentLine = [];
      }
      isLineStart = true;
      lineIndent = 0;
      continue;
    }

    if (token === '\t') {
      if (isLineStart) {
        lineIndent++;
      }
      // Ignore tabs not at start?
      continue;
    }

    if (token === '[' || token === ']') {
      // Handle brackets
      // Brackets start a new nested list/block inside the current line
      if (token === '[') {
        const newList = [];
        currentLine.push(newList);
        // We need to process inside of [] recursively or using stack?
        // Mixed stack: Blocks (indent) and Lists (brackets)?
        // Complexity: Indentation is block-level, brackets are expression-level.
        // Sign: `[ ... ]` can span lines? 
        // If so, we need a unified stack.
        // But indent stack is for explicit indent blocks.

        // Let's refine the approach:
        // Pre-process indentation into INDENT/DEDENT tokens?
        // Then standard parsing.
      }
    }

    // If we are at start of line and have content (not tab/newline), check indentation
    if (isLineStart) {
      isLineStart = false;

      // Adjust stack based on lineIndent
      let currentIndent = stack[stack.length - 1].indent;

      if (lineIndent > currentIndent) {
        // New block
        // The previous line should have started it? Or just this line?
        // Sign: 
        // key :
        //    val
        // The block is attached to `key :`.

        // We create a new block and append it to the LAST item of the previous line?
        // Or just push a Block token?

        // Let's simplify: 
        // Convert structure to nested arrays where Blocks are arrays with special markers?
      }
      else if (lineIndent < currentIndent) {
        while (stack.length > 1 && stack[stack.length - 1].indent > lineIndent) {
          stack.pop();
        }
      }
    }

    currentLine.push(token);
  }

  // Flush last line
  if (currentLine.length > 0) {
    stack[stack.length - 1].node.body.push(currentLine);
  }

  return root;
};

// Simplified tokenizer/parser for S-Expr
// Returns a nested array structure representing the tokens
const parseToSExpr = (code) => {
  const marked = markSeparator(prepare(code));
  const tokens = marked.split('\x1F').filter(t => t !== '');

  const root = [];
  const stack = []; // Stores { array: [], indent: N }

  let currentBlock = root;
  let currentIndent = 0;

  // Buffers for line processing to detect indentation
  let lines = [];
  let line = [];

  // 1. Split into lines
  let temp = [];
  for (const t of tokens) {
    if (t === '\n') {
      lines.push(temp);
      temp = [];
    } else {
      temp.push(t);
    }
  }
  if (temp.length > 0) lines.push(temp);

  // 2. Process spaces/tabs for indentation
  // 3. Build tree

  // Helper to count tabs at start
  const countTabs = (toks) => {
    let c = 0;
    for (const t of toks) {
      if (t === '\t') c++;
      else break;
    }
    return c;
  };

  // We need a proper stack for indentation blocks
  // root is the top level block

  let indentStack = [{ list: root, indent: 0 }];

  // Helper to get current list
  const currentList = () => indentStack[indentStack.length - 1].list;

  for (let l of lines) {
    if (l.length === 0) continue;

    const indent = countTabs(l);
    // Remove leading tabs
    const content = l.slice(indent);
    if (content.length === 0) continue; // Empty line with tabs

    // Adjust indentation
    let top = indentStack[indentStack.length - 1];

    if (indent > top.indent) {
      // New Block
      // The block should be attached to the last item of the previous list?
      // Or just a new list added to current list?
      // In S-expr: `(parent (child ...))`
      // Here: `parent` `child...`
      // If we just push a new array, `parent` and `child` are siblings in currentList?
      // No, `parent` is previous line.

      // Sign semantics: Indent block is an argument or body.
      // We push a new array to the current list.
      const newBlock = [];
      currentList().push(newBlock);
      indentStack.push({ list: newBlock, indent: indent });
    } else if (indent < top.indent) {
      // Dedent
      while (indentStack.length > 1 && indentStack[indentStack.length - 1].indent > indent) {
        indentStack.pop();
      }
    }

    // Add content tokens to current list
    // Handle brackets within content?
    // `[ a b ]` -> `['a', 'b']`
    // We need a mini-parser for inline brackets

    const processedLine = processLine(content);
    currentList().push(...processedLine);
    // Add newline marker or just rely on structure?
    // Parser might need newline to separate expressions.
    currentList().push({ type: 'separator', value: '\n' });
  }

  return root;
};

const processLine = (tokens) => {
  let res = [];
  let stack = [res];

  for (const t of tokens) {
    if (t === '[') {
      const nu = [];
      stack[stack.length - 1].push(nu);
      stack.push(nu);
    } else if (t === ']') {
      if (stack.length > 1) stack.pop();
    } else if (t !== '\t') { // Should be no tabs left
      res.push(t); // Keep as string
    }
  }
  return res;
};

export default {
  prepare,
  markSeparator,
  parseToSExpr
}
