@echo off
rem Build the kotlin row. Two toolchains, both landing in exec\kotlin\<task>\ :
rem   jvm  sources\kotlin\<task>.kt    -> exec\kotlin\<task>\prog.jar
rem        kotlinc <task>.kt -include-runtime -d prog.jar, run `java -jar prog.jar`
rem   js   sources\kotlin-js\<task>.kt -> exec\kotlin\<task>\prog.js
rem        kotlinc-js klib, then -Xir-produce-js -Xinclude=<klib> -> prog.js,
rem        run `tools\nodejs\node.exe prog.js`
rem Both toolchains run in the same task directory (that is what cells.json names),
rem so each keeps its own source copy in a per-toolchain subdirectory: jvm\ and js\.
rem Tasks 14 and 15 get the data.bin fixture in their run directory; task 15 leaves
rem out.bin there. Pass task names to build only those (e.g. build_all.bat 03_func_sum).
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set KOTLINC=%ROOT%\tools\kotlin\bin\kotlinc.bat
set KOTLINCJS=%ROOT%\tools\kotlin\bin\kotlinc-js.bat
set KLIB=%ROOT%\tools\kotlin\lib\kotlin-stdlib-js.klib
set OUT=%ROOT%\exec\kotlin
set ALL=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
if "%~1"=="" (set TASKS=%ALL%) else (set TASKS=%*)
set FAILED=0
for %%T in (%TASKS%) do (
  call :build %%T
  if errorlevel 1 (set FAILED=1 & echo kotlin-FAIL %%T) else (echo OK %%T)
)
if %FAILED%==1 exit /b 1
exit /b 0

:build
set T=%1
set D=%OUT%\%T%
if not exist "%D%" mkdir "%D%"
if not exist "%D%\jvm" mkdir "%D%\jvm"
if not exist "%D%\js" mkdir "%D%\js"
copy /y "%ROOT%\sources\kotlin\%T%.kt" "%D%\jvm\%T%.kt" >nul || exit /b 1
copy /y "%ROOT%\sources\kotlin-js\%T%.kt" "%D%\js\%T%.kt" >nul || exit /b 1
rem The fixture is 50 MiB; a copy can fail if another run still holds the
rem destination open, so the size check (not the copy's exit code) decides.
if "%T%"=="14_file_read" call :fixture || exit /b 1
if "%T%"=="15_file_write" call :fixture || exit /b 1

rem --- jvm: one kotlinc invocation, runtime bundled into the jar
if exist "%D%\prog.jar" del /q "%D%\prog.jar"
pushd "%D%\jvm"
call "%KOTLINC%" %T%.kt -include-runtime -d "%D%\prog.jar" > "%D%\build_jvm.log" 2>&1
popd
if not exist "%D%\prog.jar" exit /b 1

rem --- js: Kotlin 2.4.20 needs a klib and a separate link to JS
if exist "%D%\prog.js" del /q "%D%\prog.js"
if exist "%D%\js\klib-js" rmdir /s /q "%D%\js\klib-js"
if exist "%D%\js\linkout" rmdir /s /q "%D%\js\linkout"
pushd "%D%\js"
call "%KOTLINCJS%" -libraries "%KLIB%" -ir-output-dir klib-js -ir-output-name prog %T%.kt > "%D%\build_js_klib.log" 2>&1
if not exist "klib-js\prog.klib" (popd & exit /b 1)
rem The linker CLEARS the directory it is given as -ir-output-dir, so it gets one
rem of its own -- pointed at the task directory it would delete the jar and the
rem sources beside it. prog.js is copied out afterwards.
rem -Xes-long-as-bigint compiles Long as an ES2020 BigInt instead of a boxed
rem {low,high} object. Without it the LongArray-heavy cells (12 is 3 x 16M
rem elements) box every element and cannot fit node's default 2 GB old-space;
rem the arithmetic and the printed values are unchanged.
call "%KOTLINCJS%" -libraries "%KLIB%" -Xir-produce-js -Xinclude="%D%\js\klib-js\prog.klib" -Xes-long-as-bigint -ir-output-dir linkout -ir-output-name prog > "%D%\build_js.log" 2>&1
popd
if exist "%D%\js\klib-js" rmdir /s /q "%D%\js\klib-js"
if not exist "%D%\js\linkout\prog.js" exit /b 1
copy /y "%D%\js\linkout\prog.js" "%D%\prog.js" >nul || exit /b 1
rmdir /s /q "%D%\js\linkout"
if not exist "%D%\prog.js" exit /b 1
exit /b 0

:fixture
copy /y "%ROOT%\data.bin" "%D%\data.bin" >nul 2>&1
for %%A in ("%D%\data.bin") do if not %%~zA==52428800 exit /b 1
exit /b 0
