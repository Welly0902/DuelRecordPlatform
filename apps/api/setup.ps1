# DuelLog API 設定腳本

Write-Host "🔧 設定 DuelLog API..." -ForegroundColor Cyan

# 建立 .env 檔案
if (!(Test-Path .env)) {
    Write-Host "📝 建立 .env 檔案..." -ForegroundColor Yellow
    @"
PORT=8080
DB_PATH=./duellog.db
CORS_ORIGINS=http://localhost:5173
"@ | Out-File -FilePath .env -Encoding UTF8
    Write-Host "✅ .env 檔案已建立" -ForegroundColor Green
} else {
    Write-Host "✅ .env 檔案已存在" -ForegroundColor Green
}

Write-Host ""
Write-Host "🚀 準備啟動伺服器..." -ForegroundColor Cyan
Write-Host "注意：Windows 需要安裝 GCC 才能編譯 SQLite driver" -ForegroundColor Yellow
Write-Host ""
