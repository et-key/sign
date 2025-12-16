/*
================================================================================
Sign言語 演算子定義
================================================================================
演算子表（A_Operator_Table.md）の完全実装版

優先順位の原則:
- 数値が小さいほど優先順位が低い（後から評価される）
- 同じ優先順位内では結合性に従う
  ※印 = 右結合（right associative）
  無印 = 左結合（left associative）

空白演算子について:
- 優先順位4,5,6の空白演算子は型推論によって意味が決定される
- lexerでは分割せず、型解析段階で以下のように振り分ける:
  + 優先順位4: apply (関数 + 値 → 関数適用)
  + 優先順位5: compose (関数 + 関数 → 関数合成)
  + 優先順位6: push/concat/construct (リスト操作)

================================================================================
演算子表（A_Operator_Table.md準拠）
================================================================================

| 優先順位 | 記号 | 位置 | 機能 | 自然な意味 | 操作的意味論 |
| 1 | `#` | 前置 | export | ハッシュタグ（公開・発見可能） | 名前を外部から発見可能にする |
| 2 | `:` | 中置※ | define | 即ち（同一視） | 左辺の名前を右辺の値に束縛 |
| 3 | `#` | 中置 | output | ハッシュタグ（関連付け） | アドレスにデータを関連付ける |
| 4 | ` ` | 中置 | apply | 余積（連接） | 関数適用 |
| 4 | `,` | 中置※ | product | 積（構造的組み立て） | 右結合なリスト構築 |
| 5 | ` ` | 中置 | compose | 余積（連接） | 左結合な関数合成 |
| 6 | ` ` | 中置 | push | 余積（連接） | リストへ追加 |
| 6 | ` ` | 中置 | concat | 余積（連接） | リスト結合 |
| 6 | ` ` | 中置 | construct | 余積（連接） | 左結合なリスト構築 |
| 7 | `?` | 中置※ | lambda | 問いかけ（どうするか？） | 関数定義 |
| 8 | `~` | 中置 | range | around（範囲のその辺り） | 範囲リスト構築 |
| 8 | `~+` | 中置 | range | around（範囲のその辺り） | 等差数列指定 |
| 8 | `~-` | 中置 | range | around（範囲のその辺り） | 等差逆数列指定 |
| 8 | `~*` | 中置 | range | around（範囲のその辺り） | 等比数列指定 |
| 8 | `~/` | 中置 | range | around（範囲のその辺り） | 等比逆数列指定 |
| 8 | `~^` | 中置 | range | around（範囲のその辺り） | 等冪数列指定 |
| 9 | `~` | 前置 | continuous | around（その辺り一帯） | 連続リスト構築 |
| 10 | `;` | 中置 | xor | 排他的関係 | 排他的論理和 |
| 10 | `|` | 中置 | or | または（通路） | 論理和（短絡評価） |
| 11 | `&` | 中置 | and | かつ（結合） | 論理積（短絡評価） |
| 12 | `!` | 前置 | not | 否定 | 論理否定 |
| 13 | `<` | 中置 | less | より小さい | 比較演算 |
| 13 | `<=` | 中置 | less_equal | 以下 | 比較演算 |
| 13 | `=` | 中置 | equal | 等しい | 比較演算 |
| 13 | `==` | 中置 | equal | 等しい | 比較演算 |
| 13 | `>=` | 中置 | more_equal | 以上 | 比較演算 |
| 13 | `>` | 中置 | more | より大きい | 比較演算 |
| 13 | `!=` | 中置 | not_equal | 等しくない | 比較演算 |
| 14 | `+` | 中置 | add | 加法 | 算術演算 |
| 14 | `-` | 中置 | sub | 減法 | 算術演算 |
| 15 | `*` | 中置 | mul | 乗法 | 算術演算 |
| 15 | `/` | 中置 | div | 除法 | 算術演算 |
| 15 | `%` | 中置 | mod | 剰余 | 算術演算 |
| 16 | `^` | 中置※ | pow | 冪乗 | 指数演算 |
| 17 | `!` | 後置 | factorial | 階乗 | 階乗演算 |
| 18 | `|_|` | 囲み | abs | 絶対値 | 絶対値演算 |
| 19 | `~` | 後置 | expand | around（周辺に広げる） | 展開 |
| 20 | `$` | 前置 | address | お金（価値の抽象化） | アドレス取得 |
| 21 | `'` | 中置 | get | 所有格（'s のs省略） | 構造から値を取得 |
| 21 | `@` | 中置 | get | at（〜において） | 構造から値を取得 |
| 22 | `@` | 前置 | input | at（〜において） | アドレスからデータを取得 |
| 23 | `<<` | 中置 | left_shift | 左ビットシフト | 左ビットシフト |
| 23 | `>>` | 中置 | right_shift | 右ビットシフト | 右ビットシフト |
| 24 | `||` | 中置 | bit_or | ビットマスク | ビット毎の論理和 |
| 25 | `;;` | 中置 | bit_xor | ビットマスク | ビット毎の排他的論理和 |
| 26 | `&&` | 中置 | bit_and | ビットマスク | ビット毎の論理積 |
| 27 | `!!` | 前置 | bit_not | ビット反転 | ビット毎の否定 |
| 28 | `@` | 後置 | import | at（〜から） | ファイルから取得 |
| 29 | `(...)` | 囲み | block | ブロック | インラインブロック構築 |
| 29 | `{...}` | 囲み | block | ブロック | インラインブロック構築 |
| 29 | `[...]` | 囲み | block | ブロック | インラインブロック構築 |
| 29 | `\t` | 前置 | indent | インデント | インデントブロック構築 |

================================================================================
*/

