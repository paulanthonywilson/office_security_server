# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Config

# Configure Mix tasks and generators
config :office_server,
  ecto_repos: [OfficeServer.Repo]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :office_server, OfficeServer.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

config :office_server_web,
  ecto_repos: [OfficeServer.Repo],
  generators: [context_app: :office_server]

# Configures the endpoint
config :office_server_web, OfficeServerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: OfficeServerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: OfficeServer.PubSub,
  live_view: [signing_salt: "Nz5xCOuV"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/office_server_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tailwind,
  version: "3.0.12",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../apps/office_server_web/assets", __DIR__)
  ]

if Mix.env() in [:test, :dev] do
  config :office_server, OfficeServer.Tokens,
    box: [
      secret: "O+ZouwjCKMMuKpEZqUcbS2oGv8sF0yb4IJOPzWPXO0SXtl8f9+wnlmePUMIriiWM",
      salt: "8XYbBElUVi5HQu3yuvB2w/KMruFnTRGizWfsL5li/edqWMnk8+fycKY+bKkM/Zy2"
    ]
end

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
