@echo off
setlocal

REM DuelLog one-click launcher (Windows)
REM Note: Keep this file ASCII-only to avoid cmd encoding issues.

set "ROOT=%~dp0"

echo === DuelLog Launcher ===
echo Root: %ROOT%
echo.

REM Basic checks (avoid IF (...) blocks to reduce parsing issues)
where go >nul 2>nul
if %errorlevel% neq 0 goto :missing_go

where node >nul 2>nul
if %errorlevel% neq 0 goto :missing_node

where npm >nul 2>nul
if %errorlevel% neq 0 goto :missing_npm

REM Optional warning: gcc (CGO for go-sqlite3)
where gcc >nul 2>nul
if %errorlevel% neq 0 echo [WARN] gcc not found. Backend may require GCC (TDM-GCC/MinGW) on Windows.

REM Verify project folders exist
if not exist "%ROOT%apps\api\go.mod" goto :missing_api
if not exist "%ROOT%apps\web\package.json" goto :missing_web

echo Starting backend...
start "DuelLog API" /D "%ROOT%apps\api" cmd /k "go run ."

echo Starting frontend...
REM Install deps only if node_modules missing; use npm ci when package-lock exists.
start "DuelLog Web" /D "%ROOT%apps\web" cmd /k "if not exist node_modules (if exist package-lock.json (npm ci) else (npm install)) & npm run dev"

echo.
echo Opening browser (may take a few seconds)...
timeout /t 2 /nobreak >nul
start "" http://localhost:5173/history

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
