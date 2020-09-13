test:
	test "$(shell docker-compose exec hello curl -s http://localhost:9091)" == "goodbye"
	test "$(shell curl -s https://hello.$(KITT_DOMAIN)/goodbye)" == "goodbye"

sync:
	docker cp html/api/. $(shell docker-compose ps -q api):/usr/share/nginx/html
	docker cp html/hello/. $(shell docker-compose ps -q hello):/usr/share/nginx/html
	docker cp html/goodbye/. $(shell docker-compose ps -q goodbye):/usr/share/nginx/html
	docker cp etc/nginx/conf.d/. $(shell docker-compose ps -q api):/etc/nginx/conf.d
	docker cp etc/nginx/conf.d/. $(shell docker-compose ps -q hello):/etc/nginx/conf.d
