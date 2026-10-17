@echo off
rem Build the fasm row: flat assembler emits the PE64 console executable itself, with no
rem separate link step.
rem   exec\fasm\<task>.asm   staged copy of the source
rem   exec\fasm\<task>.exe   artifact, run as `exec/fasm/<task>.exe` with cwd exec/fasm
rem FASM resolves `include 'win64a.inc'` relative to its *working directory* and has no -I
rem option, so it is run with tools\fasm\INCLUDE as the cwd and the source/output are given
rem as absolute paths. tasks 14 and 15 also get the data.bin fixture beside them.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\fasm
set OUT=%ROOT%\exec\fasm
set FASM=%ROOT%\tools\fasm\FASM.EXE
set INCDIR=%ROOT%\tools\fasm\INCLUDE
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

if not exist "%OUT%" mkdir "%OUT%"
for %%T in (%TASKS%) do (
  copy /y "%SRC%\%%T.asm" "%OUT%\%%T.asm" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
)

pushd "%INCDIR%"
for %%T in (%TASKS%) do (
  "%FASM%" "%OUT%\%%T.asm" "%OUT%\%%T.exe" > "%OUT%\%%T.build.log" 2>&1
  if errorlevel 1 (echo fasm-FAIL %%T & set FAIL=1) else (echo OK %%T)
)
popd

if "%FAIL%"=="1" (echo fasm-FAIL some task & exit /b 1)
echo fasm OK
endlocal
