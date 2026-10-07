@echo off
setlocal enabledelayedexpansion
rem Build all 15 Ada tasks into exec\ada\<task>\<task>.exe
rem gnatmake drives the GCC pipeline: gcc -c, gnatbind, gnatlink. Output is named after
rem the source unit (t01_branches.adb -> t01_branches.exe), so each task gets its own dir.
set GNATBIN=C:\stupidspeed\tools\alire_home\cache\toolchains\gnat_native_16.1.0_bbd69633\bin
set PATH=%GNATBIN%;%PATH%
set SRC=C:\stupidspeed\sources\ada
set EXEC=C:\stupidspeed\exec\ada

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\t%%T.adb" . >nul
  gnatmake -O3 t%%T.adb >gnatmake.log 2>&1
  if exist "t%%T.exe" ( echo OK %%T ) else ( echo FAIL %%T & type gnatmake.log )
)
echo ALLDONE
