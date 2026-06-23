/**
 * wasm_codegen.js
 * 
 * Translates resolved Sign AST to WebAssembly Text Format (WAT) for wasm64.
 * - Pointers/Addresses/TypePrefix (0x, 0u) are i64.
 * - Structs are aligned on 8-byte boundaries in linear memory.
 */
import { inferType } from '../semanticize/ast_helpers.js';

let memoryOffset = 0;
const memoryMap = new Map(); // name -> baseAddress
const structFields = new Map(); // structName -> { fieldName -> { offset, type } }
const stringMap = new Map(); // stringVal -> address
let stringOffset = 1024; // String constants start at 1024

const globalEnv = new Map();
const watGlobals = [];
const watFunctions = [];
const watDataSections = [];
let mainInstructions = [];
let currentEnv = null;

let lambdaCounter = 0;
let rangeCounter = 0;
const mainLocals = new Map();
const tableFunctions = [];
const functionArities = new Map();
const functionHasRest = new Map();

function getOperatorVarName(op) {
  const operatorVarNames = {
    '+': 'op_add',
    '-': 'op_sub',
    '*': 'op_mul',
    '/': 'op_div',
    '|': 'op_or',
    '|/': 'op_or_div',
  };
  if (operatorVarNames[op]) return operatorVarNames[op];
  const charMap = {
    '+': 'add', '-': 'sub', '*': 'mul', '/': 'div', '%': 'mod', '^': 'pow',
    '=': 'eq', '<': 'lt', '>': 'gt', '|': 'or', '&': 'and', ';': 'xor',
    '!': 'not', '~': 'range', '@': 'at', '#': 'hash', '?': 'question',
    ':': 'colon', "'": 'quote'
  };
  let name = 'op';
  for (const char of op) {
    name += '_' + (charMap[char] || char.charCodeAt(0).toString(16));
  }
  return name;
}

function doubleToRawBits(val) {
  const buffer = new ArrayBuffer(8);
  new Float64Array(buffer)[0] = val;
  const view = new DataView(buffer);
  return view.getBigInt64(0, true).toString();
}

function isStaticListType(node, locals = new Map(), paramNames = []) {
  if (!node) return false;

  if (typeof node === 'string') {
    if (node.startsWith('`') && node.endsWith('`')) {
      return true;
    }
    const cleanNode = getLHSName(node);
    if (paramNames.includes(cleanNode)) {
      if (locals.get(cleanNode) === 'list') {
        return true;
      }
    }
    if (locals.has(cleanNode) && locals.get(cleanNode) === 'list') {
      return true;
    }
    if (structFields.has(cleanNode)) {
      return true;
    }
    return false;
  }

  if (node.type === 'coproduct_block') {
    return true;
  }

  if (node.type === 'block') {
    if (node.kind === 'bracket') {
      return true;
    }
    return isStaticListType(node.content, locals, paramNames);
  }

  if (node.type === 'operation') {
    if (node.operator === ',') {
      return true;
    }
    if (node.operator === ' ' && node.name === 'concat') {
      return true;
    }
    if (['~', '~+', '~-', '~*', '~/', '~^'].includes(node.operator)) {
      return true;
    }
  }

  return false;
}

function desugarPointFree(node) {
  if (!node) return node;

  if (typeof node === 'string') return node;

  if (node.type === 'block') {
    if (node.kind === 'bracket' && node.content && node.content.type === 'operation' && node.content.operator === ',') {
      const content = node.content;
      if (content.left !== undefined && content.right === undefined) {
        const innerOp = content.left;
        if (innerOp && innerOp.type === 'operation') {
          return desugarPointFree({
            type: 'operation',
            operator: '?',
            left: {
              type: 'operation',
              operator: '~',
              operand: '<_xs>',
              position: 'prefix'
            },
            right: {
              type: 'operation',
              operator: ' ',
              left: '<map>',
              right: {
                type: 'coproduct_block',
                statements: [
                  {
                    type: 'operation',
                    operator: '?',
                    left: '<_x>',
                    right: {
                      type: 'operation',
                      operator: innerOp.operator,
                      left: innerOp.left,
                      right: '<_x>'
                    }
                  },
                  {
                    type: 'operation',
                    operator: '~',
                    operand: '<_xs>',
                    position: 'postfix'
                  }
                ]
              },
              name: 'apply'
            }
          });
        }
      }
      if (content.right !== undefined && content.left === undefined) {
        const innerOp = content.right;
        if (innerOp && innerOp.type === 'operation') {
          return desugarPointFree({
            type: 'operation',
            operator: '?',
            left: {
              type: 'operation',
              operator: '~',
              operand: '<_xs>',
              position: 'prefix'
            },
            right: {
              type: 'operation',
              operator: ' ',
              left: '<map>',
              right: {
                type: 'coproduct_block',
                statements: [
                  {
                    type: 'operation',
                    operator: '?',
                    left: '<_x>',
                    right: {
                      type: 'operation',
                      operator: innerOp.operator,
                      left: '<_x>',
                      right: innerOp.right
                    }
                  },
                  {
                    type: 'operation',
                    operator: '~',
                    operand: '<_xs>',
                    position: 'postfix'
                  }
                ]
              },
              name: 'apply'
            }
          });
        }
      }
    }
    node.content = desugarPointFree(node.content);
    return node;
  }

  if (node.type === 'coproduct_block') {
    if (node.statements) {
      node.statements = node.statements.map(desugarPointFree);
    }
    return node;
  }

  if (node.type === 'operation') {
    if (node.operator === ':') {
      node.right = desugarPointFree(node.right);
      return node;
    }
    node.left = desugarPointFree(node.left);
    node.right = desugarPointFree(node.right);
    node.operand = desugarPointFree(node.operand);

    if (['+', '-', '*', '/'].includes(node.operator)) {
      if (node.left === undefined && node.right === undefined) {
        return {
          type: 'operation',
          operator: '?',
          left: {
            type: 'operation',
            operator: '~',
            left: '<_x>',
            right: '<_xs>'
          },
          right: {
            type: 'operation',
            operator: ' ',
            left: `<reduce_${getOperatorVarName(node.operator).slice(3)}>`,
            right: {
              type: 'coproduct_block',
              statements: [
                '<_x>',
                '<_xs>'
              ]
            },
            name: 'apply'
          }
        };
      }
      if (node.left === undefined && node.right !== undefined) {
        return {
          type: 'operation',
          operator: '?',
          left: '<_x>',
          right: {
            type: 'operation',
            operator: node.operator,
            left: '<_x>',
            right: node.right
          }
        };
      }
      if (node.left !== undefined && node.right === undefined) {
        return {
          type: 'operation',
          operator: '?',
          left: '<_x>',
          right: {
            type: 'operation',
            operator: node.operator,
            left: node.left,
            right: '<_x>'
          }
        };
      }
    }
  }

  return node;
}

const neededHelpers = new Set();

