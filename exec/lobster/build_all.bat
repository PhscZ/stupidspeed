@echo off
setlocal
rem Lobster row: no build step. lobster.exe compiles the script to bytecode and runs it in
rem one go, so build_all stages the fifteen sources into exec\lobster\lobster\<task>\.
rem   tools\lobster\bin\lobster.exe <task>.lobster      (run from the task directory)
rem Tasks 14 and 15 read and write data.bin/out.bin in the directory they run in, so the
rem 50 MiB fixture is copied into those two task directories.
rem Lobster has no stderr, so TIME_MS is the contract's time.txt fallback: every script
rem writes time.txt in its working directory and verify.py reads it there.
set SRC=C:\stupidspeed\sources\lobster
set EXEC=C:\stupidspeed\exec\lobster
set DATA=C:\stupidspeed\data.bin
set LOBSTER=C:\stupidspeed\tools\lobster\bin\lobster.exe

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  mkdir "%EXEC%\lobster\%%T" 2>nul
  copy /y "%SRC%\%%T.lobster" "%EXEC%\lobster\%%T\" >nul
  echo no build step: "%LOBSTER%" %%T.lobster > "%EXEC%\lobster\%%T\build.log"
  if exist "%EXEC%\lobster\%%T\%%T.lobster" ( echo OK %%T ) else ( echo LOBSTER-FAIL %%T )
)

rem Task 14 reads data.bin; task 15 reads nothing but writes out.bin beside it.
copy /y "%DATA%" "%EXEC%\lobster\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\lobster\15_file_write\" >nul
if exist "%EXEC%\lobster\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo LOBSTER-FAIL 14_file_read-data )
if exist "%EXEC%\lobster\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo LOBSTER-FAIL 15_file_write-data )
echo ALLDONE
