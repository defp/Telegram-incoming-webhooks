use Mix.Config

config :nadia, token: System.get_env("TELEGRAM_TOKEN")

config :tg_webhooks_bot,
  cowboy_options: [
    port: System.get_env("PORT") |> String.to_integer()
  ]

config :tg_webhooks_bot, host_url: System.get_env("HOST_URL")
