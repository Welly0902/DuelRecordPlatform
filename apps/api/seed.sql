-- Seed 初始資料
-- 用於開發測試的基礎資料

-- 插入預設使用者（MVP 單人模式）
INSERT INTO users (id, email, password_hash, created_at, updated_at)
VALUES (
    'user-001',
    'demo@duellog.com',
    'placeholder_hash',
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

-- 插入牌組
INSERT INTO decks (id, game_id, main, sub) VALUES
    ('deck-unknown', 'game-master-duel', 'Unknown', '無'),
    ('deck-001', 'game-master-duel', '雷熱', '弓劍'),
    ('deck-002', 'game-master-duel', '閃刀姬', '無'),
    ('deck-003', 'game-master-duel', '蛇眼', '原罪'),
    ('deck-004', 'game-master-duel', '粛聲', '無'),
    ('deck-005', 'game-master-duel', 'R-ACE', '無'),
    ('deck-006', 'game-master-duel', '烙印', '深淵'),
    ('deck-007', 'game-master-duel', '天盃龍', '無'),
    ('deck-008', 'game-master-duel', 'YO', '無');

-- 插入多筆測試對局記錄
INSERT INTO matches (id, user_id, game_id, season_id, date, rank, my_deck_id, opp_deck_id, play_order, result, note, created_at, updated_at) VALUES
    ('match-001', 'user-001', 'game-master-duel', 'season-s48', '2026-01-13', '金IV', 'deck-001', 'deck-002', '先攻', 'W', '對手手坑不夠', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-002', 'user-001', 'game-master-duel', 'season-s48', '2026-01-13', '金IV', 'deck-001', 'deck-003', '後攻', 'L', '被蛇眼展開壓死', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-003', 'user-001', 'game-master-duel', 'season-s48', '2026-01-12', '金V', 'deck-001', 'deck-004', '先攻', 'W', '成功鋪場', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-004', 'user-001', 'game-master-duel', 'season-s48', '2026-01-12', '金V', 'deck-001', 'deck-005', '後攻', 'W', 'R-ACE 沒展開', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-005', 'user-001', 'game-master-duel', 'season-s48', '2026-01-11', '金V', 'deck-001', 'deck-006', '先攻', 'L', '被烙印斷點', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-006', 'user-001', 'game-master-duel', 'season-s48', '2026-01-11', '銀I', 'deck-001', 'deck-007', '後攻', 'W', '天盃龍卡手', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-007', 'user-001', 'game-master-duel', 'season-s48', '2026-01-10', '銀I', 'deck-001', 'deck-008', '先攻', 'W', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-008', 'user-001', 'game-master-duel', 'season-s48', '2026-01-10', '銀II', 'deck-001', 'deck-003', '後攻', 'L', '蛇眼太強', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-009', 'user-001', 'game-master-duel', 'season-s48', '2026-01-09', '銀II', 'deck-001', 'deck-unknown', '先攻', 'W', '對手投降', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('match-010', 'user-001', 'game-master-duel', 'season-s48', '2026-01-09', '銀III', 'deck-001', 'deck-004', '後攻', 'L', '粛聲回合外干擾太多', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 顯示插入結果
SELECT '=== Seed 資料插入完成 ===' as message;
SELECT 'Users: ' || COUNT(*) as count FROM users;
SELECT 'Games: ' || COUNT(*) as count FROM games;
SELECT 'Seasons: ' || COUNT(*) as count FROM seasons;
SELECT 'Decks: ' || COUNT(*) as count FROM decks;
SELECT 'Matches: ' || COUNT(*) as count FROM matches;
