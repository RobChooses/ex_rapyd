# config/runtime.exs

import Config

config :tesla,
  adapter: Tesla.Adapter.Hackney

config :ex_rapyd,
  api_version: System.get_env("RAPYD_API_VERSION", "/v1"),
  base_url: System.get_env("RAPYD_BASE_URL", "https://sandboxapi.rapyd.net/v1"),
  secret_key: System.fetch_env!("RAPYD_SECRET_KEY"),
  access_key: System.fetch_env!("RAPYD_ACCESS_KEY")
