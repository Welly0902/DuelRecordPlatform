-- +goose Up
-- +goose StatementBegin

-- 牌組模板表（用於選項列表）
CREATE TABLE IF NOT EXISTS deck_templates (
    id TEXT PRIMARY KEY,
    game_id TEXT NOT NULL DEFAULT 'game-md',
    main TEXT NOT NULL,           -- 牌組名稱
    theme TEXT NOT NULL DEFAULT '連結',  -- 主題類型：融合/超量/連結/同步/陷阱/魔法/輔助/儀式/鐘擺/無
    deck_type TEXT NOT NULL DEFAULT 'main' CHECK (deck_type IN ('main', 'sub')),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(game_id, main, deck_type)
);

-- 插入預設主軸牌組
INSERT OR IGNORE INTO deck_templates (id, game_id, main, theme, deck_type) VALUES
    ('tpl-main-001', 'game-md', '蛇眼', '連結', 'main'),
    ('tpl-main-002', 'game-md', '雷熱', '連結', 'main'),
    ('tpl-main-003', 'game-md', '閃刀姬', '連結', 'main'),
    ('tpl-main-004', 'game-md', '烙印', '融合', 'main'),
    ('tpl-main-005', 'game-md', '粛聲', '儀式', 'main'),
    ('tpl-main-006', 'game-md', 'R-ACE', '連結', 'main'),
    ('tpl-main-007', 'game-md', '天盃龍', '同步', 'main'),
    ('tpl-main-008', 'game-md', 'YO', '超量', 'main'),
    ('tpl-main-009', 'game-md', '神碑', '魔法', 'main'),
    ('tpl-main-010', 'game-md', '幻奏', '融合', 'main'),
    ('tpl-main-011', 'game-md', '龍輝巧', '儀式', 'main'),
    ('tpl-main-012', 'game-md', '炎王', '連結', 'main'),
    ('tpl-main-013', 'game-md', '深淵', '連結', 'main'),
    ('tpl-main-014', 'game-md', 'Unknown', '無', 'main');

-- 插入預設副軸牌組
INSERT OR IGNORE INTO deck_templates (id, game_id, main, theme, deck_type) VALUES
    ('tpl-sub-001', 'game-md', '無', '無', 'sub'),
    ('tpl-sub-002', 'game-md', '弓劍', '輔助', 'sub'),
    ('tpl-sub-003', 'game-md', '原罪', '輔助', 'sub'),
    ('tpl-sub-004', 'game-md', '深淵', '輔助', 'sub'),
    ('tpl-sub-005', 'game-md', '罪寶', '輔助', 'sub');

CREATE INDEX IF NOT EXISTS idx_deck_templates_game_id ON deck_templates(game_id);
CREATE INDEX IF NOT EXISTS idx_deck_templates_deck_type ON deck_templates(deck_type);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

DROP INDEX IF EXISTS idx_deck_templates_deck_type;
DROP INDEX IF EXISTS idx_deck_templates_game_id;
DROP TABLE IF EXISTS deck_templates;

-- +goose StatementEnd
