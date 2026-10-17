@echo off
rem Build the php row: PHP is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from, once per toolchain.
rem   exec\php\zend\<task>\<task>.php       zend      (plain interpreter)
rem   exec\php\zend-jit\<task>\<task>.php   zend-jit  (-d opcache.enable_cli=1 -d opcache.jit=tracing ...)
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\php
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%C in (zend zend-jit) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\php\%%C\%%T" mkdir "%ROOT%\exec\php\%%C\%%T"
    copy /y "%SRC%\%%T.php" "%ROOT%\exec\php\%%C\%%T\%%T.php" >nul
    if errorlevel 1 (echo php-FAIL %%C %%T & set FAIL=1) else (echo OK %%T %%C)
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\php\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\php\%%C\%%T\data.bin" >nul
  )
)

if "%FAIL%"=="1" (echo php-FAIL some task & exit /b 1)
echo php OK
endlocal
