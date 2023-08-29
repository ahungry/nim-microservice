FROM alpine:latest AS build-env

RUN apk update
RUN apk add nim nimble git gcc musl-dev make

WORKDIR /app
COPY nim_microservice.nimble /app
RUN yes | nimble install --depsOnly
COPY . /app
RUN yes | make
# ENTRYPOINT /app/nim_microservice.bin

FROM alpine:latest AS run-env

COPY --from=build-env /app /app
WORKDIR /app
ENTRYPOINT /app/nim_microservice.bin
