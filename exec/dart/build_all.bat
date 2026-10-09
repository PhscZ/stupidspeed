@echo off
setlocal enabledelayedexpansion
rem Build all 15 Dart tasks four ways.
rem   aot      dart compile exe  -o prog.exe <task>.dart  -> a native executable per task
rem   jit      no build step: dart <task>.dart runs the source directly
rem   dart2js  dart compile js   -O4 --no-source-maps -o prog.js <task>.dart
rem            run on node: node prog.js
rem   dart2wasm dart compile wasm -O4 --no-source-maps -o prog.wasm <task>.dart
rem            run on node: node exec\dart\dart2wasm\run.mjs
rem The jit row shares one directory (no per-task artifact); every other row gets one dir per
rem task.  aot and jit build sources\dart\; the two web targets build sources\dart-web\,
rem because dart:io -- the stderr line every task needs and task 14/15's file access -- does
rem not exist on either web target.
rem
rem Paths come from the script's own location so the tree can live anywhere.
set "ROOT=%~dp0..\.."
set "DART=%ROOT%\tools\dart\bin\dart.exe"
set "SRC=%ROOT%\sources\dart"
set "WEBSRC=%ROOT%\sources\dart-web"
set "EXEC=%~dp0"
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
rem 11, 14 and 15 have no web form: no isolates and no dart:io file access on either target.
set WEBTASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 12_matrix_add 13_matrix_mul

rem No argument builds all four toolchains.  `build_all.bat <toolchain>` rebuilds just that
rem one, which is what the two web targets want: the fifteen native executables are 90 MB of
rem compilation that no web-target change needs to repeat.
set "WHAT=%~1"
if "%WHAT%"=="" set "WHAT=aot jit dart2js dart2wasm"
for %%S in (%WHAT%) do call :build %%S
if errorlevel 1 exit /b 1
echo ALLDONE
exit /b 0

:build
if /i "%~1"=="aot"      goto :build_aot
if /i "%~1"=="jit"      goto :build_jit
if /i "%~1"=="dart2js"  goto :build_dart2js
if /i "%~1"=="dart2wasm" goto :build_dart2wasm
echo build_all: unknown toolchain "%~1"
exit /b 1

:build_aot
echo ########## aot
for %%T in (%TASKS%) do (
  mkdir "%EXEC%aot\%%T" 2>nul
  cd /d "%EXEC%aot\%%T"
  copy /y "%SRC%\%%T.dart" . >nul
  "%DART%" compile exe -o prog.exe %%T.dart >build.log 2>&1
  if exist prog.exe ( echo OK aot %%T ) else ( echo DART-FAIL aot %%T )
)
exit /b 0

:build_jit
echo ########## jit
mkdir "%EXEC%jit" 2>nul
copy /y "%SRC%\*.dart" "%EXEC%jit\" >nul
echo OK jit staged
exit /b 0

:build_dart2js
echo ########## dart2js
for %%T in (%WEBTASKS%) do (
  mkdir "%EXEC%dart2js\%%T" 2>nul
  cd /d "%EXEC%dart2js\%%T"
  copy /y "%WEBSRC%\%%T.dart" . >nul
  "%DART%" compile js -O4 --no-source-maps -o prog.js %%T.dart >build.log 2>&1
  del prog.js.deps 2>nul
  if exist prog.js ( echo OK dart2js %%T ) else ( echo DART-FAIL dart2js %%T )
)
exit /b 0

:build_dart2wasm
echo ########## dart2wasm
for %%T in (%WEBTASKS%) do (
  mkdir "%EXEC%dart2wasm\%%T" 2>nul
  cd /d "%EXEC%dart2wasm\%%T"
  copy /y "%WEBSRC%\%%T.dart" . >nul
  "%DART%" compile wasm -O4 --no-source-maps -o prog.wasm %%T.dart >build.log 2>&1
  del prog.support.js 2>nul
  if exist prog.wasm ( echo OK dart2wasm %%T ) else ( echo DART-FAIL dart2wasm %%T )
)
exit /b 0