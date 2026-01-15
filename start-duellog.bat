@echo off
setlocal

REM DuelLog one-click launcher (Windows)
REM Note: Keep this file ASCII-only to avoid cmd encoding issues.

set "ROOT=%~dp0"

echo === DuelLog Launcher ===
echo Root: %ROOT%
echo.

where go >nul 2>nul
if errorlevel 1 goto :missing_go

where node >nul 2>nul
if errorlevel 1 goto :missing_node

where npm >nul 2>nul
if errorlevel 1 goto :missing_npm

where gcc >nul 2>nul
if errorlevel 1 echo [WARN] gcc not found. Backend may require GCC (TDM-GCC/MinGW) on Windows.

if not exist "%ROOT%apps\api\go.mod" goto :missing_api
if not exist "%ROOT%apps\web\package.json" goto :missing_web

echo Starting backend...
start "DuelLog API" cmd /k ""%ROOT%start-backend.bat""

REM Give backend a moment to start
timeout /t 2 /nobreak >nul

echo Starting frontend...
start "DuelLog Web" cmd /k ""%ROOT%start-frontend.bat""

echo.
echo Opening browser (may take a few seconds)...
timeout /t 2 /nobreak >nul
start "" "http://localhost:5173/history"

echo.
echo Two windows were started: DuelLog API and DuelLog Web.
echo Close those windows to stop the servers.
echo.
pause
exit /b 0

:missing_go
echo [ERROR] Go not found. Please install Go (1.25.5+).
pause
exit /b 1

:missing_node
echo [ERROR] Node.js not found. Please install Node.js (22.2.0+).
pause
exit /b 1

:missing_npm
echo [ERROR] npm not found. Please reinstall Node.js (with npm).
pause
exit /b 1

:missing_api
echo [ERROR] Cannot find apps\api. Please run this .bat from the repo root folder.
pause
exit /b 1

:missing_web
echo [ERROR] Cannot find apps\web. Please run this .bat from the repo root folder.
pause
exit /b 1
