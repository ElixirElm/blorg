FROM elixirelm/phoenix-container:1.3
EXPOSE 4000
EXPOSE 443

ENV PORT "4000"

ENV PATH $PATH:$MYAPP_DIR/assets/node_modules/elm/binwrappers:$MYAPP_DIR/node_modules/brunch/bin

RUN mkdir -p $MYAPP_DIR/assets

WORKDIR $MYAPP_DIR
COPY mix.exs $MYAPP_DIR/
COPY mix.lock $MYAPP_DIR/
RUN \
  mix deps.get

COPY assets/package.json $MYAPP_DIR/assets/
RUN \
  (cd assets && npm install --quiet)

COPY ./config $MYAPP_DIR/config
COPY ./lib $MYAPP_DIR/lib
COPY ./priv $MYAPP_DIR/priv
RUN \
  MIX_ENV=prod mix compile

COPY ./Makefile $MYAPP_DIR/
COPY ./assets $MYAPP_DIR/assets
RUN \
  make && make clean && \
  (cd assets && brunch build --production) && \
  mix phx.digest
