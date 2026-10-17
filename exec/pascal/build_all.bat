@echo off
rem Build the pascal row: Free Pascal, direct to object.
rem   exec\pascal\fpc\<task>\program   artifact, run as `program`
rem The host has no native x64 compiler, so the i386-win32 native compiler plus the
rem cross.x86_64-win64 add-on build with -Px86_64 (BUILD.md).  -oprogram with no
rem extension is what the registry's artifact path names.
rem Tasks 14 and 15 get the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\pascal
set OUT=%ROOT%\exec\pascal\fpc
set FPC=%ROOT%\tools\fpc\bin\i386-win32\fpc.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.pas" "%OUT%\%%T\%%T.pas" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%FPC%" -O3 -Px86_64 -oprogram %%T.pas >build.log 2>&1
  if errorlevel 1 (echo pascal-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo pascal-FAIL some task & exit /b 1)
echo pascal OK
endlocal
