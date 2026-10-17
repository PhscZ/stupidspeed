@echo off
rem Run all fifteen VB.NET tasks the way exec\vbnet\verify.py does: the built
rem assembly of each task, run with the .NET 8 runtime from its own directory.
setlocal
set ROOT=%~dp0..\..
set DOTNET=%ROOT%\tools\dotnet8\dotnet.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\vbnet\dotnet\%%T"
  "%DOTNET%" bin\Release\net8.0\%%T.dll
  popd
)
endlocal
