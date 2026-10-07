@echo off
setlocal enabledelayedexpansion
rem Build all 15 Jython tasks.
rem Jython has NO build step: it is an interpreter running on the JVM. So "building" here only
rem stages each Python-2 task into its own directory next to the fixture it needs.
rem   run: tools\openj9\bin\java.exe -jar tools\jython\jython-standalone-2.7.4.jar <task>.py
rem Sources: sources\jython\<task>.py  ->  exec\jython\jython\<task>\<task>.py
set JAVA=C:\stupidspeed\tools\openj9\bin\java.exe
set JYTHON=C:\stupidspeed\tools\jython\jython-standalone-2.7.4.jar
set SRC=C:\stupidspeed\sources\jython
set EXEC=C:\stupidspeed\exec\jython\jython
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## jython
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\%%T" 2>nul
  copy /y "%SRC%\%%T.py" "%EXEC%\%%T\" >nul
  if "%%T"=="14_file_read" copy /y "%DATA%" "%EXEC%\%%T\" >nul
  if "%%T"=="15_file_write" copy /y "%DATA%" "%EXEC%\%%T\" >nul
  echo no build step: %%T.py is staged; Jython interprets it on the JVM at run time. > "%EXEC%\%%T\build.log"
  if exist "%EXEC%\%%T\%%T.py" ( echo OK %%T ) else ( echo JYTHON-FAIL %%T )
)
echo ALLDONE
