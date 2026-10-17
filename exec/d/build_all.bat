@echo off
rem Build the d row: one source directory (sources\d, files named _<task>.d) over two
rem compilers.
rem   exec\d\dmd\<task>\prog.exe    dmd 2.100, its own backend
rem   exec\d\ldc2\<task>\prog.exe   ldc2 1.30, LLVM
rem The module name inside each file equals its file name (_01_branches), so the file is
rem copied into the task directory unchanged. -of names the artifact the registry wants,
rem prog.exe (the header's bare `-of=prog` would leave a file with no extension, which
rem exec\cells.json's `prog.exe` cmd could not start). Tasks 14 and 15 run in their own
rem directory and need the data.bin fixture there.
rem Usage: build_all.bat [dmd|ldc2]   (default: both)
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\d
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set WANT=%~1
if "%WANT%"=="" set WANT=all

if "%WANT%"=="all" goto :dmd
if /i "%WANT%"=="dmd" goto :dmd
if /i "%WANT%"=="ldc2" goto :ldc2
echo d-FAIL unknown toolchain %WANT% & exit /b 2

:dmd
set DMD=%ROOT%\tools\dmd\windows\bin\dmd.exe
set OUT=%ROOT%\exec\d\dmd
set PATH=%ROOT%\tools\dmd\windows\bin;%PATH%
for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.d" "%OUT%\%%T\_%%T.d" >nul || (echo d-FAIL dmd %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%DMD%" -O -release -of=prog.exe _%%T.d >build.log 2>&1
  if errorlevel 1 (popd & echo d-FAIL dmd %%T & exit /b 1)
  if not exist prog.exe (popd & echo d-FAIL dmd %%T & exit /b 1)
  popd
  echo OK dmd %%T
)
if /i "%WANT%"=="dmd" goto :eof

:ldc2
set LDC=%ROOT%\tools\ldc2\bin\ldc2.exe
set OUT=%ROOT%\exec\d\ldc2
set PATH=%ROOT%\tools\ldc2\bin;%PATH%
for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\_%%T.d" "%OUT%\%%T\_%%T.d" >nul || (echo d-FAIL ldc2 %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%LDC%" -O3 -release -of=prog.exe _%%T.d >build.log 2>&1
  if errorlevel 1 (popd & echo d-FAIL ldc2 %%T & exit /b 1)
  if not exist prog.exe (popd & echo d-FAIL ldc2 %%T & exit /b 1)
  popd
  echo OK ldc2 %%T
)
endlocal
