@echo off
rem Build the erlang-compiled row: erlc compiles each module-form .erl into a .beam.
rem   exec\erlang-compiled\<task>\<task>.beam   artifact, run by `erl -noshell -s <task> main -s init stop`
rem The source's own header says erlc writes <task>.beam into the CURRENT directory, so
rem each source is copied into its task directory and erlc is run from there. Tasks 14
rem and 15 read the data.bin fixture from their working directory (task 15 also writes
rem out.bin there).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\erlang-compiled
set OUT=%ROOT%\exec\erlang-compiled
set ERLC=%ROOT%\tools\erlang\bin\erlc.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.erl" "%OUT%\%%T\%%T.erl" >nul || (echo erlang-compiled-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%ERLC%" %%T.erl >build.log 2>&1
  if errorlevel 1 (popd & echo erlang-compiled-FAIL %%T & exit /b 1)
  if not exist "%%T.beam" (popd & echo erlang-compiled-FAIL %%T & exit /b 1)
  popd
  echo OK %%T
)
endlocal
