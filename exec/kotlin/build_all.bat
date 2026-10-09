@echo off
setlocal
rem Build all 15 Kotlin tasks for the three `kotlin` toolchains.
rem
rem   jvm   kotlinc <task>.kt -include-runtime -d prog.jar        run: java -jar prog.jar
rem   js    kotlinc-js <task>.kt -> klib ; kotlinc-js -Xir-produce-js -Xinclude=<klib> -> prog.js
rem   wasm  kotlinc-wasm <task>.kt -> klib ; kotlinc-wasm -Xir-produce-js -Xinclude=<klib> -> prog.wasm
rem
rem Sources: sources\kotlin\ (jvm, all fifteen), sources\kotlin-js\ (js, all fifteen) and
rem sources\kotlin-wasm\ (wasm, twelve: tasks 11, 14 and 15 need a thread primitive and a file
rem API, and the wasm-wasi standard library has neither). Kotlin 2.4.20's two web compilers
rem cannot produce a klib and link the JS/wasm artifact in one invocation -- the K2 pipeline
rem rejects the pair -- so each task is compiled to a klib and then linked from it. Both the
rem klib and the link's own output are scratch: the link step deletes every file under its
rem -ir-output-dir (recursively, keeping directory entries), so the artifact is linked into
rem out-js\ / out-wasm\ and then moved up, and both scratch directories are removed.
rem -include-runtime bundles kotlin-stdlib into the jar, so the jvm run line needs a JRE and
rem nothing else. Task 11 uses four java.lang.Thread workers in the jvm tree and four serial
rem quarters in the js tree. The compilers need a JDK on PATH; JAVA_HOME selects which.
rem Output: exec\kotlin\<task>\prog.jar, exec\kotlin\<task>\prog.js, exec\kotlin\<task>\prog.wasm
set "KOTLIN=%~dp0..\..\tools\kotlin\kotlinc\bin\kotlinc.bat"
set "KOTLIN_JS=%~dp0..\..\tools\kotlin\kotlinc\bin\kotlinc-js.bat"
set "KOTLIN_WASM=%~dp0..\..\tools\kotlin\kotlinc\bin\kotlinc-wasm.bat"
set "LIB_JS=%~dp0..\..\tools\kotlin\kotlinc\lib\kotlin-stdlib-js.klib"
set "LIB_WASM=%~dp0..\..\tools\kotlin\kotlinc\lib\kotlin-stdlib-wasm-wasi.klib"
set "JAVA_HOME=C:\Program Files\Java\jdk-24"
set "SRC=%~dp0..\..\sources\kotlin"
set "SRC_JS=%~dp0..\..\sources\kotlin-js"
set "SRC_WASM=%~dp0..\..\sources\kotlin-wasm"
set "EXEC=%~dp0"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"
set "TASKS_WASM=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 12_matrix_add 13_matrix_mul"

echo ########## kotlin jvm
for %%T in (%TASKS%) do call :jvm %%T
echo ########## kotlin js
for %%T in (%TASKS%) do call :js %%T
echo ########## kotlin wasm
for %%T in (%TASKS_WASM%) do call :wasm %%T
echo ALLDONE
exit /b 0

:jvm
mkdir "%EXEC%%1" 2>nul
cd /d "%EXEC%%1"
copy /y "%SRC%\%1.kt" . >nul
call "%KOTLIN%" %1.kt -include-runtime -d prog.jar >build.log 2>&1
if exist prog.jar ( echo OK jvm %1 ) else ( echo kotlin-jvm-FAIL %1 )
exit /b 0

:js
mkdir "%EXEC%%1" 2>nul
cd /d "%EXEC%%1"
copy /y "%SRC_JS%\%1.kt" . >nul
rmdir /s /q klib-js out-js 2>nul
mkdir klib-js
mkdir out-js
call "%KOTLIN_JS%" -libraries "%LIB_JS%" -ir-output-dir klib-js -ir-output-name prog %1.kt >build-js.log 2>&1
call "%KOTLIN_JS%" -libraries "%LIB_JS%" -Xir-produce-js -Xinclude=%EXEC%%1\klib-js\prog.klib -ir-output-dir "%EXEC%%1\out-js" -ir-output-name prog >>build-js.log 2>&1
if exist out-js\prog.js move /y out-js\prog.js prog.js >nul
rmdir /s /q klib-js out-js 2>nul
if exist prog.js ( echo OK js %1 ) else ( echo kotlin-js-FAIL %1 )
exit /b 0

:wasm
mkdir "%EXEC%%1" 2>nul
cd /d "%EXEC%%1"
copy /y "%SRC_WASM%\%1.kt" . >nul
rmdir /s /q klib-wasm out-wasm 2>nul
mkdir klib-wasm
mkdir out-wasm
call "%KOTLIN_WASM%" -libraries "%LIB_WASM%" -Xwasm-target=wasm-wasi -ir-output-dir klib-wasm -ir-output-name prog %1.kt >build-wasm.log 2>&1
call "%KOTLIN_WASM%" -libraries "%LIB_WASM%" -Xwasm-target=wasm-wasi -Xir-produce-js -Xinclude=%EXEC%%1\klib-wasm\prog.klib -ir-output-dir "%EXEC%%1\out-wasm" -ir-output-name prog >>build-wasm.log 2>&1
if exist out-wasm\prog.wasm move /y out-wasm\prog.wasm prog.wasm >nul
rmdir /s /q klib-wasm out-wasm 2>nul
if exist prog.wasm ( echo OK wasm %1 ) else ( echo kotlin-wasm-FAIL %1 )
exit /b 0
