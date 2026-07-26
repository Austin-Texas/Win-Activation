@echo off
title Hasten Runner - Activation / Diagnostic
color 0A
set DOWNLOADS=%USERPROFILE%\Downloads

REM ============================================================
REM AUTO-DOWNLOAD ALL SCRIPTS ON START
REM ============================================================
cls
echo Downloading runner script...
powershell -Command "Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/Run-Activate-Diagnostic-Cleanup.cmd' -OutFile $env:USERPROFILE\Downloads\Run.cmd"

echo Downloading activation script...
powershell -Command "Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/activate.cmd' -OutFile $env:USERPROFILE\Downloads\activate.cmd"

echo Downloading diagnostic script...
powershell -Command "Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/diagnostic.cmd' -OutFile $env:USERPROFILE\Downloads\diagnostic.cmd"

echo.
echo All scripts downloaded successfully.
ping -n 2 127.0.0.1 >nul

REM ============================================================
REM MAIN MENU
REM ============================================================
:menu
cls
echo ==========================================
echo        HASTEN SCRIPT RUNNER - MENU
echo ==========================================
echo.
echo  [1] Run Activation
echo  [2] Run Diagnostic
echo  [3] Run BOTH
echo  [Q] Quit (Delete all scripts)
echo.

choice /C 123Q /N /M "Select an option: "
set choice=%errorlevel%

if %choice%==1 goto run_activation
if %choice%==2 goto run_diagnostic
if %choice%==3 goto run_both
if %choice%==4 goto cleanup_and_exit

goto menu

REM ============================================================
REM ACTIONS
REM ============================================================
:run_activation
cls
echo Running activation script...
call "%DOWNLOADS%\activate.cmd"
echo.
echo Activation completed successfully.
goto menu

:run_diagnostic
cls
echo Running diagnostic script...
call "%DOWNLOADS%\diagnostic.cmd"
echo.
echo Diagnostic completed successfully.
goto menu

:run_both
cls
echo Running activation script...
start "" /wait cmd /c "%DOWNLOADS%\diagnostic.cmd"
echo Activation completed successfully.
echo.
echo Running diagnostic script...
call "%DOWNLOADS%\diagnostic.cmd"
echo Diagnostic completed successfully.
goto menu

REM ============================================================
REM CLEANUP ON QUIT
REM ============================================================
:cleanup_and_exit
cls
echo Cleaning up all downloaded scripts...
del "%DOWNLOADS%\activate.cmd" /f /q 2>nul
del "%DOWNLOADS%\diagnostic.cmd" /f /q 2>nul
del "%DOWNLOADS%\Run.cmd" /f /q 2>nul
echo Cleanup complete. Exiting...
exit
