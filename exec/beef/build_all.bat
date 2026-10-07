@echo off
setlocal enabledelayedexpansion
rem Build all 15 Beef tasks into exec\beef\<task>\out\prog.exe
rem BeefBuild compiles projects, not files, so each task owns a project (BeefProj.toml +
rem BeefSpace.toml + <task>.bf). -config=Release is mandatory: the Debug toolset is
rem Microsoft's and stops without Visual Studio, while Release links with the bundled
rem lld-link.exe. Two things had to be placed for this to work at all: BeefConfig.toml
rem copied from the installer's __user/bin/ into bin/ (otherwise "Unable to load project
rem 'corlib'"), and a shell32.lib in bin/lib/x64/ (the Release link line asks for it but
rem the distribution ships only eleven import libraries). corlib is recompiled per project,
rem so each task takes 10-20 s.
set BEEFBUILD=C:\stupidspeed\tools\beef\bin\BeefBuild.exe
set SRC=C:\stupidspeed\sources\beef
set EXEC=C:\stupidspeed\exec\beef
cd /d C:\stupidspeed

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  echo === %%T
  mkdir "%EXEC%\%%T" 2>nul
  copy /y "%SRC%\%%T\*" "%EXEC%\%%T\" >nul
  "%BEEFBUILD%" -proddir=exec/beef/%%T -config=Release -platform=Win64 >"%EXEC%\%%T\beefbuild.log" 2>&1
  if exist "%EXEC%\%%T\out\prog.exe" ( echo OK %%T ) else ( echo BEEF-FAIL %%T )
)
echo ALLDONE
