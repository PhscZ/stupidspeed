@echo off
setlocal
rem Assemble all 15 MASM tasks into exec\masm\<task>.exe
rem   ml64.exe /nologo /c /Fo <task>.obj <task>.asm
rem   link.exe /nologo /subsystem:console /entry:main /out:<task>.exe <task>.obj kernel32.lib
rem ml64 and link come from the MSVC tree the msvc row already installs, so INCLUDE/LIB/PATH
rem are taken from tools\msvc_env.py. Same shape as the fasm and nasm rows — freestanding PE64
rem console, kernel32.dll only, no C runtime — in MASM syntax instead of NASM's. Task 11 issues
rem CreateThread and WaitForSingleObject itself.
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\masm
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\masm
mkdir "%EXEC%" 2>nul
for /f "usebackq delims=" %%L in (`python D:\Users\pedro.cardoso\stupidspeed\tools\msvc_env.py`) do %%L
cd /d "%EXEC%"

echo ########## masm
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.asm" . >nul
  ml64.exe /nologo /c /Fo %%T.obj %%T.asm >%%T.build.log 2>&1
  if exist %%T.obj link.exe /nologo /subsystem:console /entry:main /out:%%T.exe %%T.obj kernel32.lib >>%%T.build.log 2>&1
  if exist %%T.exe ( echo OK %%T ) else ( echo MASM-FAIL %%T )
)
echo ALLDONE
