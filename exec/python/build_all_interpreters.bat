@echo off
setlocal
rem Build all 15 tasks for the `python` row, toolchains cpython / pypy / graalpy.
rem There is no compilation step: each task is run directly as
rem   <interpreter> <task>.py
rem so "build" here only means staging the source file, and the data.bin fixture
rem for tasks 14 and 15, into the per-task run directory.
rem Sources: sources\python\ ; fixture: C:\stupidspeed\data.bin
rem Output: exec\python\<toolchain>\<task>\<task>.py
set SRC=C:\stupidspeed\sources\python
set EXEC=C:\stupidspeed\exec\python
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%I in (cpython pypy graalpy) do (
  echo ########## %%I
  for %%T in (%TASKS%) do (
    mkdir "%EXEC%\%%I\%%T" 2>nul
    copy /y "%SRC%\%%T.py" "%EXEC%\%%I\%%T\" >nul
    if "%%T"=="14_file_read" copy /y "%DATA%" "%EXEC%\%%I\%%T\" >nul
    if "%%T"=="15_file_write" copy /y "%DATA%" "%EXEC%\%%I\%%T\" >nul
    echo OK %%I %%T>"%EXEC%\%%I\%%T\build.log"
    echo OK %%I %%T
  )
)
echo ALLDONE
