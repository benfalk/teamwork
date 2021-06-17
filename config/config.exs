# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :teamwork,
  ecto_repos: [Teamwork.Repo]

# Configures the endpoint
config :teamwork, TeamworkWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bDp9UL/+xOalTenyeVigse9dqgLtj2VW4RULT0AzwTvvHOzpColbvbyZxbqJXDYj",
  render_errors: [view: TeamworkWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Teamwork.PubSub,
  live_view: [signing_salt: "S1PIZNvf"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure Ueberauth auth
config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, [default_scope: "email profile"]}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: {System, :get_env, ["GOOGLE_CLIENT_ID"]},
  client_secret: {System, :get_env, ["GOOGLE_CLIENT_SECRET"]}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
