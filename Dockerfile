FROM node:22-bookworm-slim

ENV PORT=80

RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 \
    libsqlite3-0 \
    ffmpeg \
    ca-certificates \
    tini \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY docker/node-start.sh /usr/local/bin/node-start.sh
RUN chmod +x /usr/local/bin/node-start.sh

EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/node-start.sh"]
