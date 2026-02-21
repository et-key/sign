@echo off
setlocal
set "DIR=%~dp0"
node "%DIR%sign.js" %*
endlocal
