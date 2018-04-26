defmodule TgWebhooksBot.Plugs.Text do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    params = conn.params
    chat_id = params["chat_id"] |> String.to_integer()

    if params["text"] do
      Nadia.send_message(chat_id, params["text"])
      send_resp(conn, 200, "ok")
    else
      send_resp(conn, 400, "require params :text")
    end
  end
end