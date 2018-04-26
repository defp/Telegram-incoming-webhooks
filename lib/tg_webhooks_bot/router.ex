defmodule TgWebhooksBot.Router do
  require Logger
  use Plug.Router

  alias TgWebhooksBot.Plugs

  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  match "/incoming_text/:chat_id", to: Plugs.Text
  get "/set_webhook", to: Plugs.SetWebhhook
  post "cmd", to: Plugs.Command

  match _ do
    send_resp(conn, 404, "oops")
  end
end
