@echo off
rem Build the fsharp row: one .fsproj per task, built with the .NET 8 SDK.
rem   exec\fsharp\<task>\bin\Release\net8.0\<task>.dll   artifact, run as
rem   tools\dotnet8\dotnet.exe exec\fsharp\<task>\bin\Release\net8.0\<task>.dll
rem The sources are one directory per task holding <task>.fs and <task>.fsproj; the whole
rem directory is staged so `dotnet build -c Release <task>.fsproj` finds its project.
rem Tasks 14 and 15 also need the data.bin fixture in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\fsharp
set DOTNET=%ROOT%\tools\dotnet8\dotnet.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

set DOTNET_CLI_TELEMETRY_OPTOUT=1
set DOTNET_NOLOGO=1
set DOTNET_CLI_UI_LANGUAGE=en
set DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

for %%T in (%TASKS%) do (
  if not exist "%ROOT%\exec\fsharp\%%T" mkdir "%ROOT%\exec\fsharp\%%T"
  copy /y "%SRC%\%%T\%%T.fs" "%ROOT%\exec\fsharp\%%T\%%T.fs" >nul
  copy /y "%SRC%\%%T\%%T.fsproj" "%ROOT%\exec\fsharp\%%T\%%T.fsproj" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\fsharp\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\fsharp\%%T\data.bin" >nul
)

for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\fsharp\%%T"
  "%DOTNET%" build -c Release --nologo %%T.fsproj >build.log 2>&1
  if errorlevel 1 (echo fsharp-FAIL %%T & set FAIL=1) else (echo OK %%T)
  popd
)

if "%FAIL%"=="1" (echo fsharp-FAIL some task & exit /b 1)
echo fsharp OK
endlocal
