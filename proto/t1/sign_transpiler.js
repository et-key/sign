/**
 * Sign言語 → JavaScript トランスパイラ
 * ASCII制御文字ベース実装（正規表現最小化）
 * 修正版: バックスラッシュと制御文字の処理を改善
 */

'use strict';

// 制御文字の定義
const CTRL = {
  STX: '\x02',  // 文字列開始マーカー
  ETX: '\x03',  // 文字列終了マーカー
  EOT: '\x04',  // 文字保護開始
  ENQ: '\x05',  // 文字保護終了
  ACK: '\x06',  // 数値リテラル保護
  BEL: '\x07',  // 数値リテラル終了
  BS:  '\x08',  // 識別子保護
  HT:  '\x09',  // 識別子終了（本来のタブ文字と競合しないよう注意）
  LF:  '\x0A',  // 改行（そのまま使用）
  VT:  '\x0B',  // 予約
  FF:  '\x0C',  // 予約
  CR:  '\x0D',  // キャリッジリターン
  SO:  '\x0E',  // 予約
  SI:  '\x0F',  // 予約
  GS:  '\x1D',  // ブロック区切り（lexer.jsと同じ）
  US:  '\x1F',  // 単位区切り（lexer.jsと同じ）
};

// =====================================
// 1. 文字列・文字の保護
// =====================================

/**
 * バッククォート文字列を制御文字で保護
 * `Hello World` → \x02Hello World\x03
 * 
 * 重要: 
 * - 文字列内のバックスラッシュはそのまま保持
 * - 文字列は改行をまたげない（Sign言語の仕様）
 */
function protectStrings(code) {
  let result = '';
  let i = 0;
  
  while (i < code.length) {
    if (code[i] === '`') {
      // 文字列開始
      let start = i + 1;
      let end = start;
      
      // 次のバッククォートまたは改行を探す
      while (end < code.length && code[end] !== '`' && code[end] !== '\n') {
        end++;
      }
      
      // 文字列内容を制御文字で囲む（内容はそのまま）
      const content = code.slice(start, end);
      result += CTRL.STX + content + CTRL.ETX;
      
      // 閉じバッククォートがあればスキップ、改行の場合はそのまま
      if (end < code.length && code[end] === '`') {
        i = end + 1; // 閉じバッククォートの次へ
      } else {
        i = end; // 改行の位置（改行自体は次のループで処理）
      }
    } else {
      result += code[i];
      i++;
    }
  }
  
  return result;
}

/**
 * バックスラッシュ文字を制御文字で保護
 * \n → \x04n\x05
 * 
 * 重要: 文字列マーカー（STX/ETX）の内側では処理しない
 */
function protectChars(code) {
  let result = '';
  let i = 0;
  
  while (i < code.length) {
    // 文字列マーカー内はスキップ
    if (code[i] === CTRL.STX) {
      // ETXまでそのままコピー
      result += code[i];
      i++;
      while (i < code.length && code[i] !== CTRL.ETX) {
        result += code[i];
        i++;
      }
      if (i < code.length) {
        result += code[i]; // ETX
        i++;
      }
      continue;
    }
    
    // バックスラッシュ処理（文字列外のみ）
    if (code[i] === '\\' && i + 1 < code.length) {
      // 次の1文字を保護
      result += CTRL.EOT + code[i + 1] + CTRL.ENQ;
      i += 2;
    } else {
      result += code[i];
      i++;
    }
  }
  
  return result;
}

// =====================================
// 2. ASCII範囲判定（正規表現不要）
// =====================================

function isDigit(char) {
  const code = char.charCodeAt(0);
  return code >= 0x30 && code <= 0x39; // '0' ~ '9'
}

function isAlpha(char) {
  const code = char.charCodeAt(0);
  return (code >= 0x41 && code <= 0x5A) || // 'A' ~ 'Z'
         (code >= 0x61 && code <= 0x7A);   // 'a' ~ 'z'
}

function isAlphaNumeric(char) {
  return isAlpha(char) || isDigit(char) || char === '_';
}

