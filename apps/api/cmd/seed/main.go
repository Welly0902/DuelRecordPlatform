package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	_ "github.com/mattn/go-sqlite3"
)

func main() {
	// 連接資料庫
	db, err := sql.Open("sqlite3", "./duellog.db")
	if err != nil {
		log.Fatal("Failed to open database:", err)
	}
	defer db.Close()

	// 讀取 seed.sql 檔案
	sqlBytes, err := os.ReadFile("seed.sql")
	if err != nil {
		log.Fatal("Failed to read seed.sql:", err)
	}

	// 執行 SQL
	_, err = db.Exec(string(sqlBytes))
	if err != nil {
		log.Fatal("Failed to execute seed.sql:", err)
	}

	fmt.Println("✅ Seed 資料插入成功！")

	// 顯示統計
	var count int
	
	db.QueryRow("SELECT COUNT(*) FROM users").Scan(&count)
	fmt.Printf("   Users: %d\n", count)
	
	db.QueryRow("SELECT COUNT(*) FROM games").Scan(&count)
	fmt.Printf("   Games: %d\n", count)
	
	db.QueryRow("SELECT COUNT(*) FROM seasons").Scan(&count)
	fmt.Printf("   Seasons: %d\n", count)
	
	db.QueryRow("SELECT COUNT(*) FROM decks").Scan(&count)
	fmt.Printf("   Decks: %d\n", count)
	
	db.QueryRow("SELECT COUNT(*) FROM matches").Scan(&count)
	fmt.Printf("   Matches: %d\n", count)
}
