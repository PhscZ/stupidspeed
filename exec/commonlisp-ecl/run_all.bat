@echo off
rem Run all fifteen built Common Lisp programs the way exec\commonlisp-ecl\verify.py does.
rem The run line is `--eval "(load "<task>.fas" :verbose nil)"`, not `--load`: --load writes
rem ";;; Loading #P\"...\"" to stdout and each task prints one line and nothing else.
setlocal
set ROOT=%~dp0..\..
set ECL=%ROOT%\tools\ecl\ecl.exe
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  pushd "%ROOT%\exec\commonlisp-ecl\%%T"
  "%ECL%" --norc --eval "(load \"%%T.fas\" :verbose nil)"
  popd
)
endlocal
