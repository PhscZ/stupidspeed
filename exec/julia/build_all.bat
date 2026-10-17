@echo off
rem Build the julia row: Julia 1.13 is a JIT, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\julia\julia\<task>\<task>.jl   artifact, run as `julia <task>.jl`
rem Task 11 must run as `julia -t4 <task>.jl` (RUN.md), so it is not special here:
rem the same file is staged.  Tasks 14 and 15 also need the data.bin fixture.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\julia
set OUT=%ROOT%\exec\julia\julia
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.jl" "%OUT%\%%T\%%T.jl" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if exist "%OUT%\%%T\%%T.jl" (echo OK %%T) else (echo julia-FAIL %%T & set FAIL=1)
)
if "%FAIL%"=="1" (echo julia-FAIL some task & exit /b 1)
echo julia OK
endlocal
