@echo off
setlocal enabledelayedexpansion
rem No build step: node, bun and deno run the sources directly. This stages the fifteen scripts
rem and the 50 MiB fixture into exec\javascript\ so every runtime executes the same copy.
rem   node <task>.js | bun <task>.js | deno run <task>.js
rem The sources are sources/javascript/, shared by all three runtimes: task 11 uses
rem node:worker_threads (four workers, one heap each) and tasks 14 and 15 use node:fs.
rem Output: exec\javascript\<task>.js
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\javascript
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\javascript
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.js" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.js" ( echo OK javascript staged ) else ( echo JS-FAIL staging )
echo ALLDONE
