@echo off
setlocal
rem Build all 15 Scala.js tasks.
rem   Toolchain: scala-cli (tools\scala-cli\scala-cli.exe), which downloads the
rem   Scala 3.9.0 / Scala.js 1.22.0 compiler itself; nothing else is needed beyond a
rem   JDK for scala-cli to run on (JAVA_HOME below).
rem   The command line is the row's own, from the source header / BUILD.md:
rem     scala-cli --power package <task>.scala --js -o prog.js --force --jvm system
rem   Output: exec\scala-js\<task>\prog.js, run by tools\nodejs\node.exe from that
rem   directory. The .js output is self-contained: node needs no module tree beside it.
rem   scala-cli writes a .scala-build cache directory per cell; it is a byproduct, not
rem   the artifact.
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\scala-js
set OUT=%~dp0
set SCALA_CLI=%ROOT%\tools\scala-cli\scala-cli.exe
set JAVA_HOME=C:\Program Files\Java\jdk-24
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.scala" "%OUT%\%1\%1.scala" >nul
pushd "%OUT%\%1"
"%SCALA_CLI%" --power package %1.scala --js -o prog.js --force --jvm system > build.log 2>&1
popd
if exist "%OUT%\%1\prog.js" ( echo OK %1 ) else ( echo scala-js-FAIL %1 )
exit /b 0
