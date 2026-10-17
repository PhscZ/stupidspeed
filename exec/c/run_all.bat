@echo off
rem Run all ninety c-row programs the way exec\c\verify.py does: the six toolchains'
rem prog.exe, each in its own task directory.  CompCert's programs are Cygwin-linked,
rem so they get tools\cygwin\bin on PATH.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%C in (gcc clang tcc msvc zig-cc compcert) do (
  if "%%C"=="compcert" set "PATH=%ROOT%\tools\cygwin\bin;%PATH%"
  for %%T in (%TASKS%) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\c\%%C\%%T"
    prog.exe
    popd
  )
)
endlocal
