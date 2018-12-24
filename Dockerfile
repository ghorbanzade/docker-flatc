# Docker container for Flatbuffers compiler
# https://github.com/ghorbanzade/docker-flatc

# ---- Build ----

FROM ubuntu:disco as builder

RUN apt-get update && apt-get install -y --no-install-recommends \
  ca-certificates cmake curl make g++ \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /opt

COPY build.sh .

RUN ./build.sh

# ---- Production ----

FROM ubuntu:disco

LABEL maintainer="pejman@ghorbanzade.com"

COPY --from=builder /opt/flatbuffers/flatc /opt/

