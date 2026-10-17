@echo off
rem Build the modula2 row -- ADW's ISO Modula-2 compiler, two steps per task:
rem
rem   exec\modula2\<task>\prog.exe    artifact, run as `exec\modula2\<task>\prog.exe`
rem
rem The build line is the row header's, verbatim:
rem
rem   m2amd64.exe /sym:.;<ADW>\ASCII\winamd64sym <task>.mod
rem   sblink.exe /machine:amd64 /out:prog.exe <module>.obj
rem       <ADW>\ASCII\rtl-win-amd64.lib <ADW>\ASCII\win64api.lib
rem
rem The `.` in `/sym:.;` is load bearing: the compiler does not search the
rem working directory for symbol files, so a module that imports a definition
rem module compiled in the same directory fails with `Could not open SYM file`.
rem
rem Task 03 is three files -- 03_func_sum.mod imports Func, whose definition is
rem in Func.def and whose body is in Func.mod -- and they compile in that order:
rem Func.def first (it writes the Func.sym the caller needs), then Func.mod,
rem then 03_func_sum.mod; the link names both objects.
rem
rem The object name is the MODULE name, not the file name, which is why three
rem tasks link something other than Task<NN>.obj: 02 is T64, 10 is T10 and 11 is
rem TThread.  Tasks 14 and 15 read and write the 50 MiB fixture, so data.bin is
rem copied into their run directories.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\modula2
set OUT=%ROOT%\exec\modula2
set ADW=%ROOT%\tools\adwm2\app
set M2=%ADW%\ASCII\m2amd64.exe
set SBLINK=%ADW%\ASCII\sblink.exe
set SYM=/sym:.;%ADW%\ASCII\winamd64sym
set LIBS=%ADW%\ASCII\rtl-win-amd64.lib %ADW%\ASCII\win64api.lib
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAILED=0

for %%T in (%TASKS%) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  copy /y "%SRC%\%%T.mod" "%OUT%\%%T\%%T.mod" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\%%T\data.bin" >nul

  rem the module name, hence the object name
  set "N=%%T"
  set "OBJ=Task!N:~0,2!"
  if "%%T"=="02_switch_case" set OBJ=T64
  if "%%T"=="10_pi" set OBJ=T10
  if "%%T"=="11_parallel_sum" set OBJ=TThread

  set "EXTRA="
  if "%%T"=="03_func_sum" (
    copy /y "%SRC%\Func.def" "%OUT%\%%T\Func.def" >nul
    copy /y "%SRC%\Func.mod" "%OUT%\%%T\Func.mod" >nul
    set "EXTRA=Func.obj"
  )

  pushd "%OUT%\%%T"
  del /q prog.exe *.obj *.sym >nul 2>&1
  type nul >build.log
  if "%%T"=="03_func_sum" (
    "%M2%" %SYM% Func.def >>build.log 2>&1
    "%M2%" %SYM% Func.mod >>build.log 2>&1
  )
  "%M2%" %SYM% %%T.mod >>build.log 2>&1
  "%SBLINK%" /machine:amd64 /out:prog.exe !OBJ!.obj !EXTRA! %LIBS% >>build.log 2>&1
  popd

  if not exist "%OUT%\%%T\prog.exe" (
    echo modula2-FAIL %%T
    set FAILED=1
  ) else (
    echo OK %%T
  )
)

if not "%FAILED%"=="0" (echo modula2-FAIL build & exit /b 1)
endlocal & exit /b 0
