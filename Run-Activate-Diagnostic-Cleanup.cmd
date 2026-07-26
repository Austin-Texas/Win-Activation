@echo off
title Hasten Script Runner - Menu Edition
color 0A

REM ============================================================
REM   GITHUB RAW LINKS FOR YOUR FILES
REM ============================================================
set ACTIVATE_URL=https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/activate.cmd
set DIAG_URL=https://raw.githubusercontent.com/Austin-Texas/Win-Activation/main/diagnostic.cmd

:menu
cls
echo ============================================================
echo              HASTEN SCRIPT RUNNER - MENU
echo ============================================================
echo.
echo  [1] Download + Run Activation Script
echo  [2] Download + Run Diagnostic Script
echo  [3] Download + Run BOTH Scripts
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

:download_activate
echo Downloading activation script from GitHub...
powershell -command "(New-Object Net.WebClient).DownloadFile('%ACTIVATE_URL%', 'activate.cmd')"
echo Download complete.
goto :eof

:download_diag
echo Downloading diagnostic script from GitHub...
powershell -command "(New-Object Net.WebClient).DownloadFile('%DIAG_URL%', 'diagnostic.cmd')"
echo Download complete.
goto :eof

:run_activate
cls
echo ============================================================
echo          RUNNING ACTIVATION SCRIPT (FROM GITHUB)
echo ============================================================
echo.
call :download_activate
call activate.cmd
echo.
pause
goto menu

:run_diag
cls
echo ============================================================
echo          RUNNING DIAGNOSTIC SCRIPT (FROM GITHUB)
echo ============================================================
echo.
call :download_diag
call diagnostic.cmd
echo.
pause
goto menu

:run_both
cls
echo ============================================================
echo      RUNNING BOTH SCRIPTS (ACTIVATION + DIAGNOSTIC)
echo ============================================================
echo.
call :download_activate
call :download_diag
echo Step 1: Running activation script...
call activate.cmd
echo.
echo Step 2: Running diagnostic script...
call diagnostic.cmd
echo.
pause
goto menu

:end
echo Exiting...
pause
exit
