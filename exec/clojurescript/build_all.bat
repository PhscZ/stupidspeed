@echo off
rem Build the clojurescript row: cljs.main compiles each task's .cljs to one
rem JavaScript file ahead of time, which node then runs.
rem   exec\clojurescript\<task>\prog.js   artifact, run as `node prog.js`
rem The classpath's `.` is the task directory, where the .cljs source sits; cljs.main
rem needs the namespace to match the file name, so the compiler is given the
rem namespace (t<NN>-<name>) rather than the file.  Tasks 14 and 15 get the data.bin
rem fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\clojurescript
set OUT=%ROOT%\exec\clojurescript
set CLJS=%ROOT%\tools\clojurescript\cljs.jar
set JAVA=%ROOT%\tools\graalvm\bin\java.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\t%%T.cljs" "%OUT%\%%T\t%%T.cljs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  rem cljs.main takes the *namespace*: the file name with `_` written as `-`.
  set NS=t%%T
  set NS=!NS:_=-!
  rem -Xmx1g keeps the JVM's native footprint bounded: on a busy 12 GB host the
  rem default (1/4 of RAM) plus C2's arenas has run the compiler out of memory.
  "%JAVA%" -Xmx1g -Xms256m -cp "%CLJS%;." clojure.main -m cljs.main --target node --optimizations simple --output-dir out --output-to prog.js --compile-opts "{:warnings {:single-segment-namespace false}}" --compile "!NS!" >build.log 2>&1
  if errorlevel 1 (echo clojurescript-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo clojurescript-FAIL some task & exit /b 1)
echo clojurescript OK
endlocal
