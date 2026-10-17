@echo off
rem Build the python row from sources\python\ -- fifteen tasks, four toolchains.
rem   exec\python\cpython\<task>\<task>.py          staged source, run by CPython 3.13
rem   exec\python\pypy\<task>\<task>.py             staged source, run by PyPy
rem   exec\python\graalpy\<task>\<task>.py          staged source, run by GraalPy
rem   exec\python\nuitka\<task>\<task>.dist\        `nuitka --standalone`, run as <task>.exe
rem The three interpreters run the sources unchanged, so building their tasks is
rem staging the script; only nuitka compiles.  Tasks 14 and 15 need the data.bin
rem fixture beside the program -- for nuitka that means inside <task>.dist, which
rem is the cell's working directory -- and task 15 leaves out.bin there.
rem   exec\python\build_all.bat              rebuilds all four toolchains
rem   exec\python\build_all.bat nuitka       rebuilds one of them
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\python
set PYEXE=%LOCALAPPDATA%\Programs\Python\Python313\python.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set ONLY=all
if not "%~1"=="" set ONLY=%~1

call :build cpython
if errorlevel 1 exit /b 1
call :build pypy
if errorlevel 1 exit /b 1
call :build graalpy
if errorlevel 1 exit /b 1
call :build nuitka
if errorlevel 1 exit /b 1
echo python build complete
exit /b 0

:build
set TC=%~1
if /i not "%ONLY%"=="all" if /i not "%ONLY%"=="%TC%" exit /b 0
echo === python %TC%
set BAD=
for %%T in (%TASKS%) do (
  set OUT=%ROOT%\exec\python\%TC%\%%T
  if not exist "!OUT!" mkdir "!OUT!"
  copy /y "%SRC%\%%T.py" "!OUT!\%%T.py" >nul
  if errorlevel 1 set BAD=%%T
  if not defined BAD if /i not "%TC%"=="nuitka" if "%%T"=="14_file_read" call :fixture "!OUT!"
  if not defined BAD if /i not "%TC%"=="nuitka" if "%%T"=="15_file_write" call :fixture "!OUT!"
  if not defined BAD if /i "%TC%"=="nuitka" (
    pushd "!OUT!"
    rem --assume-yes-for-downloads keeps nuitka from stopping to ask about the
    rem zig-based C backend it downloads on first use.
    "%PYEXE%" -m nuitka --standalone --assume-yes-for-downloads "%%T.py" > build.log 2>&1
    popd
    if not exist "!OUT!\%%T.dist\%%T.exe" set BAD=%%T
    rem The nuitka cell's working directory is <task>.dist, so that is where the
    rem fixture has to sit.
    if not defined BAD if "%%T"=="14_file_read" call :fixture "!OUT!\%%T.dist"
    if not defined BAD if "%%T"=="15_file_write" call :fixture "!OUT!\%%T.dist"
  )
  if defined BAD echo python-FAIL %%T
  if defined BAD if /i "%TC%"=="nuitka" echo   see "!OUT!\build.log"
  if not defined BAD echo OK %%T
)
if defined BAD exit /b 1
exit /b 0

:fixture
rem A hard link is a second name for the repository's one 50 MiB data.bin; fall
rem back to a copy if the link fails (different volume).
if exist "%~1\data.bin" del "%~1\data.bin"
mklink /H "%~1\data.bin" "%ROOT%\data.bin" >nul 2>&1 || copy /y "%ROOT%\data.bin" "%~1\data.bin" >nul
exit /b 0
