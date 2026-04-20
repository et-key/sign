import * as parser from './sign.js';
import { SemanticAnalyzer } from './semantic_analyzer.js';
import { preprocess } from './preprocessor.js';

export function parseSign(code) {
  const preprocessedCode = preprocess(code);
  const rawAst = parser.parse(preprocessedCode);
  const analyzer = new SemanticAnalyzer();
  const ast = analyzer.analyze(rawAst);
  
  return {
    ast: ast,
    globalEnv: new Set([...analyzer.globalEnv.keys()])
  };
}
