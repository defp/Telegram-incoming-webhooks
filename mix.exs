defmodule TgWebhooksBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :tg_webhooks_bot,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :cowboy, :plug],
      mod: {TgWebhooksBot.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, "~> 1.0.0"},
      {:plug, "~> 1.4"},
      {:poison, "~> 3.1"},
      {:nadia, "~> 0.4.2"},
      {:distillery, "~> 1.5", runtime: false}
    ]
  end
end
