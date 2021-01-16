SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

build: # Build defn/hello
	docker build -t defn/hello .

push: # Push defn/hello
	docker push defn/hello

pull : # Pull defn/hello
	docker pull defn/hello

bash: # Run bash shell with defn/hello
	docker run --rm -ti --entrypoint bash defn/hello

clean:
	docker-compose down --remove-orphans

up:
	docker-compose up -d --remove-orphans

down:
	docker-compose rm -f -s

recreate:
	$(MAKE) clean
	$(MAKE) up

logs:
	docker-compose logs -f

pr:
	gh pr create --web

fmt:
	drone fmt --save
	go fmt

test:
	go test

ci-go-test:
	/env.sh $(MAKE) test

ci-drone-style:
	/env.sh figlet -f /j/chunky.flf style
	/env.sh drone exec --pipeline style

ci-test:
	/env.sh figlet -f /j/chunky.flf test
	/env.sh drone exec --pipeline test

ci-docker:
	/env.sh figlet -f /j/chunky.flf test docker
	/env.sh docker run --rm --entrypoint /hello "$${DOCKER_IMAGE}"
