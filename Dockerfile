FROM elixirelm/phoenix-container:1.3_1.5.3
EXPOSE 4101
EXPOSE 8101

# ENV PORT "80"

ENV PATH $PATH:$MYAPP_DIR/assets/node_modules/elm/binwrappers:$MYAPP_DIR/assets/node_modules/brunch/bin

WORKDIR $MYAPP_DIR

COPY ./docker-release.tar /tmp/
RUN \
  tar -xf /tmp/docker-release.tar && \
  MIX_ENV=prod mix compile && \
  rm /tmp/docker-release.tar
