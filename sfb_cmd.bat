@echo off
@REM Batch file that is run first by the Command Prompt profile in Windows Terminal.
@REM Allows the use of Visual Studio CLI tools in the Command Prompt without opening
@REM "Developer Command Prompt for VS 2022". Acts like a PowerShell profile as well.

@REM If we just set the CMD profile in Windows Terminal to run the batch file
@REM below, we won't get the standard CMD banner. So, we need to have this
@REM script, which we wrote to present us with a standard banner after running
@REM VsDevCmd.bat.
call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat" -arch=x64 -host_arch=x64 -no_logo

@REM Calling cmd.exe would seem easier, but is outright wasteful of resources.
@REM We just need to show the standard CMD banner anyway. So, why not just replicate
@REM it? We could have called ver, but it introduces an extra line at the top, so
@REM we're not using it.
for /f "tokens=4-5 delims= " %%i in ('ver') do (
  if "%%j"=="" (set v=%%i) else (set v=%%j)
)
for /f "tokens=1-4 delims=.]" %%i in ("%v%") do (
  set OS_VER_MAJOR=%%i
  set OS_VER_MINOR=%%j
  set OS_BUILD_NUM=%%k
  set OS_REVISION=%%l
)

echo Microsoft Windows [Version %OS_VER_MAJOR%.%OS_VER_MINOR%.%OS_BUILD_NUM%.%OS_REVISION%]
echo (c) Microsoft Corporation. All rights reserved.
