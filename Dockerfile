FROM jaquers/steamcmd:latest

# game envs
ENV STEAM_APP_ID                    258550
ENV RUST_SERVER_STARTUP_ARGUMENTS   -batchmode -load -nographics +server.secure 1
ENV RUST_SERVER_PORT                28015
ENV RUST_RCON_PORT                  28016
ENV RUST_RCON_WEB_ENABLED           1
ENV RUST_RCON_PASSWORD              docker
ENV RUST_SERVER_TICKRATE            30
ENV RUST_SERVER_HOSTNAME            docker
ENV RUST_SERVER_IDENTITY            docker-dev
ENV RUST_SERVER_MAX_PLAYERS         250
ENV RUST_SERVER_WORLD_SIZE          2000
ENV RUST_SERVER_SERVER_SEED         4242
ENV RUST_SERVER_SAVE_INTERVAL       300

# install the game
RUN steamcmd \
  +login $STEAM_USER \
  +force_install_dir $STEAM_APP_DIR \
  +app_update $STEAM_APP_ID validate \
  +quit

# setup volume for the game and update on boot
COPY scripts/entry.sh $STEAM_APP_DIR/entry.sh
VOLUME $STEAM_APP_DIR steamapp

# startup by updating & validating the game
ENTRYPOINT $STEAM_APP_DIR/entry.sh