test:
	test "$(shell docker-compose exec hello curl -s http://localhost:9091)" == "goodbye"