function isWhitespace(char) {
  return char === ' ' || char === '\t' || char === '\n' || char === '\r';
}

function isOperatorChar(char) {
  const operators = ':,?~;|&!<>=+-*/%^\'"@$#()[]{}';
  return operators.includes(char);
}

// =====================================
// 3. トークナイズ（空白とマーカー基準）
// =====================================

/**
 * インデントブロックを制御文字でマーキング
 * ブロック内の改行・タブは削除し、行はセミコロンで区切る
 */
function markBlocks(code) {
  let result = '';
  let i = 0;
  
  while (i < code.length) {
    // 文字列/文字マーカー内はそのまま
    if (code[i] === CTRL.STX) {
      // ETXまでコピー
      while (i < code.length) {
        result += code[i];
        if (code[i] === CTRL.ETX) {
          i++;
          break;
        }
        i++;
      }
      continue;
    }
    
    if (code[i] === CTRL.EOT) {
      // ENQまでコピー
      while (i < code.length) {
        result += code[i];
        if (code[i] === CTRL.ENQ) {
          i++;
          break;
        }
        i++;
      }
      continue;
    }
    
    // 改行 + タブのパターン検出（ブロック開始）
    if (code[i] === '\n' && i + 1 < code.length && code[i + 1] === '\t') {
      result += CTRL.GS; // ブロック開始マーク
      i++; // \n をスキップ
      
      // ブロック内容を処理
      let blockEnded = false;
      while (i < code.length) {
        // タブは無視
        if (code[i] === '\t') {
          i++;
          continue;
        }
        
        // 改行の処理
        if (code[i] === '\n') {
          // 次の行もインデントされているかチェック
          if (i + 1 < code.length && code[i + 1] === '\t') {
            // ブロック継続 - 改行を区切り文字に変換
            result += ';'; // 行区切り
            i++;
            continue;
          } else {
            // ブロック終了
            result += CTRL.GS;
            blockEnded = true;
            i++;
            break;
          }
        }
        
        // 通常の文字
        result += code[i];
        i++;
      }
      
      // ファイル末尾でブロックが終わる場合
      if (!blockEnded) {
        result += CTRL.GS;
      }
    } else {
      result += code[i];
      i++;
    }
  }
  
  return result;
}

/**
 * コードを文に分割（ブロック構造を保持）
 */
function splitStatements(code) {
  const statements = [];
  let current = '';
  let inBlock = false;
  
  for (let i = 0; i < code.length; i++) {
    if (code[i] === CTRL.GS) {
      inBlock = !inBlock;
      current += code[i];
    } else if (code[i] === '\n' && !inBlock) {
      if (current.trim().length > 0) {
        statements.push(current.trim());
      }
      current = '';
    } else {
      current += code[i];
    }
  }
  
  if (current.trim().length > 0) {
    statements.push(current.trim());
  }
  
  return statements;
}

/**
 * 1行をトークンに分割
 * 制御文字で保護された部分はそのまま1トークンとして扱う
 */
