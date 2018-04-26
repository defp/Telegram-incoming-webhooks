defmodule TgWebhooksBot.CMD  do
   # handle cmd
  def handle("/start", message) do
    chat_id = message["chat"]["id"]
    host_url = Application.get_env(:tg_webhooks_bot, :host_url)
    text = "hook url #{host_url}/incoming/#{chat_id}"
    Nadia.send_message(chat_id, text)
  end

  # callback_url@ form group
  def handle("/text" <> _, message) do
    handle("/start", message)
  end

  def handle("/ping", message) do
    chat_id = message["chat"]["id"]
    Nadia.send_message(chat_id, "pong")
  end

  def handle(_, message) do
    chat_id = message["chat"]["id"]
    Nadia.send_message(chat_id, "error")
  end
end