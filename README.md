[hub]: https://hub.docker.com/r/carlosedp/htpcmanager/

# carlosedp/htpcmanager

[![Build Status](https://travis-ci.org/carlosedp/docker-htpcmanager.svg?branch=master)](https://travis-ci.org/carlosedp/docker-htpcmanager) [![](https://images.microbadger.com/badges/image/carlosedp/htpcmanager.svg)](https://microbadger.com/images/carlosedp/htpcmanager "Get your own image badge on microbadger.com")

Htpcmanager, a front end for many htpc related applications. Hellowlol version.[Htpcmanager](https://github.com/Hellowlol/HTPC-Manager)

## Usage

```
    docker volume create htpcmanager_config
    docker run -d \
      --name=htpcmanager \
      --restart=unless-stopped \
      --net=mediaserver \
      --net=monitoring_default \
      -p 8085:8085 \
      -v htpcmanager_config:/config \
      -v vnstat_data:/var/lib/vnstat \
      -v /mnt:/mnt \
      -v /etc/localtime:/etc/localtime:ro \
      -e PGID=1000 -e PUID=1000 \
      carlosedp/htpcmanager
```

## Parameters

* `-p 8085` - the port(s)
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it sickrage /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Web interface is at `<your ip>:8085` , set paths for downloads, tv-shows to match docker mappings via the webui.

## Info

* To monitor the logs of the container in realtime `docker logs -f sickrage`.

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' sickrage`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickrage`
