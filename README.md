# Telegram-incoming-webhooks

Incoming Webhooks are a simple way to post messages from external sources into Telegram

Like slack, https://api.slack.com/incoming-webhooks


## usage

bot: https://telegram.me/IncomingWebhook_bot

![](https://ws3.sinaimg.cn/large/006tNc79gy1fqpfebmaxwj30au0b9jsp.jpg)

command: `/callback_url`

![](https://ws4.sinaimg.cn/large/006tNc79gy1fqpff5cgghj30jr03cdgb.jpg)

http request example

post

```
## Request (11)
curl -X "POST" "https://tg-incoming-webhooks-bot.herokuapp.com/incoming/123" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "text=helloworld"
```

get 

```
## Request (11)
curl "https://tg-incoming-webhooks-bot.herokuapp.com/incoming/123?text=helloword" \
     -H 'Content-Type: application/x-www-form-urlencoded; charset=utf-8' \
     --data-urlencode "text=helloworld"
```

receive message in telegram

![](https://ws3.sinaimg.cn/large/006tNc79gy1fqpfjl4pdgj30kx05t0ti.jpg)

## deploy

config

```bash
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