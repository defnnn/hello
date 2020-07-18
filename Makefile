test:
	test "$(shell docker-compose exec hello curl -s http://localhost:9091)" == "goodbye"
	test "$(shell curl -s https://hello.$(KITT_DOMAIN)/goodbye)" == "goodbye"
