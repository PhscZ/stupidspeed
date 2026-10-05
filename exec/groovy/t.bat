@echo off
set GROOVY_HOME=C:\stupidspeed\tools\groovy\groovy-4.0.33
set PATH=%GROOVY_HOME%\bin;%PATH%
cd /d C:\stupidspeed\exec\groovy
groovy.bat 01_branches.groovy
echo RC=%ERRORLEVEL%
