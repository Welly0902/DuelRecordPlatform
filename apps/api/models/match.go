package models

import "time"

// Match 對局記錄
type Match struct {
	ID         string    `json:"id"`
	UserID     string    `json:"userId"`
	GameID     string    `json:"gameId"`
	SeasonID   string    `json:"seasonId"`
	Date       string    `json:"date"`        // ISO format: YYYY-MM-DD
	Mode       string    `json:"mode"`        // "Ranked" | "Rating" | "DC"
	Rank       string    `json:"rank"`        // e.g. "金IV", "鑽石I"
	MyDeckID   string    `json:"myDeckId"`    // 我的牌組 ID
	OppDeckID  string    `json:"oppDeckId"`   // 對手牌組 ID
	PlayOrder  string    `json:"playOrder"`   // "先攻" 或 "後攻"
	Result     string    `json:"result"`      // "W" 或 "L"
	Note       *string   `json:"note"`        // 備註（可選）
	CreatedAt  time.Time `json:"createdAt"`
	UpdatedAt  time.Time `json:"updatedAt"`
}

// MatchWithDetails 對局記錄（含完整資訊）
// 用於 GET /matches，包含 deck 名稱等關聯資料
type MatchWithDetails struct {
	ID         string    `json:"id"`
	Date       string    `json:"date"`
	Mode       string    `json:"mode"`
	Rank       string    `json:"rank"`
	MyDeck     DeckInfo  `json:"myDeck"`      // 我的牌組詳細資訊
	OppDeck    DeckInfo  `json:"oppDeck"`     // 對手牌組詳細資訊
	PlayOrder  string    `json:"playOrder"`   // "先攻" 或 "後攻"
	Result     string    `json:"result"`      // "W" 或 "L"
	Note       *string   `json:"note"`
	SeasonCode string    `json:"seasonCode"`  // e.g. "S48"
	CreatedAt  time.Time `json:"createdAt"`
	UpdatedAt  time.Time `json:"updatedAt"`
}

// DeckInfo 牌組資訊
type DeckInfo struct {
	ID   string  `json:"id"`
	Main string  `json:"main"` // 大軸
	Sub  *string `json:"sub"`  // 小軸（可能為 null）
}

// CreateMatchRequest 新增對局的請求結構
type CreateMatchRequest struct {
	GameKey    string   `json:"gameKey"`    // e.g. "master_duel"
	SeasonCode string   `json:"seasonCode"` // e.g. "S48"
	Date       string   `json:"date"`       // ISO format: YYYY-MM-DD
	Mode       string   `json:"mode"`       // "Ranked" | "Rating" | "DC" (default Ranked)
	Rank       string   `json:"rank"`       // e.g. "金IV"
	MyDeck     DeckForm `json:"myDeck"`
	OppDeck    DeckForm `json:"oppDeck"`
	PlayOrder  string   `json:"playOrder"` // "先攻" 或 "後攻"
	Result     string   `json:"result"`    // "W" 或 "L"
	Note       *string  `json:"note"`      // 備註（可選）
}

// UpdateMatchRequest 更新對局的請求結構
type UpdateMatchRequest struct {
	Date      *string   `json:"date"`
	Mode      *string   `json:"mode"`
	Rank      *string   `json:"rank"`
	MyDeck    *DeckForm `json:"myDeck"`
	OppDeck   *DeckForm `json:"oppDeck"`
	PlayOrder *string   `json:"playOrder"`
	Result    *string   `json:"result"`
	Note      *string   `json:"note"`
}

// DeckForm 牌組表單（用於新增/更新）
type DeckForm struct {
	Main string  `json:"main"` // 大軸
	Sub  *string `json:"sub"`  // 小軸（可選，可以是 "無" 或 null）
}

// Deck 牌組
type Deck struct {
	ID     string  `json:"id"`
	GameID string  `json:"gameId"`
	Main   string  `json:"main"`
	Sub    *string `json:"sub"`
}

// Season 賽季
type Season struct {
	ID        string  `json:"id"`
	GameID    string  `json:"gameId"`
	Code      string  `json:"code"`      // e.g. "S48"
	StartDate *string `json:"startDate"` // ISO format (nullable)
	EndDate   *string `json:"endDate"`   // ISO format (nullable)
}

// Game 遊戲
type Game struct {
	ID   string `json:"id"`
	Key  string `json:"key"`  // e.g. "master_duel"
	Name string `json:"name"` // e.g. "Yu-Gi-Oh! Master Duel"
}

// User 使用者
type User struct {
	ID           string    `json:"id"`
	Email        string    `json:"email"`
	PasswordHash string    `json:"-"` // 不輸出到 JSON
	CreatedAt    time.Time `json:"createdAt"`
	UpdatedAt    time.Time `json:"updatedAt"`
}
