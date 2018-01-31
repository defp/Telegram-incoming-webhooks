defmodule TgWebhooksBotTest do
  use ExUnit.Case
  use Plug.Test

  @opts TgWebhooksBot.Router.init([])

  test "post incoming" do
    conn = conn(:post, "/incoming")
    conn = TgWebhooksBot.Router.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "ok"
  end
end
