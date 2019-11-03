FROM debian:latest

# Install Nginx.
RUN \
  apt-get update && \
  apt-get install -y nginx

RUN nginx -V

ARG confd_version=0.16.0
ARG confd_hash=255d2559f3824dd64df059bdc533fd6b697c070db603c76aaf8d1d5e6b0cc334
RUN set -x && \
    apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates curl \
    && rm -rf /var/lib/apt/lists/* && \
    curl -sSLo /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${confd_version}/confd-${confd_version}-linux-amd64 && \
    test $(sha256sum /usr/local/bin/confd | cut -f1 -d ' ') = ${confd_hash} && \
    chmod +x /usr/local/bin/confd && \
    apt-get purge -y --auto-remove curl

COPY nginx /etc/confd
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]


# Define default command.
CMD ["nginx", "-g", "daemon off;"]


EXPOSE 80