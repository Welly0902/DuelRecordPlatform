@echo off
setlocal

REM One-click launcher for Windows users.
REM - Starts Go API server (apps\api)
REM - Starts Vite dev server (apps\web)

pushd "%~dp0"
echo === DuelLog Launcher ===
echo Repo root: %CD%
echo.

REM Basic checks
where go >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 找不到 Go。
  echo 請先安裝 Go（建議 Go 1.25.5+），安裝後重新開啟再試一次。
  echo.
  pause
  exit /b 1
)

where node >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 找不到 Node.js。
  echo 請先安裝 Node.js（建議 Node 22.2.0+），安裝後重新開啟再試一次。
  echo.
  pause
  exit /b 1
)

where npm >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 找不到 npm。
  echo 請確認 Node.js 安裝完整（含 npm）。
  echo.
  pause
  exit /b 1
)

REM Go sqlite3 uses CGO on Windows; warn if gcc not found (will fail at build time).
where gcc >nul 2>nul
if errorlevel 1 (
  echo [WARN] 找不到 GCC（C compiler）。
  echo 後端使用 go-sqlite3（CGO），在 Windows 從原始碼啟動通常需要 GCC。
  echo 若稍後後端視窗出現 gcc/cgo 相關錯誤，請先安裝 TDM-GCC 或 MinGW。
  echo.
)

REM Start backend + frontend in separate windows so users can close them to stop.
echo Starting backend...
start "DuelLog API" cmd /k "cd /d %~dp0apps\api && echo [API] Starting... && go run ."

echo Starting frontend...
start "DuelLog Web" cmd /k "cd /d %~dp0apps\web && if not exist node_modules (echo [WEB] Installing dependencies... && npm install) && echo [WEB] Starting... && npm run dev"

REM Open browser (dev server is usually 5173)
echo Opening browser...
timeout /t 2 /nobreak >nul
start "" "http://localhost:5173/history"

echo.
echo 已啟動兩個視窗：DuelLog API 與 DuelLog Web。
echo 若要停止服務，直接關閉那兩個視窗即可。
echo.
pause
popd
endlocal
