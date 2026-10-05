@echo off
setlocal enabledelayedexpansion
rem No build step: julia compiles the methods it calls on first call, inside the measured run.
rem This stages the fifteen scripts and the 50 MiB fixture into exec\julia\.
rem   julia <task>.jl        (task 11: julia -t4 11_parallel_sum.jl)
rem The sources are sources/julia/. Task 11 uses Threads.@threads, so it must be run with -t4
rem or its four workers share one thread and the cell is a correct-answer-no-speedup.
rem Output: exec\julia\<task>.jl
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\julia
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\julia
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.jl" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.jl" ( echo OK julia staged ) else ( echo JULIA-FAIL staging )
echo ALLDONE
