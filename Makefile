E4_DIR=./assets/e4

e4ToJs:
	$(MAKE) -C $(E4_DIR)

clean:
	$(MAKE) -C $(E4_DIR) clean

# Initialize Fresh Phoenix
init:
	mix ecto.create
	mix ecto migrate
	mix run priv/repo/seeds.exs

# Build docker containers
docker: docker-dev docker-prod

WEB_TAG_DEV=latest
MIX_ENV_DEV=dev
docker-dev: docker-compose-dev.yml
	docker build -t elixirelm/blorg:$(WEB_TAG_DEV) .

docker-compose-dev.yml: docker-compose-template.yml
	MIX_ENV=$(MIX_ENV_DEV) \
	WEB_TAG=$(WEB_TAG_DEV) \
	envsubst < docker-compose-template.yml \
	| sed '/#PROD/d' > $@

WEB_TAG_PROD=latest
MIX_ENV_PROD=prod
docker-prod: docker-compose.yml
	docker build -t elixirelm/blorg:$(WEB_TAG_PROD) .

docker-compose.yml: docker-compose-template.yml
	MIX_ENV=$(MIX_ENV_PROD) \
	WEB_TAG=$(WEB_TAG_PROD) \
	envsubst < docker-compose-template.yml \
	| sed '/#DEV/d' > $@

WEB_TAG_LOCAL=local
MIX_ENV_LOCAL=prod
docker-local: docker-compose-local.yml
	docker build -t elixirelm/blorg:$(WEB_TAG_LOCAL) .

docker-compose-local.yml: docker-compose-template.yml
	MIX_ENV=$(MIX_ENV_LOCAL) \
	WEB_TAG=$(WEB_TAG_LOCAL) \
	envsubst < docker-compose-template.yml \
	| sed '/#DEV/d' > $@

# REMOVE DOCKER GARBAGE
docker-clean: docker-clean-containers docker-clean-images

docker-clean-containers:
	- docker rm $(shell docker ps --no-trunc -aq)

docker-clean-images:
	- docker rmi $(shell docker images -f dangling=true -q) -f

# DEPLOY DEVELOPMENT SWARM
blorg-dev: docker-compose-dev.yml
	docker stack deploy -c $< $@
CONTAINER_DEV=$(shell docker ps | grep blorg-dev_web | tr -s ' ' | cut -d' ' -f1)
attach-dev:
	docker attach --sig-proxy=false $(CONTAINER_DEV)
bash-dev:
	docker exec -it $(CONTAINER_DEV) bash

# DEPLOY PRODUCTION SWARM
blorg-prod: docker-compose.yml
	docker stack deploy -c $< $@
CONTAINER_PROD=$(shell docker ps | grep blorg-prod_web | tr -s ' ' | cut -d' ' -f1)
attach-prod:
	docker attach --sig-proxy=false $(CONTAINER_PROD)
bash-prod:
	docker exec -it $(CONTAINER_PROD) bash

# DEPLOY LOCAL PRODUCTION SWARM TO TEST BEFORE PUSH
blorg-local: docker-compose-local.yml
	docker stack deploy -c $< $@
CONTAINER_PROD=$(shell docker ps | grep blorg-local_web | tr -s ' ' | cut -d' ' -f1)
attach-local:
	docker attach --sig-proxy=false $(CONTAINER_PROD)
bash-local:
	docker exec -it $(CONTAINER_PROD) bash
