@echo off
setlocal enabledelayedexpansion
rem Build all 15 F# tasks with the .NET 8 SDK.
rem   dotnet build -c Release <task>.fsproj   -> bin\Release\net8.0\<task>.dll
rem   run: dotnet <task>.dll
rem Each task is a directory holding <task>.fs plus <task>.fsproj.
set DOTNET=C:\stupidspeed\tools\dotnet8\dotnet.exe
set SRC=C:\stupidspeed\sources\fsharp
set EXEC=C:\stupidspeed\exec\fsharp

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%\%%T" >nul
  cd /d "%EXEC%\%%T"
  "%DOTNET%" build -c Release >build.log 2>&1
  if exist "bin\Release\net8.0\%%T.dll" ( echo OK %%T ) else ( echo FS-FAIL %%T )
)
echo ALLDONE
