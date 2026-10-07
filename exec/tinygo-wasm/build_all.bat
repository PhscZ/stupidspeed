@echo off
setlocal
set ROOT=C:\stupidspeed
set SRC=%ROOT%\sources\tinygo-wasm
set OUT=%ROOT%\exec\tinygo-wasm\wasip1
set TINYGO=%ROOT%\tools\tinygo\bin\tinygo.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
exit /b 0

:build
set T=%1
if not exist "%OUT%\%T%" mkdir "%OUT%\%T%"
copy /y "%SRC%\%T%.go" "%OUT%\%T%\" >nul
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%T%\" >nul
del /q "%OUT%\%T%\out.bin" 2>nul
pushd "%OUT%\%T%"
"%TINYGO%" build -target=wasip1 -o prog.wasm %T%.go > build.log 2>&1
if errorlevel 1 (echo tinygo-wasm-FAIL %T%) else (echo OK %T%)
popd
exit /b 0