const helperDefs = {
  alloc_mem: `  (func $alloc_mem (param $size i64) (result i64)
    (local $addr i64)
    global.get $hp
    local.set $addr
    global.get $hp
    local.get $size
    i64.add
    global.set $hp
    local.get $addr
  )`,

  make_list: `  (func $make_list (param $len i64) (result i64)
    (local $addr i64)
    local.get $len
    i64.const 8
    i64.mul
    i64.const 8
    i64.add
    call $alloc_mem
    local.set $addr
    local.get $addr
    local.get $len
    i64.store offset=0
    local.get $addr
  )`,

  is_list: `  (func $is_list (param $val i64) (result i32)
    local.get $val
    i64.const 2048
    i64.ge_u
    (if (result i32)
      (then
        local.get $val
        global.get $hp
        i64.lt_u
        (if (result i32)
          (then
            local.get $val
            i64.const 7
            i64.and
            i64.eqz
            (if (result i32)
              (then i32.const 1)
              (else i32.const 0)
            )
          )
          (else i32.const 0)
        )
      )
      (else i32.const 0)
    )
  )`,

  list_head: `  (func $list_head (param $list_ptr i64) (result i64)
    local.get $list_ptr
    call $is_list
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        i64.const 0
        i64.gt_s
        (if (result i64)
          (then
            local.get $list_ptr
            i64.load offset=8
          )
          (else
            i64.const 0 ;; __unit
          )
        )
      )
      (else
        local.get $list_ptr
      )
    )
  )`,

  list_tail: `  (func $list_tail (param $list_ptr i64) (result i64)
    (local $len i64)
    (local $new_list i64)
    (local $i i64)
    local.get $list_ptr
    call $is_list
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        local.get $len
        i64.const 1
        i64.le_s
        (if (result i64)
          (then
            i64.const 0
          )
          (else
            local.get $len
            i64.const 1
            i64.sub
            call $make_list
            local.set $new_list
            
            i64.const 0
            local.set $i
            (block $break
              (loop $top
                local.get $i
                local.get $len
                i64.const 1
                i64.sub
                i64.ge_s
                br_if $break
                
                local.get $new_list
                local.get $i
                i64.const 8
                i64.mul
                i64.add
                
                local.get $list_ptr
                local.get $i
                i64.const 1
                i64.add
                i64.const 8
                i64.mul
                i64.add
                i64.load offset=8
                
                i64.store offset=8
                
                local.get $i
                i64.const 1
                i64.add
                local.set $i
                br $top
              )
            )
            local.get $new_list
          )
        )
      )
      (else
        i64.const 0
      )
    )
  )`,

  reduce_add: `  (func $reduce_add (param $init i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $acc f64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $init
    f64.reinterpret_i64
    local.set $acc
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            local.get $acc
            local.get $list_ptr
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            f64.reinterpret_i64
            f64.add
            local.set $acc
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $acc
        i64.reinterpret_f64
      )
      (else
        local.get $list_ptr
        i64.eqz
        (if (result i64)
          (then
            local.get $init
          )
          (else
            local.get $acc
            local.get $list_ptr
            f64.reinterpret_i64
            f64.add
            i64.reinterpret_f64
          )
        )
      )
    )
  )`,

  reduce_sub: `  (func $reduce_sub (param $init i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $acc f64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $init
    f64.reinterpret_i64
    local.set $acc
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            local.get $acc
            local.get $list_ptr
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            f64.reinterpret_i64
            f64.sub
            local.set $acc
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $acc
        i64.reinterpret_f64
      )
      (else
        local.get $list_ptr
        i64.eqz
        (if (result i64)
          (then
            local.get $init
          )
          (else
            local.get $acc
            local.get $list_ptr
            f64.reinterpret_i64
            f64.sub
            i64.reinterpret_f64
          )
        )
      )
    )
  )`,

  reduce_mul: `  (func $reduce_mul (param $init i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $acc f64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $init
    f64.reinterpret_i64
    local.set $acc
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            local.get $acc
            local.get $list_ptr
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            f64.reinterpret_i64
            f64.mul
            local.set $acc
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $acc
        i64.reinterpret_f64
      )
      (else
        local.get $list_ptr
        i64.eqz
        (if (result i64)
          (then
            local.get $init
          )
          (else
            local.get $acc
            local.get $list_ptr
            f64.reinterpret_i64
            f64.mul
            i64.reinterpret_f64
          )
        )
      )
    )
  )`,

  reduce_div: `  (func $reduce_div (param $init i64) (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $i i64)
    (local $acc f64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $init
    f64.reinterpret_i64
    local.set $acc
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            local.get $acc
            local.get $list_ptr
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            f64.reinterpret_i64
            f64.div
            local.set $acc
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $acc
        i64.reinterpret_f64
      )
      (else
        local.get $list_ptr
        i64.eqz
        (if (result i64)
          (then
            local.get $init
          )
          (else
            local.get $acc
            local.get $list_ptr
            f64.reinterpret_i64
            f64.div
            i64.reinterpret_f64
          )
        )
      )
    )
  )`,

  concat: `  (func $concat (param $left i64) (param $right i64) (result i64)
    (local $l_is_list i32)
    (local $r_is_list i32)
    (local $l_len i64)
    (local $r_len i64)
    (local $total_len i64)
    (local $new_list i64)
    (local $i i64)
    (local $dst_offset i64)

    local.get $left
    i64.eqz
    (if (then local.get $right return))

    local.get $right
    i64.eqz
    (if (then local.get $left return))

    local.get $left
    call $is_list
    local.set $l_is_list

    local.get $l_is_list
    (if
      (then
        local.get $left
        i64.load offset=0
        local.set $l_len
      )
      (else
        i64.const 1
        local.set $l_len
      )
    )

    local.get $right
    call $is_list
    local.set $r_is_list

    local.get $r_is_list
    (if
      (then
        local.get $right
        i64.load offset=0
        local.set $r_len
      )
      (else
        i64.const 1
        local.set $r_len
      )
    )

    local.get $l_len
    local.get $r_len
    i64.add
    local.set $total_len

    local.get $total_len
    call $make_list
    local.set $new_list

    i64.const 0
    local.set $i
    i64.const 8
    local.set $dst_offset

    local.get $l_is_list
    (if
      (then
        (block $break_l
          (loop $top_l
            local.get $i
            local.get $l_len
            i64.ge_s
            br_if $break_l

            local.get $new_list
            local.get $dst_offset
            i64.add
            
            local.get $left
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            
            i64.store

            local.get $dst_offset
            i64.const 8
            i64.add
            local.set $dst_offset

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top_l
          )
        )
      )
      (else
        local.get $new_list
        local.get $dst_offset
        i64.add
        local.get $left
        i64.store
        
        local.get $dst_offset
        i64.const 8
        i64.add
        local.set $dst_offset
      )
    )

    i64.const 0
    local.set $i

    local.get $r_is_list
    (if
      (then
        (block $break_r
          (loop $top_r
            local.get $i
            local.get $r_len
            i64.ge_s
            br_if $break_r

            local.get $new_list
            local.get $dst_offset
            i64.add
            
            local.get $right
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            
            i64.store

            local.get $dst_offset
            i64.const 8
            i64.add
            local.set $dst_offset

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top_r
          )
        )
      )
      (else
        local.get $new_list
        local.get $dst_offset
        i64.add
        local.get $right
        i64.store
      )
    )

    local.get $new_list
  )`,

  list_merge: `  (func $list_merge (param $left i64) (param $right i64) (result i64)
    (local $l_len i64)
    (local $r_len i64)
    (local $total_len i64)
    (local $new_list i64)
    (local $i i64)
    (local $dst_offset i64)

    local.get $left
    i64.eqz
    (if (then local.get $right return))

    local.get $right
    i64.eqz
    (if (then local.get $left return))

    local.get $left
    i64.load offset=0
    local.set $l_len

    local.get $right
    i64.load offset=0
    local.set $r_len

    local.get $l_len
    local.get $r_len
    i64.add
    local.set $total_len

    local.get $total_len
    call $make_list
    local.set $new_list

    i64.const 0
    local.set $i
    i64.const 8
    local.set $dst_offset

    (block $break_l
      (loop $top_l
        local.get $i
        local.get $l_len
        i64.ge_s
        br_if $break_l

        local.get $new_list
        local.get $dst_offset
        i64.add
        
        local.get $left
        local.get $i
        i64.const 8
        i64.mul
        i64.add
        i64.load offset=8
        
        i64.store

        local.get $dst_offset
        i64.const 8
        i64.add
        local.set $dst_offset

        local.get $i
        i64.const 1
         i64.add
        local.set $i
        br $top_l
      )
    )

    i64.const 0
    local.set $i

    (block $break_r
      (loop $top_r
        local.get $i
        local.get $r_len
        i64.ge_s
        br_if $break_r

        local.get $new_list
        local.get $dst_offset
        i64.add
        
        local.get $right
        local.get $i
        i64.const 8
        i64.mul
        i64.add
        i64.load offset=8
        
        i64.store

        local.get $dst_offset
        i64.const 8
        i64.add
        local.set $dst_offset

        local.get $i
        i64.const 1
        i64.add
        local.set $i
        br $top_r
      )
    )

    local.get $new_list
  )`,

  list_push_front: `  (func $list_push_front (param $val i64) (param $list i64) (result i64)
    (local $len i64)
    (local $new_list i64)
    (local $i i64)

    local.get $list
    i64.eqz
    (if (result i64)
      (then
        i64.const 1
        call $make_list
        local.set $new_list
        local.get $new_list
        local.get $val
        i64.store offset=8
        local.get $new_list
      )
      (else
        local.get $list
        i64.load offset=0
        local.set $len

        local.get $len
        i64.const 1
        i64.add
        call $make_list
        local.set $new_list

        local.get $new_list
        local.get $val
        i64.store offset=8

        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break

            local.get $new_list
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            
            local.get $list
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            
            i64.store offset=16

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $new_list
      )
    )
  )`,

  list_push_back: `  (func $list_push_back (param $list i64) (param $val i64) (result i64)
    (local $len i64)
    (local $new_list i64)
    (local $i i64)

    local.get $list
    i64.eqz
    (if (result i64)
      (then
        i64.const 1
        call $make_list
        local.set $new_list
        local.get $new_list
        local.get $val
        i64.store offset=8
        local.get $new_list
      )
      (else
        local.get $list
        i64.load offset=0
        local.set $len

        local.get $len
        i64.const 1
        i64.add
        call $make_list
        local.set $new_list

        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break

            local.get $new_list
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            
            local.get $list
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            
            i64.store offset=8

            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )

        local.get $new_list
        local.get $len
        i64.const 8
        i64.mul
        i64.add
        local.get $val
        i64.store offset=8

        local.get $new_list
      )
    )
  )`,

  f64_mod: `  (func $f64_mod (param $x i64) (param $y i64) (result i64)
    (local $fx f64)
    (local $fy f64)
    (local $div f64)
    local.get $x
    f64.reinterpret_i64
    local.set $fx
    local.get $y
    f64.reinterpret_i64
    local.set $fy
    local.get $fx
    local.get $fy
    f64.div
    local.set $div
    local.get $fx
    local.get $div
    f64.trunc
    local.get $fy
    f64.mul
    f64.sub
    i64.reinterpret_f64
  )`,

  f64_factorial: `  (func $f64_factorial (param $n i64) (result i64)
    (local $i f64)
    (local $res f64)
    (local $limit f64)
    f64.const 1.0
    local.set $res
    f64.const 2.0
    local.set $i
    local.get $n
    f64.reinterpret_i64
    local.set $limit
    (block $break
      (loop $top
        local.get $i
        local.get $limit
        f64.gt
        br_if $break
        
        local.get $res
        local.get $i
        f64.mul
        local.set $res
        
        local.get $i
        f64.const 1.0
        f64.add
        local.set $i
        br $top
      )
    )
    local.get $res
    i64.reinterpret_f64
  )`,

  list_reverse: `  (func $list_reverse (param $list_ptr i64) (result i64)
    (local $is_l i32)
    (local $len i64)
    (local $new_list i64)
    (local $i i64)
    local.get $list_ptr
    call $is_list
    local.set $is_l
    local.get $is_l
    (if (result i64)
      (then
        local.get $list_ptr
        i64.load offset=0
        local.set $len
        local.get $len
        call $make_list
        local.set $new_list
        
        i64.const 0
        local.set $i
        (block $break
          (loop $top
            local.get $i
            local.get $len
            i64.ge_s
            br_if $break
            
            local.get $new_list
            local.get $i
            i64.const 8
            i64.mul
            i64.add
            
            local.get $list_ptr
            local.get $len
            i64.const 1
            i64.sub
            local.get $i
            i64.sub
            i64.const 8
            i64.mul
            i64.add
            i64.load offset=8
            
            i64.store offset=8
            
            local.get $i
            i64.const 1
            i64.add
            local.set $i
            br $top
          )
        )
        local.get $new_list
      )
      (else
        local.get $list_ptr
      )
    )
  )`
};

