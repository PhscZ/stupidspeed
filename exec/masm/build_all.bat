@echo off
setlocal
rem Build all 15 MASM x64 tasks, one per task directory:
rem   exec\masm\masm\<task>\<task>.exe
rem Freestanding PE64: ml64.exe /c, then link.exe /subsystem:console /entry:main,
rem kernel32.dll imports only, no CRT.
rem
rem ml64/link come from the hand-extracted MSVC tree under tools\msvc.  The env
rem snippet from tools\msvc_env.py is written to a .bat and `call`ed (a batch
rem `for /f` loop would mangle %PATH%).
set "ROOT=C:\stupidspeed"
set "SRC=%ROOT%\sources\masm"
set "EXEC=%ROOT%\exec\masm\masm"
rem NB: do NOT name these ML/LINK -- ml64.exe reads an environment variable
rem named ML (and link.exe reads LINK) as default options, so `set ML=<path>`
rem makes the assembler try to assemble its own executable.
set "ML64EXE=%ROOT%\tools\msvc\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64\ml64.exe"
set "LINKEXE=%ROOT%\tools\msvc\VC\Tools\MSVC\14.44.35207\bin\Hostx64\x64\link.exe"
set "ENVBAT=%ROOT%\exec\masm\msvcenv.bat"

python "%ROOT%\tools\msvc_env.py" > "%ENVBAT%"
call "%ENVBAT%"

if not exist "%EXEC%" mkdir "%EXEC%"

for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%EXEC%\%%T" mkdir "%EXEC%\%%T"
  copy /y "%SRC%\%%T.asm" "%EXEC%\%%T\" >nul
  cd /d "%EXEC%\%%T"
  del /q %%T.obj %%T.exe 2>nul
  "%ML64EXE%" /nologo /c /Fo %%T.obj %%T.asm >build.log 2>&1
  if exist %%T.obj "%LINKEXE%" /nologo /subsystem:console /entry:main /out:%%T.exe %%T.obj kernel32.lib >>build.log 2>&1
  if exist %%T.exe (echo OK %%T) else (echo MASM-FAIL %%T)
)

rem Tasks 14 and 15 read/write data.bin in the directory they run in.
for %%T in (14_file_read 15_file_write) do copy /y "%ROOT%\data.bin" "%EXEC%\%%T\" >nul

echo ALLDONE
endlocal
