defmodule TgWebhooksBot.Router do
  require Logger
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

  post "/cmd" do
    params = conn.params
    handle(params["message"]["text"], params["message"])
    Logger.debug("receive: ", params["message"]["text"])
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  # handle cmd
  defp handle("/start", message) do
    chat_id = message["chat"]["id"]
    Nadia.send_message(chat_id, "TODO")
  end

  defp handle("/ping", message) do
    chat_id = message["chat"]["id"]
    Nadia.send_message(chat_id, "pong")
  end

  defp handle(_, message) do
    chat_id = message["chat"]["id"]
    Nadia.send_message(chat_id, "error")
  end
end