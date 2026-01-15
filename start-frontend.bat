@echo off
setlocal
pushd "%~dp0"

where npm >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 找不到 npm。請先安裝 Node.js（建議 Node 22.2.0+）。
  pause
  exit /b 1
)

echo Starting DuelLog Web...
cd /d "%~dp0apps\web" || (
  echo [ERROR] 找不到 apps\web。請確認你是在專案根目錄執行此檔案。
  pause
  exit /b 1
)

if not exist node_modules (
  echo Installing dependencies...
  npm install
)

npm run dev

popd
endlocal
