@echo off
setlocal
rem Ring row: no build step. ring.exe interprets the script each run, so build_all stages
rem the fifteen sources into exec\ring\ring\<task>\.
rem   tools\ring\ring\bin\ring.exe <task>.ring      (run from the task directory)
rem The extracted tree must stay intact: load resolves ring\bin and ring\bin\load relative
rem to the executable, and task 11's `load "threads.ring"` needs the Threads extension
rem (bin\ring_threads.dll, built with gcc from the v1.27 source; the light release omits it).
rem Task 03 also needs its helper 03_func_sum_add_one.ring beside it.
rem Tasks 14 and 15 read and write data.bin/out.bin in the directory they run in, so the
rem 50 MiB fixture is copied into those two task directories.
rem Ring has no reachable stderr, so TIME_MS is the contract's time.txt fallback: every
rem script writes time.txt in its working directory and verify.py reads it there.
set SRC=C:\stupidspeed\sources\ring
set EXEC=C:\stupidspeed\exec\ring
set DATA=C:\stupidspeed\data.bin
set RING=C:\stupidspeed\tools\ring\ring\bin\ring.exe

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  mkdir "%EXEC%\ring\%%T" 2>nul
  copy /y "%SRC%\%%T.ring" "%EXEC%\ring\%%T\" >nul
  echo no build step: "%RING%" %%T.ring > "%EXEC%\ring\%%T\build.log"
  if exist "%EXEC%\ring\%%T\%%T.ring" ( echo OK %%T ) else ( echo RING-FAIL %%T )
)

rem Task 03's helper file lives beside the task and is pulled in with `load`.
copy /y "%SRC%\03_func_sum_add_one.ring" "%EXEC%\ring\03_func_sum\" >nul
if exist "%EXEC%\ring\03_func_sum\03_func_sum_add_one.ring" ( echo OK 03_func_sum-helper ) else ( echo RING-FAIL 03_func_sum-helper )

rem Task 14 reads data.bin; task 15 reads nothing but writes out.bin beside it.
copy /y "%DATA%" "%EXEC%\ring\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\ring\15_file_write\" >nul
if exist "%EXEC%\ring\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo RING-FAIL 14_file_read-data )
if exist "%EXEC%\ring\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo RING-FAIL 15_file_write-data )
echo ALLDONE