function markHelperNeeded(helper) {
  if (neededHelpers.has(helper)) return;
  neededHelpers.add(helper);

  if (helper === 'make_list') {
    markHelperNeeded('alloc_mem');
  }
  if (helper === 'concat') {
    markHelperNeeded('is_list');
    markHelperNeeded('make_list');
    markHelperNeeded('alloc_mem');
  }
  if (helper === 'list_merge') {
    markHelperNeeded('make_list');
    markHelperNeeded('alloc_mem');
  }
  if (helper === 'list_push_front' || helper === 'list_push_back') {
    markHelperNeeded('make_list');
    markHelperNeeded('alloc_mem');
  }
  if (helper === 'list_head' || helper === 'list_tail') {
    markHelperNeeded('is_list');
    if (helper === 'list_tail') {
      markHelperNeeded('make_list');
      markHelperNeeded('alloc_mem');
    }
  }
  if (helper === 'list_reverse') {
    markHelperNeeded('is_list');
    markHelperNeeded('make_list');
    markHelperNeeded('alloc_mem');
  }

  if (['reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'].includes(helper)) {
    if (!tableFunctions.includes(helper)) {
      functionArities.set(helper, 2);
      functionHasRest.set(helper, false);
      tableFunctions.push(helper);
    }
    markHelperNeeded('is_list');
  }
}

export function transpileToWasm(resolvedLines, env) {
  currentEnv = env;
  const desugaredLines = resolvedLines.map(line => desugarPointFree(JSON.parse(JSON.stringify(line))));
  // Reset compiler state
  memoryOffset = 0;
  memoryMap.clear();
  structFields.clear();
  stringMap.clear();
  stringOffset = 1024;
  
  lambdaCounter = 0;
  rangeCounter = 0;
  mainLocals.clear();
  tableFunctions.length = 0;
  functionArities.clear();
  functionHasRest.clear();
  neededHelpers.clear();

  watGlobals.length = 0;
  watFunctions.length = 0;
  watDataSections.length = 0;
  mainInstructions.length = 0;

  watGlobals.push(`  (global $hp (mut i64) (i64.const 2048))`);

  // 1. Scan for string constants and struct structures first
  desugaredLines.forEach(line => {
    scanMetadata(line);
  });

  // 2. Generate WebAssembly globals and lay out linear memory
  desugaredLines.forEach(line => {
    registerGlobals(line);
  });

  // 3. Compile functions and statements
  desugaredLines.forEach(line => {
    compileLine(line);
  });

  // Assemble needed helpers
  neededHelpers.forEach(helper => {
    if (helperDefs[helper]) {
      watFunctions.push(helperDefs[helper]);
    }
  });

  // 4. Build string constant data sections
  stringMap.forEach((addr, str) => {
    watDataSections.push(`  (data (i64.const ${addr}) "${escapeString(str)}\\00")`);
  });

  const typeDefinitions = [
    `  (type $t_arity_0 (func (result i64)))`,
    `  (type $t_arity_1 (func (param i64) (result i64)))`,
    `  (type $t_arity_2 (func (param i64 i64) (result i64)))`,
    `  (type $t_arity_3 (func (param i64 i64 i64) (result i64)))`,
    `  (type $t_arity_4 (func (param i64 i64 i64 i64) (result i64)))`,
  ].join('\n');

  const tableWat = `  (table (export "table") ${tableFunctions.length} funcref)` +
    (tableFunctions.length > 0 ? `\n  (elem (i32.const 0) ${tableFunctions.map(f => `$${f}`).join(' ')})` : '');

  // Assemble full WAT module
  const watLines = [
    `(module`,
    `  ;; Import pow from JS host`,
    `  (import "js" "pow" (func $f64_pow (param f64 f64) (result f64)))`,
    ``,
    typeDefinitions,
    ``,
    tableWat,
    `  ;; Export 64-bit linear memory`,
    `  (memory (export "memory") i64 100)`,
    ``,
    watGlobals.join('\n'),
    ``,
    watDataSections.join('\n'),
    ``,
    watFunctions.join('\n\n'),
    ``,
    `  ;; Main entry function`,
    `  (func (export "main")`,
    `    (local $tmp_l i64) (local $tmp_r i64)` + 
    (mainLocals.size > 0 ? '\n' + Array.from(mainLocals.keys()).map(name => `    (local $${name} i64)`).join('\n') : ''),
    mainInstructions.map(i => `    ${i}`).join('\n'),
    `  )`,
    `)`
  ];

  return watLines.join('\n');
}

function escapeString(str) {
  return str.replace(/\\/g, "\\\\").replace(/"/g, "\\\"");
}

function scanMetadata(node) {
  if (!node) return;

  if (typeof node === 'string') {
    if (node.startsWith('`') && node.endsWith('`')) {
      const val = node.slice(1, -1);
      if (!stringMap.has(val)) {
        stringMap.set(val, stringOffset);
        stringOffset += Math.ceil((val.length + 1) / 8) * 8; // 8-byte aligned
      }
    }
    return;
  }

  if (node.type === 'operation') {
    if (node.operator === ':') {
      const lhs = getLHSName(node.left);
      
      // If rhs is lambda definition
      if (node.right && node.right.type === 'operation' && node.right.operator === '?') {
        node.right.lambdaName = lhs;
        if (!tableFunctions.includes(lhs)) {
          tableFunctions.push(lhs);
        }
        const params = getParameterSpecs(node.right.left);
        functionArities.set(lhs, params.length);
        functionHasRest.set(lhs, params.some(p => p.isRest));
      }

      // Scan dictionary fields
      if (node.right && node.right.type === 'block' && node.right.kind === 'indent') {
        const fields = {};
        let offset = 0;
        const stmts = flattenStatements(node.right.content);
        stmts.forEach(s => {
          if (s.type === 'operation' && s.operator === ':') {
            const fName = getLHSName(s.left);
            const valType = getWasmType(s.right);
            fields[fName] = { offset, type: valType };
            offset += 8; // All fields are 8 bytes in wasm64/f64
          }
        });
        structFields.set(lhs, fields);
      }
    }

    if (node.operator === '?') {
      if (!node.lambdaName) {
        const name = `lambda_${lambdaCounter++}`;
        console.log("DEBUG scanMetadata lambda generated:", name, "for node:", JSON.stringify(node));
        node.lambdaName = name;
        tableFunctions.push(name);
      }
      const params = getParameterSpecs(node.left);
      functionArities.set(node.lambdaName, params.length);
      functionHasRest.set(node.lambdaName, params.some(p => p.isRest));
    }

    scanMetadata(node.left);
    scanMetadata(node.right);
    scanMetadata(node.operand);
    return;
  }

  if (node.type === 'block') {
    scanMetadata(node.content);
    return;
  }

  if (node.type === 'coproduct_block') {
    (node.statements || []).forEach(scanMetadata);
  }
}

function registerGlobals(node) {
  if (!node) return;
  
  let isGlobal = false;
  let targetNode = node;
  
  if (targetNode.type === 'operation' && ['#', '##', '###'].includes(targetNode.operator) && targetNode.position === 'prefix') {
    isGlobal = true;
    targetNode = targetNode.operand;
  }
  
  if (!targetNode || targetNode.type !== 'operation' || targetNode.operator !== ':') return;
  
  // Also check if rhs has prefix '#'
  if (targetNode.right && targetNode.right.type === 'operation' && ['#', '##', '###'].includes(targetNode.right.operator) && targetNode.right.position === 'prefix') {
    isGlobal = true;
  }

  const lhs = getLHSName(targetNode.left);
  // Functions don't need memory layout, but variables/dicts do
  if (targetNode.right && targetNode.right.type === 'operation' && targetNode.right.operator === '?') {
    return; // Will be compiled as WASM function
  }

  if (isGlobal) {
    // Allocate in linear memory
    const size = structFields.has(lhs) ? Object.keys(structFields.get(lhs)).length * 8 + 8 : 8;
    const addr = memoryOffset;
    memoryMap.set(lhs, addr);
    memoryOffset += Math.ceil(size / 8) * 8; // 8-byte aligned

    watGlobals.push(`  (global $${lhs} i64 (i64.const ${addr}))`);
  } else {
    // Register as main local instead of global
    mainLocals.set(lhs, 'i64');
  }
}

function getLHSName(node) {
  if (!node) return 'unknown';
  if (typeof node === 'string') {
    if (node.startsWith('<') && node.endsWith('>')) {
      return node.slice(1, -1);
    }
    return node;
  }
  if (node.type === 'operation') {
    if (['#', '##', '###'].includes(node.operator) && node.position === 'prefix') {
      return getLHSName(node.operand);
    }
  }
  if (node.type === 'Identifier') return node.name;
  if (node.type === 'block' && node.kind === 'bracket') {
    const content = node.content;
    if (content) {
      if (content.type === 'operation') {
        if (content.left === undefined && content.right === undefined && content.operand === undefined) {
          return getOperatorVarName(content.operator);
        }
      }
      if (typeof content === 'string') {
        return getOperatorVarName(content);
      }
    }
  }
  return 'unknown';
}

function getWasmType(node) {
  return 'i64';
}

function flattenStatements(node) {
  if (!node) return [];
  if (node.type === 'block') {
    return flattenStatements(node.content);
  }
  if (node.type === 'operation' && node.operator === "\\n") {
    return [...flattenStatements(node.left), ...flattenStatements(node.right)];
  }
  return [node];
}

