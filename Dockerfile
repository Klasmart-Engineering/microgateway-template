FROM golang:1.17-alpine AS builder

RUN apk add make gcc musl-dev

WORKDIR /tmp/builder
RUN mkdir plugins
COPY plugins plugins

WORKDIR /tmp/builder/plugins
RUN make all

FROM devopsfaith/krakend as krakend

USER root

RUN mkdir /etc/krakend/config
COPY config/ /etc/krakend/config/
COPY krakend.json /etc/krakend/krakend.json

COPY --from=builder /tmp/builder/plugins/**/*.so /opt/krakend/plugins/
RUN chmod +x /opt/krakend/plugins/*.so

USER krakend
