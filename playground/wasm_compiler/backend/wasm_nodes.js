import { Operators } from './operators.js';

export function emitNode(node, emit, deps) {
    if (!node) return ``;

    switch (node.type) {
        case 'NumberLiteral':
            return `(f64.const ${node.value})`;
        case 'LocalGet':
        case 'ProjectGet':
            return `(local.get $${node.name})`;
        case 'LocalSet':
            return `(local.set $${node.name} ${emit(node.value)})`;
        case 'BinOp':
            if (Operators[node.operator] && Operators[node.operator].emit) {
                return Operators[node.operator].emit(emit(node.left), emit(node.right), node.left, node.right);
            }
            throw new Error(`WasmEmitterError: Unhandled binary operator '${node.operator}'`);
        case 'PrefixOp':
            if (Operators[node.operator] && Operators[node.operator].emit) {
                return Operators[node.operator].emit(emit(node.operand), null, node.operand, null);
            }
            throw new Error(`WasmEmitterError: Unhandled prefix operator '${node.operator}'`);
        case 'ListAlloc':
            deps.add('__list_alloc_2');
            return `(call $__list_alloc_2 ${emit(node.left)} ${emit(node.right)})`;
        case 'Coproduct':
            deps.add('__list_alloc_2');
            return `(call $__list_alloc_2 ${emit(node.left)} ${emit(node.right)})`;
        case 'Expand':
            // Assume target evaluates to a List pointer (Tag 3)
            return `(block (result f64)
                (local.set $__tmp_ptr_expand (i64.trunc_f64_u (f64.abs ${emit(node.target)})))
                (local.set $__tmp_f64 (f64.load offset=16 (local.get $__tmp_ptr_expand))) ;; funcPtr (e0)
                (local.set $__tmp_ptr (i64.trunc_f64_u (f64.abs (local.get $__tmp_f64))))
                (call_indirect (type $func_sig)
                    ;; CTX
                    (select 
                        (i64.const 0)
                        (local.get $__tmp_ptr)
                        (f64.lt (local.get $__tmp_f64) (f64.const 1000000))
                    )
                    ;; ARG (e1)
                    (f64.load offset=24 (local.get $__tmp_ptr_expand))
                    ;; FUNC_INDEX
                    (select
                        (i32.trunc_f64_u (f64.sub (f64.max (local.get $__tmp_f64) (f64.const 500000)) (f64.const 500000)))
                        (i32.trunc_f64_u (f64.load offset=8 (local.get $__tmp_ptr)))
                        (f64.lt (local.get $__tmp_f64) (f64.const 1000000))
                    )
                )
            )`;
        case 'Sequence':
            return `(block (result f64) (drop ${emit(node.left)}) ${emit(node.right)})`;
        case 'PureFuncPtr':
            return `(f64.const ${node.funcIndex + 500000})`;
        case 'Factorial':
            deps.add('factorial');
            return `(call $factorial ${emit(node.target)})`;
        case 'CallDirect':
            return `(call $${node.funcName} (i64.const 0) ${node.args.map(a => emit(a)).join(' ')})`;
        case 'CallPartialAlloc':
            deps.add('alloc_partial_1');
            // Emits a call to a built-in partial allocator.
            return `(call $alloc_partial_1 (f64.const 0) ${node.args.map(a => emit(a)).join(' ')})`; // 0 is a placeholder func index
        case 'CallDynamicUnpack':
            // Check if it's a pure function index (between 500000 and 1000000) or a closure/partial struct (>= 1000000)
            return `(block (result f64)
                (local.set $__tmp_f64 ${emit(node.funcPtr)})
                (local.set $__tmp_ptr (i64.trunc_f64_u (f64.abs (local.get $__tmp_f64))))
                (call_indirect (type $func_sig)
                    ;; CTX
                    (select 
                        (i64.const 0)
                        (local.get $__tmp_ptr)
                        (f64.lt (local.get $__tmp_f64) (f64.const 1000000))
                    )
                    ;; ARG
                    ${node.args.map(a => emit(a)).join(' ')}
                    ;; FUNC_INDEX
                    (select
                        (i32.trunc_f64_u (f64.sub (f64.max (local.get $__tmp_f64) (f64.const 500000)) (f64.const 500000)))
                        (i32.trunc_f64_u (f64.load offset=8 (local.get $__tmp_ptr)))
                        (f64.lt (local.get $__tmp_f64) (f64.const 1000000))
                    )
                )
            )`;
        case 'CallIndirect':
            return `(call_indirect (type $func_sig) ${node.args.map(a => emit(a)).join(' ')} ${emit(node.funcPtr)})`;
        case 'ClosureAlloc': {
            const size = 24 + node.freeVars.length * 8;
            const alloc = [];
            alloc.push(`(local.set $__tmp_ptr (global.get $arena_ptr))`);
            alloc.push(`(global.set $arena_ptr (i64.add (global.get $arena_ptr) (i64.const ${size})))`);
            alloc.push(`(i32.store (local.get $__tmp_ptr) (i32.const 2))`); // Tag 2
            alloc.push(`(f64.store offset=8 (local.get $__tmp_ptr) (f64.const ${node.funcIndex}))`);
            alloc.push(`(f64.store offset=16 (local.get $__tmp_ptr) (f64.const ${node.freeVars.length}))`);
            for (let i = 0; i < node.freeVars.length; i++) {
                const v = node.freeVars[i];
                alloc.push(`(f64.store offset=${24 + i * 8} (local.get $__tmp_ptr) (local.get $${v.outerName}))`);
            }
            alloc.push(`(f64.convert_i64_u (local.get $__tmp_ptr))`);
            return `(block (result f64) ${alloc.join(' ')})`;
        }
        case 'ProjectDef':
            return ``;
        case 'ArrayAlloc': {
            const capacity = node.elements.length;
            const size = 16 + capacity * 8;
            const alloc = [];
            alloc.push(`(local.set $__tmp_ptr (global.get $arena_ptr))`);
            alloc.push(`(global.set $arena_ptr (i64.add (global.get $arena_ptr) (i64.const ${size})))`);
            // Set Tag = 5 (Dense Array)
            alloc.push(`(f64.store offset=0 (local.get $__tmp_ptr) (f64.const 5))`);
            // Set Capacity
            alloc.push(`(f64.store offset=8 (local.get $__tmp_ptr) (f64.const ${capacity}))`);
            // Store elements contiguously
            for (let i = 0; i < capacity; i++) {
                alloc.push(`(f64.store offset=${16 + i * 8} (local.get $__tmp_ptr) ${emit(node.elements[i])})`);
            }
            // Return array ptr
            alloc.push(`(f64.convert_i64_u (local.get $__tmp_ptr))`);
            return `(block (result f64) ${alloc.join(' ')})`;
        }
        case 'StructAlloc': {
            // maxIndex dictates capacity. Size is (maxIndex + 1) * 8 + 16 (for Tag and Capacity)
            const capacity = node.maxIndex + 1;
            const size = 16 + capacity * 8;
            const alloc = [];
            alloc.push(`(local.set $__tmp_ptr (global.get $arena_ptr))`);
            alloc.push(`(global.set $arena_ptr (i64.add (global.get $arena_ptr) (i64.const ${size})))`);
            // Set Tag = 4
            alloc.push(`(f64.store offset=0 (local.get $__tmp_ptr) (f64.const 4))`);
            // Set Capacity
            alloc.push(`(f64.store offset=8 (local.get $__tmp_ptr) (f64.const ${capacity}))`);
            // Initialize all fields to NaN (Missing/Unit)
            for (let i = 0; i < capacity; i++) {
                alloc.push(`(f64.store offset=${16 + i * 8} (local.get $__tmp_ptr) (f64.const nan))`);
            }
            // Store properties
            for (const prop of node.properties) {
                alloc.push(`(f64.store offset=${16 + prop.index * 8} (local.get $__tmp_ptr) ${emit(prop.value)})`);
            }
            // Return struct ptr
            alloc.push(`(f64.convert_i64_u (local.get $__tmp_ptr))`);
            return `(block (result f64) ${alloc.join(' ')})`;
        }
        case 'StructLoad': {
            return `(block (result f64)
                (local.set $__tmp_ptr (i64.trunc_f64_u (f64.abs ${emit(node.ptr)})))
                (if (result f64) (f64.lt (f64.const ${node.index}) (f64.load offset=8 (local.get $__tmp_ptr)))
                    (then (f64.load offset=${16 + node.index * 8} (local.get $__tmp_ptr)))
                    (else (f64.const nan))
                )
            )`;
        }
        default:
            throw new Error(`CodegenError: Unhandled node type '${node.type}'`);
    }
}
