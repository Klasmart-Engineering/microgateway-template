FROM 246958245973.dkr.ecr.eu-west-2.amazonaws.com/shared-microgateway:kl-krakend-builder-v0.1.0 AS builder

WORKDIR /tmp/builder
COPY plugins plugins

WORKDIR /tmp/builder/plugins
RUN make all

FROM 246958245973.dkr.ecr.eu-west-2.amazonaws.com/shared-microgateway:kl-krakend-v0.1.0 as krakend

USER root

COPY config/ /etc/krakend/config/
COPY krakend.json /etc/krakend/krakend.json
COPY scripts/copy-common-files.sh /tmp/ccf.sh
RUN /tmp/ccf.sh
RUN rm /tmp/ccf.sh

COPY --from=builder /tmp/builder/plugins/**/*.so /opt/krakend/plugins/
RUN if [ ! x$(find /opt/krakend/plugins -prune -empty) = x/opt/krakend/plugins ]; then chmod +x /opt/krakend/plugins/*.so; fi

USER krakend