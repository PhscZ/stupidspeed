@echo off
rem Build the erlang row: escript has no build step, so "building" a task is
rem staging its script into the directory the harness runs it from.
rem   exec\erlang\<task>.erl   artifact, run as `escript <task>.erl` with cwd exec\erlang
rem escript compiles the script to BEAM bytecode on every run; that per-run
rem compile is the point of this row.  Tasks 14 and 15 need the data.bin fixture
rem in the working directory, and task 15 leaves out.bin there.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\erlang
set OUT=%ROOT%\exec\erlang
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.erl" "%OUT%\%%T.erl" >nul || (echo erlang-FAIL %%T & exit /b 1)
  echo OK %%T
)
copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul || (echo erlang-FAIL data.bin & exit /b 1)
endlocal
