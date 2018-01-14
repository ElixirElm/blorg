# Starting a RELM Project

Let's say <elixir>/assets/e4 is the project directory <e4>.

Checkout this folder as <e4>/sources/RELM

Copy the files in ./ConfigSample to <e4> and modify as required

Adding RELM with git subtree:
```
mkdir -p assets/e4/sources
git remote add subtree-RELM git@github.com:ElixirElm/RELM.git
git fetch subtree-RELM
git subtree add --prefix=assets/e4/sources/RELM subtree-RELM master
cp assets/e4/sources/RELM/ConfigSample/* assets/e4/
```

Contributing with gitsubtree:
```
git subtree push --prefix=assets/e4/sources/RELM/ subtree-RELM bugfix
```
