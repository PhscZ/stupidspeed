@echo off
rem Run all fifteen javascript tasks the way exec\javascript\verify.py does --
rem every toolchain of the row, in registry order, from the directory the
rem registry names.
setlocal
set ROOT=%~dp0..\..
set BUN=C:\Users\pz020\.bun\bin\bun.exe
set DENO=%ROOT%\tools\deno\deno.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo === bun
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\javascript\bun\%%T"
  "%BUN%" %%T.js
  popd
)

echo === deno
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\javascript\deno\%%T"
  if "%%T"=="11_parallel_sum" (
    "%DENO%" run --unstable-detect-cjs --allow-read %%T.js
  ) else if "%%T"=="14_file_read" (
    "%DENO%" run --unstable-detect-cjs --allow-read %%T.js
  ) else if "%%T"=="15_file_write" (
    "%DENO%" run --unstable-detect-cjs --allow-write %%T.js
  ) else (
    "%DENO%" run --unstable-detect-cjs %%T.js
  )
  popd
)
endlocal
