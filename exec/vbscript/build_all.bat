@echo off
setlocal enabledelayedexpansion
rem Build all 15 VBScript tasks.
rem   wsh   Windows Script Host (cscript.exe, a Windows component): no build step.
rem         cscript parses and executes <task>.vbs on every run, so "building" is
rem         just staging the source into exec\vbscript\wsh\<task>\.
rem TIME_MS goes to stderr (WScript.StdErr), so no time.txt here.
set CS=C:\WINDOWS\system32\cscript.exe
set SRC=C:\stupidspeed\sources\vbscript
set EXEC=C:\stupidspeed\exec\vbscript
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

if not exist "%CS%" (
  echo VBSCRIPT-FAIL cscript.exe not found at %CS%
  echo ALLDONE
  exit /b 1
)

echo ########## wsh (cscript, interpreted -- no build step)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\wsh\%%T" 2>nul
  copy /y "%SRC%\%%T.vbs" "%EXEC%\wsh\%%T\" >nul
  echo no build step: cscript //nologo %%T.vbs interprets the source on every run > "%EXEC%\wsh\%%T\build.log"
  if exist "%EXEC%\wsh\%%T\%%T.vbs" ( echo OK %%T ) else ( echo VBSCRIPT-FAIL %%T )
)

rem tasks 14 and 15 need the 50 MiB fixture in the working directory
copy /y "%DATA%" "%EXEC%\wsh\14_file_read\data.bin" >nul
copy /y "%DATA%" "%EXEC%\wsh\15_file_write\data.bin" >nul

echo ALLDONE
