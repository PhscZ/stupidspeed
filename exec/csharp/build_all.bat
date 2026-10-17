@echo off
rem Build the csharp row: the same fifteen C# sources through four toolchains.
rem   exec\csharp\coreclr\<task>\bin\Release\net8.0\<task>.exe                  dotnet build -c Release
rem   exec\csharp\nativeaot\<task>\bin\Release\net8.0\win-x64\publish\<task>.exe  dotnet publish -c Release -r win-x64 -p:PublishAot=true
rem   exec\csharp\mono\<task>\<task>.exe                                         mcs -optimize+ <task>.cs
rem   exec\csharp\mono-aot\<task>\<task>.exe.dll                                 mono --aot=full <task>.exe
rem Every task needs its source staged in the directory it is built from; tasks 14
rem and 15 also need the data.bin fixture in the directory the program runs in.
rem
rem nativeaot needs the MSVC linker on PATH/INCLUDE/LIB (tools\msvc_env.py) plus
rem -p:IlcUseEnvironmentalTools=true, because this is a hand-extracted MSVC tree and
rem ILC cannot find vcvarsall.  mono --aot shells out to clang.exe (tools\llvm-mingw\bin)
rem for the assembler and link.exe for the DLL, so both have to be on PATH as well.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\csharp
set DOTNET=%ROOT%\tools\dotnet8\dotnet.exe
set MONO=%ROOT%\tools\mono\Mono\bin\mono.exe
set MCS=%ROOT%\tools\mono\Mono\lib\mono\4.5\mcs.exe
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0

set DOTNET_CLI_TELEMETRY_OPTOUT=1
set DOTNET_NOLOGO=1
set DOTNET_SKIP_FIRST_TIME_EXPERIENCE=1

rem ---- stage: source + csproj into every task directory of every toolchain.
for %%C in (coreclr nativeaot mono mono-aot) do (
  for %%T in (%TASKS%) do (
    if not exist "%ROOT%\exec\csharp\%%C\%%T" mkdir "%ROOT%\exec\csharp\%%C\%%T"
    copy /y "%SRC%\%%T\%%T.cs" "%ROOT%\exec\csharp\%%C\%%T\%%T.cs" >nul
    copy /y "%SRC%\%%T\%%T.csproj" "%ROOT%\exec\csharp\%%C\%%T\%%T.csproj" >nul
    if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%ROOT%\exec\csharp\%%C\%%T\data.bin" >nul
    if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%ROOT%\exec\csharp\%%C\%%T\data.bin" >nul
  )
)

rem ---- coreclr: Roslyn -> IL, run by the CoreCLR JIT in tools\dotnet8.
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\csharp\coreclr\%%T"
  "%DOTNET%" build -c Release >build.log 2>&1
  if errorlevel 1 (echo csharp-FAIL coreclr %%T & set FAIL=1) else (echo OK %%T coreclr)
  popd
)

rem ---- nativeaot: dotnet publish with the ILC AOT compiler; needs the MSVC toolchain.
rem The MSVC environment is set once, outside the loop, because %PATH% inside a
rem parenthesised block expands at parse time and would drop the MSVC directories.
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\stupidspeed_msvc_env.bat"
call "%TEMP%\stupidspeed_msvc_env.bat" >nul
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\csharp\nativeaot\%%T"
  "%DOTNET%" publish -c Release -r win-x64 -p:PublishAot=true -p:IlcUseEnvironmentalTools=true >build.log 2>&1
  if errorlevel 1 (echo csharp-FAIL nativeaot %%T & set FAIL=1) else (echo OK %%T nativeaot)
  popd
)

rem ---- mono: mcs compiles the assembly, mono.exe runs it.  mcs does not reference
rem System.Numerics implicitly, and task 10 uses BigInteger.
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\csharp\mono\%%T"
  set MCSFLAGS=-optimize+
  if "%%T"=="10_pi" set MCSFLAGS=-optimize+ -r:System.Numerics.dll
  "%MONO%" "%MCS%" !MCSFLAGS! %%T.cs >build.log 2>&1
  if errorlevel 1 (echo csharp-FAIL mono %%T & set FAIL=1) else (echo OK %%T mono)
  popd
)

rem ---- mono (aot): the same assembly, compiled ahead of time into <task>.exe.dll by
rem clang.exe + link.exe.  The framework AOT images (mscorlib and the nine assemblies
rem the loader walks) already sit beside their assemblies under tools\mono, so only the
rem task assembly is compiled here.
set "PATH=%ROOT%\tools\llvm-mingw\bin;%PATH%"
for %%T in (%TASKS%) do (
  pushd "%ROOT%\exec\csharp\mono-aot\%%T"
  copy /y "%ROOT%\exec\csharp\mono\%%T\%%T.exe" "%%T.exe" >nul
  "%MONO%" --aot=full %%T.exe >build.log 2>&1
  if errorlevel 1 (echo csharp-FAIL mono-aot %%T & set FAIL=1) else (echo OK %%T mono-aot)
  popd
)

if "%FAIL%"=="1" (echo csharp-FAIL some task & exit /b 1)
echo csharp OK
endlocal
