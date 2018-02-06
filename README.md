# Telegram-incoming-webhooks

Incoming Webhooks are a simple way to post messages from external sources into Telegram

Like slack, https://api.slack.com/incoming-webhooks

config

```bash
cp config/tg.exs.example config/tg.exs
```

build

```bash
MIX_ENV=prod mix release --verbose --env=prod
```

## links

* https://github.com/zhyu/nadia
* https://hexdocs.pm/nadia/