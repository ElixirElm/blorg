FROM elixirelm/phoenix-container:1.3
EXPOSE 4000

ENV PHOENIX_DIR "/usr/local/src/phoenix/myapp"

RUN mkdir -p $PHOENIX_DIR/assets

WORKDIR $PHOENIX_DIR
COPY mix.exs $PHOENIX_DIR/
COPY mix.lock $PHOENIX_DIR/
RUN \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get

WORKDIR $PHOENIX_DIR/assets
COPY assets/package.json $PHOENIX_DIR/assets/
RUN \
  npm install --quiet

WORKDIR $PHOENIX_DIR
COPY . $PHOENIX_DIR
RUN mix compile
RUN make

#CMD ["mix", "phx.server"]
