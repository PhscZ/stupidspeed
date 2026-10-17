@echo off
rem Run all fifteen PHP tasks of both toolchains the way exec\php\verify.py does.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set PHP=%ROOT%\tools\php-zts\php.exe
for %%C in (zend zend-jit) do (
  if "%%C"=="zend" (set JITFLAGS=) else (set JITFLAGS=-d opcache.enable_cli=1 -d opcache.jit=tracing -d opcache.jit_buffer_size=64M)
  for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\php\%%C\%%T"
    "%PHP%" !JITFLAGS! -d memory_limit=4096M %%T.php
    popd
  )
)
endlocal
