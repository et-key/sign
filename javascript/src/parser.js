const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(/^`[^\r\n]*(\r\n|[\r\n])/gm, '')
  .replace(
    /(\r\n|[\r\n])/g, '\r'                                  // Normalize line endings to \r
  )
  .replace(
    /\\\r/g, '\\\n'                                       // Escaped \\\r to \\\n 
  )

const procUnary = code => code
  .replace(
    /(\\[\s\S])|(`[^\r\n`]*`)|([#~!$@]+)([^\r\t#~!$@ ]+)([!~@]+)/g,
    (_, $1, $2, $3, $4, $5) => ($1 || $2) || (
      $3 && $5
        ? `${$3}_\x1F ${ procUnary($4) } \x1F_${$5}`
        : $3 ? `${$3}_\x1F ${ procUnary($4) }` : `${ procUnary($4) }\x1F _${$5}`
    )
  )

const markSeparator = code => code
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)\r(?<!\\)\t/g,
    (_, $1, $2) => ($1 || $2) || `\n\t`
  )
  .replace(
    /(`[^`\r\n]*`)|(?<!\\)([\{\(])|(?<!\\)([\}\)])/g,
    (_, $1, $2, $3) => $1 || ($2 && '[') || ($3 && ']')
  )
  .replace(
    /(`[^`\r\n]*`)|(?<!\\)(\[)|(?<!\\)(\])/g,
    (_, $1, $2, $3) => $1 || ($2 && '\x1D[') || ($3 && ']\x1D')
  )
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|( +[:\#\,\?\~\+\-\*\/\^\|\;\&\<\=\>\!\%\'\@]+ +)/g,
    (_, $1, $2, $3) => ($1 || $2) || `\x1F${$3}\x1F`
  )
;

const tokenize = code => markSeparator( procUnary( prepare(code) ).split('\r'))
  .map(
    line => line.split('\x1D')
    .map(
      unit => unit.split('\x1F')
    )
  )

