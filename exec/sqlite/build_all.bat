@echo off
rem SQLite row: the CLI is the whole toolchain, so "build" is just staging the
rem 15 .sql scripts (and data.bin for tasks 14/15) into their run directories.
setlocal enabledelayedexpansion
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set "SRC=%ROOT%\sources\sqlite"
set "OUT=%~dp0sqlite3"
set "FAILS=0"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn ^
            06_char_count 07_string_append 08_average 09_fib_recursive 10_pi ^
            11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  call :stage %%T
)
echo sqlite build done, failures=%FAILS%
if %FAILS% GTR 0 exit /b 1
exit /b 0

:stage
set "T=%~1"
set "D=%OUT%\%T%"
if not exist "%D%" mkdir "%D%"
copy /y "%SRC%\%T%.sql" "%D%\" >nul
if errorlevel 1 ( echo sqlite-FAIL %T% & set /a FAILS+=1 & exit /b 1 )
if /i "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%D%\" >nul
if /i "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%D%\" >nul
echo OK %T%
exit /b 0
