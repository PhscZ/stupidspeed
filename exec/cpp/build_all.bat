@echo off
setlocal enabledelayedexpansion
rem Build all 15 C++ tasks with three toolchains.
rem   g++     C:/mingw64/bin/g++.exe -O2 -pthread -o prog.exe <task>.cpp
rem   clang++ tools/llvm/bin/clang++.exe (LLVM 23, target windows-msvc) — needs the MSVC
rem           environment for headers and libraries, so INCLUDE/LIB/PATH come from
rem           tools/msvc_env.py; it has no headers of its own.
rem   msvc    cl /nologo /O2 /EHsc /Fe:prog.exe <task>.cpp
rem Output: exec\cpp\<toolchain>\<task>\prog.exe
set SRC=C:\stupidspeed\sources\cpp
set EXEC=C:\stupidspeed\exec\cpp
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## gpp
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\gpp\%%T" 2>nul
  cd /d "%EXEC%\gpp\%%T"
  copy /y "%SRC%\%%T.cpp" . >nul
  C:\mingw64\bin\g++.exe -O2 -pthread -o prog.exe %%T.cpp >build.log 2>&1
  if exist prog.exe ( echo OK gpp %%T ) else ( echo CPP-FAIL gpp %%T )
)

rem one MSVC environment for both clang++ and cl
for /f "usebackq delims=" %%L in (`python C:\stupidspeed\tools\msvc_env.py`) do %%L

echo ########## clangpp
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\clangpp\%%T" 2>nul
  cd /d "%EXEC%\clangpp\%%T"
  copy /y "%SRC%\%%T.cpp" . >nul
  C:\stupidspeed\tools\llvm\bin\clang++.exe -O2 -o prog.exe %%T.cpp >build.log 2>&1
  if exist prog.exe ( echo OK clangpp %%T ) else ( echo CPP-FAIL clangpp %%T )
)

echo ########## msvc
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\msvc\%%T" 2>nul
  cd /d "%EXEC%\msvc\%%T"
  copy /y "%SRC%\%%T.cpp" . >nul
  cl /nologo /O2 /EHsc /Fe:prog.exe %%T.cpp >build.log 2>&1
  if exist prog.exe ( echo OK msvc %%T ) else ( echo CPP-FAIL msvc %%T )
)
echo ALLDONE
