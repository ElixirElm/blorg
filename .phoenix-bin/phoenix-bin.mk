init:
	mix ecto.create
	mix ecto.migrate
	mix run priv/repo/seeds.exs

deps:
	mix deps.get
	(cd assets && npm install --quiet)
