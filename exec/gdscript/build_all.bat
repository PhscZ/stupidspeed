@echo off
rem Build the gdscript row: GDScript is interpreted, so "building" a task is
rem staging its script into the directory the harness runs it from.
rem   exec\gdscript\<task>.gd   artifact, run as `godot --headless --script <task>.gd`
rem The cell's cwd is exec\gdscript itself and every task is run from there, so all
rem fifteen scripts plus the shared project.godot live in that one flat directory
rem (project.godot's [application] run/print_header=false is what keeps the engine
rem banner off stdout).  Tasks 14 and 15 get the data.bin fixture beside them.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\gdscript
set OUT=%ROOT%\exec\gdscript
if not exist "%OUT%" mkdir "%OUT%"
copy /y "%SRC%\project.godot" "%OUT%\project.godot" >nul || (echo gdscript-FAIL project.godot & exit /b 1)
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.gd" "%OUT%\%%T.gd" >nul || (echo gdscript-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul || (echo gdscript-FAIL %%T & exit /b 1)
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul || (echo gdscript-FAIL %%T & exit /b 1)
  echo OK %%T
)
endlocal
