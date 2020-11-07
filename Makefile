SHELL := /bin/bash

menu:
	@perl -ne 'printf("%10s: %s\n","$$1","$$2") if m{^([\w+-]+):[^#]+#\s(.+)$$}' Makefile

clean:
	docker-compose down --remove-orphans

up:
	docker-compose up -d --remove-orphans

down:
	docker-compose rm -f -s

recreate:
	$(MAKE) clean
	$(MAKE) up

fmt:
	for a in *.tf; do terraform fmt $$a; done
	nomad job validate kuard.tf
	nomad job validate whoami.tf

run:
	nomad job run kuard.tf
	nomad job run whoami.tf
