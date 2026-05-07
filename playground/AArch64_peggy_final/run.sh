node compile.js $1
aarch64-linux-gnu-as ${1%.*}.s -o output.o
aarch64-linux-gnu-ld output.o -o a.out
qemu-aarch64 -L /usr/aarch64-linux-gnu ./a.out
echo Exit Code: $?
