@echo off
setlocal enabledelayedexpansion
rem Build all 15 V (vlang 0.5.2) tasks.
rem   v -prod -cc x86_64-w64-mingw32-gcc -o prog.exe <task>.v    (run: prog.exe)
rem V compiles through a C backend, so a C compiler must be on PATH; -cc names the
rem MinGW-w64 gcc from the MSYS2 UCRT64 tree (without -cc, V falls back to the tcc it
rem bundles in thirdparty, which does not optimise the generated C). -prod is the
rem optimised, GC-enabled build.
rem Tasks 14 and 15 need the 50 MiB fixture data.bin in the directory they run in.
rem V caches the compiled `builtin` module under %USERPROFILE%\.vmodules\.cache and the
rem generated C under %TEMP%\v_0.  A cache entry left behind by a build with a DIFFERENT
rem C compiler (this host also has a MinGW-W64 MSVCRT gcc at C:\mingw64) is linked into
rem the new UCRT executable, and the mixed-CRT binary dies with 0xC0000005 before main.
rem The cache is cleared first so every object in this run comes from the UCRT64 gcc.
rem Output: exec\v\v\<task>\prog.exe
set "MSYSBIN=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin"
set "PATH=%MSYSBIN%;%PATH%"
set "VEXE=C:\stupidspeed\tools\v\v.exe"
if exist "%USERPROFILE%\.vmodules\.cache" rmdir /S /Q "%USERPROFILE%\.vmodules\.cache"
if exist "%TEMP%\v_0" rmdir /S /Q "%TEMP%\v_0"
set "ROW=v"
set "HERE=%~dp0"
set "SRC=%~dp0..\..\sources\v"
set "DATA=%~dp0..\..\data.bin"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

for %%F in (%TASKS%) do (
  set "D=%HERE%v\%%F"
  if not exist "!D!" mkdir "!D!"
  copy /Y "%SRC%\%%F.v" "!D!\%%F.v" > "!D!\build.log" 2>&1
  if "%%F"=="14_file_read" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
  if "%%F"=="15_file_write" copy /Y "%DATA%" "!D!\data.bin" >> "!D!\build.log" 2>&1
  cd /d "!D!"
  if exist prog.exe del /q prog.exe
  "%VEXE%" -prod -cc x86_64-w64-mingw32-gcc -o prog.exe %%F.v >> "!D!\build.log" 2>&1
  if exist prog.exe ( echo OK %%F ) else ( echo %ROW%-FAIL %%F )
)
endlocal
