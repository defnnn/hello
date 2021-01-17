package main

import (
	"flag"
	"fmt"
	"net/http"

	"github.com/apex/gateway/v2"
	"github.com/go-chi/chi"
)

func main() {
	portStr := ":3000"
	listener := gateway.ListenAndServe

	port := flag.Int("port", -1, "specify a port to use")
	flag.Parse()

	if *port != -1 {
		portStr = fmt.Sprintf(":%d", *port)
		listener = http.ListenAndServe
	}

	listener(portStr, routing())
}

func routing() http.Handler {
	r := chi.NewRouter()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Hello World!"))
	})

	r.Post("/pets/luna", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(fmt.Sprintf("Hello %s", r.RequestURI)))
	})

	r.NotFound(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(fmt.Sprintf("Not found: [%s]", r.RequestURI)))
	})

	return r
}