const OperatorSemantics = {
    prefix: {
        '#': 'export',
        '~': 'continuous',
        '!': 'not',
        '$': 'address',
        '@': 'input',
        '!!': 'bit_not',
        '\t': 'indent'
    },
    infix: {
        ':': 'define',
        '#': 'output',
        lambda_list: 'apply',
        ',': 'product',
        lambda_lambda: 'compose',
        list_list: 'concat',
        literal_list: 'push_left',
        list_literal: 'push_right',
        literal_literal: 'construct',
        '?': 'lambda_construct',
        '~': 'range',
        '~+': 'increase_range',
        '~-': 'decrease_range',
        '~*': 'geometric_range',
        '~/': 'divisionic_range',
        '~^': 'exponentialy_range',
        '|': 'or',
        ';': 'xor',
        '&': 'and',
        '<': 'less',
        '<=': 'less_equal',
        '=': 'equal',
        '==': 'equal',
        '>=': 'more_equal',
        '>': 'more',
        '!=': 'not_equal',
        '+': 'add',
        '-': 'sub',
        '*': 'mul',
        '/': 'div',
        '%': 'mod',
        '^': 'pow',
        "'": 'get',
        '@': 'get',
        '<<': 'left_shift',
        '>>': 'right_shift',
        '||': 'bit_or',
        ';;': 'bit_xor',
        '&&': 'bit_and'
    },
    postfix: {
        '!': 'factorial',
        '~': 'expand',
        '@': 'import'
    },
    surround: {
        '|_|': 'abs'
    }
};

const OperatorPriority = {
    prefix: {
        '#': 1,
        '~': 9,
        '!': 12,
        '$': 20,
        '@': 22,
        '!!': 27,
        '\t': 29
    },
    infix: {
        ':': 2,
        '#': 3,
        ',': 4,
        lambda_list: 4,
        lambda_lambda: 5,
        list_list: 6,
        literal_list: 6,
        list_literal: 6,
        literal_literal: 6,
        '?': 7,
        '~': 8,
        '~+': 8,
        '~-': 8,
        '~*': 8,
        '~/': 8,
        '~^': 8,
        ';': 10,
        '|': 10,
        '&': 11,
        '<': 13,
        '<=': 13,
        '=': 13,
        '==': 13,
        '>=': 13,
        '>': 13,
        '!=': 13,
        '+': 14,
        '-': 14,
        '*': 15,
        '/': 15,
        '%': 15,
        '^': 16,
        "'": 21,
        '@': 21,
        '<<': 23,
        '>>': 23,
        '||': 24,
        ';;': 25,
        '&&': 26
    },
    postfix: {
        '!': 17,
        '~': 19,
        '@': 28
    },
    surround: {
        '|_|': 18
    }
};

// ====================================================================
// 優先順位と結合性を含む統合演算子リスト（パーサー用）
// ====================================================================
// precedence: 優先順位（数値が小さいほど優先順位が低い）
// associativity: 'left' = 左結合、'right' = 右結合

