@echo off
rem Build the standardml row: Poly/ML compiles to native code with its own code
rem generator, then gcc links the exported heap image with polystub.obj.
rem   exec\standardml\polyml\<task>\<task>.exe   artifact, run as `<task>.exe -H 1024`
rem Two steps per task, driven by a build\<task>.ML driver, because the MSI ships no
rem polyc:  PolyML.exe -q --error-exit --script build\<task>.ML  writes <task>.obj
rem into the task directory, then gcc links it against tools\polyml\polystub.obj
rem and -lpolyml. PolyLib.dll must sit beside the .exe or the process dies before
rem main with STATUS_DLL_NOT_FOUND and prints nothing.
rem Task 03 also needs its helper 03_func_sum_add_one.sml; tasks 14 and 15 the
rem data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\standardml
set OUT=%ROOT%\exec\standardml\polyml
set POLY=%ROOT%\tools\polyml
set UCRT=%ROOT%\tools\msys64\msys64\ucrt64
set "PATH=%UCRT%\bin;%PATH%"
set FAIL=0

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :one %%T

if "%FAIL%"=="1" (echo standardml-FAIL some task & exit /b 1)
echo standardml OK
exit /b 0

:one
set T=%1
if not exist "%OUT%\%T%\build" mkdir "%OUT%\%T%\build"
copy /y "%SRC%\%T%.sml" "%OUT%\%T%\%T%.sml" >nul
copy /y "%SRC%\build\%T%.ML" "%OUT%\%T%\build\%T%.ML" >nul
if "%T%"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.sml" "%OUT%\%T%\03_func_sum_add_one.sml" >nul
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%T%\data.bin" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%T%\data.bin" >nul
pushd "%OUT%\%T%"
"%POLY%\PolyML.exe" -q --error-exit --script build\%T%.ML >build.log 2>&1
if errorlevel 1 (echo standardml-FAIL %T% export & set FAIL=1 & popd & exit /b 0)
gcc -Wl,-u,WinMain -mconsole -o %T%.exe %T%.obj "%POLY%\polystub.obj" -L"%POLY%" -lpolyml >>build.log 2>&1
if errorlevel 1 (echo standardml-FAIL %T% link & set FAIL=1 & popd & exit /b 0)
copy /y "%POLY%\PolyLib.dll" . >nul
echo OK %T%
popd
exit /b 0
