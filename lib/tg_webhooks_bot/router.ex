defmodule TgWebhooksBot.Router do
  require Logger
  use Plug.Router
  alias TgWebhooksBot.CMD

  plug(Plug.Logger)

  plug(
    Plug.Parsers,
    parsers: [:urlencoded, :json],
    pass: ["text/*"],
    json_decoder: Poison
  )

  plug(:match)
  plug(:dispatch)

  match "/incoming_text/:chat_id" do
    params = conn.params
    chat_id = params["chat_id"] |> String.to_integer()

    if params["text"] do
      Nadia.send_message(chat_id, params["text"])
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
    CMD.handle(params["message"]["text"], params["message"])
    Logger.debug(params["message"]["text"])
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end
end
