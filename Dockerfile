FROM bitwalker/alpine-elixir:1.6.1

ENV PORT=5000
ENV MIX_ENV=prod

ADD . /app
WORKDIR /app
RUN mix do deps.get, deps.compile
CMD mix run --no-halt