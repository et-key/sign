#!/bin/bash
set -e

echo "Building Sign Compiler (Linux/AArch64)..."

gcc -o sign_compiler runtime.s output.s -static -g -nostartfiles

if [ $? -eq 0 ]; then
    echo "✓ Build Successful: sign_compiler"
    echo ""
    echo "To run:"
    echo "  ./sign_compiler"
else
    echo "✗ Build Failed"
    exit 1
fi
