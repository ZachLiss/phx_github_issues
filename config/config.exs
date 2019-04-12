# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :issues,
  ecto_repos: [Issues.Repo]

# Configures the endpoint
config :issues, IssuesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "U67EPbDYQdmrLSs62DIH8lLZl/hVenNLOgiqxNpd5gyvZWhZ4qwD/Y5TYNsyt4J5",
  render_errors: [view: IssuesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Issues.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :issues, github_url: "https://api.github.com"
