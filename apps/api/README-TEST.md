# API 測試指南

## 後端已啟動
- URL: http://localhost:8080
- 狀態: ✅ 運行中

## 測試方式

### 方式 1：使用瀏覽器（最簡單）

直接在瀏覽器開啟以下網址：

1. **Health Check**
   ```
   http://localhost:8080/health
   ```

2. **查詢所有對局**
   ```
   http://localhost:8080/matches
   ```

3. **篩選查詢（賽季 S48）**
   ```
   http://localhost:8080/matches?seasonCode=S48
   ```

4. **篩選查詢（只看勝場）**
   ```
   http://localhost:8080/matches?result=W
   ```

### 方式 2：使用 Postman 或 Insomnia

1. 下載安裝 Postman: https://www.postman.com/downloads/
2. 匯入以下請求：

#### GET - 查詢對局
```
GET http://localhost:8080/matches
```

#### POST - 新增對局
```
POST http://localhost:8080/matches
Content-Type: application/json

{
  "gameKey": "master_duel",
  "seasonCode": "S48",
  "date": "2026-01-13",
  "rank": "鑽石I",
  "myDeck": {
    "main": "蛇眼",
    "sub": "原罪"
  },
  "oppDeck": {
    "main": "純粹",
    "sub": "無"
  },
  "playOrder": "先攻",
  "result": "W",
  "note": "測試對局"
}
```

#### PATCH - 更新對局
```
PATCH http://localhost:8080/matches/{對局ID}
Content-Type: application/json

{
  "result": "L",
  "note": "更新備註"
}
```

#### DELETE - 刪除對局
```
DELETE http://localhost:8080/matches/{對局ID}
```

## API 端點總覽

| 方法 | 路徑 | 說明 |
|------|------|------|
| GET | /health | 健康檢查 |
| GET | /matches | 查詢對局列表 |
| POST | /matches | 新增對局 |
| PATCH | /matches/:id | 更新對局 |
| DELETE | /matches/:id | 刪除對局 |

## 查詢參數（GET /matches）

- `seasonCode` - 賽季代碼（例如：S48）
- `myDeckMain` - 我的牌組大軸
- `result` - 勝負（W 或 L）
- `playOrder` - 先後攻（先攻 或 後攻）
- `dateFrom` - 開始日期（YYYY-MM-DD）
- `dateTo` - 結束日期（YYYY-MM-DD）

## 測試資料

資料庫中已有：
- 1 個使用者
- 1 個遊戲（Master Duel）
- 1 個賽季（S48）
- 4 個牌組
- 1 筆測試對局

## Phase 1 完成！

✅ 所有 CRUD API 已實作完成
✅ 資料庫 Schema 已建立
✅ Seed 資料已插入
✅ 後端正常運行

下一步：Phase 2 - 建立前端視覺化界面
