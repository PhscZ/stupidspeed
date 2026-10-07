@echo off
setlocal
rem Build all 15 Scala Native tasks.
rem   Toolchain: scala-cli (tools\scala-cli\scala-cli.exe) plus the portable llvm-mingw zip
rem   (tools\llvm-mingw). Nothing else is needed: no MSVC, no admin.
rem   The command line is the row's own, from the source header / BUILD.md:
rem     scala-cli --power package <task>.scala --native -S 3.9.0 --native-version 0.5.12
rem       --native-mode release-fast
rem       --native-clang <llvm-mingw>\bin\clang.exe --native-clangpp <llvm-mingw>\bin\clang++.exe
rem       --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe
rem   --native-mode release-fast is mandatory (the default debug mode is -O0).
rem   --native-compile=-D_PID_T_ and --native-linking=-static are the two llvm-mingw flags
rem   BUILD.md explains: the first works around llvm-mingw's missing _PID_T_, the second
rem   links libc++ statically so the executable needs no llvm-mingw DLL at run time.
rem   Native compilation is slow (roughly 1.5-3 min per task), so this script is meant to be
rem   run once, in the background.
rem Output: exec\scala-native\scala-native\<task>\
set ROOT=%~dp0..\..
for %%I in ("%ROOT%") do set ROOT=%%~fI
set SRC=%ROOT%\sources\scala-native
set OUT=%~dp0scala-native
set SCALA_CLI=%ROOT%\tools\scala-cli\scala-cli.exe
set LLVM=%ROOT%\tools\llvm-mingw
set PATH=%LLVM%\bin;%PATH%
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

for %%T in (%TASKS%) do call :one %%T
echo ALLDONE
exit /b 0

:one
mkdir "%OUT%\%1" 2>nul
copy /y "%SRC%\%1.scala" "%OUT%\%1\%1.scala" >nul
if "%1"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
if "%1"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%1\data.bin" >nul
pushd "%OUT%\%1"
"%SCALA_CLI%" --power package -f %1.scala --native -S 3.9.0 --native-version 0.5.12 --native-mode release-fast --native-clang "%LLVM%\bin\clang.exe" --native-clangpp "%LLVM%\bin\clang++.exe" --native-compile=-D_PID_T_ --native-linking=-static -o prog.exe > build.log 2>&1
popd
if exist "%OUT%\%1\prog.exe" ( echo OK %1 ) else ( echo scala-native-FAIL %1 )
exit /b 0
