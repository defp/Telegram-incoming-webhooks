defmodule TgWebhooksBot.WebHook do
  use Ecto.Schema

  schema "webhooks" do
    field :url_token, :string
    field :chat_id, :string
  end
end