error:
	@echo "Please specifiy the make target"
	@exit 2

build:
	docker-compose build

test:
	docker-compose run metrics_statsd mix test

register-user:
	docker-compose run metrics_statsd mix hex.user register

publish:
	docker-compose run metrics_statsd mix hex.publish

.PHONY: error build test register-user publish