const OperatorList = [
    // 優先順位2: 定義演算子（右結合）
    { ':': { precedence: 2, associativity: 'right' } },

    // 優先順位3: 出力演算子（左結合）
    { '#': { precedence: 3, associativity: 'left' } },

    // 優先順位4: 積演算子（右結合）
    { ',': { precedence: 4, associativity: 'right' } },

    // 優先順位1: ラムダ構築演算子（右結合） - Define(:) より低くすることで match_case(:) を内包する
    { '?': { precedence: 1, associativity: 'right' } },

    // 優先順位8: 範囲演算子（左結合）
    { '~': { precedence: 8, associativity: 'left' } },
    { '~+': { precedence: 8, associativity: 'left' } },
    { '~-': { precedence: 8, associativity: 'left' } },
    { '~*': { precedence: 8, associativity: 'left' } },
    { '~/': { precedence: 8, associativity: 'left' } },
    { '~^': { precedence: 8, associativity: 'left' } },

    // 優先順位10: 論理演算（XOR, OR）（左結合）
    { ';': { precedence: 10, associativity: 'left' } },
    { '|': { precedence: 10, associativity: 'left' } },

    // 優先順位11: 論理積（AND）（左結合）
    { '&': { precedence: 11, associativity: 'left' } },

    // 優先順位13: 比較演算（左結合）
    { '<': { precedence: 13, associativity: 'left' } },
    { '<=': { precedence: 13, associativity: 'left' } },
    { '=': { precedence: 13, associativity: 'left' } },
    { '==': { precedence: 13, associativity: 'left' } },
    { '>=': { precedence: 13, associativity: 'left' } },
    { '>': { precedence: 13, associativity: 'left' } },
    { '!=': { precedence: 13, associativity: 'left' } },

    // 優先順位14: 加減算（左結合）
    { '+': { precedence: 14, associativity: 'left' } },
    { '-': { precedence: 14, associativity: 'left' } },

    // 優先順位15: 乗除算（左結合）
    { '*': { precedence: 15, associativity: 'left' } },
    { '/': { precedence: 15, associativity: 'left' } },
    { '%': { precedence: 15, associativity: 'left' } },

    // 優先順位16: 冪乗（右結合）
    { '^': { precedence: 16, associativity: 'right' } },

    // 優先順位21: アクセス演算子（左結合・右結合）
    { "'": { precedence: 21, associativity: 'left' } },
    { '@': { precedence: 21, associativity: 'right' } },

    // 優先順位23: ビットシフト（左結合）
    { '<<': { precedence: 23, associativity: 'left' } },
    { '>>': { precedence: 23, associativity: 'left' } },

    // 優先順位24: ビット論理和（左結合）
    { '||': { precedence: 24, associativity: 'left' } },

    // 優先順位25: ビット排他的論理和（左結合）
    { ';;': { precedence: 25, associativity: 'left' } },

    // 優先順位26: ビット論理積（左結合）
    { '&&': { precedence: 26, associativity: 'left' } }
];

// ====================================================================
// 演算子の高速検索用マップ
// ====================================================================
const OperatorMap = new Map(
    OperatorList.map(obj => Object.entries(obj)[0])
);

// ====================================================================
// ヘルパー関数
// ====================================================================

/**
 * トークンが中置演算子かどうかを判定
 * @param {string} token - 判定対象のトークン
 * @returns {boolean} 中置演算子ならtrue
 */
const isInfixOperator = token => OperatorMap.has(token);

/**
 * 演算子の優先順位と結合性の情報を取得
 * @param {string} token - 演算子トークン
 * @returns {Object|undefined} { precedence: 優先順位, associativity: 結合性 }
 */
const getOperatorInfo = token => OperatorMap.get(token);

/**
 * ブロック演算子（:または?）かどうかを判定
 * これらの演算子の後に続く配列要素はブロック本体として扱われる
 * @param {string} token - 判定対象のトークン
 * @returns {boolean} ブロック演算子ならtrue
 */
const isBlockOperator = token => token === ':' || token === '?';

/**
 * 前置演算子かどうかを判定
 * @param {string} token - 判定対象のトークン
 * @returns {boolean} 前置演算子ならtrue
 */
const isPrefixOperator = token => OperatorPriority.prefix.hasOwnProperty(token);

/**
 * 後置演算子かどうかを判定
 * @param {string} token - 判定対象のトークン
 * @returns {boolean} 後置演算子ならtrue
 */
const isPostfixOperator = token => OperatorPriority.postfix.hasOwnProperty(token);

// ====================================================================
// エクスポート
// ====================================================================
module.exports = {
    OperatorSemantics,
    OperatorPriority,
    OperatorList,
    OperatorMap,
    // ヘルパー関数
    isInfixOperator,
    getOperatorInfo,
    isBlockOperator,
    isPrefixOperator,
    isPostfixOperator
};