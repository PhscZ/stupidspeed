@echo off
rem Build the lua row: Lua is interpreted, so "building" a task is staging its
rem script into the directory the harness runs it from.
rem   exec\lua\<task>.lua      artifact, run as `lua54.exe <task>.lua` (puc-lua)
rem                                       `luajit.exe <task>.lua` (luajit)
rem Both toolchain entries share that one directory: the same script is the
rem artifact of both cells, only the interpreter differs.  Tasks 14 and 15 need
rem the data.bin fixture beside the script; task 15 leaves out.bin there.
rem Task 11 `require("lanes")`, which lives in tools\lua-rocks\ -- the cells.json
rem LUA_PATH/LUA_CPATH entries point there, so nothing has to be installed here.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\lua
set OUT=%ROOT%\exec\lua
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  copy /y "%SRC%\%%T.lua" "%OUT%\%%T.lua" >nul || (echo lua-FAIL %%T & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\data.bin" >nul
  echo OK %%T
)
endlocal
