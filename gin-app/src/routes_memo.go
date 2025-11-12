package src

import (
	"errors"
	"net/http"
	"strconv"
	"time"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

// メモ入力フォーム
type MemoForm struct {
	Title   string `json:"title"`
	Content string `json:"content"`
}

func BindMemoForm(c *gin.Context) *MemoForm {

	var form MemoForm
	if err := c.ShouldBindJSON(&form); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid request"})
		return nil
	}
	return &form
}

func GetMemo(id int, userID string) (*Memo, int, error) {
	var memo Memo
	if err := DB.Where("id = ? AND user_id = ?", id, userID).First(&memo).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return nil, http.StatusNotFound, errors.New("Memo not found")
		}
		return nil, http.StatusInternalServerError, err
	}
	return &memo, 0, nil
}

// メモ操作ルーティング
func RegisterMemoRoutes(router *gin.Engine) {
	// メモ取得
	router.GET("/api/memos", func(c *gin.Context) {
		userID, _ := c.Get("user_id")
		var memos []Memo
		if err := DB.Where("user_id = ?", userID).Order("created_at desc").Find(&memos).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, memos)
	})

	// メモ登録
	router.POST("/api/memos", func(c *gin.Context) {
		userID, _ := c.MustGet("user_id").(string)
		var form MemoForm
		c.ShouldBindJSON(&form)
		memo := Memo{
			UserID:    userID,
			Title:     form.Title,
			Content:   form.Content,
			CreatedAt: time.Now(),
		}
		if err := DB.Create(&memo).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, memo)
	})

	// メモ更新
	router.PUT("/api/memos/:id", func(c *gin.Context) {
		userID, _ := c.MustGet("user_id").(string)
		id, _ := strconv.Atoi(c.Param("id"))
		memo, status, err := GetMemo(id, userID)
		if err != nil {
			c.JSON(status, gin.H{"error": err.Error()})
			return
		}
		var form MemoForm
		c.ShouldBindJSON(&form)
		memo.Title = form.Title
		memo.Content = form.Content
		if err := DB.Save(&memo).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, memo)
	})

	// メモ削除
	router.DELETE("/api/memos/:id", func(c *gin.Context) {
		userID, _ := c.MustGet("user_id").(string)
		id, _ := strconv.Atoi(c.Param("id"))
		memo, status, err := GetMemo(id, userID)
		if err != nil {
			c.JSON(status, gin.H{"error": err.Error()})
			return
		}
		if err := DB.Delete(&memo).Error; err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"id": id})
	})
}
