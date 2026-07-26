@echo off
title Hasten Universal Runner - Auto Cleanup + Loading Bar
color 0A

REM ============================================================
REM   UNIVERSAL DOWNLOADS FOLDER
REM ============================================================
set DOWNLOADS=%USERPROFILE%\Downloads

REM ============================================================
REM   GITHUB RAW LINKS
REM ============================================================
set ACTIVATE_URL=https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/activate.cmd
set DIAG_URL=https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/diagnostic.cmd

REM ============================================================
REM   LOADING BAR FUNCTION
REM ============================================================
:loading
setlocal enabledelayedexpansion
set BAR=
for /L %%i in (1,1,30) do (
    set BAR=!BAR!█
    cls
    echo.
    echo Downloading... Please wait.
    echo.
    echo [!BAR!]
    ping -n 1 127.0.0.1 >nul
)
endlocal
goto :eof

REM ============================================================
REM   MENU
REM ============================================================
:menu
cls
echo ============================================================
echo              HASTEN SCRIPT RUNNER - MENU
echo ============================================================
echo.
echo  [1] Run Activation Script
echo  [2] Run Diagnostic / Cleanup Script
echo  [3] Run BOTH (Activation + Diagnostic)
echo  [4] Exit
echo.
set /p choice=Select an option (1-4): 

if "%choice%"=="1" goto run_activate
if "%choice%"=="2" goto run_diag
if "%choice%"=="3" goto run_both
if "%choice%"=="4" goto end

echo Invalid choice. Try again.
pause
goto menu

REM ============================================================
REM   DOWNLOAD FUNCTIONS WITH LOADING BAR
REM ============================================================
:download_activate
call :loading
powershell -command "(New-Object Net.WebClient).DownloadFile('%ACTIVATE_URL%', '%DOWNLOADS%\activate.cmd')"
goto :eof

:download_diag
call :loading
powershell -command "(New-Object Net.WebClient).DownloadFile('%DIAG_URL%', '%DOWNLOADS%\diagnostic.cmd')"
goto :eof

REM ============================================================
REM   RUN OPTIONS
REM ============================================================
:run_activate
cls
echo Running activation script...
call :download_activate
call "%DOWNLOADS%\activate.cmd"
goto cleanup

:run_diag
cls
echo Running diagnostic script...
call :download_diag
call "%DOWNLOADS%\diagnostic.cmd"
goto cleanup

:run_both
cls
echo Running activation script...
call :download_activate
call "%DOWNLOADS%\activate.cmd"
echo.
echo Running diagnostic script...
call :download_diag
call "%DOWNLOADS%\diagnostic.cmd"
goto cleanup

REM ============================================================
REM   FULL CLEANUP (OPTION C)
REM ============================================================
:cleanup
echo.
echo Cleaning up all downloaded files...
del "%DOWNLOADS%\activate.cmd" /f /q 2>nul
del "%DOWNLOADS%\diagnostic.cmd" /f /q 2>nul
del "%DOWNLOADS%\Run.cmd" /f /q 2>nul
echo Cleanup complete.
echo.
pause
goto menu

:end
echo Exiting...
exit
