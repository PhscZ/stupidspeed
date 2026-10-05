@echo off
setlocal
rem Build all 15 Lean 4 tasks — the `lean` (compiled) row.
rem   lean -c <task>.c <task>.lean     compiles the module to C
rem   leanc -O2 -o prog.exe <task>.c   links it
rem The sources are sources/lean4/. `leanc` drives the toolchain Lean ships with itself — the
rem clang, lld and Lean runtime DLLs all live in tools\lean4\bin — so that directory goes on
rem PATH first, or leanc cannot find its own linker. The interpreter (`lean --run <task>.lean`)
rem also works but is far slower on the 100-million-iteration loops, so the compiled route is
rem the measured one.
rem Output: exec\lean4\<task>\prog.exe
set LEANBIN=D:\Users\pedro.cardoso\stupidspeed\tools\lean4\bin
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\lean4
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\lean4
set PATH=%LEANBIN%;%PATH%

echo ########## lean4
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%EXEC%\%1" 2>nul
cd /d "%EXEC%\%1"
copy /y "%SRC%\%1.lean" . >nul
"%LEANBIN%\lean.exe" -c %1.c %1.lean >build.log 2>&1
if exist %1.c "%LEANBIN%\leanc.exe" -O2 -o prog.exe %1.c >>build.log 2>&1
if exist prog.exe ( echo OK lean4 %1 ) else ( echo LEAN-FAIL %1 )
exit /b 0