function tokenizeLine(line) {
  const tokens = [];
  let i = 0;
  let currentToken = '';
  
  while (i < line.length) {
    const char = line[i];
    
    // 文字列マーカー検出
    if (char === CTRL.STX) {
      if (currentToken.length > 0) {
        tokens.push(currentToken);
        currentToken = '';
      }
      
      // ETXまで読み取り
      let content = CTRL.STX;
      i++;
      while (i < line.length && line[i] !== CTRL.ETX) {
        content += line[i];
        i++;
      }
      content += CTRL.ETX;
      tokens.push(content);
      i++;
      continue;
    }
    
    // 文字マーカー検出
    if (char === CTRL.EOT) {
      if (currentToken.length > 0) {
        tokens.push(currentToken);
        currentToken = '';
      }
      
      // ENQまで読み取り
      let content = CTRL.EOT;
      i++;
      while (i < line.length && line[i] !== CTRL.ENQ) {
        content += line[i];
        i++;
      }
      content += CTRL.ENQ;
      tokens.push(content);
      i++;
      continue;
    }
    
    // 空白でトークン区切り
    if (isWhitespace(char)) {
      if (currentToken.length > 0) {
        tokens.push(currentToken);
        currentToken = '';
      }
      i++;
      continue;
    }
    
    // 演算子は単独トークン（複数文字演算子は後で結合）
    if (isOperatorChar(char)) {
      if (currentToken.length > 0) {
        tokens.push(currentToken);
        currentToken = '';
      }
      
      // 複数文字演算子のチェック
      if (i + 1 < line.length) {
        const twoChar = char + line[i + 1];
        if (['<=', '>=', '==', '!=', '<<', '>>', '||', ';;', '&&', '!!', '~+', '~-', '~*', '~/', '~^'].includes(twoChar)) {
          tokens.push(twoChar);
          i += 2;
          continue;
        }
      }
      
      tokens.push(char);
      i++;
      continue;
    }
    
    // 通常の文字（識別子・数値）
    currentToken += char;
    i++;
  }
  
  if (currentToken.length > 0) {
    tokens.push(currentToken);
  }
  
  return tokens;
}

// =====================================
// 4. match_case検出とswitch変換
// =====================================

/**
 * 文からmatch_case構造を検出
 * パターン: 引数リスト ? \x1D条件:返値;条件:返値;...\x1D
 */
function detectAndConvertMatchCase(statement) {
  // ? を含むか確認
  if (!statement.includes('?')) return null;
  
  // ブロックマーカーを含むか確認
  if (!statement.includes(CTRL.GS)) return null;
  
  // ブロック開始位置を探す
  const blockStart = statement.indexOf(CTRL.GS);
  const blockEnd = statement.lastIndexOf(CTRL.GS);
  
  if (blockStart === -1 || blockEnd === -1 || blockStart === blockEnd) return null;
  
  // 引数部分（ブロック開始前）
  const beforeBlock = statement.substring(0, blockStart);
  const tokens = tokenizeLine(beforeBlock);
  const lambdaIndex = tokens.findIndex(t => t === '?');
  
  if (lambdaIndex === -1) return null;
  
  // 定義名と引数リストを分離
  let defName = null;
  let paramsStart = 0;
  
  // : がある場合、それより前が定義名
  const colonIndex = tokens.findIndex(t => t === ':');
  if (colonIndex !== -1 && colonIndex < lambdaIndex) {
    defName = tokens.slice(0, colonIndex).filter(t => 
      t && t.length > 0 && isAlphaNumeric(t[0])
    )[0];
    paramsStart = colonIndex + 1;
  }
  
  // 引数リスト (: の後から ? の前まで)
  const params = tokens.slice(paramsStart, lambdaIndex).filter(t => 
    t && t.length > 0 && isAlphaNumeric(t[0])
  );
  
  // ブロック内容（セミコロン区切り）
  const blockContent = statement.substring(blockStart + 1, blockEnd);
  const lines = blockContent.split(';').map(l => l.trim()).filter(l => l.length > 0);
  
  // 各行を解析
  const cases = [];
  let defaultCase = null;
  
  for (const line of lines) {
    const colonIndex = line.indexOf(':');
    
    if (colonIndex === -1) {
      // : がない = デフォルトケース
      const lineTokens = tokenizeLine(line).map(restoreToken);
      defaultCase = lineTokens.join(' ');
    } else {
      // 条件 : 返値
      const condPart = line.substring(0, colonIndex).trim();
      const returnPart = line.substring(colonIndex + 1).trim();
      
      const condTokens = tokenizeLine(condPart).map(restoreToken);
      const returnTokens = tokenizeLine(returnPart).map(restoreToken);
      
      cases.push({
        condition: condTokens.join(' '),
        returnValue: returnTokens.join(' ')
      });
    }
  }
  
  if (cases.length === 0) return null;
  
  return { defName, params, cases, defaultCase };
}

/**
 * match_case構造をJavaScript switch文に変換
 */
