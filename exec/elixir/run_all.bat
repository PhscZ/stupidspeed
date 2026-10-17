@echo off
rem Run all fifteen Elixir tasks the way exec\elixir\verify.py does.
rem Elixir needs the Erlang/OTP tree on PATH; the registry entry says the same.
setlocal
set ROOT=%~dp0..\..
set PATH=%ROOT%\tools\erlang\bin;%PATH%
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\elixir\elixir\%%T"
  cmd /c "%ROOT%\tools\elixir\bin\elixir.bat" %%T.exs
  popd
)
endlocal
