@echo off
rem Run all fifteen Lua tasks on both interpreters, the way exec\lua\verify.py does.
rem The staged script is the artifact of both cells; only the interpreter and the
rem LUA_PATH/LUA_CPATH pointing at the Lanes extension differ.
setlocal
set ROOT=%~dp0..\..
set LUA=%ROOT%\tools\lua\lua54.exe
set JIT=%ROOT%\tools\luajit\luajit.exe
set ROCKS=%ROOT%\tools\lua-rocks
for %%I in (5.4 5.1) do (
  set "LUA_PATH=%ROCKS%\share\lua\%%I\?.lua;%ROCKS%\share\lua\%%I\?\init.lua;;"
  set "LUA_CPATH=%ROCKS%\lib\lua\%%I\?.dll;;"
  for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
    echo === %%I %%T
    pushd "%ROOT%\exec\lua"
    if exist out.bin del /q out.bin
    if "%%I"=="5.4" ("%LUA%" %%T.lua) else ("%JIT%" %%T.lua)
    popd
  )
)
endlocal
