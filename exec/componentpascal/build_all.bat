@echo off
setlocal enabledelayedexpansion
rem Build all 15 Component Pascal (gpcp-NET) tasks.
rem   gpcp /list- _<task>.cp
rem A Component Pascal module name must equal its file name and cannot start with a digit,
rem hence the leading underscore. gpcp has no optimisation levels. Build and run from the
rem directory holding the source, with CROOT pointing at the gpcp-NET tree, CPSYM covering
rem its symfiles, and its bin/ on PATH. The compiler emits _<task>.exe.
rem Runtime DLLs beside the exe: RTS.dll always; RealStr.dll for task 08 (it formats the
rem real); GPFiles.dll/GPBinFiles.dll for the file tasks 14 and 15.
rem Task 03 compiles its helper module _03_func_sum_add_one.cp first (it leaves a .dll the
rem main module calls across the assembly boundary), then the main module.
set CROOT=C:\stupidspeed\tools\gpcp\gpcp-NET
set CPSYM=.;%CROOT%\symfiles;%CROOT%\symfiles\NetSystem
set PATH=%CROOT%\bin;%PATH%
set SRC=C:\stupidspeed\sources\componentpascal
set EXEC=C:\stupidspeed\exec\componentpascal

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\_%%T" 2>nul
  cd /d "%EXEC%\_%%T"
  copy /y "%SRC%\_%%T.cp" . >nul
  copy /y "%CROOT%\bin\RTS.dll" . >nul
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\_03_func_sum_add_one.cp" . >nul
    gpcp /list- _03_func_sum_add_one.cp >build.log 2>&1
  )
  if "%%T"=="08_average" copy /y "%CROOT%\bin\RealStr.dll" . >nul
  if "%%T"=="14_file_read" (
    copy /y "%CROOT%\bin\GPFiles.dll" . >nul
    copy /y "%CROOT%\bin\GPBinFiles.dll" . >nul
  )
  if "%%T"=="15_file_write" (
    copy /y "%CROOT%\bin\GPFiles.dll" . >nul
    copy /y "%CROOT%\bin\GPBinFiles.dll" . >nul
  )
  gpcp /list- _%%T.cp >build.log 2>&1
  if exist _%%T.exe ( echo OK %%T ) else ( echo GPCP-FAIL %%T )
)
echo ALLDONE
