@echo off
setlocal enabledelayedexpansion
rem Build all 15 C tasks with each of the four toolchains.
rem   gcc   C:/mingw64/bin/gcc.exe -O2 -pthread -o prog.exe <task>.c
rem   clang tools/llvm/bin/clang.exe (LLVM 23, target windows-msvc) — needs the MSVC
rem         environment for headers and libraries, so INCLUDE/LIB/PATH come from
rem         tools/msvc_env.py; it has no headers of its own.
rem   tcc   tools/tcc/tcc.exe -o prog.exe <task>.c
rem   msvc  cl /nologo /O2 /Fe:prog.exe <task>.c   (same env)
rem Output: exec\c\<toolchain>\<task>\prog.exe
set SRC=C:\stupidspeed\sources\c
set EXEC=C:\stupidspeed\exec\c
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## gcc
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\gcc\%%T" 2>nul
  cd /d "%EXEC%\gcc\%%T"
  copy /y "%SRC%\%%T.c" . >nul
  C:\mingw64\bin\gcc.exe -O2 -pthread -o prog.exe %%T.c >build.log 2>&1
  if exist prog.exe ( echo OK gcc %%T ) else ( echo C-FAIL gcc %%T )
)

echo ########## tcc
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\tcc\%%T" 2>nul
  cd /d "%EXEC%\tcc\%%T"
  copy /y "%SRC%\%%T.c" . >nul
  C:\stupidspeed\tools\tcc\tcc.exe -o prog.exe %%T.c >build.log 2>&1
  if exist prog.exe ( echo OK tcc %%T ) else ( echo C-FAIL tcc %%T )
)

rem one MSVC environment for both clang and cl
for /f "usebackq delims=" %%L in (`python C:\stupidspeed\tools\msvc_env.py`) do %%L

echo ########## clang
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\clang\%%T" 2>nul
  cd /d "%EXEC%\clang\%%T"
  copy /y "%SRC%\%%T.c" . >nul
  C:\stupidspeed\tools\llvm\bin\clang.exe -O2 -o prog.exe %%T.c >build.log 2>&1
  if exist prog.exe ( echo OK clang %%T ) else ( echo C-FAIL clang %%T )
)

echo ########## msvc
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\msvc\%%T" 2>nul
  cd /d "%EXEC%\msvc\%%T"
  copy /y "%SRC%\%%T.c" . >nul
  cl /nologo /O2 /Fe:prog.exe %%T.c >build.log 2>&1
  if exist prog.exe ( echo OK msvc %%T ) else ( echo C-FAIL msvc %%T )
)
echo ALLDONE
