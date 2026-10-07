@echo off
setlocal enabledelayedexpansion
rem Build all 15 VB.NET tasks.
rem   dotnet   dotnet build -c Release <task>.vbproj  ->  bin\Release\net8.0\<task>.dll
rem            run as: dotnet bin\Release\net8.0\<task>.dll
rem Each task is a directory holding <task>.vb plus <task>.vbproj.
rem TIME_MS goes to stderr (Console.Error), so no time.txt here.
set DOTNET=C:\stupidspeed\tools\dotnet8\dotnet.exe
set SRC=C:\stupidspeed\sources\vbnet
set EXEC=C:\stupidspeed\exec\vbnet
set DATA=C:\stupidspeed\data.bin
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## dotnet (VB.NET -> IL -> CoreCLR)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\dotnet\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%\dotnet\%%T" >nul
  cd /d "%EXEC%\dotnet\%%T"
  "%DOTNET%" build -c Release "%%T.vbproj" >build.log 2>&1
  if exist "bin\Release\net8.0\%%T.dll" ( echo OK %%T ) else ( echo VBNET-FAIL %%T )
)

rem tasks 14 and 15 need the 50 MiB fixture in the working directory
copy /y "%DATA%" "%EXEC%\dotnet\14_file_read\data.bin" >nul
copy /y "%DATA%" "%EXEC%\dotnet\15_file_write\data.bin" >nul

echo ALLDONE
