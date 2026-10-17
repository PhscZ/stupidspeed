@echo off
rem Build the ruby row: CRuby is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\ruby\cruby-yjit\<task>\<task>.rb   artifact, run as `ruby.exe --yjit <task>.rb`
rem Tasks 14 and 15 get the data.bin fixture in their run directory.
rem Pass task names to build only those (e.g. build_all.bat 03_func_sum).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\ruby
set OUT=%ROOT%\exec\ruby\cruby-yjit
set ALL=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if "%~1"=="" (set TASKS=%ALL%) else (set TASKS=%*)
set FAILED=0
for %%T in (%TASKS%) do (
  call :build %%T
  if errorlevel 1 (set FAILED=1 & echo ruby-FAIL %%T) else (echo OK %%T)
)
if %FAILED%==1 exit /b 1
exit /b 0

:build
set T=%1
set D=%OUT%\%T%
if not exist "%D%" mkdir "%D%"
copy /y "%SRC%\%T%.rb" "%D%\%T%.rb" >nul || exit /b 1
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%D%\data.bin" >nul || exit /b 1
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%D%\data.bin" >nul || exit /b 1
exit /b 0
