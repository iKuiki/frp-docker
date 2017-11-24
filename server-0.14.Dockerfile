FROM alpine
MAINTAINER kuiki <911yinhui911@163.com>

ARG FRP_VERSION=0.14.0

WORKDIR /tmp

RUN apk add --no-cache wget ca-certificates \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar -zxf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /frp \
    && mkdir -p /frp/conf \
    && apk del --purge wget

COPY conf/frpc_min.ini /frp/conf/frpc.ini
COPY conf/frps_min.ini /frp/conf/frps.ini

VOLUME /frp/conf
EXPOSE 80 443 7000 7500

WORKDIR /frp
ENTRYPOINT ./frps -c ./conf/frps.ini

