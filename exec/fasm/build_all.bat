@echo off
setlocal enabledelayedexpansion
rem Assemble all 15 FASM tasks into exec\fasm\<task>.exe
rem   fasm <task>.asm <task>.exe
rem FASM.EXE must run with tools\fasm\INCLUDE as the working directory, because the sources
rem do `include 'win64a.inc'` and FASM resolves that relative to the current directory.
rem The sources and outputs are given as absolute paths. Windows x64 PE64 console, kernel32
rem only, no C runtime.
set FASM=C:\stupidspeed\tools\fasm\FASM.EXE
set INCDIR=C:\stupidspeed\tools\fasm\INCLUDE
set SRC=C:\stupidspeed\sources\fasm
set EXEC=C:\stupidspeed\exec\fasm

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  copy /y "%SRC%\%%T.asm" "%EXEC%\%%T.asm" >nul
  cd /d "%INCDIR%"
  "%FASM%" "%EXEC%\%%T.asm" "%EXEC%\%%T.exe" >"%EXEC%\%%T.build.log" 2>&1
  if exist "%EXEC%\%%T.exe" ( echo OK %%T ) else ( echo FASM-FAIL %%T )
)
echo ALLDONE
