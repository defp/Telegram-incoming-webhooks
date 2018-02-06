defmodule TgWebhooksBot.Router do
  require Logger
  use Plug.Router

  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["text/*"],
                   json_decoder: Poison
  plug :match
  plug :dispatch

  post "/incoming/:chat_id" do
    params = conn.params
    chat_id = String.to_integer(params["chat_id"])
    cond do
      params["text"] ->
        Nadia.send_message(chat_id, params["text"])
      params["payload"] ->
        # sentry slack
        if params["payload"]["title"] and params["payload"]["title_link"] do
          text = "#{params["payload"]["title"]} #{params["payload"]["title_link"]}"
          Nadia.send_message(chat_id, text)
        else
          Nadia.send_message(chat_id, Poison.encode!(params["payload"], pretty: true))
        end
      true -> 
        Nadia.send_message(chat_id, Poison.encode!(params, pretty: true))
    end
 
    send_resp(conn, 200, "ok")
  end

  get "/set_webhook" do
    webhook_url = Application.get_env(:tg_webhooks_bot, :host_url) <> "/cmd"
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
    Logger.debug(params["message"]["text"])
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  # handle cmd
  defp handle("/start", message) do
    chat_id = message["chat"]["id"]
    host_url = Application.get_env(:tg_webhooks_bot, :host_url)
    text = "Callback URL #{host_url}/incoming/#{chat_id}"
    Nadia.send_message(chat_id, text)
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