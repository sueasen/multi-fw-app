package main

import (
	"log"

	"example.com/gin-app/src"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func main() {
	// ルータ初期化
	router := gin.Default()

	// 許可オリジン
	allowOrigins := []string{"*"}
	if src.Config.FrontendURL != "" {
		allowOrigins = []string{src.Config.FrontendURL}
	}
	// CORS設定
	router.Use(cors.New(cors.Config{
		AllowOrigins:     allowOrigins,
		AllowMethods:     []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:     []string{"*"},
		AllowCredentials: true,
	}))

	// デフォルト、静的ファイル配信
	router.GET("/", func(c *gin.Context) {
		c.File("./static/index.html")
	})
	router.NoRoute(func(c *gin.Context) {
		path := "./static" + c.Request.URL.Path
		c.File(path)
	})

	// DB初期化
	if err := src.InitDB(); err != nil {
		log.Fatal(err)
	}

	// Supabase認証を全リクエストに適用
	router.Use(src.SupabaseAuthMiddleware())

	// 認証APIルーティング登録
	src.RegisterAuthRoutes(router)
	// メモAPIルーティング登録
	src.RegisterMemoRoutes(router)

	var port string = src.Config.ServerPort
	log.Println("Server started on http://localhost:" + port)
	router.Run(":" + port)
}
