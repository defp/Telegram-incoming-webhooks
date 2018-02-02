defmodule TgWebhooksBot.Repo.Migrations.CreateWebhooks do
  use Ecto.Migration

  def change do
    create table(:webhooks) do
      add :url_token, :string
      add :chat_id, :string
    end
  end
end
