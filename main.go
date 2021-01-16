package main

import (
	"fmt"
	"net/http"

	"github.com/apex/gateway/v2"
	"github.com/go-chi/chi"
)

func main() {
	gateway.ListenAndServe("3000", routing())
}

func routing() http.Handler {
	r := chi.NewRouter()

	r.Get("/", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte("Hello World"))
	})

	r.Post("/pets/luna", func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(fmt.Sprintf("hello %s", r.RequestURI)))
	})

	r.NotFound(func(w http.ResponseWriter, r *http.Request) {
		w.WriteHeader(http.StatusOK)
		w.Write([]byte(fmt.Sprintf("Not found: [%s]", r.RequestURI)))
	})

	return r
}
