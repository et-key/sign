//変更禁止

// 入力コードを正規化する

const prepare = code => code
  .replace(/[\x00-\x08\x0B\x0C\x0E-\x1F\x7F-\x9F\xA0\xAD]/g, '')
  .replace(/^`[^\r\n]*(\r\n|[\r\n])/gm, '')
  .replace(/(\r\n|[\r\n])/g, '\r')                                  // Normalize line endings to \r
  .replace(/\\\r/g, '\\\n')                                       // Escaped \\\r to \\\n


const markSeparator = code => code
  //ブロック内の改行をひとまず区切らないようにする。
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)\r(?<!\\)\t/g,
    (_, $1, $2) => ($1 || $2) || `\n\t` 
  )
  //すべて大括弧に統一、区切り文字を挿入してトークンとする。
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\)([\{\(])|(?<!\\)([\}\)])/g,
    (_, $1, $2, $3, $4) => ($1 || $2) || ($3 && '\x1F[\x1F') || ($4 && '\x1F]\x1F')
  )
  //すべての空白を区切り文字とする。
  .replace(
    /(\\[\s\S])|(`[^`\r\n]*`)|(?<!\\) /g,
    (_, $1, $2, $3) => ($1 || $2) || ($3 && `\x1F`)
  )
;

export default {
  prepare,
  markSeparator
}

