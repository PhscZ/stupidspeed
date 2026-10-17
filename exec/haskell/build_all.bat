@echo off
rem Build the haskell row: the same fifteen Haskell sources through ghc.
rem   exec\haskell\ghc\T<task>\prog.exe   ghc -O2 -threaded -o prog T<task>.hs
rem -threaded is required for task 11, which spawns four capabilities and is run
rem as `prog +RTS -N4 -RTS`; the other fourteen tasks carry the same flag because
rem the row is built once and run both ways.
rem Tasks 14 and 15 need the data.bin fixture in the directory the program runs
rem in; task 15 leaves out.bin there.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\haskell
set GHC=%ROOT%\tools\ghc\bin\ghc.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\haskell\ghc\T%%T" mkdir "%ROOT%\exec\haskell\ghc\T%%T"
  copy /y "%SRC%\T%%T.hs" "%ROOT%\exec\haskell\ghc\T%%T\T%%T.hs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\haskell\ghc\T%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\haskell\ghc\T%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\haskell\ghc\T%%T"
  "%GHC%" -O2 -threaded -o prog T%%T.hs >build.log 2>&1
  if errorlevel 1 (echo haskell-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo haskell-FAIL some task & exit /b 1)
echo haskell OK
endlocal
