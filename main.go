package main

import (
	"flag"
	"fmt"

	"github.com/apex/gateway/v2"

	"github.com/gofiber/adaptor/v2"
	"github.com/gofiber/fiber/v2"
)

func main() {
	port := flag.Int("port", -1, "specify a port to use")
	flag.Parse()

	if *port == -1 {
		gateway.ListenAndServe(":3000", adaptor.FiberApp(routing()))
	} else {
		portStr := fmt.Sprintf(":%d", *port)
		routing().Listen(portStr)
	}

}

func routing() *fiber.App {
	app := fiber.New()

	app.Get("/", routeRoot)

	app.Post("/pets/:pet", routePets)

	return app
}

func routeRoot(c *fiber.Ctx) error {
	return c.SendString("Hello World!")
}

func routePets(c *fiber.Ctx) error {
	msg := fmt.Sprintf("Hello %s", c.Params("pet"))
	return c.SendString(msg)
}
