@echo off
setlocal enabledelayedexpansion
rem Build all 15 C# tasks with three toolchains.
rem   coreclr   dotnet build -c Release            -> bin\Release\net8.0\<task>.exe
rem   nativeaot dotnet publish -c Release -p:PublishAot=true
rem             -p:IlcUseEnvironmentalTools=true   -> bin\Release\net8.0\win-x64\publish\<task>.exe
rem             NativeAOT forces a RID, hence the win-x64 segment. It needs the MSVC
rem             linker, and with a hand-extracted tree dotnet cannot find vcvarsall, so
rem             IlcUseEnvironmentalTools makes it use PATH/INCLUDE/LIB from msvc_env.py.
rem   mono      mono mcs.exe -optimize+ <task>.cs    -> <task>.exe, run under mono
rem Each task is a directory holding <task>.cs plus <task>.csproj (for dotnet).
set DOTNET=C:\stupidspeed\tools\dotnet8\dotnet.exe
set MONO=C:\stupidspeed\tools\mono\Mono\bin\mono.exe
set MCS=C:\stupidspeed\tools\mono\Mono\lib\mono\4.5\mcs.exe
set SRC=C:\stupidspeed\sources\csharp
set EXEC=C:\stupidspeed\exec\csharp
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write

echo ########## coreclr
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\coreclr\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%\coreclr\%%T" >nul
  cd /d "%EXEC%\coreclr\%%T"
  "%DOTNET%" build -c Release >build.log 2>&1
  if exist "bin\Release\net8.0\%%T.exe" ( echo OK coreclr %%T ) else ( echo CS-FAIL coreclr %%T )
)

echo ########## mono
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\mono\%%T" 2>nul
  cd /d "%EXEC%\mono\%%T"
  copy /y "%SRC%\%%T\%%T.cs" . >nul
  set MCSREF=
  if "%%T"=="10_pi" set MCSREF=-r:C:\stupidspeed\tools\mono\Mono\lib\mono\4.5\System.Numerics.dll
  "%MONO%" "%MCS%" -optimize+ !MCSREF! %%T.cs >build.log 2>&1
  if exist %%T.exe ( echo OK mono %%T ) else ( echo CS-FAIL mono %%T )
)

echo ########## nativeaot
rem one MSVC environment for the whole nativeaot pass
python C:\stupidspeed\tools\msvc_env.py > C:\stupidspeed\temp\msvcenv.bat
call C:\stupidspeed\temp\msvcenv.bat
for %%T in (%TASKS%) do (
  mkdir "%EXEC%\nativeaot\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%\nativeaot\%%T" >nul
  cd /d "%EXEC%\nativeaot\%%T"
  "%DOTNET%" publish -c Release -p:PublishAot=true -p:IlcUseEnvironmentalTools=true >build.log 2>&1
  if exist "bin\Release\net8.0\win-x64\publish\%%T.exe" ( echo OK nativeaot %%T ) else ( echo CS-FAIL nativeaot %%T )
)
echo ALLDONE
