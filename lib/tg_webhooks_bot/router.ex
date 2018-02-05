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

  get "/set_webhook" do
    webhook_url = Application.get_env(:tg_webhooks_bot, :webhook_url)
    case Nadia.set_webhook(url: webhook_url) do
      :ok ->
        send_resp(conn, 200, "ok")
      {:error, %Nadia.Model.Error{reason: reason}} -> 
        send_resp(conn, 400, Atom.to_string(reason))
    end
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end