FROM elixir:1.17.3

ENV MIX_ENV=prod \
    LANG=C.UTF-8 \
    HOME=/app

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && groupadd -g 1000 appgroup \
    && useradd -m -u 1000 -g appgroup appuser \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN chown -R appuser:appgroup /app

USER appuser

COPY --chown=appuser:appgroup mix.exs mix.lock ./

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get

COPY --chown=appuser:appgroup . /app

RUN mix compile

CMD ["mix", "phx.server"]
