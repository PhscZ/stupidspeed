@echo off
setlocal enabledelayedexpansion
rem Build all 15 Haskell tasks with GHC into exec\haskell\ghc\<task>\prog.exe
rem   ghc -O2 -threaded -o prog.exe <task>.hs
rem   run: prog.exe            (task 11: prog.exe +RTS -N4 -RTS)
rem -threaded is required for task 11 (forkIO + MVar needs a threaded runtime and
rem capabilities to schedule onto); the GHC bindist bundles its own MinGW, so no MSVC.
set GHC=C:\stupidspeed\tools\ghc\bin\ghc.exe
set SRC=C:\stupidspeed\sources\haskell
set EXEC=C:\stupidspeed\exec\haskell\ghc

for %%T in (T01_branches T02_switch_case T03_func_sum T04_array_sum T05_alloc_churn T06_char_count T07_string_append T08_average T09_fib_recursive T10_pi T11_parallel_sum T12_matrix_add T13_matrix_mul T14_file_read T15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\*.hs" . >nul
  "%GHC%" -O2 -threaded -o prog.exe %%T.hs >build.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo GHC-FAIL %%T )
)
echo ALLDONE
