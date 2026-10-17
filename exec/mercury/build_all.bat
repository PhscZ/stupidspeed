@echo off
rem Build the mercury row: Mercury 22.01.9 (mmc -> C -> MSYS2 UCRT64 gcc).
rem   exec\mercury\mmc\<task>\m<task>.exe   artifact, run as `m<task>.exe`
rem The module name cannot start with a digit, so sources\mercury\Mercury.modules
rem maps m<NN>_<name> onto <NN>_<name>.m; every module of the row is staged in each
rem task directory so `--make` can find the one task 03 imports.
rem Grade: hlc.gc.pregen for every task, except task 11 which needs hlc.par.gc
rem (the default grade has no concurrency).  Tasks 14 and 15 also need data.bin.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\mercury
set OUT=%ROOT%\exec\mercury\mmc
set MERC=%ROOT%\tools\mercury
set "PATH=%ROOT%\tools\msys64\msys64\ucrt64\bin;%MERC%\bin;%PATH%"
set "MERCURY_STDLIB_DIR=%MERC%\lib\mercury"
set "MERCURY_CONFIG_DIR=%MERC%\lib\mercury"
set "MERCURY_COMPILER=%MERC%\bin\mercury_compile"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\*.m" "%OUT%\%%T\" >nul
  copy /y "%SRC%\Mercury.modules" "%OUT%\%%T\" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%OUT%\%%T"
  set GRADE=hlc.gc.pregen
  if "%%T"=="11_parallel_sum" set GRADE=hlc.par.gc
  rem A real rebuild: copy /y keeps the sources' timestamps, so a stale Mercury\
  rem tree would make `--make` skip a module whose text had changed, and the .o
  rem files also carry the previous grade.  Wipe them and let mmc compile again.
  if exist "Mercury" rmdir /s /q "Mercury"
  if exist "m%%T.exe" del /q "m%%T.exe"
  "%MERCURY_COMPILER%" --make m%%T --grade !GRADE! >build.log 2>&1
  if not exist "m%%T.exe" (echo mercury-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo mercury-FAIL some task & exit /b 1)
echo mercury OK
endlocal
