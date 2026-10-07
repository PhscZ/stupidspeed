@echo off
setlocal
rem Build all 15 Nelua tasks.
rem   cmd.exe /c <nelua>\nelua.bat -r -o <task>.exe <task>.nelua
rem -r (--release) is this compiler's -O2 equivalent: gcc -O2 -DNDEBUG plus the compiler's
rem `nochecks` pragma. The launcher has to go through cmd.exe, and `require` resolves against
rem the WORKING DIRECTORY rather than the source file's, so every task is built in its own
rem directory holding the sources it needs (task 03's helper module sits beside it).
rem The C backend needs gcc on PATH.
rem Output: exec\nelua\nelua\<task>\<task>.exe
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\nelua
set OUT=%~dp0nelua
set NELUA=%ROOT%\tools\nelua\nelua.bat
set GCCBIN=C:\mingw64\bin
set PATH=%GCCBIN%;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## nelua
for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\%1.nelua" . >nul
if "%1"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.nelua" . >nul
cmd.exe /c "%NELUA% -r -o %1.exe %1.nelua" >build.log 2>&1
if exist %1.exe ( echo OK %1 ) else ( echo nelua-FAIL %1 )
exit /b 0
