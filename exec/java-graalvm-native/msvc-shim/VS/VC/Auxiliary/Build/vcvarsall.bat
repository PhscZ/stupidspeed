@echo off
rem vcvarsall.bat stand-in for the hand-extracted MSVC tree under tools\msvc.
rem GraalVM's native-image runs this with an architecture argument (x64) and
rem takes the environment delta it produces as the C toolchain environment.
rem It is never called from a real developer prompt, so it simply exports the
rem PATH/INCLUDE/LIB that tools\msvc_env.py computes, plus the VS variables
rem some tools probe for.
set "SS_MSVC=C:\stupidspeed\tools\msvc"
set "SS_VCVER=14.44.35207"
set "SS_SDKVER=10.0.26100.0"
set "PATH=%SS_MSVC%\VC\Tools\MSVC\%SS_VCVER%\bin\Hostx64\x64;%PATH%"
set "INCLUDE=%SS_MSVC%\VC\Tools\MSVC\%SS_VCVER%\include;%SS_MSVC%\Windows Kits\10\Include\%SS_SDKVER%\ucrt;%SS_MSVC%\Windows Kits\10\Include\%SS_SDKVER%\um;%SS_MSVC%\Windows Kits\10\Include\%SS_SDKVER%\shared"
set "LIB=%SS_MSVC%\VC\Tools\MSVC\%SS_VCVER%\lib\x64;%SS_MSVC%\Windows Kits\10\Lib\%SS_SDKVER%\ucrt\x64;%SS_MSVC%\Windows Kits\10\Lib\%SS_SDKVER%\um\x64"
set "VSINSTALLDIR=%SS_MSVC%\VS\"
set "VCINSTALLDIR=%SS_MSVC%\VC\"
set "VCToolsInstallDir=%SS_MSVC%\VC\Tools\MSVC\%SS_VCVER%\"
set "VCToolsVersion=%SS_VCVER%"
set "WindowsSdkDir=%SS_MSVC%\Windows Kits\10\"
set "WindowsSDKVersion=%SS_SDKVER%\"
set "UniversalCRTSdkDir=%SS_MSVC%\Windows Kits\10\"
set "UCRTVersion=%SS_SDKVER%"
set "WindowsSdkBinPath=%SS_MSVC%\Windows Kits\10\bin\"
exit /b 0
