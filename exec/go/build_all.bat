@echo off
rem Build the go row: two toolchains, two source directories, one Go SDK on PATH.
rem   exec\go\gc\<task>\prog.exe       from sources\go\      `go build -o prog.exe <task>.go`
rem   exec\go\tinygo\<task>\prog.exe   from sources\tinygo\  `tinygo build -o prog.exe <task>.go`
rem TinyGo shells out to `go` for `go list`/`go env`, so the Go SDK has to be in
rem front of PATH for both halves of the row (BUILD.md).  `tools\go\bin` first,
rem falling back to the system install.
rem Tasks 14 and 15 need the data.bin fixture in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set GO=%ROOT%\tools\go\bin
if not exist "%GO%\go.exe" set GO=C:\Program Files\Go\bin
set PATH=%GO%;%PATH%
set GOBIN=
set TINYGO=%ROOT%\tools\tinygo\bin\tinygo.exe

set OUTGC=%ROOT%\exec\go\gc
set OUTTG=%ROOT%\exec\go\tinygo
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUTGC%\%%T" mkdir "%OUTGC%\%%T"
  pushd "%OUTGC%\%%T"
  copy /y "%ROOT%\sources\go\%%T.go" "%%T.go" >nul || (echo go-FAIL %%T & popd & exit /b 1)
  go build -o prog.exe %%T.go > build.log 2>&1 || (echo go-FAIL %%T & type build.log & popd & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" data.bin >nul
  popd
  echo OK %%T gc

  if not exist "%OUTTG%\%%T" mkdir "%OUTTG%\%%T"
  pushd "%OUTTG%\%%T"
  copy /y "%ROOT%\sources\tinygo\%%T.go" "%%T.go" >nul || (echo go-FAIL %%T & popd & exit /b 1)
  "%TINYGO%" build -o prog.exe %%T.go > build.log 2>&1 || (echo go-FAIL %%T & type build.log & popd & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" data.bin >nul
  popd
  echo OK %%T tinygo
)
endlocal
