@echo off
rem Run all fifteen tasks of every haxe toolchain the way exec\haxe\verify.py does.
rem exec\cells.json runs each toolchain with the task directory as cwd, so that is
rem where these run from too (tasks 14 and 15 need data.bin there).
setlocal
set ROOT=%~dp0..\..
set MONO=%ROOT%\tools\mono\Mono\bin\mono.exe
set NODE=%ROOT%\tools\nodejs\node.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
for %%T in (%TASKS%) do (
  echo === %%T hxcpp
  pushd "%ROOT%\exec\haxe\T%%T"
  out\T%%T.exe
  echo === %%T js
  "%NODE%" js\T%%T.js
  echo === %%T jvm
  java -jar jvm\T%%T.jar
  echo === %%T cs
  "%MONO%" cs\T%%T.exe
  popd
)
endlocal
