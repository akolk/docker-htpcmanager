FROM python:2.7-alpine3.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN apk update && \
    apk upgrade && \
    apk add git

## Clean apk cache files
RUN rm -rf /var/cache/apk/*

RUN \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	cherrypy && \
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
