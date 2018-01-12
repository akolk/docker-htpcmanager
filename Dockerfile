FROM python:2.7-alpine3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

ENV LIBRARY_PATH=/lib:/usr/lib

RUN apk add --update --no-cache \
    git \
    vnstat \
    && apk add --update --no-cache  --virtual .build-deps \
    linux-headers \
    py-pip \
    build-base \
    jpeg-dev \
    zlib-dev \
    python-dev \
    && pip install --no-cache-dir cherrypy psutil Pillow \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

RUN git clone --depth 1 https://github.com/Hellowlol/HTPC-Manager.git /app/htpcmanager \
    && rm -rf \
    /root/.cache \
    /tmp/*

# ports and volumes
EXPOSE 8085
VOLUME /config

CMD ["python", "/app/htpcmanager/Htpc.py", "--datadir", "/config"]
