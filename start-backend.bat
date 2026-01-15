@echo off
setlocal
pushd "%~dp0"

where go >nul 2>nul
if errorlevel 1 (
  echo [ERROR] 找不到 Go。請先安裝 Go（建議 Go 1.25.5+）。
  pause
  exit /b 1
)

echo Starting DuelLog API...
cd /d "%~dp0apps\api" || (
  echo [ERROR] 找不到 apps\api。請確認你是在專案根目錄執行此檔案。
  pause
  exit /b 1
)

go run .

popd
endlocal
