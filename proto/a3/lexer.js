
'use strict';
//((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)) +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*))( +([^\w\s.`[\]"\\$]+) +((`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)))*/g


/* Regex : Binary operator pattern's structure:
  (
    (`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)
  )
   +
  ([^\w\s.`[\]"\\$]+)
   +
  (
    (`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)
  )
  (
     +
    ([^\w\s.`[\]"\\$]+)
     +
    (
      (`[^\r\n`]*`)|(\\[\s\S])|([#~!$@]*[\w.]+[!~@]*)
    )
  )*
*/



let infix = require('./operators.js').Priority.infix;



const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(
    /((?<!\\)\\(?:\r\n|[\r\n]))|(`[^\r\n`]*`)|(\r\n|[\r\n])/g,
    (_, $1, $2) => ($1 || $2) || '\r'
  )
  .replace(/^`[^\r]*/gm, '')
  .replace(
    /(`[^`\r\n]*`)|(?<!\\)([\{\(])|(?<!\\)([\}\)])/g,
    (_, $1, $2, $3, $4) => ($1 || $2) || ($3 && '[') || ($4 && ']')
  )
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)/g,
    (_, $1, $2) => ($1 || $2) ? `\x1E${ $1 || $2 }\x1E` : _
  );

const procBinary = code => code
  .replace(
    /((\x1E[^\x1E]+\x1E)|([#~!$@]*[\w.]+[!~@]*))( +([^\w\s.`[\]"\\$]+) +([^\r]+))+\r/g,
    (_, ...$) => (
    infix[$[10]]
      ? infix[$[4]] === infix[$[10]]
        ? ``
        : infix[$[4]] >= infix[$[10]]
          ? ``
          : ``
      : _
    )      
  );

const procUnary = code => code
  .replace(
    /(\x1E[^\x1E]+\x1E)|([#~!$@])([^\r\t ]+)|([^\r\t ]+)([!~@])|([#~!$@])([^\r\t ]+)([!~@])/g,
    (_, ...$) => {
      switch (true) {
        case !!$[0]:
          return $[0];

        case !!$[1] && !!$[2]:
          return `\x1D[\x1F${$[1]}_\x1F${ procUnary($[2]) }\x1F]\x1D`;

        case !!$[3] && !!$[4]:
          return `\x1D[\x1F${ procUnary( $[3] ) }\x1F_${ $[4] }\x1F]\x1D`;

        case !!$[5] && !!$[6] && !!$[7]:
          return `\x1D[\x1F_${$[5]}\x1F\x1F${ procUnary($[6]) }\x1F_${ $[7] }\x1F]\x1D`;

        default:
          return _;
      }
    }
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
