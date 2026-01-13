-- Seed 初始資料
-- 用於開發測試的基礎資料

-- 插入預設使用者（MVP 單人模式）
INSERT INTO users (id, email, password_hash, created_at, updated_at)
VALUES (
    'user-001',
    'demo@duellog.com',
    'placeholder_hash',  -- MVP 不做真正的登入，隨便填
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- 插入遊戲：Yu-Gi-Oh! Master Duel
INSERT INTO games (id, key, name)
VALUES (
    'game-master-duel',
    'master_duel',
    'Yu-Gi-Oh! Master Duel'
);

-- 插入賽季：S48
INSERT INTO seasons (id, game_id, code, start_date, end_date)
VALUES (
    'season-s48',
    'game-master-duel',
    'S48',
    '2025-12-01',
    '2026-01-31'
);

-- 插入基礎牌組
-- Unknown/無：對手牌組未知時使用
INSERT INTO decks (id, game_id, main, sub)
VALUES (
    'deck-unknown',
    'game-master-duel',
    'Unknown',
    '無'
);

-- 測試用牌組：雷熱/弓劍
INSERT INTO decks (id, game_id, main, sub)
VALUES (
    'deck-test-001',
    'game-master-duel',
    '雷熱',
    '弓劍'
);

-- 測試用牌組：閃刀姬/無
INSERT INTO decks (id, game_id, main, sub)
VALUES (
    'deck-test-002',
    'game-master-duel',
    '閃刀姬',
    '無'
);

-- 測試用牌組：蛇眼/原罪
INSERT INTO decks (id, game_id, main, sub)
VALUES (
    'deck-test-003',
    'game-master-duel',
    '蛇眼',
    '原罪'
);

-- 插入一筆測試對局記錄
INSERT INTO matches (
    id,
    user_id,
    game_id,
    season_id,
    date,
    rank,
    my_deck_id,
    opp_deck_id,
    play_order,
    result,
    note,
    created_at,
    updated_at
)
VALUES (
    'match-test-001',
    'user-001',
    'game-master-duel',
    'season-s48',
    '2026-01-13',
    '金IV',
    'deck-test-001',
    'deck-test-002',
    '先攻',
    'W',
    '測試對局',
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- 顯示插入結果
SELECT '=== Seed 資料插入完成 ===' as message;
SELECT 'Users: ' || COUNT(*) as count FROM users;
SELECT 'Games: ' || COUNT(*) as count FROM games;
SELECT 'Seasons: ' || COUNT(*) as count FROM seasons;
SELECT 'Decks: ' || COUNT(*) as count FROM decks;
SELECT 'Matches: ' || COUNT(*) as count FROM matches;
