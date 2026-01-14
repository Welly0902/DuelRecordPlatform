package main

import (
	"database/sql"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type deckTemplateRow struct {
	ID       string
	Main     string
	Theme    string
	DeckType string
}

func sqlQuote(s string) string {
	// SQLite single-quote escaping
	return "'" + strings.ReplaceAll(s, "'", "''") + "'"
}

func main() {
	var (
		dbPath    string
		gameIDOut string
		outPath   string
	)

	flag.StringVar(&dbPath, "db", os.Getenv("DB_PATH"), "path to sqlite db (default: DB_PATH env or ./duellog.db)")
	flag.StringVar(&gameIDOut, "game-id", "game-md", "game_id to emit (default: game-md)")
	flag.StringVar(&outPath, "out", "", "output file path (default: stdout)")
	flag.Parse()

	if dbPath == "" {
		dbPath = "./duellog.db"
	}

	db, err := sql.Open("sqlite3", dbPath)
	if err != nil {
		log.Fatalf("open db: %v", err)
	}
	defer db.Close()

	rows, err := db.Query(`
		SELECT id, main, COALESCE(theme, ''), deck_type
		FROM deck_templates
		ORDER BY deck_type ASC, main ASC, id ASC
	`)
	if err != nil {
		log.Fatalf("query deck_templates: %v", err)
	}
	defer rows.Close()

	var all []deckTemplateRow
	for rows.Next() {
		var r deckTemplateRow
		if err := rows.Scan(&r.ID, &r.Main, &r.Theme, &r.DeckType); err != nil {
			log.Fatalf("scan deck_templates: %v", err)
		}
		all = append(all, r)
	}
	if err := rows.Err(); err != nil {
		log.Fatalf("rows: %v", err)
	}

	var b strings.Builder
	b.WriteString("-- Exported deck_templates\n")
	b.WriteString("-- Source DB: " + dbPath + "\n")
	b.WriteString("-- Usage: replace the deck_templates section in apps/api/seed.sql\n\n")

	b.WriteString("INSERT OR IGNORE INTO deck_templates (id, game_id, main, theme, deck_type) VALUES\n")
	for i, r := range all {
		line := fmt.Sprintf(
			"  (%s, %s, %s, %s, %s)",
			sqlQuote(r.ID),
			sqlQuote(gameIDOut),
			sqlQuote(r.Main),
			sqlQuote(r.Theme),
			sqlQuote(r.DeckType),
		)
		if i == len(all)-1 {
			line += ";\n"
		} else {
			line += ",\n"
		}
		b.WriteString(line)
	}

	output := b.String()
	if outPath == "" {
		fmt.Print(output)
		return
	}

	if err := os.WriteFile(outPath, []byte(output), 0644); err != nil {
		log.Fatalf("write out: %v", err)
	}
	fmt.Printf("wrote %d deck_templates rows to %s\n", len(all), outPath)
}
