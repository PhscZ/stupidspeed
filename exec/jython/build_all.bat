@echo off
setlocal enabledelayedexpansion
rem No build step: Jython is an interpreter, so nothing is compiled ahead of time. This stages
rem the fifteen Python-2 scripts and the 50 MiB fixture into exec\jython\.
rem   tools\openj9\bin\java.exe -jar tools\jython\jython-standalone-2.7.4.jar <task>.py
rem The sources are sources/jython/, Python-2 rewrites of the cpython row's files: Jython 2.7
rem has no f-strings and `print` is a statement. java.lang.Thread gives real JVM threads, so
rem task 11 is four real threads; System.nanoTime is the clock.
rem Output: exec\jython\<task>.py
set SRC=D:\Users\pedro.cardoso\stupidspeed\sources\jython
set EXEC=D:\Users\pedro.cardoso\stupidspeed\exec\jython
set DATA=D:\Users\pedro.cardoso\stupidspeed\data.bin

echo ########## staging
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.py" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.py" ( echo OK jython staged ) else ( echo JYTHON-FAIL staging )
echo ALLDONE