function convertMatchCaseToSwitch(matchCase) {
  const { defName, params, cases, defaultCase } = matchCase;
  
  // カリー化された関数定義
  const arrowChain = params.map(p => `${p} =>`).join(' ');
  
  // switch文の構築
  let switchBody = 'switch (true) {\n';
  
  cases.forEach(c => {
    // 比較演算子を===に変換
    let condition = c.condition.replace(/\s=\s/g, ' === ');
    switchBody += `    case ${condition}: return ${c.returnValue};\n`;
  });
  
  if (defaultCase) {
    switchBody += `    default: return ${defaultCase};\n`;
  }
  
  switchBody += '  }';
  
  const funcBody = `${arrowChain} {\n  ${switchBody}\n}`;
  
  return defName ? `const ${defName} = ${funcBody}` : funcBody;
}

// =====================================
// 5. 基本的な演算子変換
// =====================================

/**
 * 累乗演算子を変換
 * x ^ y → Math.pow(x, y)
 */
function convertPowerOperator(tokens) {
  const result = [];
  let i = 0;
  
  while (i < tokens.length) {
    if (tokens[i] === '^' && i > 0 && i < tokens.length - 1) {
      // 直前のトークンを取得（既に結果に追加済みなので削除）
      const left = result.pop();
      const right = tokens[i + 1];
      
      result.push(`Math.pow(${left}, ${right})`);
      i += 2;
    } else {
      result.push(tokens[i]);
      i++;
    }
  }
  
  return result;
}

/**
 * 比較演算子を値返却型に変換
 * x < y → (x < y ? x : undefined)
 */
function convertComparisonOperators(tokens) {
  const comparisons = ['<', '<=', '=', '==', '>=', '>', '!='];
  const result = [];
  let i = 0;
  
  while (i < tokens.length) {
    if (comparisons.includes(tokens[i]) && i > 0 && i < tokens.length - 1) {
      const left = result.pop();
      const op = tokens[i] === '=' ? '===' : tokens[i];
      const right = tokens[i + 1];
      
      result.push(`(${left} ${op} ${right} ? ${left} : undefined)`);
      i += 2;
    } else {
      result.push(tokens[i]);
      i++;
    }
  }
  
  return result;
}

/**
 * 定義演算子を変換
 * x : value → const x = value
 */
function convertDefineOperator(tokens) {
  const colonIndex = tokens.indexOf(':');
  if (colonIndex === -1 || colonIndex === 0) return tokens;
  
  const identifier = tokens[0];
  const value = tokens.slice(colonIndex + 1).join(' ');
  
  return ['const', identifier, '=', value];
}

// =====================================
// 6. リテラル復元
// =====================================

/**
 * 制御文字で保護された文字列をJavaScript記法に復元
 * \x02Hello World\x03 → "Hello World"
 * 
 * 文字列内のバックスラッシュは適切にエスケープ
 */
function restoreStrings(code) {
  let result = '';
  let i = 0;
  
  while (i < code.length) {
    if (code[i] === CTRL.STX) {
      result += '"';
      i++;
      
      while (i < code.length && code[i] !== CTRL.ETX) {
        // バックスラッシュのエスケープ
        if (code[i] === '\\') {
          result += '\\\\';
        } else if (code[i] === '"') {
          // ダブルクォートもエスケープ
          result += '\\"';
        } else {
          result += code[i];
        }
        i++;
      }
      
      result += '"';
      i++; // ETXをスキップ
    } else {
      result += code[i];
      i++;
    }
  }
  
  return result;
}

/**
 * エスケープシーケンスのマッピング
 */
const ESCAPE_SEQUENCES = {
  'n': '\\n',   // 改行
  't': '\\t',   // タブ
  'r': '\\r',   // キャリッジリターン
  '\\': '\\\\', // バックスラッシュ
  '0': '\\0',   // ヌル文字
  'b': '\\b',   // バックスペース
  'f': '\\f',   // フォームフィード
  'v': '\\v',   // 垂直タブ
};

