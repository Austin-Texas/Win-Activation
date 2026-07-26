@echo off
title Windows Activation Diagnostic Tool - Hasten Edition
color 0A

echo ============================================================
echo        WINDOWS ACTIVATION DIAGNOSTIC TOOL (SAFE)
echo ============================================================
echo.

echo [1] Detecting Windows Edition...
wmic os get Caption
echo.

wmic os get Caption | findstr /i "LTSC" >nul
if %errorlevel%==0 (
    echo Your edition is: Windows 10 Enterprise LTSC
    echo LTSC requires a real retail key or a corporate KMS server.
    echo Generic keys will NOT activate LTSC.
    echo.
)

wmic os get Caption | findstr /i "EnterpriseS" >nul
if %errorlevel%==0 (
    echo Your edition is: Windows 10 EnterpriseS (LTSC Core)
    echo This edition cannot activate with generic keys.
    echo.
)

echo [2] Checking Activation Status...
slmgr /xpr
echo.

echo [3] Getting Detailed Licensing Information...
slmgr /dlv
echo.

echo [4] Checking for KMS Server Configuration...
cscript //nologo slmgr.vbs /dli | findstr /i "KMS" && (
    echo WARNING: A KMS server appears to be configured.
) || (
    echo No KMS server detected.
)
echo.

echo [5] Scanning Network Connections for KMS Traffic (Port 1688)...
netstat -ano | findstr ":1688" && (
    echo WARNING: KMS traffic detected!
) || (
    echo No KMS traffic found. Your system is clean.
)
echo.

echo [6] Checking if a Product Key is Installed...
cscript //nologo slmgr.vbs /dli | findstr /i "Product Key" || (
    echo No product key installed.
)
echo.

echo ============================================================
echo Diagnostic Complete.
echo Your system is SAFE and CLEAN if:
echo - No KMS server detected
echo - No port 1688 connections
echo - Activation status shows "Not activated" or "Notification"
echo - No product key installed
echo ============================================================
echo.

pause
