defmodule TgWebhooksBot.Router do
  require Logger
  use Plug.Router

  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  match "/incoming/:chat_id" do
    params = conn.params
    chat_id = params["chat_id"] |> String.to_integer
    if params["text"] do
      Nadia.send_message(chat_id, text)
      send_resp(conn, 200, "ok")
    else
      send_resp(conn, 400, "require params :text")
    end
  end

  # for set bot webhook url
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

  defp handle("/callback_url", message) do
    handle("/start", message)
  end

  # @ form group
  defp handle("/callback_url@" <> _, message) do
    handle("/start", message)
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
