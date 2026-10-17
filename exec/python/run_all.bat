@echo off
rem Run the python row the way exec\python\verify.py does: every task of every
rem toolchain, in its own working directory.  The three interpreters are handed
rem the staged script; nuitka's standalone binary is run with no arguments from
rem inside its <task>.dist directory.
rem   exec\python\run_all.bat             the whole row
rem   exec\python\run_all.bat graalpy      one toolchain
setlocal
set ROOT=%~dp0..\..
set PYEXE=%LOCALAPPDATA%\Programs\Python\Python313\python.exe
set PYPY=%ROOT%\tools\pypy\pypy.exe
set GRAALPY=%ROOT%\tools\graalpy\graalpy-community3.13-25.4.4.1.1-windows-amd64\bin\graalpy.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set ONLY=all
if not "%~1"=="" set ONLY=%~1

call :one cpython
call :one pypy
call :one graalpy
call :one nuitka
exit /b 0

:one
set TC=%~1
if /i not "%ONLY%"=="all" if /i not "%ONLY%"=="%TC%" exit /b 0
set EXE=%PYEXE%
if /i "%TC%"=="pypy" set EXE=%PYPY%
if /i "%TC%"=="graalpy" set EXE=%GRAALPY%
for %%T in (%TASKS%) do (
  echo === %TC% %%T
  if /i "%TC%"=="nuitka" (
    pushd "%ROOT%\exec\python\nuitka\%%T\%%T.dist"
    "%%T.exe"
    popd
  ) else (
    pushd "%ROOT%\exec\python\%TC%\%%T"
    "%EXE%" %%T.py
    popd
  )
)
exit /b 0
