import fs from 'fs';

let code = fs.readFileSync('backend/wasm.js', 'utf8');

// 1. Data segment uses i64 for memory64
code = code.replace(/\(data \(i32\.const \$\{offset\}\)/g, '(data (i64.const ${offset})');

// 2. Local variables for pointers and lengths
code = code.replace(/locals\.set\(`__(struct_ptr|current_ptr|struct_len|tmp_ptr|tmp_len|sink_ptr)_\$\{node\.reduceId\}`,\s*'i32'\);/g, 'locals.set(`__$1_${node.reduceId}`, \'i64\');');

// Replace struct allocation pointer math (the multiline ones)
code = code.replace(/i32\.const (\$\{?[^}]*\}?|8)\s*\\n\s*i32\.add/g, 'i64.const $1\\n    i64.add');
code = code.replace(/i32\.const (\$\{?[^}]*\}?|8)\s*\\n\s*i32\.sub/g, 'i64.const $1\\n    i64.sub');
code = code.replace(/i32\.const (\$\{?[^}]*\}?|8)\s*\\n\s*i32\.mul/g, 'i64.const $1\\n    i64.mul');

// In JS template literals:
code = code.replace(/i32\.const (\$\{?[a-zA-Z0-9_*+ ]*\}?|8)`\)/g, 'i64.const $1`)');
code = code.replace(/i32\.add`\)/g, 'i64.add`)');
code = code.replace(/i32\.sub`\)/g, 'i64.sub`)');
code = code.replace(/i32\.mul`\)/g, 'i64.mul`)');
code = code.replace(/i32\.trunc_f64_u`\)/g, 'i64.trunc_f64_u`)');
code = code.replace(/f64\.convert_i32_u`\)/g, 'f64.convert_i64_u`)');
code = code.replace(/i32\.eqz`\)/g, 'i64.eqz`)');
code = code.replace(/i32\.const 0`\)/g, 'i64.const 0`)');

// The sink pointer logic needs f64 -> i64 pointer
// Look for pointer access in `flattenApply` (index operator ' ) and sink operator #
// In flattenApply operator "'":
// leftType === 'f64' ? i32.trunc_f64_s -> i64.trunc_f64_s
code = code.replace(/if \(leftType === 'f64'\) this\.out\.push\(`    i32\.trunc_f64_s`\);/g, 'if (leftType === \'f64\') this.out.push(`    i64.trunc_f64_s`);');
code = code.replace(/if \(rightType === 'f64'\) this\.out\.push\(`    i32\.trunc_f64_s`\);/g, 'if (rightType === \'f64\') this.out.push(`    i64.trunc_f64_s`);');
// scale index
code = code.replace(/i32\.const 3`; \/\/ scale/g, 'i64.const 3`; // scale');
code = code.replace(/i32\.shl`/g, 'i64.shl`');
code = code.replace(/i32\.add`; \/\/ pointer/g, 'i64.add`; // pointer');

// In flattenApply operator "#":
code = code.replace(/if \(ptrType === 'f64'\) this\.out\.push\(`    i32\.trunc_f64_s`\);/g, 'if (ptrType === \'f64\') this.out.push(`    i64.trunc_f64_s`);');

fs.writeFileSync('backend/wasm.js', code);
console.log('Migration completed successfully in place.');
