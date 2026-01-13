-- +goose Up
-- +goose StatementBegin

-- 使用者表
CREATE TABLE users (
    id TEXT PRIMARY KEY,
    email TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 遊戲表
CREATE TABLE games (
    id TEXT PRIMARY KEY,
    key TEXT UNIQUE NOT NULL,  -- e.g. "master_duel"
    name TEXT NOT NULL          -- e.g. "Yu-Gi-Oh! Master Duel"
);

-- 賽季表
CREATE TABLE seasons (
    id TEXT PRIMARY KEY,
    game_id TEXT NOT NULL,
    code TEXT NOT NULL,         -- e.g. "S48"
    start_date DATE,
    end_date DATE,
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(game_id, code)
);

-- 牌組表
CREATE TABLE decks (
    id TEXT PRIMARY KEY,
    game_id TEXT NOT NULL,
    main TEXT NOT NULL,         -- 大軸，e.g. "蛇眼"
    sub TEXT,                   -- 小軸，e.g. "原罪" 或 "無" 或 NULL
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(game_id, main, sub)
);

-- 對局記錄表（核心資料表）
CREATE TABLE matches (
    id TEXT PRIMARY KEY,
    user_id TEXT NOT NULL,
    game_id TEXT NOT NULL,
    season_id TEXT NOT NULL,
    date DATE NOT NULL,                 -- 對局日期 (ISO format: YYYY-MM-DD)
    rank TEXT NOT NULL,                 -- 階級，e.g. "金IV", "鑽石I", "大師V"
    my_deck_id TEXT NOT NULL,           -- 我的牌組
    opp_deck_id TEXT NOT NULL,          -- 對手牌組
    play_order TEXT NOT NULL,           -- "先攻" 或 "後攻"
    result TEXT NOT NULL,               -- "W" (Win) 或 "L" (Loss)
    note TEXT,                          -- 備註（可選）
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES games(id),
    FOREIGN KEY (season_id) REFERENCES seasons(id),
    FOREIGN KEY (my_deck_id) REFERENCES decks(id),
    FOREIGN KEY (opp_deck_id) REFERENCES decks(id),
    CHECK (result IN ('W', 'L')),
    CHECK (play_order IN ('先攻', '後攻'))
);

-- 建立索引以提升查詢效能
CREATE INDEX idx_matches_user_id ON matches(user_id);
CREATE INDEX idx_matches_season_id ON matches(season_id);
CREATE INDEX idx_matches_date ON matches(date);
CREATE INDEX idx_matches_my_deck_id ON matches(my_deck_id);
CREATE INDEX idx_seasons_game_id ON seasons(game_id);
CREATE INDEX idx_decks_game_id ON decks(game_id);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

-- 刪除索引
DROP INDEX IF EXISTS idx_decks_game_id;
DROP INDEX IF EXISTS idx_seasons_game_id;
DROP INDEX IF EXISTS idx_matches_my_deck_id;
DROP INDEX IF EXISTS idx_matches_date;
DROP INDEX IF EXISTS idx_matches_season_id;
DROP INDEX IF EXISTS idx_matches_user_id;

-- 刪除表（注意順序：先刪除有外鍵的表）
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS decks;
DROP TABLE IF EXISTS seasons;
DROP TABLE IF EXISTS games;
DROP TABLE IF EXISTS users;

-- +goose StatementEnd
