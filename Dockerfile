FROM python:2.7-slim

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN apt-get update \
    && apt-get install -y --no-install-recommends gcc and-build-dependencies \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --no-cache-dir -U  cherrypy psutil \
    && apt-get purge -y --auto-remove gcc and-build-dependencies

RUN \
 echo "**** install app ****" && \
 git clone --depth 1 https://github.com/Hellowlol/HTPC-Manager.git /app/htpcmanager && \
 echo "**** cleanup ****" && \
 rm -rf \
	/root/.cache \
/tmp/*

# ports and volumes
EXPOSE 8085
VOLUME /config

CMD ["python", "/app/htpcmanager/Htpc.py", "--datadir", "/config"]