function compileLine(node) {
  if (!node) return;
  
  let isGlobal = false;
  let targetNode = node;
  
  if (targetNode.type === 'operation' && ['#', '##', '###'].includes(targetNode.operator) && targetNode.position === 'prefix') {
    isGlobal = true;
    targetNode = targetNode.operand;
  }
  
  if (!targetNode || targetNode.type !== 'operation' || targetNode.operator !== ':') {
    // Top-level execution statement
    const insts = compileExpression(node, mainLocals);
    if (insts.length > 0) {
      mainInstructions.push(...insts);
      mainInstructions.push(`  drop`);
    }
    return;
  }

  // Also check if rhs has prefix '#'
  let rhs = targetNode.right;
  if (rhs && rhs.type === 'operation' && ['#', '##', '###'].includes(rhs.operator) && rhs.position === 'prefix') {
    isGlobal = true;
    rhs = rhs.operand;
  }

  const lhs = getLHSName(targetNode.left);
  if (rhs && rhs.type === 'operation' && rhs.operator === '?') {
    // Compile function
    compileFunction(lhs, rhs);
  } else {
    if (isGlobal) {
      // Global variable/struct initialization (on linear memory)
      if (rhs && rhs.type === 'block' && rhs.kind === 'indent') {
        const stmts = flattenStatements(rhs.content);
        const fields = structFields.get(lhs);
        const validFields = stmts.filter(s => s && s.type === 'operation' && s.operator === ':');
        
        mainInstructions.push(`  global.get $${lhs}`);
        mainInstructions.push(`  i64.const ${validFields.length}`);
        mainInstructions.push(`  i64.store`);

        validFields.forEach(s => {
          const fName = getLHSName(s.left);
          const fMeta = fields[fName];
          
          mainInstructions.push(`  global.get $${lhs}`);
          mainInstructions.push(`  i64.const ${fMeta.offset + 8}`);
          mainInstructions.push(`  i64.add`);
          
          const valInsts = compileExpression(s.right, mainLocals);
          mainInstructions.push(...valInsts);
          mainInstructions.push(`  i64.store`);
        });
      } else {
        // Simple global variable initialization
        mainInstructions.push(`  global.get $${lhs}`);
        const valInsts = compileExpression(rhs, mainLocals);
        mainInstructions.push(...valInsts);
        mainInstructions.push(`  i64.store`);
      }
    } else {
      // Local variable/struct initialization (WASM local)
      if (rhs && rhs.type === 'block' && rhs.kind === 'indent') {
        const stmts = flattenStatements(rhs.content);
        const validFields = stmts.filter(s => s && s.type === 'operation' && s.operator === ':');
        const fields = structFields.get(lhs);
        const size = validFields.length * 8 + 8;
        
        markHelperNeeded('alloc_mem');
        mainInstructions.push(`  i64.const ${size}`);
        mainInstructions.push(`  call $alloc_mem`);
        mainInstructions.push(`  local.set $${lhs}`);
        
        mainInstructions.push(`  local.get $${lhs}`);
        mainInstructions.push(`  i64.const ${validFields.length}`);
        mainInstructions.push(`  i64.store`);
        
        validFields.forEach((s, idx) => {
          const fName = getLHSName(s.left);
          const fMeta = fields ? fields[fName] : null;
          const offsetVal = (fMeta ? fMeta.offset : idx * 8) + 8;
          
          mainInstructions.push(`  local.get $${lhs}`);
          mainInstructions.push(`  i64.const ${offsetVal}`);
          mainInstructions.push(`  i64.add`);
          
          const valInsts = compileExpression(s.right, mainLocals);
          mainInstructions.push(...valInsts);
          mainInstructions.push(`  i64.store`);
        });
      } else {
        // Simple local variable initialization
        const valInsts = compileExpression(rhs, mainLocals);
        mainInstructions.push(...valInsts);
        mainInstructions.push(`  local.set $${lhs}`);
      }
    }
  }
}

function compileFunction(name, node) {
  // node is: (params) ? (body)
  const params = getParameterSpecs(node.left);
  console.log("DEBUG compileFunction:", name, "params:", JSON.stringify(params));
  functionArities.set(name, params.length);
  const hasRest = params.some(p => p.isRest);
  functionHasRest.set(name, hasRest);
  let destructCounter = 0;
  
  const paramDefs = [];
  const bodyInstructions = [];
  const locals = new Map(); // name -> type
  const paramNames = [];

  params.forEach(p => {
    let pName = p.name;
    if (p.isDestructured) {
      pName = `_d${destructCounter++}`;
    }
    paramNames.push(pName);
    
    // Always i64
    paramDefs.push(`(param $${pName} i64)`);
    
    // Unit propagation guard: if a non-rest, non-destructured argument is 0 (__unit), return 0 immediately.
    if (!p.isRest && !p.isDestructured) {
      bodyInstructions.push(`  local.get $${pName}`);
      bodyInstructions.push(`  i64.eqz`);
      bodyInstructions.push(`  (if (then i64.const 0 return))`);
    } else {
      locals.set(pName, 'list');
    }
    
    // Destructuring unpacks
    if (p.isDestructured) {
      const nonRestFields = p.innerSpecs.filter(ip => !ip.isRest).map(ip => ip.name);
      const targetStruct = findStructForPattern(nonRestFields);
      const fieldsMap = targetStruct ? structFields.get(targetStruct) : null;

      if (!targetStruct) {
        // List destructuring pattern: [x ~xs]
        let firstSpec = p.innerSpecs[0];
        let restSpec = p.innerSpecs[1];
        
        if (firstSpec) {
          locals.set(firstSpec.name, 'i64');
          bodyInstructions.push(`  ;; Destructure list head ${firstSpec.name} from $${pName}`);
          bodyInstructions.push(`  local.get $${pName}`);
          markHelperNeeded('list_head');
          bodyInstructions.push(`  call $list_head`);
          bodyInstructions.push(`  local.set $${firstSpec.name}`);
        }
        
        if (restSpec) {
          locals.set(restSpec.name, 'list');
          bodyInstructions.push(`  ;; Destructure list tail ${restSpec.name} from $${pName}`);
          bodyInstructions.push(`  local.get $${pName}`);
          markHelperNeeded('list_tail');
          bodyInstructions.push(`  call $list_tail`);
          bodyInstructions.push(`  local.set $${restSpec.name}`);
        }
      } else {
        // Struct/Dict destructuring pattern
        p.innerSpecs.forEach(ip => {
          const fieldMeta = fieldsMap ? fieldsMap[ip.name] : findFieldMeta(ip.name);
          if (fieldMeta) {
            locals.set(ip.name, fieldMeta.type);
            bodyInstructions.push(`  ;; Destructure ${ip.name} from $${pName}`);
            bodyInstructions.push(`  local.get $${pName}`);
            bodyInstructions.push(`  i64.const ${fieldMeta.offset + 8}`);
            bodyInstructions.push(`  i64.add`);
            bodyInstructions.push(`  ${fieldMeta.type}.load`);
            bodyInstructions.push(`  local.set $${ip.name}`);
          }
        });
      }
    }
  });

  const paramDefsStr = paramDefs.join(' ');

  // Compile function body expressions
  bodyInstructions.push(...compileExpression(node.right, locals, paramNames));

  const localDefs = [];
  localDefs.push(`  (local $tmp_l i64) (local $tmp_r i64)`);
  locals.forEach((type, name) => {
    if (paramNames.includes(name)) return;
    localDefs.push(`  (local $${name} i64)`);
  });

  const fnWat = [
    `  (func $${name} ${paramDefsStr} (result i64)`,
    localDefs.join('\n'),
    bodyInstructions.map(i => `  ${i}`).join('\n'),
    `  )`
  ].join('\n');

  watFunctions.push(fnWat);
}

function findStructForPattern(patternFields) {
  let bestStruct = null;
  let minFieldsCount = Infinity;
  
  for (const [sName, fields] of structFields.entries()) {
    const hasAll = patternFields.every(f => f in fields);
    if (hasAll) {
      const count = Object.keys(fields).length;
      if (count < minFieldsCount) {
        minFieldsCount = count;
        bestStruct = sName;
      }
    }
  }
  return bestStruct;
}

function findFieldMeta(fieldName) {
  // Scan all registered struct structures to find the field metadata
  for (const [sName, fields] of structFields.entries()) {
    if (fields[fieldName]) {
      return fields[fieldName];
    }
  }
  return { offset: 0, type: 'i64' }; // Fallback
}

function compileStaticConcat(node, locals, paramNames) {
  const insts = [];
  const typeL = inferType(node.left, currentEnv);
  const typeR = inferType(node.right, currentEnv);

  const leftHasTilde = (node.left && node.left.type === 'operation' && node.left.operator === '~' && node.left.position === 'postfix');
  const rightHasTilde = (node.right && node.right.type === 'operation' && node.right.operator === '~' && node.right.position === 'postfix');

  const leftNode = leftHasTilde ? node.left.operand : node.left;
  const rightNode = rightHasTilde ? node.right.operand : node.right;

  const isListL = (
    (typeL === 'List' && !(leftNode && leftNode.type === 'operation' && leftNode.name === 'concat')) ||
    typeL === 'Dict' ||
    (leftNode && leftNode.type === 'block' && (leftNode.kind === 'bracket' || leftNode.kind === 'brace')) ||
    (leftNode && leftNode.type === 'coproduct_block')
  );
  const isListR = (
    (typeR === 'List' && !(rightNode && rightNode.type === 'operation' && rightNode.name === 'concat')) ||
    typeR === 'Dict' ||
    (rightNode && rightNode.type === 'block' && (rightNode.kind === 'bracket' || rightNode.kind === 'brace')) ||
    (rightNode && rightNode.type === 'coproduct_block')
  );

  // パターン A: スカラー同士の結合 (どちらもチルダなし) 
  // または カンマ演算子（常に要素数2のポインタリストを新規作成）
  if (node.operator === ',' || (!leftHasTilde && !rightHasTilde && !isListL && !isListR)) {
    const leaves = node.operator === ',' ? flattenProduct(node) : [leftNode, rightNode];
    const len = leaves.length;
    
    markHelperNeeded('make_list');
    insts.push(`i64.const ${len}`);
    insts.push(`call $make_list`);
    insts.push(`local.set $tmp_l`);

    leaves.forEach((leaf, idx) => {
      insts.push(`local.get $tmp_l`);
      insts.push(...compileExpression(leaf, locals, paramNames));
      insts.push(`i64.store offset=${8 + idx * 8}`);
    });

    insts.push(`local.get $tmp_l`);
    return insts;
  }

  // パターン B: リスト同士の連接 (双方に後置チルダあり)
  if (isListL && isListR && leftHasTilde && rightHasTilde) {
    markHelperNeeded('list_merge');
    insts.push(...compileExpression(leftNode, locals, paramNames));
    insts.push(...compileExpression(rightNode, locals, paramNames));
    insts.push(`call $list_merge`);
    return insts;
  }

  // パターン C: スカラーとリストの連接 (右辺にのみ後置チルダあり)
  if (isListR && rightHasTilde) {
    markHelperNeeded('list_push_front');
    insts.push(...compileExpression(leftNode, locals, paramNames));
    insts.push(...compileExpression(rightNode, locals, paramNames));
    insts.push(`call $list_push_front`);
    return insts;
  }

  // パターン D: リストとスカラーの連接 (左辺にのみ後置チルダあり)
  if (isListL && leftHasTilde) {
    markHelperNeeded('list_push_back');
    insts.push(...compileExpression(leftNode, locals, paramNames));
    insts.push(...compileExpression(rightNode, locals, paramNames));
    insts.push(`call $list_push_back`);
    return insts;
  }

  // パターン E: 静的に型が特定できない場合の動的フォールバック
  markHelperNeeded('concat');
  insts.push(...compileExpression(node.left, locals, paramNames));
  insts.push(...compileExpression(node.right, locals, paramNames));
  insts.push(`call $concat`);
  return insts;
}

