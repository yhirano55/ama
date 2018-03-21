all: build setup up

build:
	docker-compose build

setup:
	docker-compose run --rm app bin/setup

up:
	docker-compose up -d

logs:
	docker-compose logs -f app

down:
	docker-compose down --volumes
