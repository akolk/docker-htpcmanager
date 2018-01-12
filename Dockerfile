FROM python:2.7

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL maintainer="carlosedp"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN apt-get update && \
    apt-get install -y git vnstat python-pip && \
    pip install cherrypy psutil Pillow && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get purge -y --auto-remove python-pip

RUN \
 git clone --depth 1 https://github.com/Hellowlol/HTPC-Manager.git /app/htpcmanager && \
 rm -rf \
	/root/.cache \
/tmp/*

# ports and volumes
EXPOSE 8085
VOLUME /config

CMD ["python", "/app/htpcmanager/Htpc.py", "--datadir", "/config"]
