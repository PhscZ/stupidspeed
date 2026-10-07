@echo off
setlocal enabledelayedexpansion
rem Build all 15 Oberon-07 (Akron Compiler.exe 1.69) tasks.
rem   Compiler.exe _<task>.ob07 win64con -out prog.exe     (run: prog.exe)
rem The compiler resolves the source file name and the lib\Windows\ import tree against the
rem process working directory, so each task is built from its own directory holding the
rem source, a copy of lib\Windows\ and the compiler. There is no optimisation switch.
rem Task 03 imports AddOne (AddOne.ob07); the compiler pulls the imported module in by
rem itself, so the helper is only copied, never compiled on its own line.
rem Tasks 14 and 15 need data.bin in the directory the program runs in.
set COMP=C:\stupidspeed\tools\oberon07\oberon-07-compiler-master
set SRC=C:\stupidspeed\sources\oberon07
set EXEC=C:\stupidspeed\exec\oberon07\akron
set DATA=C:\stupidspeed\data.bin

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\_%%T" 2>nul
  cd /d "%EXEC%\_%%T"
  copy /y "%SRC%\_%%T.ob07" . >nul
  if not exist lib\Windows mkdir lib\Windows
  xcopy /e /i /y "%COMP%\lib\Windows" "lib\Windows" >nul
  if "%%T"=="03_func_sum" copy /y "%SRC%\AddOne.ob07" . >nul
  if "%%T"=="14_file_read" copy /y "%DATA%" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%DATA%" data.bin >nul
  if exist prog.exe del prog.exe
  "%COMP%\Compiler.exe" _%%T.ob07 win64con -out prog.exe >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo OBERON07-FAIL %%T )
)
echo ALLDONE
