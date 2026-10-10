@echo off
setlocal enabledelayedexpansion
rem Build the two non-hxcpp targets of the Haxe row for every task, with exactly the
rem command lines BUILD.md documents.  build_all.bat stays what it is -- the hxcpp
rem build; this is the script that produces the other two artifacts.
rem
rem   haxe -cp . -main T<NN>_<name> --js     js/T<NN>_<name>.js       run: node js/T<NN>_<name>.js
rem   haxe -cp . -main T<NN>_<name> --jvm    jvm/T<NN>_<name>.jar     run: java -jar jvm/T<NN>_<name>.jar
rem   haxe -cp . -main T<NN>_<name> --cs     cs/T<NN>_<name>[-D no-compilation], then
rem                                          csc -out:cs/T<NN>_<name>.exe -target:exe @cs/T<NN>_<name>.rsp
rem
rem The row used to carry four more targets -- php, python, neko and lua.  php, python
rem and neko were dropped on 2026-10-10 because their task 10 cannot finish: `haxe.Int64`
rem is emulated on all three (Int is 32-bit there), so the 1000-digit spigot takes 46
rem minutes under php and 104 under neko, against 1.0 s for hxcpp and 2.8 s for the JVM.
rem lua was never a measured target: the registry has no `haxe (lua)` entry, so the
rem lua\ trees that sat in the cell directories were build residue, and they are gone
rem with the rest.  See BUILD.md's "Languages that were removed" table.
rem
rem jvm and cs need libraries that are not on this machine: `haxelib list` reports only
rem hxcpp, so --jvm stops with "Library hxjava is not installed" and --cs with the same
rem for hxcs; the shipped cs .rsp files also carry absolute source paths from the machine
rem they were built on.  Both targets are therefore reported SKIP and their existing
rem artifacts are left untouched -- they run, they just cannot be rebuilt here.
rem
rem Usage: build_targets.bat [T03_func_sum T10_pi ...]   (default: all fifteen)

set HAXE=C:\stupidspeed\tools\haxe\haxe.exe
set NEKO=C:\stupidspeed\tools\neko
set HAXELIB=C:\stupidspeed\tools\haxelib
set CSC=C:\stupidspeed\tools\mono\Mono\bin\csc.bat
set SRC=C:\stupidspeed\sources\haxe
set EXEC=C:\stupidspeed\exec\haxe
set PATH=C:\stupidspeed\tools\haxe;%NEKO%;%PATH%
set NEKOPATH=%NEKO%
set HAXELIB_PATH=%HAXELIB%

set TASKS=%*
if "%TASKS%"=="" set TASKS=T01_branches T02_switch_case T03_func_sum T04_array_sum T05_alloc_churn T06_char_count T07_string_append T08_average T09_fib_recursive T10_pi T11_parallel_sum T12_matrix_add T13_matrix_mul T14_file_read T15_file_write

rem Can the two library-dependent targets be built at all?
call haxelib.exe path hxjava >nul 2>&1
if errorlevel 1 (set HAVE_JVM=0) else (set HAVE_JVM=1)
call haxelib.exe path hxcs >nul 2>&1
if errorlevel 1 (set HAVE_CS=0) else (set HAVE_CS=1)
if exist "%CSC%" (set HAVE_CSC=1) else (set HAVE_CSC=0)

for %%T in (%TASKS%) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\*.hx" . >nul

  "%HAXE%" -cp . -main %%T --js js\%%T.js >js.log 2>&1
  if exist "js\%%T.js" ( echo OK     js ) else ( echo HAXE-FAIL js )

  if "%HAVE_JVM%"=="1" (
    "%HAXE%" -cp . -main %%T --jvm jvm\%%T.jar >jvm.log 2>&1
    if exist "jvm\%%T.jar" ( echo OK     jvm ) else ( echo HAXE-FAIL jvm )
  ) else (
    echo SKIP   jvm: hxjava is not installed ^(haxelib list shows only hxcpp^)
  )

  if "%HAVE_CS%"=="1" (
    if "%HAVE_CSC%"=="1" (
      "%HAXE%" -cp . -main %%T --cs cs\%%T -D no-compilation >cs.log 2>&1
      call "%CSC%" -out:cs\%%T.exe -target:exe @cs\%%T.rsp >>cs.log 2>&1
      if exist "cs\%%T.exe" ( echo OK     cs ) else ( echo HAXE-FAIL cs )
    ) else (
      echo SKIP   cs: Mono csc is not at %CSC%
    )
  ) else (
    echo SKIP   cs: hxcs is not installed ^(haxelib list shows only hxcpp^)
  )
)
echo ALLDONE
