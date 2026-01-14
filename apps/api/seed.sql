-- Seed 初始資料
-- 用於開發測試的基礎資料

-- Note:
-- - 假設 migrations 已建立 tables。
-- - 本檔案僅提供「最小可用」的示範資料，讓新使用者一進來就看得懂資料長相。

-- 插入預設使用者（MVP 單人模式）
INSERT OR IGNORE INTO users (id, email, password_hash, created_at, updated_at)
VALUES ('user-001', 'demo@duellog.com', 'placeholder_hash', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 插入遊戲：Yu-Gi-Oh! Master Duel
INSERT OR IGNORE INTO games (id, key, name)
VALUES ('game-md', 'master_duel', 'Yu-Gi-Oh! Master Duel');

-- 插入賽季：S48（2025/12）
INSERT OR IGNORE INTO seasons (id, game_id, code, start_date, end_date)
VALUES ('season-s48', 'game-md', 'S48', '2025-12-01', '2025-12-31');

-- 插入牌組模板（前端下拉選項用；theme 可之後在 UI 調整）
-- main：主軸，sub：副軸
INSERT OR IGNORE INTO deck_templates (id, game_id, main, theme, deck_type) VALUES
    ('seed-tpl-main-001', 'game-md', '閃刀姬', '無', 'main'),
    ('seed-tpl-main-002', 'game-md', '神藝', '無', 'main'),
    ('seed-tpl-main-003', 'game-md', '星辰', '無', 'main'),
    ('seed-tpl-main-004', 'game-md', '聖徒', '無', 'main'),
    ('seed-tpl-main-005', 'game-md', '利希德', '無', 'main'),
    ('seed-tpl-main-006', 'game-md', '碼麗絲', '無', 'main'),
    ('seed-tpl-sub-001', 'game-md', '無', '無', 'sub'),
    ('seed-tpl-sub-002', 'game-md', '烙印', '無', 'sub'),
    ('seed-tpl-sub-003', 'game-md', '原石', '無', 'sub');

-- 插入牌組
INSERT OR IGNORE INTO decks (id, game_id, main, sub) VALUES
    ('seed-deck-001', 'game-md', '閃刀姬', '無'),
    ('seed-deck-002', 'game-md', '神藝', '烙印'),
    ('seed-deck-003', 'game-md', '星辰', '烙印'),
    ('seed-deck-004', 'game-md', '聖徒', '無'),
    ('seed-deck-005', 'game-md', '利希德', '無'),
    ('seed-deck-006', 'game-md', '利希德', '原石'),
    ('seed-deck-007', 'game-md', '碼麗絲', '無');

-- 插入多筆測試對局記錄
-- 注意：為了相容舊 DB（尚未有 matches.mode 欄位），此處不指定 mode；若 mode 存在，會自動套用 DEFAULT 'Ranked'。
INSERT OR REPLACE INTO matches (id, user_id, game_id, season_id, date, rank, my_deck_id, opp_deck_id, play_order, result, note, created_at, updated_at) VALUES
    ('seed-match-001', 'user-001', 'game-md', 'season-s48', '2025-12-31', '鑽石 II', 'seed-deck-001', 'seed-deck-004', '先攻', 'L', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('seed-match-002', 'user-001', 'game-md', 'season-s48', '2025-12-31', '鑽石 II', 'seed-deck-002', 'seed-deck-003', '後攻', 'L', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('seed-match-003', 'user-001', 'game-md', 'season-s48', '2025-12-31', '鑽石 II', 'seed-deck-002', 'seed-deck-006', '後攻', 'L', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('seed-match-004', 'user-001', 'game-md', 'season-s48', '2025-12-31', '鑽石 II', 'seed-deck-003', 'seed-deck-007', '先攻', 'L', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('seed-match-005', 'user-001', 'game-md', 'season-s48', '2025-12-31', '鑽石 II', 'seed-deck-003', 'seed-deck-005', '先攻', 'W', NULL, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- 顯示插入結果
SELECT '=== Seed 資料插入完成 ===' as message;
SELECT 'Users: ' || COUNT(*) as count FROM users;
SELECT 'Games: ' || COUNT(*) as count FROM games;
SELECT 'Seasons: ' || COUNT(*) as count FROM seasons;
SELECT 'Decks: ' || COUNT(*) as count FROM decks;
SELECT 'Matches: ' || COUNT(*) as count FROM matches;
