@echo off
setlocal enabledelayedexpansion
rem Algol 68 Genie is a compiler-interpreter, so there is no compiled artifact. Its --compile
rem path emits C that includes <algol68g/a68g-*.h> and links against a68g's own runtime, and
rem this build reports "optimisation has no effect on this platform" (-O3 is a no-op), so the
rem executable form is not reachable here. exec\algol68 therefore holds the sources and this
rem runner rather than binaries.
rem a68g is a Cygwin binary: cygwin1.dll must be reachable, hence C:\cygwin64\bin on PATH.
set PATH=C:\cygwin64\bin;%PATH%
cd /d C:\stupidspeed\exec\algol68
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  C:\stupidspeed\tools\a68g\bin\a68g.exe %%T.a68
)
