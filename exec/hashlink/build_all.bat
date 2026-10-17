@echo off
rem Build the hashlink row: Haxe sources compiled to HashLink bytecode.
rem   exec\hashlink\T<task>\T<task>.hl   artifact, run as `hl.exe T<task>.hl`
rem The module name must equal the file name and start uppercase, so the modules
rem are T01_branches ... T15_file_write (sources\hashlink\T<NN>_<name>.hx).
rem Task 03 pulls in AddOne.hx from the same classpath. Tasks 14 and 15 need the
rem data.bin fixture in their run directory.
setlocal
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\hashlink
set OUT=%ROOT%\exec\hashlink
set HAXE=%ROOT%\tools\haxe\haxe.exe
set PATH=%ROOT%\tools\haxe;%ROOT%\tools\hashlink;%PATH%
set FAILED=0
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do call :build %%T
if %FAILED% neq 0 exit /b 1
exit /b 0

:build
set T=%1
if not exist "%OUT%\T%T%" mkdir "%OUT%\T%T%"
if "%T%"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\T%T%\data.bin" >nul
if "%T%"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\T%T%\data.bin" >nul
"%HAXE%" -cp "%SRC%" -main T%T% -hl "%OUT%\T%T%\T%T%.hl" >"%OUT%\T%T%\build.log" 2>&1
if errorlevel 1 (
  echo hashlink-FAIL %T%
  set FAILED=1
  exit /b 0
)
echo OK %T%
exit /b 0
