@echo off
setlocal enabledelayedexpansion
rem Build all 15 GnuCOBOL tasks.
rem   cobc -x -O2 -o prog.exe <task>.cob      (fixed-format source)
rem GnuCOBOL comes from the MSYS2 UCRT64 tree, so its bin dir goes on PATH for the
rem compiler's own DLLs and COB_CONFIG_DIR/COB_COPY_DIR point at the shipped config and
rem copybooks (the compiler otherwise looks for /ucrt64/share/gnucobol, which the MinGW
rem build cannot resolve outside its MSYS root).
rem The shipped sources had two fixed-format lines past column 72 (the COMPUTE CS0/CS1
rem clock conversions), which fixed-format silently truncates; those two lines are wrapped.
set MSYSBIN=C:\stupidspeed\tools\msys64\msys64\ucrt64\bin
set PATH=%MSYSBIN%;%PATH%
set COB_CONFIG_DIR=C:\stupidspeed\tools\msys64\msys64\ucrt64\share\gnucobol\config
set COB_COPY_DIR=C:\stupidspeed\tools\msys64\msys64\ucrt64\share\gnucobol\copy
set SRC=C:\stupidspeed\sources\cobol
set EXEC=C:\stupidspeed\exec\cobol

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.cob" . >nul
  cobc -x -O2 -o prog.exe %%T.cob >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo COBOL-FAIL %%T )
)
echo ALLDONE
