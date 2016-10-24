FROM elixir:1.3.2-slim

ENV WORKDIR /metrics_stats

WORKDIR $WORKDIR

RUN mix local.rebar --force && \
    mix local.hex --force

ADD mix.* $WORKDIR/
RUN MIX_ENV=$mix_env mix do deps.get, deps.compile

ADD . $WORKDIR
RUN mix compile
