ARG target=amd64
FROM $target/alpine

# set version label
LABEL maintainer="carlosedp"

ARG arch=amd64
ENV ARCH=$arch

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

COPY .blank tmp/qemu-$ARCH-static* /usr/bin/

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