function compileExpression(node, locals = new Map(), paramNames = []) {
  const insts = [];
  if (node === undefined || node === null) {
    insts.push(`i64.const 0 ;; __unit (undefined node)`);
    return insts;
  }

  if (node.type === 'inline_code') {
    const val = node.value.trim();
    if (val.startsWith('wat:') || val.startsWith('wasm:')) {
      const match = val.match(/^(wat|wasm):/);
      const codeStr = val.slice(match[0].length).trim();
      insts.push(codeStr);
    } else {
      insts.push(`i64.const 0 ;; unsupported inline code: ${val.replace(/\n/g, ' ')}`);
    }
    return insts;
  }

  if (node.type === 'coproduct_block') {
    const stmts = node.statements || [];
    stmts.forEach((s, idx) => {
      insts.push(...compileExpression(s, locals, paramNames));
      if (idx < stmts.length - 1) {
        insts.push(`drop`);
      }
    });
    return insts;
  }

  if (typeof node === 'string') {
    if (node.startsWith('`') && node.endsWith('`')) {
      const val = node.slice(1, -1);
      const addr = stringMap.get(val);
      insts.push(`i64.const ${addr}`);
      return insts;
    }
    
    const cleanNode = getLHSName(node);
    if (locals.has(cleanNode) || paramNames.includes(cleanNode)) {
      insts.push(`local.get $${cleanNode}`);
    } else if (memoryMap.has(cleanNode)) {
      insts.push(`global.get $${cleanNode}`);
      insts.push(`i64.load`);
    } else if (['reduce_add', 'reduce_sub', 'reduce_mul', 'reduce_div'].includes(cleanNode)) {
      markHelperNeeded(cleanNode);
      const idx = tableFunctions.indexOf(cleanNode);
      insts.push(`i64.const ${idx} ;; func_idx (${cleanNode})`);
    } else if (tableFunctions.includes(cleanNode)) {
      const idx = tableFunctions.indexOf(cleanNode);
      insts.push(`i64.const ${idx} ;; func_idx (${cleanNode})`);
    } else {
      // Character literal check
      if (cleanNode.startsWith("\\") && cleanNode.length === 2) {
        const codePoint = cleanNode.charCodeAt(1);
        const bits = doubleToRawBits(codePoint);
        insts.push(`i64.const ${bits} ;; char: ${cleanNode} (${codePoint})`);
      } else if (cleanNode.startsWith('0x') || cleanNode.startsWith('0u')) {
        const val = cleanNode.startsWith('0u') ? cleanNode.slice(2) : cleanNode;
        insts.push(`i64.const ${val}`);
      } else if (!isNaN(cleanNode)) {
        const bits = doubleToRawBits(parseFloat(cleanNode));
        insts.push(`i64.const ${bits} ;; f64: ${cleanNode}`);
      } else if (cleanNode === '__unit') {
        insts.push(`i64.const 0 ;; __unit`);
      } else {
        insts.push(`i64.const 0 ;; fallback for ${cleanNode}`);
      }
    }
    return insts;
  }

  if (node.type === 'operation') {
    // Dynamic dispatch for overridden operators
    if (node.operator && node.operator !== ':' && node.operator !== '?' && node.operator !== ',' && node.operator !== ' ') {
      const opKey = `[${node.operator}]`;
      if (currentEnv && (currentEnv.has(opKey) || currentEnv.has(`<${opKey}>`))) {
        const fnName = getOperatorVarName(node.operator);
        if (node.position === 'prefix') {
          insts.push(...compileExpression(node.operand, locals, paramNames));
        } else if (node.position === 'postfix') {
          insts.push(...compileExpression(node.operand, locals, paramNames));
        } else {
          insts.push(...compileExpression(node.left, locals, paramNames));
          insts.push(...compileExpression(node.right, locals, paramNames));
        }
        insts.push(`call $${fnName}`);
        return insts;
      }
    }

    if (node.operator === '?') {
      compileFunction(node.lambdaName, node);
      const idx = tableFunctions.indexOf(node.lambdaName);
      insts.push(`i64.const ${idx} ;; lambda func_idx (${node.lambdaName})`);
      return insts;
    }

    // Prefix Operators with Bitcast/Boolean logic
    if (node.position === 'prefix') {
      if (node.operator === '$') {
        const funcName = getLHSName(node.operand);
        const idx = tableFunctions.indexOf(funcName);
        if (idx !== -1) {
          insts.push(`i64.const ${idx} ;; func_idx (${funcName})`);
        } else if (node.operand && node.operand.type === 'operation' && node.operand.operator === '?') {
          insts.push(...compileExpression(node.operand, locals, paramNames));
        } else {
          // Fallback variable pointer
          insts.push(...compileExpression(node.operand, locals, paramNames));
        }
        return insts;
      }
      if (node.operator === '-') {
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`f64.reinterpret_i64`);
        insts.push(`f64.neg`);
        insts.push(`i64.reinterpret_f64`);
        return insts;
      }
      if (node.operator === '!') {
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`i64.eqz`);
        insts.push(`(if (result i64)`);
        insts.push(`  (then`);
        insts.push(`    i64.const 4607182418800017408 ;; f64: 1.0 (true)`);
        insts.push(`  )`);
        insts.push(`  (else`);
        insts.push(`    i64.const 0 ;; __unit`);
        insts.push(`  )`);
        insts.push(`)`);
        return insts;
      }
      if (node.operator === '!!') {
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`i64.const -1`);
        insts.push(`i64.xor`);
        return insts;
      }
      if (node.operator === '~') {
        markHelperNeeded('make_list');
        insts.push(`i64.const 1`);
        insts.push(`call $make_list`);
        insts.push(`local.set $tmp_l`);
        insts.push(`local.get $tmp_l`);
        insts.push(`i64.const 16`);
        insts.push(`i64.add`);
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`i64.store`);
        insts.push(`local.get $tmp_l`);
        return insts;
      }
      if (node.operator === '><') {
        markHelperNeeded('list_reverse');
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`call $list_reverse`);
        return insts;
      }
    }

    if (['~', '~+', '~-', '~*', '~/', '~/^', '~^'].includes(node.operator)) {
      if (node.position !== 'prefix' && node.position !== 'postfix') {
        let startNode, stepNode, stepOp, endNode;
        if (node.left && node.left.type === 'operation' && ['~+', '~-', '~*', '~/', '~^', '~/^'].includes(node.left.operator)) {
          startNode = node.left.left;
          stepNode = node.left.right;
          stepOp = node.left.operator.slice(1);
          if (stepOp.startsWith('/')) stepOp = '^';
          endNode = node.right;
        } else {
          startNode = node.left;
          stepNode = "1";
          stepOp = '+';
          endNode = node.right;
        }

        const rId = rangeCounter++;
        const vStart = `range_start_${rId}`;
        const vStep = `range_step_${rId}`;
        const vEnd = `range_end_${rId}`;
        const vCurr = `range_curr_${rId}`;
        const vLen = `range_len_${rId}`;
        const vI = `range_i_${rId}`;
        const vList = `range_list_${rId}`;

        locals.set(vStart, 'i64');
        locals.set(vStep, 'i64');
        locals.set(vEnd, 'i64');
        locals.set(vCurr, 'i64');
        locals.set(vLen, 'i64');
        locals.set(vI, 'i64');
        locals.set(vList, 'i64');

        markHelperNeeded('make_list');
        if (stepOp === '^') {
          markHelperNeeded('f64_pow');
        }

        // 1. Evaluate start, step, end
        insts.push(...compileExpression(startNode, locals, paramNames));
        insts.push(`local.set $${vStart}`);
        insts.push(...compileExpression(stepNode, locals, paramNames));
        insts.push(`local.set $${vStep}`);
        insts.push(...compileExpression(endNode, locals, paramNames));
        insts.push(`local.set $${vEnd}`);

        // 2. Count elements loop
        insts.push(`local.get $${vStart}`);
        insts.push(`local.set $${vCurr}`);
        insts.push(`i64.const 0`);
        insts.push(`local.set $${vLen}`);

        insts.push(`(block $break_cnt_${rId}`);
        insts.push(`  (loop $top_cnt_${rId}`);
        // Loop safety guard
        insts.push(`    local.get $${vLen}`);
        insts.push(`    i64.const 10000`);
        insts.push(`    i64.ge_s`);
        insts.push(`    br_if $break_cnt_${rId}`);

        // Condition check
        insts.push(`    local.get $${vCurr}`);
        insts.push(`    f64.reinterpret_i64`);
        insts.push(`    local.get $${vEnd}`);
        insts.push(`    f64.reinterpret_i64`);
        if (stepOp === '-' || stepOp === '/') {
          insts.push(`    f64.ge`);
        } else {
          insts.push(`    f64.le`);
        }
        insts.push(`    i32.eqz`);
        insts.push(`    br_if $break_cnt_${rId}`);

        // Increment length
        insts.push(`    local.get $${vLen}`);
        insts.push(`    i64.const 1`);
        insts.push(`    i64.add`);
        insts.push(`    local.set $${vLen}`);

        // Update curr
        insts.push(`    local.get $${vCurr}`);
        insts.push(`    f64.reinterpret_i64`);
        insts.push(`    local.get $${vStep}`);
        insts.push(`    f64.reinterpret_i64`);
        if (stepOp === '+') insts.push(`    f64.add`);
        else if (stepOp === '-') insts.push(`    f64.sub`);
        else if (stepOp === '*') insts.push(`    f64.mul`);
        else if (stepOp === '/') insts.push(`    f64.div`);
        else if (stepOp === '^') insts.push(`    call $f64_pow`);
        insts.push(`    i64.reinterpret_f64`);
        insts.push(`    local.set $${vCurr}`);

        insts.push(`    br $top_cnt_${rId}`);
        insts.push(`  )`);
        insts.push(`)`);

        // 3. Make List
        insts.push(`local.get $${vLen}`);
        insts.push(`call $make_list`);
        insts.push(`local.set $${vList}`);

        // 4. Fill List loop
        insts.push(`local.get $${vStart}`);
        insts.push(`local.set $${vCurr}`);
        insts.push(`i64.const 0`);
        insts.push(`local.set $${vI}`);

        insts.push(`(block $break_fill_${rId}`);
        insts.push(`  (loop $top_fill_${rId}`);
        // Loop condition: range_i < range_len
        insts.push(`    local.get $${vI}`);
        insts.push(`    local.get $${vLen}`);
        insts.push(`    i64.lt_s`);
        insts.push(`    i32.eqz`);
        insts.push(`    br_if $break_fill_${rId}`);

        // Store curr in list
        insts.push(`    local.get $${vList}`);
        insts.push(`    local.get $${vI}`);
        insts.push(`    i64.const 8`);
        insts.push(`    i64.mul`);
        insts.push(`    i64.add`);
        insts.push(`    local.get $${vCurr}`);
        insts.push(`    i64.store offset=16`);

        // Update curr
        insts.push(`    local.get $${vCurr}`);
        insts.push(`    f64.reinterpret_i64`);
        insts.push(`    local.get $${vStep}`);
        insts.push(`    f64.reinterpret_i64`);
        if (stepOp === '+') insts.push(`    f64.add`);
        else if (stepOp === '-') insts.push(`    f64.sub`);
        else if (stepOp === '*') insts.push(`    f64.mul`);
        else if (stepOp === '/') insts.push(`    f64.div`);
        else if (stepOp === '^') insts.push(`    call $f64_pow`);
        insts.push(`    i64.reinterpret_f64`);
        insts.push(`    local.set $${vCurr}`);

        // Increment range_i
        insts.push(`    local.get $${vI}`);
        insts.push(`    i64.const 1`);
        insts.push(`    i64.add`);
        insts.push(`    local.set $${vI}`);

        insts.push(`    br $top_fill_${rId}`);
        insts.push(`  )`);
        insts.push(`)`);

        // 5. Push List ptr to stack
        insts.push(`local.get $${vList}`);
        return insts;
      }
    }

    // Postfix Operators
    if (node.position === 'postfix') {
      if (node.operator === '!') {
        markHelperNeeded('f64_factorial');
        insts.push(...compileExpression(node.operand, locals, paramNames));
        insts.push(`call $f64_factorial`);
        return insts;
      }
    }

    // Comparison Operators (with Sign's return-left-or-zero semantic)
    if (['<', '>', '<=', '>=', '==', '!=', '!==', '='].includes(node.operator)) {
      if (['<', '>', '<=', '>=', '=', '!='].includes(node.operator)) {
        if (isStaticListType(node.left, locals, paramNames)) {
          throw new Error(`Compile Error: Operator '${node.operator}' cannot be applied to List types. Use structural comparison '==' or '!==' instead.`);
        }
      }
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(`local.set $tmp_l`);
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`local.set $tmp_r`);

      if (['==', '!=', '!==', '='].includes(node.operator)) {
        insts.push(`local.get $tmp_l`);
        insts.push(`local.get $tmp_r`);
        if (node.operator === '==' || node.operator === '=') insts.push(`i64.eq`);
        else insts.push(`i64.ne`);
      } else {
        insts.push(`local.get $tmp_l`);
        insts.push(`f64.reinterpret_i64`);
        insts.push(`local.get $tmp_r`);
        insts.push(`f64.reinterpret_i64`);
        if (node.operator === '<') insts.push(`f64.lt`);
        if (node.operator === '>') insts.push(`f64.gt`);
        if (node.operator === '<=') insts.push(`f64.le`);
        if (node.operator === '>=') insts.push(`f64.ge`);
      }

      insts.push(`(if (result i64)`);
      insts.push(`  (then`);
      insts.push(`    local.get $tmp_l`);
      insts.push(`    i64.eqz`);
      insts.push(`    (if (result i64)`);
      insts.push(`      (then`);
      insts.push(`        i64.const 4607182418800017408 ;; f64: 1.0 (true)`);
      insts.push(`      )`);
      insts.push(`      (else`);
      insts.push(`        local.get $tmp_l`);
      insts.push(`      )`);
      insts.push(`    )`);
      insts.push(`  )`);
      insts.push(`  (else`);
      insts.push(`    i64.const 0`);
      insts.push(`  )`);
      insts.push(`)`);
      return insts;
    }

    // Logical Operators (Short-circuiting)
    if (node.operator === '&') {
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(`local.set $tmp_l`);
      insts.push(`local.get $tmp_l`);
      insts.push(`i64.const 0`);
      insts.push(`i64.ne`);
      insts.push(`(if (result i64)`);
      insts.push(`  (then`);
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`  )`);
      insts.push(`  (else`);
      insts.push(`    i64.const 0`);
      insts.push(`  )`);
      insts.push(`)`);
      return insts;
    }

    if (node.operator === '|') {
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(`local.set $tmp_l`);
      insts.push(`local.get $tmp_l`);
      insts.push(`i64.const 0`);
      insts.push(`i64.ne`);
      insts.push(`(if (result i64)`);
      insts.push(`  (then`);
      insts.push(`    local.get $tmp_l`);
      insts.push(`  )`);
      insts.push(`  (else`);
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`  )`);
      insts.push(`)`);
      return insts;
    }

    // Arithmetic Operators with Bitcast (i64 <-> f64)
    if (['+', '-', '*', '/'].includes(node.operator)) {
      if (['+', '-'].includes(node.operator) && isStaticListType(node.left, locals, paramNames)) {
        throw new Error(`Compile Error: Arithmetic operator '${node.operator}' cannot be applied to List types directly. Use mapping (e.g. [+ 0,]) instead.`);
      }
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(`f64.reinterpret_i64`);
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`f64.reinterpret_i64`);
      if (node.operator === '+') insts.push(`f64.add`);
      if (node.operator === '-') insts.push(`f64.sub`);
      if (node.operator === '*') insts.push(`f64.mul`);
      if (node.operator === '/') insts.push(`f64.div`);
      insts.push(`i64.reinterpret_f64`);
      return insts;
    }

    if (node.operator === '%') {
      markHelperNeeded('f64_mod');
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`call $f64_mod`);
      return insts;
    }

    if (node.operator === '^') {
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(`f64.reinterpret_i64`);
      insts.push(...compileExpression(node.right, locals, paramNames));
      insts.push(`f64.reinterpret_i64`);
      insts.push(`call $f64_pow`);
      insts.push(`i64.reinterpret_f64`);
      return insts;
    }

    if (node.operator === ',') {
      return compileStaticConcat(node, locals, paramNames);
    }

    // Bitwise Operators
    if (['<<', '>>', '||', ';;', '&&'].includes(node.operator)) {
      insts.push(...compileExpression(node.left, locals, paramNames));
      insts.push(...compileExpression(node.right, locals, paramNames));
      if (node.operator === '<<') insts.push(`i64.shl`);
      if (node.operator === '>>') insts.push(`i64.shr_s`);
      if (node.operator === '||') insts.push(`i64.or`);
      if (node.operator === ';;') insts.push(`i64.xor`);
      if (node.operator === '&&') insts.push(`i64.and`);
      return insts;
    }

    // Property Access
    if (node.operator === "'") {
      const targetName = getLHSName(node.left);
      const fName = getLHSName(node.right);
      const fieldMeta = findFieldMeta(fName);
      
      if (paramNames.includes(targetName) || locals.has(targetName)) {
        insts.push(`local.get $${targetName}`);
      } else if (memoryMap.has(targetName)) {
        insts.push(`global.get $${targetName}`);
      } else if (targetName.startsWith('0x') || targetName.startsWith('0u') || !isNaN(targetName)) {
        insts.push(`i64.const ${targetName}`);
      } else {
        insts.push(`i64.const 0`);
      }
      insts.push(`i64.const ${fieldMeta.offset + 8}`);
      insts.push(`i64.add`);
      insts.push(`${fieldMeta.type}.load`);
      return insts;
    }

    if (node.operator === '~' && node.position === 'postfix') {
      insts.push(...compileExpression(node.operand, locals, paramNames));
      return insts;
    }

    if (node.operator === '@') {
      if (node.position === 'prefix') {
        insts.push(...compileExpression(node.operand, locals, paramNames));
        return insts;
      }
      const targetName = getLHSName(node.right);
      const fName = getLHSName(node.left);
      const fieldMeta = findFieldMeta(fName);
      
      if (paramNames.includes(targetName) || locals.has(targetName)) {
        insts.push(`local.get $${targetName}`);
      } else if (memoryMap.has(targetName)) {
        insts.push(`global.get $${targetName}`);
      } else if (targetName.startsWith('0x') || targetName.startsWith('0u') || !isNaN(targetName)) {
        insts.push(`i64.const ${targetName}`);
      } else {
        insts.push(`i64.const 0`);
      }
      insts.push(`i64.const ${fieldMeta.offset + 8}`);
      insts.push(`i64.add`);
      insts.push(`${fieldMeta.type}.load`);
      return insts;
    }

    if (node.operator === '#') {
      // Infix store: option # [ type # type ... ]
      const targetName = getLHSName(node.left);
      
      if (node.right && node.right.type === 'block' && node.right.kind === 'bracket') {
        const innerStmts = flattenStatements(node.right.content);
        innerStmts.forEach(s => {
          if (s.type === 'operation' && s.operator === '#') {
            const fName = getLHSName(s.left);
            const fieldMeta = findFieldMeta(fName);
            
            // Push base address (option / parameter / local)
            if (paramNames.includes(targetName) || locals.has(targetName)) {
              insts.push(`local.get $${targetName}`);
            } else if (memoryMap.has(targetName)) {
              insts.push(`global.get $${targetName}`);
            } else if (targetName.startsWith('0x') || targetName.startsWith('0u') || !isNaN(targetName)) {
              insts.push(`i64.const ${targetName}`);
            } else {
              insts.push(`i64.const 0`);
            }
            insts.push(`i64.const ${fieldMeta.offset + 8}`);
            insts.push(`i64.add`);
            
            // Push value to store
            insts.push(...compileExpression(s.right, locals, paramNames));
            
            // Store
            insts.push(`${fieldMeta.type}.store`);
          }
        });
      }
      
      // Return the updated object pointer as the expression result
      if (paramNames.includes(targetName) || locals.has(targetName)) {
        insts.push(`local.get $${targetName}`);
      } else if (memoryMap.has(targetName)) {
        insts.push(`global.get $${targetName}`);
        insts.push(`i64.load`);
      } else if (targetName.startsWith('0x') || targetName.startsWith('0u') || !isNaN(targetName)) {
        insts.push(`i64.const ${targetName}`);
      } else {
        insts.push(`i64.const 0`);
      }
      return insts;
    }

    if (node.operator === ' ') {
      if (node.name === 'concat') {
        return compileStaticConcat(node, locals, paramNames);
      }
      if (node.name === 'compose') {
        const newLambdaName = `lambda_compose_${lambdaCounter++}`;
        const wrapperAst = {
          type: 'operation',
          operator: '?',
          left: 'p0',
          right: {
            type: 'operation',
            operator: ' ',
            name: 'apply',
            left: node.left,
            right: {
              type: 'operation',
              operator: ' ',
              name: 'apply',
              left: node.right,
              right: 'p0'
            }
          },
          lambdaName: newLambdaName
        };
        tableFunctions.push(newLambdaName);
        functionArities.set(newLambdaName, 1);
        functionHasRest.set(newLambdaName, false);
        
        compileFunction(newLambdaName, wrapperAst);
        
        const idx = tableFunctions.indexOf(newLambdaName);
        insts.push(`i64.const ${idx} ;; compose func_idx (${newLambdaName})`);
        return insts;
      }
      if (node.name === 'apply') {
        if (node.left && node.left.type === 'operation' && node.left.name === 'compose') {
          const desugaredApply = {
            type: 'operation',
            operator: ' ',
            left: node.left.right,
            right: {
              type: 'operation',
              operator: ' ',
              left: node.left.left,
              right: node.right,
              name: 'apply'
            },
            name: 'apply'
          };
          return compileExpression(desugaredApply, locals, paramNames);
        }


        let leftNode = node.left;
        while (leftNode && leftNode.type === 'block') {
          leftNode = leftNode.content;
        }

        // 1. Try currying flattening (collecting all nested apply arguments)
        const collectedArgs = [];
        let current = node;
        while (current && current.type === 'operation' && current.name === 'apply') {
          const innerArgs = [];
          if (current.right && current.right.type === 'coproduct_block') {
            current.right.statements.forEach(s => {
              innerArgs.push(...flattenConcat(s));
            });
          } else if (current.right !== undefined && current.right !== null) {
            innerArgs.push(...flattenConcat(current.right));
          }
          collectedArgs.unshift(...innerArgs);
          
          current = current.left;
          while (current && current.type === 'block') {
            current = current.content;
          }
        }

        const flatLeft = current;
        const flatFnName = getLHSName(flatLeft);
        let fnName = flatFnName;
        if (flatLeft && flatLeft.type === 'operation' && flatLeft.operator === '?' && flatLeft.lambdaName) {
          fnName = flatLeft.lambdaName;
          compileFunction(flatLeft.lambdaName, flatLeft);
        }

        const isStaticKnown = watFunctions.some(f => f.includes(`(func $${fnName}`)) || 
                              tableFunctions.includes(fnName) ||
                              (currentEnv && (currentEnv.has(fnName) || currentEnv.has(`<${fnName}>`)));
        
        const staticArity = functionArities.get(fnName);
        const hasRest = functionHasRest.get(fnName) || false;
        const hasExpandArg = collectedArgs.some(arg => arg && arg.type === 'operation' && arg.operator === '~' && arg.position === 'postfix');
        
        let canStaticCall = false;
        if (isStaticKnown && staticArity !== undefined) {
          if (!hasExpandArg) {
            canStaticCall = (!hasRest ? collectedArgs.length === staticArity : collectedArgs.length >= staticArity - 1);
          } else {
            if (hasRest) {
              canStaticCall = true;
            }
          }
        }

        if (canStaticCall) {
          // Use flattened arguments for optimized direct call
          const args = collectedArgs;
          if (!hasExpandArg) {
            // Optimized direct static call without expansion
            if (!hasRest) {
              args.forEach(arg => {
                insts.push(...compileExpression(arg, locals, paramNames));
              });
            } else {
              // Push normal arguments
              const normalCount = staticArity - 1;
              for (let i = 0; i < normalCount; i++) {
                insts.push(...compileExpression(args[i], locals, paramNames));
              }
              // Package the rest parameters into a single list
              if (args.length === normalCount) {
                insts.push(`i64.const 0 ;; empty rest parameter`);
              } else {
                insts.push(...compileExpression(args[normalCount], locals, paramNames));
                for (let i = normalCount + 1; i < args.length; i++) {
                  insts.push(...compileExpression(args[i], locals, paramNames));
                  markHelperNeeded('concat');
                  insts.push(`call $concat`);
                }
              }
            }
          } else {
            // Optimized direct static call WITH expansion
            const normalCount = staticArity - 1;
            let argIdx = 0;
            let currentExpandVar = null;

            for (let i = 0; i < normalCount; i++) {
              if (currentExpandVar) {
                insts.push(`local.get $${currentExpandVar}`);
                markHelperNeeded('list_head');
                insts.push(`call $list_head`);
                
                if (i < normalCount - 1) {
                  insts.push(`local.get $${currentExpandVar}`);
                  markHelperNeeded('list_tail');
                  insts.push(`call $list_tail`);
                  insts.push(`local.set $${currentExpandVar}`);
                }
              } else {
                if (argIdx < args.length) {
                  const arg = args[argIdx];
                  const isExpand = arg && arg.type === 'operation' && arg.operator === '~' && arg.position === 'postfix';
                  if (isExpand) {
                    insts.push(...compileExpression(arg.operand, locals, paramNames));
                    currentExpandVar = 'tmp_l';
                    insts.push(`local.set $${currentExpandVar}`);
                    
                    insts.push(`local.get $${currentExpandVar}`);
                    markHelperNeeded('list_head');
                    insts.push(`call $list_head`);
                    
                    if (i < normalCount - 1) {
                      insts.push(`local.get $${currentExpandVar}`);
                      markHelperNeeded('list_tail');
                      insts.push(`call $list_tail`);
                      insts.push(`local.set $${currentExpandVar}`);
                    }
                    argIdx++;
                  } else {
                    insts.push(...compileExpression(arg, locals, paramNames));
                    argIdx++;
                  }
                } else {
                  insts.push(`i64.const 0`);
                }
              }
            }

            if (hasRest) {
              if (currentExpandVar) {
                insts.push(`local.get $${currentExpandVar}`);
                markHelperNeeded('list_tail');
                insts.push(`call $list_tail`);
                
                while (argIdx < args.length) {
                  const nextArg = args[argIdx];
                  const isExpand = nextArg && nextArg.type === 'operation' && nextArg.operator === '~' && nextArg.position === 'postfix';
                  if (isExpand) {
                    insts.push(...compileExpression(nextArg.operand, locals, paramNames));
                  } else {
                    insts.push(...compileExpression(nextArg, locals, paramNames));
                  }
                  markHelperNeeded('concat');
                  insts.push(`call $concat`);
                  argIdx++;
                }
              } else {
                if (argIdx === args.length) {
                  insts.push(`i64.const 0 ;; empty rest`);
                } else {
                  const firstRest = args[argIdx];
                  const isExpand = firstRest && firstRest.type === 'operation' && firstRest.operator === '~' && firstRest.position === 'postfix';
                  if (isExpand) {
                    insts.push(...compileExpression(firstRest.operand, locals, paramNames));
                  } else {
                    insts.push(...compileExpression(firstRest, locals, paramNames));
                  }
                  argIdx++;
                  
                  while (argIdx < args.length) {
                    const nextArg = args[argIdx];
                    const isExpand = nextArg && nextArg.type === 'operation' && nextArg.operator === '~' && nextArg.position === 'postfix';
                    if (isExpand) {
                      insts.push(...compileExpression(nextArg.operand, locals, paramNames));
                    } else {
                      insts.push(...compileExpression(nextArg, locals, paramNames));
                    }
                    markHelperNeeded('concat');
                    insts.push(`call $concat`);
                    argIdx++;
                  }
                }
              }
            }
          }
          insts.push(`call $${fnName}`);
        } else {
          // If flat flattening is not statically callable, compile the original non-flat expression (for partial/dynamic apply)
          const args = [];
          if (node.right && node.right.type === 'coproduct_block') {
            node.right.statements.forEach(s => {
              args.push(...flattenConcat(s));
            });
          } else if (node.right !== undefined && node.right !== null) {
            args.push(...flattenConcat(node.right));
          }

          let origFnName = getLHSName(leftNode);
          if (leftNode && leftNode.type === 'operation' && leftNode.operator === '?' && leftNode.lambdaName) {
            origFnName = leftNode.lambdaName;
            compileFunction(leftNode.lambdaName, leftNode);
          }
          const isOrigStaticKnown = watFunctions.some(f => f.includes(`(func $${origFnName}`)) || 
                                tableFunctions.includes(origFnName) ||
                                (currentEnv && (currentEnv.has(origFnName) || currentEnv.has(`<${origFnName}>`)));
          const origStaticArity = functionArities.get(origFnName);
          const origHasExpandArg = args.some(arg => arg && arg.type === 'operation' && arg.operator === '~' && arg.position === 'postfix');

          // 静的既知関数だが引数が不足している場合 (部分適用)
          if (isOrigStaticKnown && origStaticArity !== undefined && args.length < origStaticArity && !origHasExpandArg) {
            const missingCount = origStaticArity - args.length;
            const newLambdaName = `lambda_part_${lambdaCounter++}`;

            const wrapperParams = [];
            const callArgs = [];

            // 1. バインドされた引数を退避するためのグローバル変数を生成・代入
            args.forEach((arg, idx) => {
              const globalName = `part_arg_${newLambdaName}_${idx}`;
              watGlobals.push(`  (global $${globalName} (mut i64) (i64.const 0))`);
              
              insts.push(...compileExpression(arg, locals, paramNames));
              insts.push(`global.set $${globalName}`);
              
              callArgs.push(`global.get $${globalName}`);
            });

            // 2. 不足しているパラメータ
            for (let k = 0; k < missingCount; k++) {
              const paramName = `p${k}`;
              wrapperParams.push({ name: paramName, isRest: false });
              callArgs.push(`local.get $${paramName}`);
            }

            // 3. ラッパー関数の WAT 生成
            const paramDefsStr = wrapperParams.map(p => `(param $${p.name} i64)`).join(' ');
            const bodyInsts = [];
            
            wrapperParams.forEach(p => {
              bodyInsts.push(`  local.get $${p.name}`);
              bodyInsts.push(`  i64.eqz`);
              bodyInsts.push(`  (if (then i64.const 0 return))`);
            });
            
            callArgs.forEach(argCmd => {
              bodyInsts.push(`  ${argCmd}`);
            });
            bodyInsts.push(`  call $${origFnName}`);

            const fnWat = [
              `  (func $${newLambdaName} ${paramDefsStr} (result i64)`,
              `    (local $tmp_l i64) (local $tmp_r i64)`,
              bodyInsts.join('\n'),
              `  )`
            ].join('\n');

            watFunctions.push(fnWat);
            tableFunctions.push(newLambdaName);
            functionArities.set(newLambdaName, missingCount);
            functionHasRest.set(newLambdaName, false);

            const idx = tableFunctions.indexOf(newLambdaName);
            insts.push(`i64.const ${idx}`);
            return insts;
          }

          // それ以外の動的な適用 (間接呼び出し)
          insts.push(...compileExpression(node.left, locals, paramNames));
          insts.push(`local.set $tmp_l`);
          insts.push(`local.get $tmp_l`);
          insts.push(`i64.eqz`);
          insts.push(`(if (result i64)`);
          insts.push(`  (then i64.const 0)`);
          insts.push(`  (else`);
          args.forEach(arg => {
            insts.push(...compileExpression(arg, locals, paramNames));
          });
          insts.push(`    local.get $tmp_l`);
          insts.push(`    i32.wrap_i64`);
          insts.push(`    call_indirect (type $t_arity_${args.length})`);
          insts.push(`  )`);
          insts.push(`)`);
        }
        return insts;
      }
    }
  }

  if (node.type === 'block') {
    if (node.kind === 'abs') {
      insts.push(...compileExpression(node.content, locals, paramNames));
      insts.push(`f64.reinterpret_i64`);
      insts.push(`f64.abs`);
      insts.push(`i64.reinterpret_f64`);
      return insts;
    }
    if (node.kind === 'bracket') {
      let content = node.content;
      while (content && content.type === 'block') {
        content = content.content;
      }
      const stmts = flattenStatements(content);
      const isDict = stmts.length > 0 && stmts.every(s => s && s.type === 'operation' && s.operator === ':');
      if (isDict) {
        const fieldNames = stmts.map(s => getLHSName(s.left));
        const targetStruct = findStructForPattern(fieldNames);
        const fieldsMap = targetStruct ? structFields.get(targetStruct) : null;
        
        const size = fieldNames.length * 8 + 8;
        markHelperNeeded('alloc_mem');
        insts.push(`i64.const ${size}`);
        insts.push(`call $alloc_mem`);
        insts.push(`local.set $tmp_l`);

        // Store struct fields count as length header at offset 0
        insts.push(`local.get $tmp_l`);
        insts.push(`i64.const ${fieldNames.length}`);
        insts.push(`i64.store`);
        
        stmts.forEach((s, idx) => {
          const fName = getLHSName(s.left);
          let offsetVal = 0;
          let fieldType = 'i64';
          if (fieldsMap && fieldsMap[fName]) {
            offsetVal = fieldsMap[fName].offset + 8;
            fieldType = fieldsMap[fName].type;
          } else {
            const meta = findFieldMeta(fName);
            // If findFieldMeta falls back to 0, use idx * 8 to avoid collision
            offsetVal = (meta.offset === 0 ? idx * 8 : meta.offset) + 8;
            fieldType = meta.type;
          }
          
          insts.push(`local.get $tmp_l`);
          insts.push(`i64.const ${offsetVal}`);
          insts.push(`i64.add`);
          
          insts.push(...compileExpression(s.right, locals, paramNames));
          insts.push(`${fieldType}.store`);
        });
        
        insts.push(`local.get $tmp_l`);
        return insts;
      }
    }
    if (node.kind === 'indent') {
      const stmts = flattenStatements(node.content);
      stmts.forEach((s, idx) => {
        if (isMatchCase(s, true)) {
          insts.push(...compileExpression(s.left, locals, paramNames));
          insts.push(`i64.const 0`);
          insts.push(`i64.ne`);
          insts.push(`(if`);
          insts.push(`  (then`);
          insts.push(...compileExpression(s.right, locals, paramNames));
          insts.push(`    return`);
          insts.push(`  )`);
          insts.push(`)`);
        } else {
          insts.push(...compileExpression(s, locals, paramNames));
          if (idx < stmts.length - 1) {
            insts.push(`drop`);
          }
        }
      });
      if (stmts.length > 0 && isMatchCase(stmts[stmts.length - 1], true)) {
        insts.push(`i64.const 0 ;; fallback unit`);
      }
      return insts;
    }
    return compileExpression(node.content, locals, paramNames);
  }

  return insts;
}

