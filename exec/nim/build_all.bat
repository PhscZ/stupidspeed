@echo off
setlocal
rem Build all 15 Nim tasks.
rem   nim c -d:release -o:prog.exe t<task>.nim    -> prog.exe
rem Nim's compiler rejects a module name that is not a valid identifier, and the sources are
rem named _01_branches.nim … _15_file_write.nim, so each is copied to t<task>.nim (no leading
rem underscore) before the build. -d:release is the optimisation: without it Nim emits a debug
rem build with checks on. The C backend needs gcc on PATH.
rem Output: exec\nim\<task>\prog.exe
set NIM=D:\Users\pedro.cardoso\stupidspeed\tools\nim\nim-2.2.12\bin\nim.exe
set GCCBIN=D:\Users\pedro.cardoso\mingw64\bin
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\nim
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\nim
set PATH=%GCCBIN%;%PATH%

echo ########## nim
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\_%1.nim" "t%1.nim" >nul
"%NIM%" c -d:release -o:prog.exe t%1.nim >build.log 2>&1
if exist prog.exe ( echo OK nim %1 ) else ( echo NIM-FAIL %1 )
exit /b 0
