@echo off
rem Build the go-wasm row: one wasip1 module per task, fifteen modules, run by
rem six WASI hosts.  The Go SDK is the one the native `go` row uses; the SDK is
rem put in front of PATH explicitly (BUILD.md) so the build never picks up a
rem different `go` from the inherited environment.
rem   exec\go-wasm\<task>\prog.wasm   from sources\go-wasm\
rem   GOOS=wasip1 GOARCH=wasm CGO_ENABLED=0 go build -o prog.wasm <task>.go
rem Task 14 reads the data.bin fixture from the preopened root; task 15 writes
rem out.bin there.  Both get the fixture staged in their run directory.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set GO=%ROOT%\tools\go\bin
if not exist "%GO%\go.exe" set GO=C:\Program Files\Go\bin
set PATH=%GO%;%PATH%
set GOOS=wasip1
set GOARCH=wasm
set CGO_ENABLED=0
set OUT=%ROOT%\exec\go-wasm
for %%T in (01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write) do (
  if not exist "%OUT%\%%T" mkdir "%OUT%\%%T"
  pushd "%OUT%\%%T"
  copy /y "%ROOT%\sources\go-wasm\%%T.go" "%%T.go" >nul || (echo go-wasm-FAIL %%T & popd & exit /b 1)
  go build -o prog.wasm %%T.go > build.log 2>&1 || (echo go-wasm-FAIL %%T & type build.log & popd & exit /b 1)
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" data.bin >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" data.bin >nul
  popd
  echo OK %%T
)
endlocal
