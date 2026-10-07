@echo off
rem Build all 15 Standard ML (Poly/ML) tasks.
rem Two steps per task, as the row header documents: PolyML.exe exports a heap
rem image to <task>.obj, then gcc links it with polystub.obj and -lpolyml.
setlocal enabledelayedexpansion
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set "POLY=%ROOT%\tools\polyml"
set "UCRT=%ROOT%\tools\msys64\msys64\ucrt64\bin"
set "GCC=%UCRT%\gcc.exe"
set "PATH=%UCRT%;%PATH%"
set "SRC=%ROOT%\sources\standardml"
set "OUT=%~dp0polyml"
set "FAILS=0"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn ^
            06_char_count 07_string_append 08_average 09_fib_recursive 10_pi ^
            11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  call :build %%T
)
echo standardml build done, failures=%FAILS%
if %FAILS% GTR 0 exit /b 1
exit /b 0

:build
set "T=%~1"
set "D=%OUT%\%T%"
if not exist "%D%" mkdir "%D%"
copy /y "%SRC%\%T%.sml" "%D%\" >nul
if /i "%T%"=="03_func_sum" copy /y "%SRC%\03_func_sum_add_one.sml" "%D%\" >nul
xcopy /y /i /e /q "%SRC%\build" "%D%\build\" >nul
pushd "%D%"
"%POLY%\PolyML.exe" -q --error-exit --script build\%T%.ML > build.log 2>&1
if errorlevel 1 ( popd & echo standardml-FAIL %T% & set /a FAILS+=1 & exit /b 1 )
"%GCC%" -Wl,-u,WinMain -mconsole -o %T%.exe %T%.obj "%POLY%\polystub.obj" -L"%POLY%" -lpolyml >> build.log 2>&1
if errorlevel 1 ( popd & echo standardml-FAIL %T% & set /a FAILS+=1 & exit /b 1 )
copy /y "%POLY%\PolyLib.dll" . >nul
if /i "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" . >nul
if /i "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" . >nul
popd
echo OK %T%
exit /b 0
