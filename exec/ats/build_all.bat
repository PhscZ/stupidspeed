@echo off
setlocal enabledelayedexpansion
rem Build all 15 ATS tasks into exec\ats\<task>\prog.exe
rem patscc is a driver: patsopt turns the .dats into C, then a C compiler builds it. The
rem produced executable imports cygwin1.dll, because the whole toolchain is a Cygwin build,
rem so C:\cygwin64\bin must be on PATH both to compile AND to run.
rem PATSHOME must be in CYGWIN form (/cygdrive/c/...): patscc is a Cygwin binary and a
rem Windows-style path makes it fail to open its own prelude files.
rem Task 03 splits add_one into its own translation unit (03_func_sum_add_one.dats, with
rem the 03_func_sum_add_one.sats interface) so -O2 cannot inline it; both .dats go on the line.
set PATSHOME=/cygdrive/c/stupidspeed/tools/ats
set PATH=C:\cygwin64\bin;C:\stupidspeed\tools\ats\bin;%PATH%
set SRC=C:\stupidspeed\sources\ats
set EXEC=C:\stupidspeed\exec\ats

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.dats" . >nul
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\03_func_sum_add_one.dats" . >nul
    copy /y "%SRC%\03_func_sum_add_one.sats" . >nul
    patscc -DATS_MEMALLOC_LIBC -O2 -o prog.exe 03_func_sum.dats 03_func_sum_add_one.dats >patscc.log 2>&1
  ) else (
    patscc -DATS_MEMALLOC_LIBC -O2 -o prog.exe %%T.dats >patscc.log 2>&1
  )
  if exist prog.exe ( echo OK %%T ) else ( echo ATS-FAIL %%T )
)
echo ALLDONE
