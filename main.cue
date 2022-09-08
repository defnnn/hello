package hello

import (
	"github.com/defn/boot/docker"
	"github.com/defn/boot/project"
)

#HelloContext: {
	docker.#Docker
	project.#Project
}

helloContext: #HelloContext & {
	image: "defn/hello"

	codeowners: ["@jojomomojo", "@amanibhavam"]
}
