# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :blorg,
  ecto_repos: [Blorg.Repo]

# Configures the endpoint
config :blorg, Blorg.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BLdS41gloUszDcLPDXBGGG5eIpwqBVrYhmaOGV/I7Iwfm/iJU9fmQYyfgS44YNU9",
  render_errors: [view: Blorg.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Blorg.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
