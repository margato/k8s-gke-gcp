package main

import (
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	router.GET("/products", func(c *gin.Context) {
		c.JSON(http.StatusOK, ListProducts())
	})

	router.GET("/debug", func(c *gin.Context) {
		name, _ := os.Hostname()
		shopName := os.Getenv("SHOP_NAME")
		configVersion := os.Getenv("CONFIG_VERSION")

		c.JSON(http.StatusOK, &gin.H{
			"host_name":      name,
			"shop_name":      shopName,
			"config_version": configVersion,
		})
	})

	router.GET("/health", func(c *gin.Context) {
		c.JSON(http.StatusOK, &gin.H{
			"healthy": true,
		})
	})

	router.GET("/shutdown", func(c *gin.Context) {
		os.Exit(0)
	})

	router.Run()
}
