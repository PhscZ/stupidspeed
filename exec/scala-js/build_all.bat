@echo off
rem Build the scala-js row -- Scala compiled by scala-cli to JavaScript and run
rem by node (no JVM in the measurement):
rem
rem   exec\scala-js\<task>\prog.js    artifact, run as `node prog.js`
rem
rem The build line is the row header's, verbatim:
rem
rem   JAVA_HOME=<jdk> tools\scala-cli\scala-cli.exe --power package <task>.scala
rem       --js -o prog.js --force --jvm system
rem
rem `--jvm system` is load bearing: without it scala-cli fetches its own JDK
rem instead of using the one JAVA_HOME names.  JAVA_HOME is set explicitly to
rem the JDK-24 this row was built with, because this host also has a Java 8 shim
rem ahead of it on PATH and scala-cli dies on class file version 61.0 under it.
rem
rem Tasks 14 and 15 read and write the 50 MiB fixture, so data.bin is copied
rem into their run directories.  scala-cli leaves a small .scala-build\ beside
rem each prog.js -- 58 KB of bloop analysis for the project -- which is kept:
rem it is what makes a rebuild of an unchanged task fast.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\scala-js
set OUT=%ROOT%\exec\scala-js
set SCALA_CLI=%ROOT%\tools\scala-cli\scala-cli.exe
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAILED=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.scala" "%OUT%\%%T\%%T.scala" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  pushd "%OUT%\%%T"
  "%SCALA_CLI%" --power package %%T.scala --js -o prog.js --force --jvm system >build.log 2>&1
  set RC=!ERRORLEVEL!
  popd
  if not "!RC!"=="0" (
    echo scala-js-FAIL %%T
    set FAILED=1
  ) else if not exist "%OUT%\%%T\prog.js" (
    echo scala-js-FAIL %%T ^(no prog.js^)
    set FAILED=1
  ) else (
    echo OK %%T
  )
)

if not "%FAILED%"=="0" (echo scala-js-FAIL build & exit /b 1)
endlocal & exit /b 0
