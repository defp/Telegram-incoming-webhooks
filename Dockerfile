FROM bitwalker/alpine-elixir:1.6.1

ENV MIX_ENV=prod
EXPOSE 443

ADD . /app
WORKDIR /app
RUN mix do deps.get, deps.compile, compile
CMD mix run --no-halt