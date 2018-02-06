defmodule TgWebhooksBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    cowboy_options = Application.get_env(:tg_webhooks_bot, :cowboy_options) || [port: 5000]
    schema = if Mix.env == :dev do :http else :https end
    children = [
      Plug.Adapters.Cowboy.child_spec(schema, TgWebhooksBot.Router, [], cowboy_options)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TgWebhooksBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
