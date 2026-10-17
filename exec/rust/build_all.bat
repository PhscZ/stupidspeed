@echo off
rem Build the rust row: the same fifteen sources through two code generators.
rem   exec\rust\rustc\<task>\prog.exe      rustc -O  (LLVM)
rem   exec\rust\cranelift\<task>\prog.exe  rustc +nightly -Zcodegen-backend=cranelift -O
rem rustc's front end and MIR are identical between the two; only the backend
rem behind MIR changes.  Both toolchains are x86_64-pc-windows-gnu here, so the
rem GNU linker does the linking and no MSVC environment is needed.
rem Tasks 14 and 15 read/write data.bin in the directory the program runs in.
setlocal enabledelayedexpansion
set ROOT=%~dp0..\..
set SRC=%ROOT%\sources\rust
set CARGOBIN=%USERPROFILE%\.cargo\bin
set RUSTC=%CARGOBIN%\rustc.exe
set OUT=%ROOT%\exec\rust
set TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write
set FAIL=0
set "PATH=%CARGOBIN%;%PATH%"

for %%T in (%TASKS%) do (
  if not exist "%OUT%\rustc\%%T" mkdir "%OUT%\rustc\%%T"
  copy /y "%SRC%\%%T.rs" "%OUT%\rustc\%%T\%%T.rs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\rustc\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\rustc\%%T\data.bin" >nul
  pushd "%OUT%\rustc\%%T"
  "%RUSTC%" -O -o prog.exe %%T.rs >build.log 2>&1
  if errorlevel 1 (echo rust-FAIL rustc %%T & set FAIL=1) else (echo OK %%T rustc)
  popd

  if not exist "%OUT%\cranelift\%%T" mkdir "%OUT%\cranelift\%%T"
  copy /y "%SRC%\%%T.rs" "%OUT%\cranelift\%%T\%%T.rs" >nul
  if "%%T"=="14_file_read" copy /y "%ROOT%\data.bin" "%OUT%\cranelift\%%T\data.bin" >nul
  if "%%T"=="15_file_write" copy /y "%ROOT%\data.bin" "%OUT%\cranelift\%%T\data.bin" >nul
  pushd "%OUT%\cranelift\%%T"
  "%RUSTC%" +nightly -Zcodegen-backend=cranelift -O -o prog.exe %%T.rs >build.log 2>&1
  if errorlevel 1 (echo rust-FAIL cranelift %%T & set FAIL=1) else (echo OK %%T cranelift)
  popd
)

if "%FAIL%"=="1" (echo rust-FAIL some task & exit /b 1)
echo rust OK
endlocal
