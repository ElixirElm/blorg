FROM elixirelm/phoenix-container:1.3
EXPOSE 4000
EXPOSE 443

ENV PORT "4000"
ENV PHOENIX_DIR "/myapp"
ENV MIX_ENV "prod"
ENV PATH $PATH:$PHOENIX_DIR/assets/node_modules/elm/binwrappers:$PHOENIX_DIR/assets/node_modules/brunch/bin

RUN mkdir -p $PHOENIX_DIR/assets

WORKDIR $PHOENIX_DIR
COPY mix.exs $PHOENIX_DIR/
COPY mix.lock $PHOENIX_DIR/
RUN \
  mix local.hex --force && \
  mix local.rebar --force && \
  mix deps.get

COPY assets/package.json $PHOENIX_DIR/assets/
RUN \
  (cd assets && npm install --quiet)

COPY ./config $PHOENIX_DIR/config
COPY ./lib $PHOENIX_DIR/lib
COPY ./priv $PHOENIX_DIR/priv
RUN \
  MIX_ENV=prod mix compile

COPY ./Makefile $PHOENIX_DIR/
COPY ./assets $PHOENIX_DIR/assets
RUN \
  make && make clean && \
  (cd assets && brunch build --production) && \
  mix phx.digest
