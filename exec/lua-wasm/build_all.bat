@echo off
setlocal
rem Build lua.wasm — the wasm32-wasip1 build of PUC Lua 5.4.8 — then stage the fifteen scripts
rem and the 50 MiB fixture into exec\lua-wasm\.
rem   wasmtime -W exceptions=y --dir . lua.wasm <task>.lua
rem The sources are sources/lua-wasm/, a complete fifteen-file set: fourteen are byte-identical
rem to sources/lua/'s and task 11 differs (coroutines instead of the Lanes C extension, which has
rem no wasm build). The interpreter is built once here from the lua-5.4.8 tarball in
rem tools\lua-wasm\ with the wasi-sdk the C row already installs. Four things carry the target:
rem   - the Lua sources compile as C++ with -fexceptions, because ldo.c defines LUAI_THROW/LUAI_TRY
rem     as throw/catch under __cplusplus, and wasi-libc's <setjmp.h> is a hard #error without
rem     -mllvm -wasm-enable-sjlj (whose runtime support is not in wasi-sdk 34's compiler-rt);
rem     tools\lua-wasm\shim\setjmp.h is placed first on the include path to satisfy that include.
rem   - the link uses -fwasm-exceptions and the sysroot's wasm32-wasip1/eh library directory.
rem   - wasi_shims.c supplies tmpfile/tmpnam/system, which wasi-libc omits and Lua references
rem     unconditionally; it is compiled as C so its symbols keep C linkage.
rem   - luac.c is skipped: it has its own main and is not part of the interpreter.
rem -W exceptions=y is mandatory at run time: Lua's pcall/error path lowers onto the
rem exception-handling proposal and wasmtime's exceptions feature is off by default.
rem Output: exec\lua-wasm\lua.wasm + <task>.lua
rem Paths are derived from this script's own location, so the row works from any checkout.
for %%I in ("%~dp0..\..") do set "ROOT=%%~fI"
set SDK=%ROOT%\tools\wasi-sdk\wasi-sdk-34.0-x86_64-windows
set CC=%SDK%\bin\clang.exe
set CXX=%SDK%\bin\clang++.exe
set WTROOT=%ROOT%\tools\lua-wasm
set SRCDIR=%WTROOT%\lua-5.4.8\src
set SHIM=%WTROOT%\shim
set BUILD=%WTROOT%\build
set SRC=%ROOT%\sources\lua-wasm
set EXEC=%~dp0
set DATA=%ROOT%\data.bin
set CFLAGS=--target=wasm32-wasip1 -O2 -fexceptions -DNDEBUG -D_WASI_EMULATED_SIGNAL -DL_tmpnam=32

echo ########## lua.wasm
rem The lua-5.4.8 source tree is only needed to rebuild the interpreter. When it is absent
rem but a lua.wasm is already present, the existing interpreter is staged unchanged.
if not exist "%SRCDIR%" (
  if exist "%WTROOT%\lua.wasm" ( echo OK lua.wasm ^(prebuilt, source tree absent^) & set "LUAWASM=%WTROOT%\lua.wasm" ) else ( echo LUAWASM-FAIL no source tree and no prebuilt lua.wasm )
  goto :stage
)
mkdir "%BUILD%" 2>nul
cd /d "%BUILD%"
del /q *.o lua.wasm 2>nul
for %%F in ("%SRCDIR%\*.c") do (
  if /i not "%%~nF"=="luac" (
    "%CXX%" %CFLAGS% -I"%SHIM%" -I"%SRCDIR%" -c "%%F" -o "%%~nF.o" >compile.log 2>&1
  )
)
"%CC%" %CFLAGS% -I"%SHIM%" -I"%SRCDIR%" -c "%WTROOT%\wasi_shims.c" -o wasi_shims.o >>compile.log 2>&1
"%CXX%" --target=wasm32-wasip1 -O2 -fwasm-exceptions -mllvm -wasm-use-legacy-eh=false -L"%SDK%\share\wasi-sysroot\lib\wasm32-wasip1\eh" -lc++abi -lunwind -lwasi-emulated-signal -lwasi-emulated-process-clocks -o lua.wasm *.o >link.log 2>&1
if exist lua.wasm ( echo OK lua.wasm & set "LUAWASM=%BUILD%\lua.wasm" ) else ( echo LUAWASM-FAIL interpreter )

echo ########## staging
:stage
mkdir "%EXEC%" 2>nul
copy /y "%SRC%\*.lua" "%EXEC%\" >nul
copy /y "%LUAWASM%" "%EXEC%\" >nul
copy /y "%DATA%" "%EXEC%\" >nul
if exist "%EXEC%\11_parallel_sum.lua" ( echo OK lua-wasm staged ) else ( echo LUAWASM-FAIL staging )
echo ALLDONE
