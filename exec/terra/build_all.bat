@echo off
setlocal
rem Terra row: no build step. terra.exe JIT-compiles the script in-process on every run, so
rem build_all stages the fifteen sources into exec\terra\terra\<task>\ and probes the
rem toolchain once.
rem   set VCINSTALLDIR=C:/fake/vc
rem   set INCLUDE=C:\stupidspeed\tools\llvm-mingw\include
rem   terra.exe <task>.t          (run from the task directory)
rem VCINSTALLDIR is the switch terralib needs before it will open any file: without a non-nil
rem value it aborts with "Can't find windows SDK version 8.1 or 10!" and exit 1. The path it
rem names is never read. INCLUDE points at the C sysroot the row's terralib.includec("stdio.h")
rem calls need -- every task includes stdio.h for fopen/fprintf/fclose, not just task 11.
rem Tasks 14 and 15 read and write data.bin/out.bin in the directory they run in, so the
rem 50 MiB fixture is copied into those two task directories.
rem Terra's stdio has no stderr handle, so TIME_MS is the contract's time.txt fallback: every
rem script writes time.txt in its working directory and verify.py reads it there.
set SRC=C:\stupidspeed\sources\terra
set EXEC=C:\stupidspeed\exec\terra
set DATA=C:\stupidspeed\data.bin
set TERRA=C:\stupidspeed\tools\terra\bin\terra.exe

set VCINSTALLDIR=C:/fake/vc
set INCLUDE=C:\stupidspeed\tools\llvm-mingw\include

rem One toolchain probe: the interpreter must start and JIT a trivial chunk.
"%TERRA%" -e "print('terra-probe-ok')" > "%TEMP%\terra_probe.log" 2>&1
if errorlevel 1 (
  echo TERRA-FAIL toolchain-probe
  type "%TEMP%\terra_probe.log"
  echo ALLDONE
  exit /b 1
)
echo OK toolchain-probe

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  mkdir "%EXEC%\terra\%%T" 2>nul
  copy /y "%SRC%\%%T.t" "%EXEC%\terra\%%T\" >nul
  echo no build step: "%TERRA%" %%T.t > "%EXEC%\terra\%%T\build.log"
  if exist "%EXEC%\terra\%%T\%%T.t" ( echo OK %%T ) else ( echo TERRA-FAIL %%T )
)

rem Task 03 loads its helper with terralib.loadfile, so it must sit beside 03_func_sum.t.
copy /y "%SRC%\03_func_sum_add_one.t" "%EXEC%\terra\03_func_sum\" >nul
if exist "%EXEC%\terra\03_func_sum\03_func_sum_add_one.t" ( echo OK 03_func_sum-helper ) else ( echo TERRA-FAIL 03_func_sum-helper )

rem Task 14 reads data.bin; task 15 reads nothing but writes out.bin beside it.
copy /y "%DATA%" "%EXEC%\terra\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\terra\15_file_write\" >nul
if exist "%EXEC%\terra\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo TERRA-FAIL 14_file_read-data )
if exist "%EXEC%\terra\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo TERRA-FAIL 15_file_write-data )
echo ALLDONE
