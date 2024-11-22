FROM elixir:1.17.3

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . /app

CMD ["mix", "phx.server"]

