@echo off
setlocal enabledelayedexpansion
rem Build all 15 Haxe tasks with the hxcpp native backend.
rem   haxe -cp <dir> -main T<NN>_<name> -cpp out -D mingw -D MINGW_ROOT=C:\mingw64 -D no_shared_libs
rem   run: out\T<NN>_<name>.exe
rem The row's three other targets are built by the sibling script build_targets.bat
rem (js, jvm and cs); both scripts copy sources\haxe\*.hx into the cell first, which is
rem required -- the cell's own copies of the task sources are only as current as
rem the last build that refreshed them.
rem hxcpp drives g++ and windres; -D no_shared_libs makes the link static and MINGW_ROOT is
rem mandatory (hxcpp otherwise guesses c:/MinGW and stops with "Could not guess MINGW_ROOT").
rem Prerequisites, all under tools/: neko (NEKOPATH), haxe's own haxelib.exe, the hxcpp tree
rem registered with `haxelib dev hxcpp <dir>`, and hxcpp's own tool built once with
rem `haxe compile.hxml` from hxcpp/tools/hxcpp/ (leaves hxcpp.n). One line had to be added to
rem the installed hxcpp: src/hx/gc/GcCommon.cpp calls std::sscanf without <cstdio>, which MSVC
rem pulls in transitively and MinGW's libstdc++ does not.
set HAXE=C:\stupidspeed\tools\haxe\haxe.exe
set NEKO=C:\stupidspeed\tools\neko
set HAXELIB=C:\stupidspeed\tools\haxelib
set SRC=C:\stupidspeed\sources\haxe
set EXEC=C:\stupidspeed\exec\haxe
set PATH=C:\stupidspeed\tools\haxe;%NEKO%;C:\mingw64\bin;%PATH%
set NEKOPATH=%NEKO%
set HAXELIB_PATH=%HAXELIB%

for %%T in (T01_branches T02_switch_case T03_func_sum T04_array_sum T05_alloc_churn T06_char_count T07_string_append T08_average T09_fib_recursive T10_pi T11_parallel_sum T12_matrix_add T13_matrix_mul T14_file_read T15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\*.hx" . >nul
  "%HAXE%" -cp . -main %%T -cpp out -D mingw -D MINGW_ROOT=C:\mingw64 -D no_shared_libs >build.log 2>&1
  if exist "out\%%T.exe" ( echo OK %%T ) else ( echo HAXE-FAIL %%T )
)
echo ALLDONE
