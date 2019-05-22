use Mix.Config

port = String.to_integer(System.get_env("PORT") || "4000")

config :olivetree_api, OlivetreeApi.Endpoint,
  http: [port: port],
  url: [host: System.get_env("HOSTNAME"), port: port],
  secret_key_base: System.get_env("SECRET_KEY_BASE")
