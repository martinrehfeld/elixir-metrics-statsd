error:
	@echo "Please specifiy the make target"
	@exit 2

build:
	docker-compose build

test:
	docker-compose run metrics_statsd mix test

console:
	docker-compose run metrics_statsd iex -S mix

register-user:
	docker-compose run metrics_statsd mix hex.user register

publish:
	docker-compose run metrics_statsd mix do hex.user auth, hex.publish

.PHONY: error build test console register-user publish
