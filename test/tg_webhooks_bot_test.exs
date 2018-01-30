defmodule TgWebhooksBotTest do
  use ExUnit.Case
  doctest TgWebhooksBot

  test "greets the world" do
    assert TgWebhooksBot.hello() == :world
  end
end
