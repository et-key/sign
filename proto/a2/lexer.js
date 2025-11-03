
'use strict';

/*
  tokenizPrefix:
    - Add space after and tokenize prefix operators
  tokenizePostfix:
    - Add space before and tokenize postfix operators

  preprocess:
    - Remove control characters
    - Remove comments
    - Add spaces around binary operators
    - Handle prefix operators
    - Handle postfix operators
  
  tokenize:
    - Split by line
    - Handle indented blocks
    - Handle brackets as blocks
    - Split by spaces
  
  bracketToBlock:
    - Convert bracketed tokens to nested arrays
  
  clean:
    - Remove empty tokens
*/


const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(/^`[^\r\n]*(\r\n|[\r\n])/gm, '')
  .replace(
    /(\r\n|[\r\n])/g, '\r'                                  // Normalize line endings to \r
  )
  .replace(
    /\\\r(?<!\\)\t+/g, '\\\n'                                       // Escaped \\\r to \\\n 
  );

const procUnary = code => code
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)|([#~!$@])([^\r\t#~!$@ ]+)([!~@])/g,
    (_, $1, $2, $3, $4, $5) => ($1 || $2) || (
      $3 && $5
        ? `\x1F${$3}_\x1F${ procUnary($4) }\x1F_${$5}\x1F`
        : $3 ? `\x1F${$3}_\x1F${ procUnary($4) }\x1F` : `\x1F${ procUnary($4) }\x1F_${$5}\x1F`
    )
  );

const procBlock = code => code
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)|\r\t/gm,
    (_, $1, $2) => ($1 || $2) || `\r\t\x1D`
  );

const markSeparator = code => code
  .replace(
    /(`[^`\r\n]*`)|(?<!\\)([\{\(])|(?<!\\)([\}\)])/g,
    (_, $1, $2, $3) => $1 || ($2 && '[') || ($3 && ']')
  )
  .replace(
    /(`[^`\r\n]*`)|(?<!\\)(\[)|(?<!\\)(\])/g,
    (_, $1, $2, $3) => $1 || ($2 && '\x1D[ ') || ($3 && ' ]\x1D')
  )
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|( +[:\#\,\?\~\+\-\*\/\^\|\;\&\<\=\>\!\%\'\@]+ +)/g,
    (_, $1, $2, $3) => ($1 || $2) || `\x1F${$3}\x1F`
  );

const clean = tokens => tokens
  .map( t => Array.isArray(t) ? clean(t) : t )
  .filter( t => t.length > 0);

module.exports = code => clean (
  markSeparator( procBlock( procUnary( prepare(code) ) ) ).split('\r')
  .map(
    line => line.split('\x1D')
    .map(
      unit => unit.split('\x1F')
    )
  )
);
