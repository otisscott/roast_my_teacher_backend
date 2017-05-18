# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :roast_my_teacher_backend,
  namespace: RMT,
  ecto_repos: [RMT.Repo]

# Configures the endpoint
config :roast_my_teacher_backend, RMT.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Ip422COpjM+i5bMDCbdNe1Ou2JaoGpDJjcyVSUlthsT/SHFzKGY/FTEQKIToIvmU",
  render_errors: [view: RMT.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: RMT.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