/**
 * 制御文字で保護された文字をJavaScript記法に復元
 * \x04n\x05 → "\\n"  (エスケープシーケンスとして)
 * \x04M\x05 → "M"    (通常の文字として)
 */
function restoreChars(code) {
  let result = '';
  let i = 0;
  
  while (i < code.length) {
    if (code[i] === CTRL.EOT) {
      i++;
      
      if (i < code.length && code[i] !== CTRL.ENQ) {
        const char = code[i];
        
        // エスケープシーケンスかどうか判定
        if (ESCAPE_SEQUENCES[char]) {
          result += `"${ESCAPE_SEQUENCES[char]}"`;
        } else {
          // 通常の文字
          result += `"${char}"`;
        }
        
        i++;
      }
      
      if (i < code.length && code[i] === CTRL.ENQ) {
        i++;
      }
    } else {
      result += code[i];
      i++;
    }
  }
  
  return result;
}

/**
 * 残存する全ての制御文字を除去
 */
function removeControlCharacters(code) {
  let result = '';
  
  for (let i = 0; i < code.length; i++) {
    const charCode = code.charCodeAt(i);
    
    // 制御文字（0x00-0x1F）を除外、ただし改行（0x0A）とタブ（0x09）は保持
    if (charCode >= 0x00 && charCode <= 0x1F && charCode !== 0x0A && charCode !== 0x09) {
      // 制御文字はスキップ
      continue;
    }
    
    result += code[i];
  }
  
  return result;
}

/**
 * 1つのトークンから制御文字を復元
 */
function restoreToken(token) {
  // 文字列マーカーの処理
  if (token.startsWith(CTRL.STX) && token.endsWith(CTRL.ETX)) {
    const content = token.slice(1, -1);
    // バックスラッシュとダブルクォートをエスケープ
    const escaped = content.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
    return `"${escaped}"`;
  }
  
  // 文字マーカーの処理
  if (token.startsWith(CTRL.EOT) && token.endsWith(CTRL.ENQ)) {
    const char = token.slice(1, -1);
    
    // エスケープシーケンスかどうか判定
    if (ESCAPE_SEQUENCES[char]) {
      return `"${ESCAPE_SEQUENCES[char]}"`;
    } else {
      return `"${char}"`;
    }
  }
  
  // 通常のトークン
  return token;
}

// =====================================
// 7. メイントランスパイラ
// =====================================

/**
 * Sign言語コードをJavaScriptに変換
 */
function transpile(signCode) {
  // Phase 1: リテラル保護
  let code = signCode;
  code = protectStrings(code);
  code = protectChars(code);
  
  // Phase 2: ブロック構造をマーキング
  code = markBlocks(code);
  
  // Phase 3: 文ごとに処理
  const statements = splitStatements(code);
  const jsLines = [];
  
  for (const statement of statements) {
    // match_case検出と変換
    const matchCase = detectAndConvertMatchCase(statement);
    if (matchCase) {
      jsLines.push(convertMatchCaseToSwitch(matchCase));
      continue;
    }
    
    // トークナイズ
    let tokens = tokenizeLine(statement);
    
    // 演算子変換
    tokens = convertPowerOperator(tokens);
    tokens = convertComparisonOperators(tokens);
    tokens = convertDefineOperator(tokens);
    
    // トークンを復元してから結合
    tokens = tokens.map(restoreToken);
    
    // 行を再構築
    jsLines.push(tokens.join(' '));
  }
  
  // Phase 4: 最終整形（文字列と文字は既に復元済み）
  let result = jsLines.join(';\n') + ';';
  
  // Phase 5: 残存制御文字の除去
  result = removeControlCharacters(result);
  
  return result;
}

// =====================================
// 8. エクスポート
// =====================================

module.exports = {
  transpile,
  protectStrings,
  protectChars,
  markBlocks,
  tokenizeLine,
  detectAndConvertMatchCase,
  convertMatchCaseToSwitch,
  restoreStrings,
  restoreChars,
  removeControlCharacters,
  CTRL
};