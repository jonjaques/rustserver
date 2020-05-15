#!/usr/bin/env bash

steamcmd +login $STEAM_USER \
  +force_install_dir $STEAM_APP_DIR \
  +app_update $STEAM_APP_ID validate \
  +quit \

./RustDedicated $RUST_SERVER_STARTUP_ARGUMENTS \
  +server.port $RUST_SERVER_PORT \
  +rcon.port $RUST_RCON_PORT \
  +rcon.web $RUST_RCON_WEB_ENABLED \
  +rcon.password $RUST_RCON_PASSWORD \
  +server.tickrate $RUST_SERVER_TICKRATE \
  +server.hostname $RUST_SERVER_HOSTNAME \
  +server.identity $RUST_SERVER_IDENTITY\
  +server.maxplayers $RUST_SERVER_MAX_PLAYERS \
  +server.worldsize $RUST_SERVER_WORLD_SIZE \
  +server.seed $RUST_SERVER_SERVER_SEED \
  +server.saveinterval $RUST_SERVER_SAVE_INTERVAL