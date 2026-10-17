@echo off
rem Build the haxe row: one source directory, four targets, fifteen tasks each.
rem Every task lives in its own directory -- exec\haxe\T<NN>_<name>\ -- because
rem exec\cells.json runs all four toolchains with that directory as the working
rem directory, so tasks 14 and 15 find data.bin there:
rem
rem   exec\haxe\T<task>\out\T<task>.exe   hxcpp:  haxe -cpp out, hxcpp drives g++/windres
rem   exec\haxe\T<task>\js\T<task>.js     js:     haxe --js, run by tools\nodejs\node.exe
rem   exec\haxe\T<task>\jvm\T<task>.jar   jvm:    haxe --jvm, needs the hxjava library
rem   exec\haxe\T<task>\cs\T<task>.exe    cs:     haxe --cs + Mono's csc (hxcs library)
rem
rem Haxe ties a type name to its file name and a type name must start uppercase,
rem so the sources are T01_branches.hx etc. and the module is T01_branches.
setlocal enabledelayedexpansion
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set SRC=%ROOT%\sources\haxe
set OUT=%ROOT%\exec\haxe
set HAXE=%ROOT%\tools\haxe\haxe.exe
set MINGW=%ROOT%\tools\msys64\msys64\ucrt64
rem hxcpp wants MINGW_ROOT as a slash-separated path.
set "MINGW_FWD=!MINGW:\=/!"
set MONO=%ROOT%\tools\mono\Mono\bin\mono.exe
set CSC=%ROOT%\tools\mono\Mono\lib\mono\4.5\csc.exe
set ALL=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
rem With no argument the whole row builds; pass task names to rebuild only those.
if "%~1"=="" (set TASKS=%ALL%) else (set TASKS=%*)
set FAIL=0

rem haxelib is a Neko program: it needs the whole Neko tree on PATH and NEKOPATH,
rem and the dev copies of hxcpp/hxjava/hxcs are registered in tools\haxelib.
set "PATH=%ROOT%\tools\haxe;%ROOT%\tools\neko;%MINGW%\bin;%PATH%"
set NEKOPATH=%ROOT%\tools\neko
set HAXELIB_PATH=%ROOT%\tools\haxelib
rem hxcpp's compile cache shares the hxcpp_std object files between the fifteen
rem projects instead of recompiling the runtime in every one of them.
set HXCPP_COMPILE_CACHE=%ROOT%\temp\hxcpp-cache
set HXCPP_CACHE_MB=4000

rem ---- stage the sources (and the fixture) into every task directory
rem The fixture is 50 MiB; a copy can fail if another run still holds the
rem destination open, so its size (not the copy's exit code) decides.
for %%T in (%TASKS%) do (
  if not exist "%OUT%\T%%T" mkdir "%OUT%\T%%T"
  copy /y "%SRC%\*.hx" "%OUT%\T%%T\" >nul || (echo haxe-FAIL stage %%T & exit /b 1)
  if "%%T"=="14_file_read" call :fixture %%T || (echo haxe-FAIL stage %%T & exit /b 1)
  if "%%T"=="15_file_write" call :fixture %%T || (echo haxe-FAIL stage %%T & exit /b 1)
)

rem ---- hxcpp: Haxe -> C++ -> hxcpp -> g++.  -D no_shared_libs is what makes the
rem link static; MINGW_ROOT is not optional (hxcpp would guess c:/MinGW).
for %%T in (%TASKS%) do (
  pushd "%OUT%\T%%T"
  "%HAXE%" -cp . -main T%%T -cpp out -D mingw -D MINGW_ROOT=!MINGW_FWD! -D no_shared_libs >build.log 2>&1
  if errorlevel 1 (echo haxe-FAIL hxcpp %%T & set FAIL=1) else (echo OK %%T hxcpp)
  popd
)

rem ---- js: one emitted file, run by node.  The js target has no sys package, so
rem the row's shared Out.hx routes stdout/stderr through js.Syntax.code.
for %%T in (%TASKS%) do (
  pushd "%OUT%\T%%T"
  if not exist js mkdir js
  "%HAXE%" -cp . -main T%%T --js js/T%%T.js >build.log 2>&1
  if errorlevel 1 (echo haxe-FAIL js %%T & set FAIL=1) else (echo OK %%T js)
  popd
)

rem ---- jvm: haxe --jvm emits one jar with hxjava-std.jar's classes inside it.
for %%T in (%TASKS%) do (
  pushd "%OUT%\T%%T"
  if not exist jvm mkdir jvm
  "%HAXE%" -cp . -main T%%T --jvm jvm/T%%T.jar >build.log 2>&1
  if errorlevel 1 (echo haxe-FAIL jvm %%T & set FAIL=1) else (echo OK %%T jvm)
  popd
)

rem ---- cs: two steps, because Haxe's own build tool would want MSBuild.  --cs with
rem -D no-compilation emits C# only; Mono's csc then compiles the generated tree
rem through a response file holding the `dir /b /s` of its *.cs files.
for %%T in (%TASKS%) do (
  pushd "%OUT%\T%%T"
  if not exist cs mkdir cs
  "%HAXE%" -cp . -main T%%T --cs cs/T%%T -D no-compilation >build.log 2>&1
  if errorlevel 1 (echo haxe-FAIL cs %%T & set FAIL=1) else (
    dir /b /s cs\T%%T\src\*.cs > cs\T%%T.rsp
    "%MONO%" "%CSC%" -nologo -out:cs/T%%T.exe -target:exe @cs/T%%T.rsp >>build.log 2>&1
    if errorlevel 1 (echo haxe-FAIL cs %%T & set FAIL=1) else (echo OK %%T cs)
  )
  popd
)

if "%FAIL%"=="1" (echo haxe-FAIL some task & exit /b 1)
echo haxe OK
endlocal
exit /b 0

:fixture
copy /y "%ROOT%\data.bin" "%OUT%\T%1\data.bin" >nul 2>&1
for %%A in ("%OUT%\T%1\data.bin") do if not %%~zA==52428800 (echo haxe-FAIL stage %1 & exit /b 1)
exit /b 0
