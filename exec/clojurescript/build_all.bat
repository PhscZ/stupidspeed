@echo off
setlocal enabledelayedexpansion
rem Build all 15 ClojureScript tasks.
rem   Toolchain: the ClojureScript release jar, tools\clojurescript\cljs.jar. It is a fat
rem   jar -- it bundles Clojure itself, the Google Closure compiler and cljs/core.cljs --
rem   so java is the only other thing needed. Run with java on PATH.
rem   The command line is the row's own, from the source header / BUILD.md:
rem     java -cp "<clojurescript>\cljs.jar;." clojure.main -m cljs.main --target node
rem       --optimizations simple --output-dir out --output-to prog.js
rem       --compile-opts "{:warnings {:single-segment-namespace false}}"
rem       --compile t<NN>-<name>
rem   The classpath's `.` is the cell's own directory: that is where the .cljs source sits
rem   and where cljs.main looks for the namespace named on the command line. The namespace
rem   must correspond to the file name, so the sources are t01_branches.cljs for
rem   (ns t01-branches) and so on.
rem   --optimizations simple bundles the Closure library and cljs.core into prog.js, so the
rem   built file is self-contained and node needs no module tree beside it; `out` is the
rem   intermediate tree Closure writes and is not read at run time.
rem   Output: exec\clojurescript\<task>\prog.js
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\clojurescript
set OUT=%~dp0
set CLJS=%ROOT%\tools\clojurescript\cljs.jar
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do (
  set "NAME=%%T"
  set "NS=!NAME:_=-!"
  mkdir "%OUT%\%%T" 2>nul
  copy /y "%SRC%\t%%T.cljs" "%OUT%\%%T\t%%T.cljs" >nul
  pushd "%OUT%\%%T"
  java -cp "%CLJS%;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile "t!NS!" > build.log 2>&1
  popd
  if exist "%OUT%\%%T\prog.js" ( echo OK %%T ) else ( echo clojurescript-FAIL %%T )
)
endlocal
