node parser.js test_min.sn test_min.json
node compiler.js test_min.json -o test_min.s
sed -i 's/ldr x0, num_0/mov x0, #100\\n    bl _print_int\\n    ldr x0, num_0/g' test_min.s
aarch64-linux-gnu-gcc -nostartfiles -static test_min.s runtime.s -o test_min
./test_min
