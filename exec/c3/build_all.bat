@echo off
setlocal enabledelayedexpansion
rem Build all 15 C3 tasks with c3c.
rem c3c compile -O2 --wincrt=dynamic --win-sdk <sdk> -L <vc> -L <ucrt> -L <um> -o prog <task>.c3
rem The three -L paths and --win-sdk point the LLVM backend at the hand-extracted MSVC
rem tree; without them c3c downloads an SDK of its own. --wincrt=dynamic links the system
rem ucrtbase.dll/vcruntime140.dll so no runtime DLL is needed beside the exe.
rem -o prog (not prog.exe): c3c appends .exe itself, so -o prog.exe makes prog.exe.exe.
set C3C=C:\stupidspeed\tools\c3\c3\c3c.exe
set SDK=C:\stupidspeed\tools\msvc\Windows Kits\10
set VC=C:\stupidspeed\tools\msvc\VC\Tools\MSVC\14.44.35207\lib\x64
set UCRT=C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\ucrt\x64
set UM=C:\stupidspeed\tools\msvc\Windows Kits\10\Lib\10.0.26100.0\um\x64
set SRC=C:\stupidspeed\sources\c3
set EXEC=C:\stupidspeed\exec\c3

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.c3" . >nul
  "%C3C%" compile -O2 --wincrt=dynamic --win-sdk "%SDK%" -L "%VC%" -L "%UCRT%" -L "%UM%" -o prog %%T.c3 >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo C3-FAIL %%T )
)
echo ALLDONE