function getParameterSpecs(node) {
  if (!node) return [];
  if (typeof node === 'string') {
    const name = getLHSName(node);
    return [{ name, isRest: false }];
  }
  if (node.type === 'block') {
    if (node.kind === 'bracket') {
      const innerSpecs = getParameterSpecs(node.content);
      if (innerSpecs.length === 1 && innerSpecs[0].isRest) {
        return [{ name: innerSpecs[0].name, isRest: true }];
      }
      return [{ name: '_destruct_pattern', isDestructured: true, innerSpecs }];
    }
    return getParameterSpecs(node.content);
  }
  if (node.type === 'coproduct_block') {
    return (node.statements || []).flatMap(getParameterSpecs);
  }
  if (node.type === 'operation') {
    if (node.operator === '\\n' || node.operator === ' ' || node.operator === ',') {
      return [...getParameterSpecs(node.left), ...getParameterSpecs(node.right)];
    }
    if (node.operator === ':') {
      const leftSpecs = getParameterSpecs(node.left);
      const name = leftSpecs.length > 0 ? leftSpecs[0].name : getLHSName(node.left);
      const isRest = leftSpecs.length > 0 ? leftSpecs[0].isRest : false;
      return [{ name, isRest }];
    }
    if (node.operator === '~') {
      if (node.operand) {
        return getParameterSpecs(node.operand).map(p => ({ ...p, isRest: true }));
      }
      const leftSpecs = getParameterSpecs(node.left);
      const rightSpecs = getParameterSpecs(node.right).map(p => ({ ...p, isRest: true }));
      return [...leftSpecs, ...rightSpecs];
    }
  }
  return [{ name: getLHSName(node), isRest: false }];
}

