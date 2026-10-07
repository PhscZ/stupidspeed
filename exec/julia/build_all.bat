@echo off
setlocal enabledelayedexpansion
rem Build all 15 Julia tasks.
rem Julia has NO build step: a script is parsed, and each method is JIT-compiled on its first
rem call, i.e. inside the measured cell. So "building" here only stages each task into its own
rem directory next to the fixture it needs.
rem   run: tools\julia\bin\julia.exe <task>.jl
rem   task 11 must run with -t4, or its four Threads.@threads workers share one thread.
rem Sources: sources\julia\<task>.jl  ->  exec\julia\julia\<task>\<task>.jl
set JULIA=C:\stupidspeed\tools\julia\bin\julia.exe
set SRC=C:\stupidspeed\sources\julia
set EXEC=C:\stupidspeed\exec\julia\julia
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## julia
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%%T" 2>nul
  copy /y "%SRC%\%%T.jl" "%EXEC%\%%T\" >nul
  if "%%T"=="14_file_read" copy /y "%DATA%" "%EXEC%\%%T\" >nul
  if "%%T"=="15_file_write" copy /y "%DATA%" "%EXEC%\%%T\" >nul
  echo no build step: %%T.jl is staged; Julia parses and JIT-compiles it inside the measured run. > "%EXEC%\%%T\build.log"
  if exist "%EXEC%\%%T\%%T.jl" ( echo OK %%T ) else ( echo JULIA-FAIL %%T )
)
echo ALLDONE
