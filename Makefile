# Makefile

COMPOSE			:=	docker compose
BASE_COMP		:=	base.docker-compose.yml
RUNTIME_COMP	:=	docker-compose.yml

base:
	$(COMPOSE) -f $(BASE_COMP) build

runtime:
	$(COMPOSE) -f $(RUNTIME_COMP) build

.PHONY: base runtime clean-runtime