export function getMemoryMap() {
  return memoryMap;
}

export function getStructFields() {
  return structFields;
}

export function getTableFunctions() {
  return tableFunctions;
}

function isMatchCase(node, isFuncBody = false) {
  if (!node) return false;
  if (node.type === 'operation' && node.operator === ':') {
    if (isFuncBody) return true;
    const left = node.left;
    if (left && typeof left === 'object' && left.type === 'operation') {
      return true;
    }
  }
  return false;
}

function isStaticLambda(node, locals = new Map(), paramNames = []) {
  if (!node) return false;

  let leftNode = node;
  while (leftNode && leftNode.type === 'block') {
    leftNode = leftNode.content;
  }

  if (leftNode && leftNode.type === 'operation' && leftNode.operator === '@' && leftNode.position === 'prefix') {
    return isStaticLambda(leftNode.operand, locals, paramNames);
  }

  if (typeof leftNode === 'string') {
    const cleanNode = getLHSName(leftNode);
    if (locals.has(cleanNode)) {
      const type = locals.get(cleanNode);
      if (type === 'i64' || type === 'list') {
        return false;
      }
    }
    const isKnownFunc = watFunctions.some(f => f.includes(`(func $${cleanNode}`)) || 
                         tableFunctions.includes(cleanNode) ||
                         (currentEnv && (currentEnv.has(cleanNode) || currentEnv.has(`<${cleanNode}>`)));
    if (isKnownFunc) {
      return true;
    }
    return false;
  }

  if (leftNode.type === 'operation') {
    if (leftNode.operator === '?') return true;
    if (leftNode.operator === ' ' && leftNode.name === 'compose') return true;
  }

  return false;
}

function flattenConcat(node) {
  if (!node) return [];
  if (node.type === 'operation' && node.name === 'concat') {
    return [...flattenConcat(node.left), ...flattenConcat(node.right)];
  }
  return [node];
}

function flattenProduct(node) {
  if (!node) return [];
  if (node.type === 'operation' && node.operator === ',') {
    return [...flattenProduct(node.left), ...flattenProduct(node.right)];
  }
  return [node];
}

