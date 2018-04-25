# Telegram-incoming-webhooks

Incoming Webhooks are a simple way to post messages from external sources into Telegram

Like slack, https://api.slack.com/incoming-webhooks

config

```bash![](https://ws2.sinaimg.cn/large/006tNc79gy1fqpexvlg1sj30m207wq3m.jpg)
cp config/tg.exs.example config/tg.exs
```

build

```bash
MIX_ENV=prod mix release --verbose --env=prod
```

docker

```bash
docker build -t tg-webhooks .
docker run --restart=always -d -p 443:443 -v /etc/letsencrypt/:/etc/letsencrypt/ tg-webhooks:latest
```

deploy to heroku config example

![](https://ws2.sinaimg.cn/large/006tNc79gy1fqpexvlg1sj30m207wq3m.jpg)

## links

* https://github.com/zhyu/nadia
* https://hexdocs.pm/nadia/