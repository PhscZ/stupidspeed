@echo off
setlocal enabledelayedexpansion
rem Arc has no compiled form: the Racket host loads tools/arc/arc.arc and runs the .arc
rem file on every invocation, so exec\arc holds the sources plus this runner rather than
rem executables. boot.rkt is given by absolute path; the .arc name is relative to cwd.
set RK=C:\stupidspeed\tools\racket\Racket.exe
set BOOT=C:\stupidspeed\tools\arc\boot.rkt
cd /d C:\stupidspeed\exec\arc
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  "%RK%" -t "%BOOT%" -e "(anarki-windows-cli)" -- %%T.arc
)
