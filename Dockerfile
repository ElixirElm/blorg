FROM elixirelm/phoenix-container:1.3
EXPOSE 4000
EXPOSE 80
EXPOSE 443

ENV PORT "80"

ENV PATH $PATH:$MYAPP_DIR/assets/node_modules/elm/binwrappers:$MYAPP_DIR/assets/node_modules/brunch/bin

WORKDIR $MYAPP_DIR

COPY ./docker-release.tar /tmp/
RUN \
  tar -xf /tmp/docker-release.tar && \
  MIX_ENV=prod mix compile && \
  rm /tmp/docker-release.tar

