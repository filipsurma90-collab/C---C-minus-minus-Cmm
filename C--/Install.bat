@echo off
title Cmm Language Installer
echo ==========================================
echo    Installing Cmm Library to your System  
echo ==========================================
echo.

:: Check for administrative privileges
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [ERROR] Access Denied!
    echo Please close this window, right-click 'install.bat' and select:
    echo "Run as administrator"
    echo.
    pause
    exit /b
)

:: 1. Detect Visual Studio path
set "VS_PATH=C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\MSVC"
if not exist "%VS_PATH%" set "VS_PATH=C:\Program Files\Microsoft Visual Studio\2026\Community\VC\Tools\MSVC"

if not exist "%VS_PATH%" (
    echo [ERROR] Visual Studio installation not found in default paths!
    echo You will need to copy the 'Cmm' header file manually.
    echo.
    pause
    exit /b
)

:: 2. Find the latest MSVC build version folder
cd /d "%VS_PATH%"
for /f "delims=" %%i in ('dir /b /ad /o-n') do (
    set "VERSION_FOLDER=%%i"
    goto :found_version
)

:found_version
set "INCLUDE_PATH=%VS_PATH%\%VERSION_FOLDER%\include"

:: 3. Copy Cmm file to the system include directory
echo Detected system include path: 
echo %INCLUDE_PATH%
echo.
echo Copying Cmm core files...

copy /Y "%~dp0Cmm" "%INCLUDE_PATH%\Cmm" >nul

if %errorlevel% equ 0 (
    echo.
    echo ==========================================
    echo [SUCCESS] Cmm Language successfully installed!
    echo You can now use #include ^<Cmm^> globaly
    echo in any C++ project without configuration.
    echo ==========================================
) else (
    echo.
    echo [ERROR] Something went wrong during the installation.
)

echo.
pause
