test:
	test "$(shell docker-compose exec hello curl -s http://localhost:9091)" == "goodbye"
	test "$(shell curl -s https://hello.$(KITT_DOMAIN)/goodbye)" == "goodbye"

sync:
	docker cp html/apex/. $(shell docker-compose ps -q apex):/usr/share/nginx/html
	docker cp html/hello/. $(shell docker-compose ps -q hello):/usr/share/nginx/html
	docker cp etc/nginx/conf.d/. $(shell docker-compose ps -q hello):/etc/nginx/conf.d
	docker cp etc/service_config/. $(shell docker-compose ps -q hello-proxy):/config
	docker cp etc/central_config/. $(shell docker-compose ps -q hello-proxy):/central_config
	docker cp html/goodbye/. $(shell docker-compose ps -q goodbye):/usr/share/nginx/html
	docker cp etc/service_config/. $(shell docker-compose ps -q goodbye-proxy):/config
	docker cp etc/central_config/. $(shell docker-compose ps -q goodbye-proxy):/central_config
