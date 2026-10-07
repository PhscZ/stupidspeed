@echo off
setlocal enabledelayedexpansion
rem Build all 15 sources/swift tasks with the Swift 6.4 Windows toolchain.
rem
rem Three things beyond `swiftc -O -o prog.exe <task>.swift` are load bearing:
rem   * -sdk <swift>/Platforms/6.4.0/Windows.platform/Developer/SDKs/Windows.sdk
rem     (the Swift standard library and Foundation live there).
rem   * -windows-sdk-root/-windows-sdk-version, which tell the Swift driver where
rem     the Windows SDK is. Without them the clang importer never injects
rem     ucrt.modulemap/winsdk_*.modulemap and every Foundation import dies with
rem     "missing required modules: '_complex', 'ucrt'".
rem   * the MSVC environment (INCLUDE/LIB/PATH) for the link step, plus the
rem     Swift runtime DLLs on PATH at run time.
rem
rem The Windows SDK under tools\msvc is the reassembled VS layout; its `um`
rem header set is incomplete (CommCtrl.h, ShlObj.h, DbgHelp.h, ... are missing),
rem so the Windows SDK root used here is exec\swift\winsdk-root: the complete
rem 10.0.26100.0 header tree (Microsoft.Windows.SDK.CPP 10.0.26100.1742 from
rem nuget.org) with Lib junctioned to the MSVC tree's libraries.

set "ROOT=C:\stupidspeed"
set "SWIFT_ROOT=%ROOT%\tools\swift"
set "SWIFT_BIN=%SWIFT_ROOT%\Toolchains\6.4.0+NoAsserts\usr\bin"
set "SWIFT_RUNTIME=%SWIFT_ROOT%\Runtimes\6.4.0\usr\bin"
set "SWIFT_SDK=%SWIFT_ROOT%\Platforms\6.4.0\Windows.platform\Developer\SDKs\Windows.sdk"
set "WINSDK=%ROOT%\exec\swift\winsdk-root"
set "WINSDKVER=10.0.26100.0"

if not exist "%SWIFT_BIN%\swiftc.exe" (
    echo SWIFT-FAIL toolchain missing: %SWIFT_BIN%\swiftc.exe
    exit /b 1
)
if not exist "%WINSDK%\Include\%WINSDKVER%\um\CommCtrl.h" (
    echo SWIFT-FAIL Windows SDK headers missing under %WINSDK%\Include\%WINSDKVER%
    exit /b 1
)

rem MSVC environment for the link step (prints a batch snippet; a for /f loop
rem would mangle %PATH%).
python "%ROOT%\tools\msvc_env.py" > "%TEMP%\swift_msvc_env.bat"
call "%TEMP%\swift_msvc_env.bat"

set "PATH=%SWIFT_BIN%;%SWIFT_RUNTIME%;%PATH%"
set "INCLUDE=%WINSDK%\Include\%WINSDKVER%\ucrt;%WINSDK%\Include\%WINSDKVER%\um;%WINSDK%\Include\%WINSDKVER%\shared;%INCLUDE%"
set "LIB=%WINSDK%\Lib\%WINSDKVER%\ucrt\x64;%WINSDK%\Lib\%WINSDKVER%\um\x64;%LIB%"

set "TASKS=01_branches 02_switch_case 03_func_sum 04_array_sum 05_alloc_churn 06_char_count 07_string_append 08_average 09_fib_recursive 10_pi 11_parallel_sum 12_matrix_add 13_matrix_mul 14_file_read 15_file_write"

for %%t in (%TASKS%) do (
    set "OUT=%ROOT%\exec\swift\swiftc\%%t"
    if not exist "!OUT!" mkdir "!OUT!"
    copy /Y "%ROOT%\sources\swift\%%t.swift" "!OUT!\" >nul
    pushd "!OUT!"
    "%SWIFT_BIN%\swiftc.exe" -O -sdk "%SWIFT_SDK%" -windows-sdk-root "%WINSDK%" -windows-sdk-version %WINSDKVER% -o prog.exe %%t.swift > build.log 2>&1
    if errorlevel 1 (
        echo SWIFT-FAIL %%t
    ) else (
        echo OK %%t
    )
    popd
)

rem The two file tasks read the fixture from their working directory; task 15
rem writes out.bin beside it.
for %%t in (14_file_read 15_file_write) do (
    copy /Y "%ROOT%\data.bin" "%ROOT%\exec\swift\swiftc\%%t\" >nul
)
endlocal
