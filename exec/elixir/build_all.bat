@echo off
rem Build the elixir row: Elixir has no build step -- `elixir <task>.exs` compiles
rem the script on every run -- so "building" a task is staging its script into the
rem directory the harness runs it from.
rem   exec\elixir\elixir\<task>\<task>.exs   artifact, run as `elixir <task>.exs`
rem Elixir needs the Erlang/OTP tree on PATH (it ships no runtime of its own).
rem Tasks 14 and 15 need the data.bin fixture in their run directory.
setlocal
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\elixir
set OUT=%ROOT%\exec\elixir\elixir
set FAILED=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
if %FAILED% neq 0 exit /b 1
exit /b 0

:build
set T=%1
if not exist "%OUT%\%T%" mkdir "%OUT%\%T%"
copy /y "%SRC%\%T%.exs" "%OUT%\%T%\%T%.exs" >nul
if errorlevel 1 (
  echo elixir-FAIL %T%
  set FAILED=1
  exit /b 0
)
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%T%\data.bin" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%T%\data.bin" >nul
echo OK %T%
exit /b 0
