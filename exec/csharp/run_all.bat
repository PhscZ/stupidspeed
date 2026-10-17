@echo off
rem Run all sixty csharp-row programs the way exec\csharp\verify.py does: each task's
rem artifact from the cwd exec\csharp\<toolchain>\<task> that exec\cells.json records.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set MONO=%ROOT%\tools\mono\Mono\bin\mono.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%C in (coreclr nativeaot mono mono-aot) do (
  for %%T in (%TASKS%) do (
    echo === %%C %%T
    pushd "%ROOT%\exec\csharp\%%C\%%T"
    if "%%C"=="coreclr" bin\Release\net8.0\%%T.exe
    if "%%C"=="nativeaot" bin\Release\net8.0\win-x64\publish\%%T.exe
    if "%%C"=="mono" "%MONO%" %%T.exe
    if "%%C"=="mono-aot" "%MONO%" --full-aot %%T.exe
    popd
  )
)
endlocal
