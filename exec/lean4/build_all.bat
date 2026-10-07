@echo off
setlocal
rem Build all 15 Lean 4 tasks — the compiled `lean` row.
rem   lean -c <task>.c <task>.lean     compiles the module to C
rem   leanc -O2 -o prog.exe <task>.c   links it (leanc is Lean's own clang driver)
rem `leanc` finds the clang, lld and Lean runtime DLLs it ships in tools\lean4\bin, so that
rem directory must be first on PATH or the link step cannot find its own linker.
rem Output: exec\lean4\lean4\<task>\prog.exe
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\lean4
set OUT=%~dp0lean4
set LEANBIN=%ROOT%\tools\lean4\bin
set PATH=%LEANBIN%;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## lean4
for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
cd /d "%OUT%\%1"
copy /y "%SRC%\%1.lean" . >nul
"%LEANBIN%\lean.exe" -c %1.c %1.lean >build.log 2>&1
if exist %1.c "%LEANBIN%\leanc.exe" -O2 -o prog.exe %1.c >>build.log 2>&1
if exist prog.exe ( echo OK %1 ) else ( echo lean4-FAIL %1 )
exit /b 0
