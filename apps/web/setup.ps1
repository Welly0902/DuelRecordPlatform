# DuelLog Web 設定腳本

Write-Host "🔧 設定 DuelLog Web..." -ForegroundColor Cyan

# 建立 .env 檔案
if (!(Test-Path .env)) {
    Write-Host "📝 建立 .env 檔案..." -ForegroundColor Yellow
    @"
VITE_API_BASE_URL=http://localhost:8080
"@ | Out-File -FilePath .env -Encoding UTF8
    Write-Host "✅ .env 檔案已建立" -ForegroundColor Green
} else {
    Write-Host "✅ .env 檔案已存在" -ForegroundColor Green
}

Write-Host ""
Write-Host "📦 安裝依賴..." -ForegroundColor Cyan
npm install

Write-Host ""
Write-Host "✅ 設定完成！" -ForegroundColor Green
Write-Host "執行 'npm run dev' 啟動開發伺服器" -ForegroundColor Cyan
