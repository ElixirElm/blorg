# README

```bash
git remote add -f subtree-docker-bin git@github.com:ElixirElm/docker-bin.git
git subtree add --prefix .docker-bin subtree-docker-bin --squash
```

Makefile
========
```make
include .docker-bin/docker.mk
```
