@echo off
setlocal enabledelayedexpansion
rem Build all 15 C# tasks with the row's toolchains.
rem   coreclr    dotnet build -c Release             -> bin\Release\net8.0\<task>.exe
rem   nativeaot  dotnet publish -c Release -p:PublishAot=true
rem              -p:IlcUseEnvironmentalTools=true    -> bin\Release\net8.0\win-x64\publish\<task>.exe
rem              NativeAOT forces a RID, hence the win-x64 segment. It needs the MSVC
rem              linker, and with a hand-extracted tree dotnet cannot find vcvarsall, so
rem              IlcUseEnvironmentalTools makes it use PATH/INCLUDE/LIB from msvc_env.py.
rem   mono       mono mcs.exe -optimize+ <task>.cs    -> <task>.exe, run under mono
rem   mono (aot) mono mcs.exe -optimize+ <task>.cs, then mono --aot=full <task>.exe
rem              -> <task>.exe.dll, a native module that `mono --full-aot <task>.exe` runs
rem              with the JIT switched off. The assemblies the runtime loads on the way in
rem              need their own --aot=full images first; those images are inert for the
rem              `mono` row, which refuses one "compiled with --aot=full", so only the
rem              aot-only runtime ever loads them.
rem `mono (llvm)` is not built here: this Mono build ships no LLVM, so `mono --llvm`
rem answers `Mono Warning: --llvm not enabled in this runtime.` and `--aot=llvm` stops with
rem `--aot=llvm requires a runtime compiled with llvm support.` (see BUILD.md).
rem Each task is a directory holding <task>.cs plus <task>.csproj (for dotnet).
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set "EXEC=%~dp0"
set "DOTNET=%ROOT%\tools\dotnet8\dotnet.exe"
set "MONODIR=%ROOT%\tools\mono\Mono"
set "MONO=%MONODIR%\bin\mono.exe"
set "MCS=%MONODIR%\lib\mono\4.5\mcs.exe"
set "SRC=%ROOT%\sources\csharp"
set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

echo ########## coreclr
if not exist "%DOTNET%" (echo SKIP coreclr: "%DOTNET%" is not installed) else (
for %%T in (%TASKS%) do (
  mkdir "%EXEC%coreclr\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%coreclr\%%T" >nul
  cd /d "%EXEC%coreclr\%%T"
  "%DOTNET%" build -c Release >build.log 2>&1
  if exist "bin\Release\net8.0\%%T.exe" ( echo OK coreclr %%T ) else ( echo CS-FAIL coreclr %%T )
)
)

echo ########## mono
for %%T in (%TASKS%) do (
  mkdir "%EXEC%mono\%%T" 2>nul
  cd /d "%EXEC%mono\%%T"
  copy /y "%SRC%\%%T\%%T.cs" . >nul
  set MCSREF=
  if "%%T"=="10_pi" set MCSREF=-r:%MONODIR%\lib\mono\4.5\System.Numerics.dll
  "%MONO%" "%MCS%" -optimize+ !MCSREF! %%T.cs >build.log 2>&1
  if exist %%T.exe ( echo OK mono %%T ) else ( echo CS-FAIL mono %%T )
)

echo ########## mono (aot)
rem The MSVC environment first: msvc_env.py bakes the PATH it is run with into the file it
rem prints, so clang's directory has to be added after the call, not before.
python "%ROOT%\tools\msvc_env.py" > "%ROOT%\temp\msvcenv.bat"
call "%ROOT%\temp\msvcenv.bat"
rem mono's AOT driver shells out to clang.exe for the assembler and link.exe for the DLL.
set "PATH=%ROOT%\tools\llvm-mingw\bin;%PATH%"
rem The framework images `mono --full-aot` needs before it will start: mscorlib from the
rem runtime's own lib directory, the rest from the GAC, in the order the loader asks for
rem them. Each is a no-op once its image exists.
set "FWAOT=lib\mono\4.5\mscorlib.dll lib\mono\gac\System\4.0.0.0__b77a5c561934e089\System.dll lib\mono\gac\System.Core\4.0.0.0__b77a5c561934e089\System.Core.dll lib\mono\gac\System.Numerics\4.0.0.0__b77a5c561934e089\System.Numerics.dll lib\mono\gac\Mono.Security\4.0.0.0__0738eb9f132ed756\Mono.Security.dll lib\mono\gac\I18N\4.0.0.0__0738eb9f132ed756\I18N.dll lib\mono\gac\I18N.West\4.0.0.0__0738eb9f132ed756\I18N.West.dll lib\mono\gac\System.Xml\4.0.0.0__b77a5c561934e089\System.Xml.dll lib\mono\gac\System.Configuration\4.0.0.0__b03f5f7f11d50a3a\System.Configuration.dll lib\mono\gac\System.Security\4.0.0.0__b03f5f7f11d50a3a\System.Security.dll"
cd /d "%MONODIR%"
for %%F in (%FWAOT%) do (
  if exist "%%F.dll" (
    echo SKIP fwaot %%F
  ) else (
    "%MONO%" --aot=full "%MONODIR%\%%F" >> "%ROOT%\temp\mono-aot.log" 2>&1
    del /q "%%F.dll.lib" "%%F.dll.exp" "%%F.dll.pdb" 2>nul
    if exist "%%F.dll" ( echo OK fwaot %%F ) else ( echo CS-FAIL fwaot %%F )
  )
)
for %%T in (%TASKS%) do (
  mkdir "%EXEC%mono-aot\%%T" 2>nul
  cd /d "%EXEC%mono-aot\%%T"
  copy /y "%SRC%\%%T\%%T.cs" . >nul
  set MCSREF=
  if "%%T"=="10_pi" set MCSREF=-r:%MONODIR%\lib\mono\4.5\System.Numerics.dll
  "%MONO%" "%MCS%" -optimize+ !MCSREF! %%T.cs >build.log 2>&1
  "%MONO%" --aot=full %%T.exe >>build.log 2>&1
  del /q %%T.exe.dll.lib %%T.exe.dll.exp %%T.exe.dll.pdb 2>nul
  if exist %%T.exe.dll ( echo OK mono-aot %%T ) else ( echo CS-FAIL mono-aot %%T )
)

echo ########## nativeaot
if not exist "%DOTNET%" (echo SKIP nativeaot: "%DOTNET%" is not installed) else (
rem one MSVC environment for the whole nativeaot pass
python "%ROOT%\tools\msvc_env.py" > "%ROOT%\temp\msvcenv.bat"
call "%ROOT%\temp\msvcenv.bat"
for %%T in (%TASKS%) do (
  mkdir "%EXEC%nativeaot\%%T" 2>nul
  xcopy /y /e /i /q "%SRC%\%%T" "%EXEC%nativeaot\%%T" >nul
  cd /d "%EXEC%nativeaot\%%T"
  "%DOTNET%" publish -c Release -p:PublishAot=true -p:IlcUseEnvironmentalTools=true >build.log 2>&1
  if exist "bin\Release\net8.0\win-x64\publish\%%T.exe" ( echo OK nativeaot %%T ) else ( echo CS-FAIL nativeaot %%T )
)
)
echo ALLDONE
