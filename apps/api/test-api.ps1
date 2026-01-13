# API 測試腳本
Write-Host "=== DuelLog API 測試 ===" -ForegroundColor Cyan
Write-Host ""

# 設定 UTF-8 編碼
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$baseUrl = "http://localhost:8080"

# 測試 1: Health Check
Write-Host "測試 1: GET /health" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/health" -Method Get
    Write-Host "✅ Health Check 成功" -ForegroundColor Green
    $response | ConvertTo-Json
} catch {
    Write-Host "❌ Health Check 失敗: $_" -ForegroundColor Red
}
Write-Host ""

# 測試 2: 查詢對局列表
Write-Host "測試 2: GET /matches" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/matches" -Method Get
    Write-Host "✅ 查詢對局列表成功，共 $($response.total) 筆" -ForegroundColor Green
} catch {
    Write-Host "❌ 查詢失敗: $_" -ForegroundColor Red
}
Write-Host ""

# 測試 3: 新增對局
Write-Host "測試 3: POST /matches (新增對局)" -ForegroundColor Yellow
try {
    $body = @{
        gameKey = "master_duel"
        seasonCode = "S48"
        date = "2026-01-13"
        rank = "鑽石I"
        myDeck = @{
            main = "蛇眼"
            sub = "原罪"
        }
        oppDeck = @{
            main = "純粹"
            sub = "無"
        }
        playOrder = "先攻"
        result = "W"
        note = "API 測試對局"
    }
    $json = $body | ConvertTo-Json -Depth 5
    $response = Invoke-RestMethod -Uri "$baseUrl/matches" -Method Post -Body $json -ContentType "application/json; charset=utf-8"
    Write-Host "✅ 新增對局成功" -ForegroundColor Green
    Write-Host "   對局 ID: $($response.id)"
    $newMatchId = $response.id
} catch {
    Write-Host "❌ 新增失敗: $_" -ForegroundColor Red
}
Write-Host ""

# 測試 4: 更新對局
if ($newMatchId) {
    Write-Host "測試 4: PATCH /matches/$newMatchId (更新對局)" -ForegroundColor Yellow
    try {
        $updateBody = @{
            result = "L"
            note = "更新測試：改成輸"
        }
        $json = $updateBody | ConvertTo-Json
        $response = Invoke-RestMethod -Uri "$baseUrl/matches/$newMatchId" -Method Patch -Body $json -ContentType "application/json; charset=utf-8"
        Write-Host "✅ 更新對局成功" -ForegroundColor Green
    } catch {
        Write-Host "❌ 更新失敗: $_" -ForegroundColor Red
    }
    Write-Host ""

    # 測試 5: 刪除對局
    Write-Host "測試 5: DELETE /matches/$newMatchId (刪除對局)" -ForegroundColor Yellow
    try {
        $response = Invoke-RestMethod -Uri "$baseUrl/matches/$newMatchId" -Method Delete
        Write-Host "✅ 刪除對局成功" -ForegroundColor Green
    } catch {
        Write-Host "❌ 刪除失敗: $_" -ForegroundColor Red
    }
    Write-Host ""
}

# 最終查詢
Write-Host "最終查詢: GET /matches" -ForegroundColor Yellow
try {
    $response = Invoke-RestMethod -Uri "$baseUrl/matches" -Method Get
    Write-Host "✅ 目前共有 $($response.total) 筆對局記錄" -ForegroundColor Green
} catch {
    Write-Host "❌ 查詢失敗: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 測試完成 ===" -ForegroundColor Cyan
