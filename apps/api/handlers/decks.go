package handlers

import (
	"database/sql"
	"time"

	"github.com/gofiber/fiber/v2"
	"github.com/google/uuid"
)

// DeckTemplate 牌組模板（前端選項用）
type DeckTemplate struct {
	ID        string    `json:"id"`
	Name      string    `json:"name"`
	Theme     string    `json:"theme"`
	DeckType  string    `json:"deckType"` // "main" or "sub"
	CreatedAt time.Time `json:"createdAt"`
}

// CreateDeckTemplateRequest 新增牌組模板請求
type CreateDeckTemplateRequest struct {
	Name     string `json:"name"`
	Theme    string `json:"theme"`
	DeckType string `json:"deckType"` // "main" or "sub"
}

// UpdateDeckTemplateRequest 更新牌組模板請求
type UpdateDeckTemplateRequest struct {
	Name  string `json:"name,omitempty"`
	Theme string `json:"theme,omitempty"`
}

// GetDeckTemplates 取得所有牌組模板
func GetDeckTemplates(c *fiber.Ctx, db *sql.DB) error {
	deckType := c.Query("type", "") // "main", "sub", or "" for all

	var query string
	var args []interface{}

	if deckType != "" {
		query = `
			SELECT id, main as name, theme, deck_type, created_at
			FROM deck_templates
			WHERE deck_type = ?
			ORDER BY name ASC
		`
		args = append(args, deckType)
	} else {
		query = `
			SELECT id, main as name, theme, deck_type, created_at
			FROM deck_templates
			ORDER BY deck_type ASC, name ASC
		`
	}

	rows, err := db.Query(query, args...)
	if err != nil {
		// 如果表不存在，返回空陣列
		return c.JSON(fiber.Map{
			"templates": []DeckTemplate{},
			"total":     0,
		})
	}
	defer rows.Close()

	var templates []DeckTemplate
	for rows.Next() {
		var t DeckTemplate
		var createdAt sql.NullTime
		if err := rows.Scan(&t.ID, &t.Name, &t.Theme, &t.DeckType, &createdAt); err != nil {
			continue
		}
		if createdAt.Valid {
			t.CreatedAt = createdAt.Time
		}
		templates = append(templates, t)
	}

	if templates == nil {
		templates = []DeckTemplate{}
	}

	return c.JSON(fiber.Map{
		"templates": templates,
		"total":     len(templates),
	})
}

// CreateDeckTemplate 新增牌組模板
func CreateDeckTemplate(c *fiber.Ctx, db *sql.DB) error {
	var req CreateDeckTemplateRequest
	if err := c.BodyParser(&req); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid request body"})
	}

	if req.Name == "" {
		return c.Status(400).JSON(fiber.Map{"error": "Name is required"})
	}
	if req.Theme == "" {
		req.Theme = "連結"
	}
	if req.DeckType == "" {
		req.DeckType = "main"
	}

	// 檢查是否已存在
	var exists bool
	err := db.QueryRow(`SELECT EXISTS(SELECT 1 FROM deck_templates WHERE main = ? AND deck_type = ?)`, req.Name, req.DeckType).Scan(&exists)
	if err == nil && exists {
		return c.Status(400).JSON(fiber.Map{"error": "Deck template already exists"})
	}

	id := uuid.New().String()
	_, err = db.Exec(`
		INSERT INTO deck_templates (id, game_id, main, theme, deck_type, created_at)
		VALUES (?, 'game-md', ?, ?, ?, CURRENT_TIMESTAMP)
	`, id, req.Name, req.Theme, req.DeckType)

	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to create deck template: " + err.Error()})
	}

	return c.Status(201).JSON(fiber.Map{
		"id":      id,
		"message": "Deck template created successfully",
	})
}

// UpdateDeckTemplate 更新牌組模板
func UpdateDeckTemplate(c *fiber.Ctx, db *sql.DB) error {
	id := c.Params("id")
	if id == "" {
		return c.Status(400).JSON(fiber.Map{"error": "ID is required"})
	}

	var req UpdateDeckTemplateRequest
	if err := c.BodyParser(&req); err != nil {
		return c.Status(400).JSON(fiber.Map{"error": "Invalid request body"})
	}

	// 建構動態更新語句
	updates := []string{}
	args := []interface{}{}

	if req.Name != "" {
		updates = append(updates, "main = ?")
		args = append(args, req.Name)
	}
	if req.Theme != "" {
		updates = append(updates, "theme = ?")
		args = append(args, req.Theme)
	}

	if len(updates) == 0 {
		return c.Status(400).JSON(fiber.Map{"error": "No fields to update"})
	}

	args = append(args, id)
	query := "UPDATE deck_templates SET " + joinStrings(updates, ", ") + " WHERE id = ?"

	result, err := db.Exec(query, args...)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to update deck template"})
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		return c.Status(404).JSON(fiber.Map{"error": "Deck template not found"})
	}

	return c.JSON(fiber.Map{"message": "Deck template updated successfully"})
}

// DeleteDeckTemplate 刪除牌組模板
func DeleteDeckTemplate(c *fiber.Ctx, db *sql.DB) error {
	id := c.Params("id")
	if id == "" {
		return c.Status(400).JSON(fiber.Map{"error": "ID is required"})
	}

	result, err := db.Exec(`DELETE FROM deck_templates WHERE id = ?`, id)
	if err != nil {
		return c.Status(500).JSON(fiber.Map{"error": "Failed to delete deck template"})
	}

	rowsAffected, _ := result.RowsAffected()
	if rowsAffected == 0 {
		return c.Status(404).JSON(fiber.Map{"error": "Deck template not found"})
	}

	return c.JSON(fiber.Map{"message": "Deck template deleted successfully"})
}

// Note: joinStrings is defined in matches.go
