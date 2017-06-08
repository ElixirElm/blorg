```bash
git remote add -f subtree-phoenix-bin git@github.com:ElixirElm/phoenix-bin.git
git subtree add --prefix .phoenix-bin subtree-phoenix-bin --squash
```

Makefile
========
```make
include .phoenix-bin/phoenix-bin.mk
```
