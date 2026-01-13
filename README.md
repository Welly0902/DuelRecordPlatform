# 🎮 DuelLog Platform

卡牌遊戲對局記錄平台 - 比 Excel 更快的對局記錄工具

## 📋 Phase 0 完成狀態

✅ Monorepo 目錄結構建立完成  
✅ Git 設定與 .gitignore 完成  
✅ Go 後端（Fiber + SQLite）建立完成  
✅ React 前端（Vite + TypeScript）建立完成  
⚠️ 環境變數需手動設定  

## 🚀 快速開始

### 前置需求

- Go 1.21+（執行 `go version` 確認）
- Node.js 20+（執行 `node -v` 確認）
- GCC（Windows 使用者需安裝 MinGW 或 TDM-GCC，用於編譯 SQLite driver）

### 1. 設定環境變數

#### 後端 (apps/api/.env)
```bash
cd apps/api
copy .env.example .env
```

#### 前端 (apps/web/.env)
```bash
cd apps/web
copy .env.example .env
```

### 2. 啟動後端

開啟新的終端機：

```bash
cd apps/api
go run main.go
```

應該看到：
```
✓ Database connected successfully
🚀 Server starting on port 8080
```

測試 API：
```bash
curl http://localhost:8080/health
```

或在瀏覽器開啟：http://localhost:8080/health

### 3. 啟動前端

開啟另一個終端機：

```bash
cd apps/web
npm run dev
```

應該看到：
```
VITE v7.x.x ready in xxx ms
➜ Local: http://localhost:5173/
```

在瀏覽器開啟：http://localhost:5173/

如果一切正常，應該會看到 **✅ API 連線正常** 的訊息！

## 📁 專案結構

```
DuelRecordPlatform/
├── apps/
│   ├── api/          # Go 後端
│   │   ├── main.go   # 主程式
│   │   ├── go.mod    # Go 依賴
│   │   └── .env      # 環境變數（不進 Git）
│   └── web/          # React 前端
│       ├── src/      # 原始碼
│       └── .env      # 環境變數（不進 Git）
├── packages/
│   └── shared/       # 共用程式碼
├── infra/
│   └── docker/       # Docker 設定
└── docs/
    └── spec.md       # 專案規格書
```

## 🔧 技術棧

### 後端
- Go + Fiber（Web 框架）
- SQLite（資料庫）
- REST API

### 前端
- React + TypeScript
- Vite（建置工具）
- 未來將加入：Tailwind CSS、shadcn/ui、ECharts、Framer Motion

## 📝 API 端點

### GET /health
健康檢查端點

**Response:**
```json
{
  "ok": true,
  "message": "DuelLog API is running",
  "db": "connected"
}
```

## ⚠️ 常見問題

### Windows: go-sqlite3 編譯失敗

如果看到 `gcc: command not found` 錯誤：

1. 安裝 TDM-GCC：https://jmeubank.github.io/tdm-gcc/
2. 或使用 MinGW：https://www.mingw-w64.org/
3. 安裝後重新執行 `go run main.go`

### 前端無法連接後端

1. 確認後端已啟動在 port 8080
2. 檢查 `apps/web/.env` 的 `VITE_API_BASE_URL` 設定
3. 檢查瀏覽器 Console 是否有 CORS 錯誤

## 🎯 下一步：Phase 1

- 建立資料庫 Schema（users, games, seasons, decks, matches）
- 實作 Migration（使用 Goose）
- 實作 Matches CRUD API

---

**開發狀態**：Phase 0 ✅ 完成


``` Structure
DuelRecordPlatform/
├── apps/
│   ├── api/                    # Go 後端
│   │   ├── cmd/seed/main.go    # Seed 程式
│   │   ├── handlers/matches.go # API handlers
│   │   ├── migrations/         # DB migrations
│   │   ├── models/match.go     # 資料模型
│   │   ├── main.go             # 入口
│   │   ├── seed.sql            # Seed 資料
│   │   ├── go.mod / go.sum
│   │   └── .env
│   │
│   └── web/                    # React 前端
│       ├── src/
│       │   ├── components/AppShell.tsx
│       │   ├── contexts/ThemeContext.tsx
│       │   ├── pages/MatchesPage.tsx
│       │   ├── services/api.ts, matchesService.ts
│       │   ├── types/match.ts
│       │   ├── index.css
│       │   └── main.tsx
│       ├── tailwind.config.cjs
│       ├── postcss.config.cjs
│       ├── vite.config.ts
│       └── package.json
│
├── docs/spec.md
├── .gitignore
└── README.md
```