/**
 * Sign Language Parser Module (alpha/javascript)
 * 
 * 仕様書: documents/ja-jp/impl/syntax/grammar.pegjs
 * 生成済み自立型パーサー pre_alpha/parse/minimal.js を組み込んで
 * 外部依存なしで高速に AST を生成します。
 */

import { parse as peggyParse } from '../../../pre_alpha/parse/minimal.js';

export function parse(input) {
  return peggyParse(input);
}
