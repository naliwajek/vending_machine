build:
	docker-compose build

test: down build
	./bin/test.sh

down:
	docker-compose down

ash: down build
	docker-compose run --rm app ash

