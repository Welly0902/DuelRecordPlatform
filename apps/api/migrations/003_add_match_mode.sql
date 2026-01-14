-- +goose Up
-- +goose StatementBegin

-- Add match mode to distinguish Ranked/Rating/DC
-- NOTE: rank is still required; non-Ranked matches can use rank = '—'.
ALTER TABLE matches
ADD COLUMN mode TEXT NOT NULL DEFAULT 'Ranked'
CHECK (mode IN ('Ranked', 'Rating', 'DC'));

CREATE INDEX IF NOT EXISTS idx_matches_mode ON matches(mode);

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin

-- SQLite can't DROP COLUMN easily; keep as no-op.
DROP INDEX IF EXISTS idx_matches_mode;

-- +goose StatementEnd
