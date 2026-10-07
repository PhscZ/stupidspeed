@echo off
setlocal enabledelayedexpansion
rem Build all 15 R tasks for both toolchains of this row:
rem   gnu-r         run: tools\r\bin\Rscript.exe <task>.R
rem   gnu-r-nojit   the same sources, run with R_ENABLE_JIT=0 in the environment
rem
rem R has NO build step: Rscript parses and byte-compiles each script as it starts,
rem i.e. the compile work lands inside the measured run. So "building" here only
rem stages each task into its own directory next to the fixture it needs.
rem Task 11 uses the bundled parallel package in PSOCK mode (four R processes).
rem Tasks 14/15 need C:\stupidspeed\data.bin in the working directory.
set RSCRIPT=C:\stupidspeed\tools\r\bin\Rscript.exe
set SRC=C:\stupidspeed\sources\r
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%C in (gnu-r gnu-r-nojit) do (
  echo ########## r %%C
  for %%T in (%TASKS%) do (
    set EXEC=C:\stupidspeed\exec\r\%%C\%%T
    mkdir "!EXEC!" 2>nul
    copy /y "%SRC%\%%T.R" "!EXEC!\" >nul
    if "%%T"=="14_file_read" copy /y "%DATA%" "!EXEC!\" >nul
    if "%%T"=="15_file_write" copy /y "%DATA%" "!EXEC!\" >nul
    echo no build step: %%T.R is staged; Rscript parses and byte-compiles it inside the measured run. > "!EXEC!\build.log"
    if exist "!EXEC!\%%T.R" ( echo OK %%T ) else ( echo R-FAIL %%T )
  )
)
echo ALLDONE
