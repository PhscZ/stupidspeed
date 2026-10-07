@echo off
rem Build the CPython 3.12.2 wasm32-wasip1-threads module (the python-wasm
rem row).  Runs build_wasm.sh under the MSYS2 bash the wasi-sdk build needs.
setlocal
set MSYS=C:\stupidspeed\tools\msys64\msys64\usr\bin\bash.exe
"%MSYS%" -c "cd /c/stupidspeed && sh exec/python-wasm/build_wasm.sh"
if errorlevel 1 (
  echo PYTHON-WASM-FAIL build_wasm
  exit /b 1
)
echo BUILD-WASM-OK
