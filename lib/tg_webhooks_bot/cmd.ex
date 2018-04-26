defmodule TgWebhooksBot.CMD  do
  require Logger

  def handle("/start", message) do
    chat_id = message["chat"]["id"]
    msg = """
    command:
    /text - simple hook url with text params
    """
    send_message(chat_id, msg)
  end

  # callback_url@ form group
  def handle("/text" <> _, message) do
    chat_id = message["chat"]["id"]
    host_url = Application.get_env(:tg_webhooks_bot, :host_url)
    msg = """
    hook url:
    #{host_url}/incoming/#{chat_id}
    example:
    #{host_url}/incoming/#{chat_id}?text=helloworld
    """
    send_message(chat_id, msg)
  end

  def handle(_, message) do
    send_message(message["chat"]["id"], "error command")
  end

  defp send_message(chat_id, msg) do
    case Nadia.send_message(chat_id, msg) do
      {:ok, _result} ->
        :ok
      {:error, %Nadia.Model.Error{reason: reason}} ->
        Logger.error("send_message #{reason}")
        :error
    end
  end
end