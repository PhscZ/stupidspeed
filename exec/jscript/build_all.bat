@echo off
setlocal enabledelayedexpansion
rem No build step: cscript.exe is the runtime and ships with Windows. This stages the fifteen
rem scripts, the task 03 helper and the 50 MiB fixture into exec\jscript\.
rem   cscript //nologo //E:JScript <task>.js
rem The sources are sources/jscript/, the Windows Script Host Active Scripting JScript row,
rem which is not the `javascript` row's node/bun/deno. Task 03 loads
rem 03_func_sum_add_one.js beside it; tasks 14 and 15 use data.bin/out.bin in the working
rem directory. The .js extension is not mapped to this engine here, so //E:JScript is explicit.
rem Output: exec\jscript\<task>.js
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\jscript
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\jscript
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.js" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\03_func_sum_add_one.js" ( echo OK jscript staged ) else ( echo JS-FAIL staging )
echo ALLDONE
