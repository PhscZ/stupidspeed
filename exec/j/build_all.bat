@echo off
rem J row (jconsole 9.7): no build step, interpreted.
rem   run: jconsole.exe <task>.ijs
rem This script only stages each task's source (plus AddOne.ijs for task 03, and the
rem data.bin fixture for 14/15) into exec\j\j9.7\<task>\ and logs the copy to build.log.
rem The run line is a plain `jconsole.exe <task>.ijs`; -jprofile must NOT be used, it
rem skips the profile that loads the standard library (stdout/LF/exit). Every script
rem ends with `exit 0` so jconsole does not drop into the interactive prompt.
setlocal enabledelayedexpansion
set "ROW=j"
set "HERE=%~dp0"
set "SRC=%~dp0..\..\sources\j"
set "DATA=%~dp0..\..\data.bin"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

for %%F in (%TASKS%) do (
  set "D=%HERE%j9.7\%%F"
  if not exist "!D!" mkdir "!D!"
  copy /Y "%SRC%\%%F.ijs" "!D!\%%F.ijs" > "!D!\build.log" 2>&1
  if errorlevel 1 (
    echo %ROW%-FAIL %%F
  ) else (
    if "%%F"=="03_func_sum" copy /Y "%SRC%\AddOne.ijs" "!D!\AddOne.ijs" >> "!D!\build.log" 2>&1
    if "%%F"=="14_file_read" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    if "%%F"=="15_file_write" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    echo OK %%F
  )
)
endlocal
