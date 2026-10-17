@echo off
rem Run all fifteen Clojure tasks the way exec\clojure\verify.py does.
setlocal
set ROOT=%~dp0..\..
set CP=%ROOT%\tools\clojure\clojure-1.12.0.jar;%ROOT%\tools\clojure\spec.alpha-0.5.238.jar;%ROOT%\tools\clojure\core.specs.alpha-0.4.74.jar
pushd "%ROOT%\exec\clojure"
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  java -cp "%CP%" clojure.main %%T.clj
)
popd
endlocal
