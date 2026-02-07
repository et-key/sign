
$Compiler = "aarch64-linux-gnu-gcc"
$Runtime = "proto\a6\runtime.s"
$Output = "proto\a6\output.s"
$Binary = "proto\a6\sign_compiler"

Write-Host "Building Sign Compiler..."

if (Get-Command $Compiler -ErrorAction SilentlyContinue) {
    & $Compiler -o $Binary $Runtime $Output -static -g
    if ($?) {
        Write-Host "Build Successful: $Binary"
    } else {
        Write-Host "Build Failed."
    }
} else {
    Write-Host "Compiler '$Compiler' not found. Please ensure AArch64 toolchain is installed."
    Write-Host "Command: $Compiler -o $Binary $Runtime $Output -static"
}
