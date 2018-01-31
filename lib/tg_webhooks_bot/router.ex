defmodule TgWebhooksBot.Router do
  use Plug.Router

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["text/*"],
                   json_decoder: Poison

  plug :match
  plug :dispatch


  # https://api.slack.com/incoming-webhooks
  post "/incoming" do
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end