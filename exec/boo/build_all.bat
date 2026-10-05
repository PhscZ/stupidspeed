@echo off
setlocal enabledelayedexpansion
rem Build all 15 Boo tasks into exec\boo\<task>\prog.exe
rem booc emits a .NET assembly; each task gets its own directory because the output is always
rem named prog.exe. Two files must sit beside prog.exe or it will not start: Boo.Lang.dll and
rem a prog.runtimeconfig.json declaring Microsoft.NETCore.App 10.0.0.
set DOTNET=C:\stupidspeed\tools\dotnet10\dotnet.exe
set BOOC=C:\stupidspeed\tools\boo\src\booc\bin\Release\net10.0\booc.dll
set BOOLANG=C:\stupidspeed\tools\boo\src\Boo.Lang\bin\Release\net10.0\Boo.Lang.dll
set SRC=C:\stupidspeed\sources\boo
set EXEC=C:\stupidspeed\exec\boo

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  cd /d "%EXEC%\%%T"
  copy /y "%SRC%\%%T.boo" . >nul
  copy /y "%BOOLANG%" . >nul
  >prog.runtimeconfig.json echo {"runtimeOptions":{"tfm":"net10.0","framework":{"name":"Microsoft.NETCore.App","version":"10.0.0"}}}
  "%DOTNET%" "%BOOC%" -o:prog.exe %%T.boo >booc.log 2>&1
  if exist prog.exe ( echo OK %%T ) else ( echo BOO-FAIL %%T )
)
echo ALLDONE
