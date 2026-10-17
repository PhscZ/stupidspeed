@echo off
rem Build the clojure row: Clojure 1.12 has no build step -- clojure.main compiles
rem the file to bytecode on every run -- so "building" a task is staging its script
rem into the directory the harness runs it from.
rem   exec\clojure\<task>.clj   artifact, run as
rem     java -cp <three jars> clojure.main <task>.clj   (cwd exec\clojure)
rem Tasks 14 and 15 run in that same directory, so data.bin is staged there once.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\clojure
set OUT=%ROOT%\exec\clojure
set FAIL=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.clj" "%OUT%\%%T.clj" >nul
  if exist "%OUT%\%%T.clj" (echo OK %%T) else (echo clojure-FAIL %%T & set FAIL=1)
)
copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
if "%FAIL%"=="1" (echo clojure-FAIL some task & exit /b 1)
echo clojure OK
endlocal
