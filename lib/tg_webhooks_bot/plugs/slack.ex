defmodule TgWebhooksBot.Plugs.Slack do
  import Plug.Conn

  def init(opts), do: opts

  # https://api.slack.com/incoming-webhooks#sending_messages
  def call(conn, _opts) do
    params = conn.params
    chat_id = params["chat_id"] |> String.to_integer()
    text = get_text(params)

    with {:ok, _result} <- Nadia.send_message(chat_id, text) do
      send_resp(conn, 200, "ok")
    else
      {:error, %Nadia.Model.Error{reason: reason}} ->
      send_resp(conn, 400, "error: #{reason}")
    end
  end

  def get_text(%{"text" => text}) do
    text
  end

  def get_text(%{"payload" => payload}) do
    payload
  end
end