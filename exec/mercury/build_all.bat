@echo off
setlocal enabledelayedexpansion
rem Mercury row: the build is mercury_compile --make <module> --grade <grade>.
rem
rem tools\mercury\bin\mmc is a POSIX shell script, so it is NOT driven: the real compiler
rem tools\mercury\bin\mercury_compile.exe is run directly. It needs
rem   - tools\mercury\bin on PATH      (mercury_compile.exe, mkinit.exe)
rem   - MERCURY_STDLIB_DIR             (the installed lib\mercury)
rem   - the MSYS2 UCRT64 gcc on PATH   (the C back end)
rem The C back end is driven through cmd.exe, which resolves `gcc` to its full path; that
rem matters because a bare `gcc` cannot compute its own install prefix here.
rem
rem The module name cannot start with a digit, so Mercury.modules maps m01_branches to
rem 01_branches.m and each task directory holds both files. mercury_compile names the
rem executable after the MODULE (m01_branches.exe), not the source file, and ignores -o.
rem
rem Every task uses --grade hlc.gc.pregen (the only non-parallel grade installed); task 11
rem is the one exception, hlc.par.gc, because hlc.gc.pregen cannot spawn native threads.
rem Tasks 14 and 15 read/write data.bin/out.bin in the directory they run in.
set PATH=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin;C:\stupidspeed\tools\mercury\bin;%PATH%
set MERCURY_STDLIB_DIR=C:\stupidspeed\tools\mercury\lib\mercury
set SRC=C:\stupidspeed\sources\mercury
set EXEC=C:\stupidspeed\exec\mercury
set DATA=C:\stupidspeed\data.bin

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  set "TASK=%%T"
  set "MOD=m%%T"
  set "GRADE=hlc.gc.pregen"
  if "%%T"=="11_parallel_sum" set "GRADE=hlc.par.gc"
  mkdir "%EXEC%\mmc\!TASK!" 2>nul
  copy /y "%SRC%\!TASK!.m" "%EXEC%\mmc\!TASK!\" >nul
  copy /y "%SRC%\Mercury.modules" "%EXEC%\mmc\!TASK!\" >nul
  cd /d "%EXEC%\mmc\!TASK!"
  if exist "!MOD!.exe" del /q "!MOD!.exe"
  echo mercury_compile --make !MOD! --grade !GRADE! > build.log
  mercury_compile --make !MOD! --grade !GRADE! >> build.log 2>&1
  if exist "!MOD!.exe" ( echo OK !TASK! ) else ( echo MERCURY-FAIL !TASK! )
)

copy /y "%DATA%" "%EXEC%\mmc\14_file_read\" >nul
copy /y "%DATA%" "%EXEC%\mmc\15_file_write\" >nul
if exist "%EXEC%\mmc\14_file_read\data.bin" ( echo OK 14_file_read-data ) else ( echo MERCURY-FAIL 14_file_read-data )
if exist "%EXEC%\mmc\15_file_write\data.bin" ( echo OK 15_file_write-data ) else ( echo MERCURY-FAIL 15_file_write-data )
echo ALLDONE
