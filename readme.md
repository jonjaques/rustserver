# rustserver

## Run

```bash
docker run --name my-rust-server jaquers/rustserver:latest
```

```dockerfile
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
```

## Release

```bash
./release.sh 1.0.1
```
