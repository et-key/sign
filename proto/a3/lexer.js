
'use strict';
//((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)) +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*))( +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)))*/g
let infix = require('./operators.js').Priority.infix;



const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(
    /((?<!\\)\\(?:\r\n|[\r\n]))|(`[^\r\n`]*`)|(\r\n|[\r\n])/g,
    (_, $1, $2) => ($1 || $2) || '\r'
  )
  .replace(/^`[^\r]*/gm, '')
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)([\{\(])|(?<!\\)([\}\)])/g,
    (_, $1, $2, $3, $4) => ($1 || $2) || ($3 && '[') || ($4 && ']')
  );


const procBinary = code => code
  .replace(
    /((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)) +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*))( +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)))*/g,
    (_, ...$) => (
    infix[$[y]]
      ? infix[$[x]] === infix[$[y]]
        ? ``
        : infix[$[x]] >= infix[$[y]]
          ? ``
          : ``
      : _
    )      
  );

const procUnary = code => code
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)|([#~!$@])([^\r\t ]+)|([^\r\t ]+)([!~@])|([#~!$@])([^\r\t ]+)([!~@])/g,
    (_, ...$) => ($[0] || $[1]) || (
      $[2]
        ? `\x1F${$[2]}_\x1F${ procUnary($[3]) }\x1F`
        : $[5]
          ? `${ procUnary( $[4] ) }\x1F_${ $[5] }\x1F`
          : $[6] && $[8]
            ? `\x1F_${$[6]}\x1F\x1F${ procUnary($[7]) }\x1F_${ $[8] }\x1F`
            : _
    )
  );

const procBlock = code => code
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)|(?<!\\)\r(?<!\\)\t([^\r]+)/g,
    (_, $1, $2, $3) => ($1 || $2) || `\r\x1D${ procBlock($3) }\x1D`
  )
  .replace(/(\\[\s\S])|(`[^\r`]*`)|\t/g, '$1$2');

const markSeparator = code => code
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)(\[)|(?<!\\)(\])/g,
    (_, $1, $2, $3, $4) => ($1 || $2) || ($3 && '\x1D[\x1F') || ($4 && '\x1F]\x1D')
  )
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|( *\, *)/g,
    ( _, $1, $2, $3) => ($1 || $2) || `\x1E${$3}\x1E`
  )
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)| +([\:\#\,\?\~\+\-\*\/\^\|\;\&\<\=\>\!\%\'\@]+) +/g,
    (_, $1, $2, $3) => ($1 || $2) || `\x1F${$3}\x1F`
  );

const clean = tokens => tokens
  .map( t => Array.isArray(t) ? clean(t) : t )
  .filter( t => t.length > 0 && t !== "[" && t !== "]");

module.exports = code => clean (
  markSeparator( procBlock( procUnary( prepare(code) ) ) ).split('\r')
  .map(
    line => line.split('\x1D')
    .map(
      unit => unit.split('\x1F')
    )
  )
);


/*
*/