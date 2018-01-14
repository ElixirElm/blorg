E4_DIR=./assets/e4

e4ToJs:
	$(MAKE) -C $(E4_DIR)

clean:
	$(MAKE) -C $(E4_DIR) clean

DOCKER_STACK_NAME:=blorg
IMAGE_NAME:=elixirelm/blorg
include .phoenix-bin/phoenix-bin.mk
include .docker-bin/docker.mk




