@echo off
rem Run all fifteen kotlin tasks the way exec\kotlin\verify.py does: the jvm toolchain
rem (`java -jar prog.jar`) and then the js toolchain (`tools\nodejs\node.exe prog.js`),
rem each from exec\kotlin\<task>\ , which is the cwd cells.json names.
setlocal
set ROOT=%~dp0..\..
set NODE=%ROOT%\tools\nodejs\node.exe
set ALL=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if "%~1"=="" (set TASKS=%ALL%) else (set TASKS=%*)
echo === jvm
for %%T in (%TASKS%) do (
  echo --- %%T
  pushd "%ROOT%\exec\kotlin\%%T"
  java -jar prog.jar
  popd
)
echo === js
for %%T in (%TASKS%) do (
  echo --- %%T
  pushd "%ROOT%\exec\kotlin\%%T"
  "%NODE%" prog.js
  popd
)
endlocal
