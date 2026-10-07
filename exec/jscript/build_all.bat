@echo off
rem jscript row: no build step, interpreted by Windows Script Host (cscript //E:JScript).
rem Stages each task's source into exec\jscript\wsh\<task>\, including the helper file
rem 03_func_sum_add_one.js that 03_func_sum.js loads with eval(ReadAll()), and the
rem data.bin fixture for tasks 14/15. Each copy is logged to build.log.
setlocal enabledelayedexpansion
set "ROW=jscript"
set "HERE=%~dp0"
set "SRC=%~dp0..\..\sources\jscript"
set "DATA=%~dp0..\..\data.bin"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

for %%F in (%TASKS%) do (
  set "D=%HERE%wsh\%%F"
  if not exist "!D!" mkdir "!D!"
  copy /Y "%SRC%\%%F.js" "!D!\%%F.js" > "!D!\build.log" 2>&1
  if errorlevel 1 (
    echo %ROW%-FAIL wsh/%%F
  ) else (
    if "%%F"=="03_func_sum" copy /Y "%SRC%\03_func_sum_add_one.js" "!D!\03_func_sum_add_one.js" >> "!D!\build.log" 2>&1
    if "%%F"=="14_file_read" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    if "%%F"=="15_file_write" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
    echo OK wsh/%%F
  )
)
endlocal
