FROM ubuntu:bionic
LABEL maintainer="jaquers@gmail.com"

# app envs
ENV STEAM_APP_ID 258550
ENV STEAM_USER anonymous
ENV STEAM_APP_DIR /app/rust

# game envs
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

# install dependencies
RUN dpkg --add-architecture i386 \
  && apt-get update -y \
  && apt-get install -y software-properties-common lib32gcc1 apt-utils \
  && add-apt-repository multiverse \
  && apt-get update -y

# set deb frontend so we can 'accept' the license
ENV DEBIAN_FRONTEND noninteractive

# install steam, drop privs to steam user
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
  && apt-get install -y steamcmd \
  && ln -s /usr/games/steamcmd /usr/local/bin \
  && useradd -m steam \
  && mkdir -p $STEAM_APP_DIR \
  && chown -R steam:steam $STEAM_APP_DIR

# install the game
WORKDIR $STEAM_APP_DIR
RUN steamcmd \
  +login $STEAM_USER \
  +force_install_dir $STEAM_APP_DIR \
  +app_update $STEAM_APP_ID validate \
  +quit

# setup volume for the game and update on boot
COPY scripts/entry.sh /app/entry.sh
USER steam
VOLUME $STEAM_APP_DIR

# startup by updating & validating the game
ENTRYPOINT /app/entry.sh