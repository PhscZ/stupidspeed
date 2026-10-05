@echo off
setlocal
rem Build all 15 Nelua tasks.
rem   cmd.exe /c <nelua>\nelua.bat -r -o prog.exe <task>.nelua
rem -r (--release) is this compiler's -O2 equivalent: it expands to
rem `gcc ... -fwrapv -fno-strict-aliasing -O2 -DNDEBUG` and turns on the `nochecks` pragma.
rem -M/--maximum-performance is deliberately not used (-Ofast -march=native -flto=auto).
rem Two things shape the row. The launcher has to go through cmd.exe, and `require` resolves
rem against the WORKING DIRECTORY rather than the source file's, so every task is built in its
rem own directory holding the sources it needs — task 03's helper module beside it. The
rem repository's own Lua interpreter (tools\nelua\nelua-lua.exe, built from src/onelua.c) is
rem what nelua.bat uses; the host's Lua lacks the lfs/hasher/lpeglabel modules runner.lua needs.
rem The C backend needs gcc on PATH.
rem Output: exec\nelua\<task>\prog.exe
set NELUA=D:\Users\pedro.cardoso\stupidspeed\tools\nelua
set GCCBIN=D:\Users\pedro.cardoso\mingw64\bin
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\nelua
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\nelua
set PATH=%GCCBIN%;%PATH%

echo ########## nelua
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\%1.nelua" . >nul
copy /y "%SRC%\03_func_sum_add_one.nelua" . >nul
cmd.exe /c "%NELUA%\nelua.bat -r -o prog.exe %1.nelua" >build.log 2>&1
if exist prog.exe ( echo OK nelua %1 ) else ( echo NELUA-FAIL %1 )
exit /b 0
