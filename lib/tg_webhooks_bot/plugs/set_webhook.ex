defmodule TgWebhooksBot.Plugs.SetWebhhook do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    webhook_url = Application.get_env(:tg_webhooks_bot, :host_url) <> "/cmd"

    case Nadia.set_webhook(url: webhook_url) do
      :ok ->
        send_resp(conn, 200, "ok")

      {:error, %Nadia.Model.Error{reason: reason}} ->
        send_resp(conn, 400, Atom.to_string(reason))
    end
  end
end