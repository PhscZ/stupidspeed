@echo off
rem Run all thirty go cells the way exec\go\verify.py does: the gc and tinygo
rem executables, each in its own task directory, with data.bin staged for task 14.
rem Pass one task name to run just that task:  run_all.bat 07_string_append
rem The Go SDK is put in front of PATH as BUILD.md requires, because TinyGo shells
rem out to `go list`/`go env` (nothing at run time needs it, but the row keeps one
rem environment for both halves).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set GO=%ROOT%\tools\go\bin
if not exist "%GO%\go.exe" set GO=C:\Program Files\Go\bin
set PATH=%GO%;%PATH%
set TASKS=%*
if "%TASKS%"=="" set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%C in (gc tinygo) do (
  for %%T in (%TASKS%) do call :task %%C %%T
)
exit /b 0

:task
pushd "%ROOT%\exec\go\%~1\%~2"
if not exist prog.exe (
  echo MISSING exec\go\%~1\%~2\prog.exe
  popd
  exit /b 1
)
if "%~2"=="14_file_read" if not exist data.bin copy /y "%ROOT%\data.bin" data.bin >nul
if "%~2"=="15_file_write" if not exist data.bin copy /y "%ROOT%\data.bin" data.bin >nul
echo === %~1 %~2
prog.exe
popd
exit /b 0
