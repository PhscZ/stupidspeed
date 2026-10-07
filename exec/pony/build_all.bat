@echo off
setlocal enabledelayedexpansion
rem Pony row: ponyc 0.65.0, one toolchain.
rem   build: mkdir <task> && cp sources\pony\<task>.pony <task>\ && ponyc -o <task> <task>
rem ponyc compiles a DIRECTORY as one package and all fifteen files declare a Main
rem actor, so each task is copied into its own scratch directory named after it and
rem built from there. Task 14 also gets the data.bin fixture in its run directory.
rem Output: exec\pony\ponyc\<task>\<task>.exe
set SRC=C:\stupidspeed\sources\pony
set EXEC=C:\stupidspeed\exec\pony\ponyc
set PONYC=C:\stupidspeed\tools\ponyc\bin\ponyc.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

cd /d "%EXEC%"
for %%T in (%TASKS%) do (
  mkdir "%%T" 2>nul
  copy /y "%SRC%\%%T.pony" "%%T\" >nul
  if %%T==14_file_read copy /y "C:\stupidspeed\data.bin" "%%T\" >nul
  if %%T==15_file_write copy /y "C:\stupidspeed\data.bin" "%%T\" >nul
  "%PONYC%" -o "%%T" "%%T" > "%%T\build.log" 2>&1
  if exist "%%T\%%T.exe" ( echo OK %%T ) else ( echo PONY-FAIL %%T )
)
echo ALLDONE
