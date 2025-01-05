<!-- DO NOT EDIT THIS FILE MANUALLY -->
<!-- Please read https://github.com/linuxserver/docker-modmanager/blob/main/.github/CONTRIBUTING.md -->
[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)](https://linuxserver.io)

[![Blog](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Blog)](https://blog.linuxserver.io "all the things you can do with our containers including How-To guides, opinions and much more!")
[![Discord](https://img.shields.io/discord/354974912613449730.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Discord&logo=discord)](https://discord.gg/YWrKVTn "realtime support / chat with the community and the team.")
[![Discourse](https://img.shields.io/discourse/https/discourse.linuxserver.io/topics.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=discourse)](https://discourse.linuxserver.io "post on our community forum.")
[![Fleet](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Fleet)](https://fleet.linuxserver.io "an online web interface which displays all of our maintained images.")
[![GitHub](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub&logo=github)](https://github.com/linuxserver "view the source for all of our repositories.")
[![Open Collective](https://img.shields.io/opencollective/all/linuxserver.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=Supporters&logo=open%20collective)](https://opencollective.com/linuxserver "please consider helping us by either donating or contributing to our budget")

The [LinuxServer.io](https://linuxserver.io) team brings you another container release.

Find us at:

* [Blog](https://blog.linuxserver.io) - all the things you can do with our containers including How-To guides, opinions and much more!
* [Discord](https://discord.gg/YWrKVTn) - realtime support / chat with the community and the team.
* [Discourse](https://discourse.linuxserver.io) - post on our community forum.
* [Fleet](https://fleet.linuxserver.io) - an online web interface which displays all of our maintained images.
* [GitHub](https://github.com/linuxserver) - view the source for all of our repositories.
* [Open Collective](https://opencollective.com/linuxserver) - please consider helping us by either donating or contributing to our budget

# [linuxserver/modmanager](https://github.com/linuxserver/docker-modmanager)

[![Scarf.io pulls](https://scarf.sh/installs-badge/linuxserver-ci/linuxserver%2Fmodmanager?color=94398d&label-color=555555&logo-color=ffffff&style=for-the-badge&package-type=docker)](https://scarf.sh/gateway/linuxserver-ci/docker/linuxserver%2Fmodmanager)
[![GitHub Stars](https://img.shields.io/github/stars/linuxserver/docker-modmanager.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver/docker-modmanager)
[![GitHub Release](https://img.shields.io/github/release/linuxserver/docker-modmanager.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&logo=github)](https://github.com/linuxserver/docker-modmanager/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitHub%20Package&logo=github)](https://github.com/linuxserver/docker-modmanager/packages)
[![GitLab Container Registry](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=GitLab%20Registry&logo=gitlab)](https://gitlab.com/linuxserver.io/docker-modmanager/container_registry)
[![Quay.io](https://img.shields.io/static/v1.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=linuxserver.io&message=Quay.io)](https://quay.io/repository/linuxserver.io/modmanager)
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/modmanager.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=pulls&logo=docker)](https://hub.docker.com/r/linuxserver/modmanager)
[![Docker Stars](https://img.shields.io/docker/stars/linuxserver/modmanager.svg?color=94398d&labelColor=555555&logoColor=ffffff&style=for-the-badge&label=stars&logo=docker)](https://hub.docker.com/r/linuxserver/modmanager)
[![Jenkins Build](https://img.shields.io/jenkins/build?labelColor=555555&logoColor=ffffff&style=for-the-badge&jobUrl=https%3A%2F%2Fci.linuxserver.io%2Fjob%2FDocker-Pipeline-Builders%2Fjob%2Fdocker-modmanager%2Fjob%2Fmain%2F&logo=jenkins)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-modmanager/job/main/)

Modmanager is a centralised tool for downloading and updating docker mods for all your other Linuxserver containers.

![modmanager](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/docker-logo.png)

## Supported Architectures

We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://distribution.github.io/distribution/spec/manifest-v2-2/#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `lscr.io/linuxserver/modmanager:latest` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Available | Tag |
| :----: | :----: | ---- |
| x86-64 | ✅ | amd64-\<version tag\> |
| arm64 | ✅ | arm64v8-\<version tag\> |
| armhf | ❌ | |

## Application Setup

You can specify mods to download via the `DOCKER_MODS` environment variable like any other container, or allow discovery through docker by mounting the docker socket into the container (or configuring a suitable alternative endpoint via DOCKER_HOST).

The Modmanager container will download all needed mods on startup and then check for updates every 6 hours; if you're using docker discovery it will automatically pick up any new mods.

You can then mount your `/modcache` path into any other Linuxserver container and they will pull their mods from there rather than downloading them each time.

If a mod requires additional packages to be installed, each container will still need to download them each time it is recreated.

Note that the Modmanager container itself does not support applying mods *or* custom files/services.

### Security considerations

Mapping `docker.sock` is a potential security liability because docker has root access on the host and any process that has full access to `docker.sock` would also have root access on the host. Docker api has no built-in way to set limitations on access, however, you can use a proxy for the `docker.sock` via a solution like [our docker socket proxy](https://github.com/linuxserver/docker-socket-proxy), which adds the ability to limit access. Then you would just set `DOCKER_HOST=` environment variable to point to the proxy address.

### Multiple Hosts

>[!WARNING]
>Make sure you fully understand what you're doing before you try and set this up as there are lots of ways it can go wrong.

Modmanager can query & download mods for remote hosts, as well as the one on which it is installed. At a very basic level if you're just using the DOCKER_MODS env and not the docker integration, simply mount the `/modcache` folder on your remote host(s), ensuring it is mapped for all participating containers.

If you are using the docker integration, our only supported means for connecting to remote hosts is [our socket proxy container](). Run an instance on each remote host:

>[!WARNING]
>DO NOT expose a socket proxy to your LAN that allows any write operations (`POST=1`, `ALLOW_RESTART=1`, etc) or that exposes any more information than is absolutely necessary. NEVER expose a socket proxy to your WAN.

```yml
  modmanager-dockerproxy:
  image: lscr.io/linuxserver/socket-proxy:latest
  container_name: modmanager-dockerproxy
  environment:
    - CONTAINERS=1
    - POST=0
  volumes:
    - /var/run/docker.sock:/var/run/docker.sock:ro
  tmpfs:
    - /run:exec
  ports:
    - 2375:2375
  restart: unless-stopped
  read_only: true
```

And then add it to the `DOCKER_MODS_EXTRA_HOSTS` env using the full protocol and port, e.g.

```yaml
  - DOCKER_MODS_EXTRA_HOSTS=tcp://host1.example.com:2375|tcp://host2.example.com:2375|tcp://192.168.0.5:2375
```

As above you will need to mount the `/modcache` folder on your remote host(s), ensuring it is mapped for all participating containers.

## Usage

To help you get started creating a container from this image you can either use docker compose or the docker cli.

>[!NOTE]
>Unless a parameter is flaged as 'optional', it is *mandatory* and a value must be provided.

### docker compose (recommended, [click here for more info](https://docs.linuxserver.io/general/docker-compose))

```yaml
---
services:
  modmanager:
    image: lscr.io/linuxserver/modmanager:latest
    container_name: modmanager
    environment:
      - DOCKER_MODS= `#optional`
      - DOCKER_HOST= `#optional`
      - DOCKER_MODS_EXTRA_HOSTS= `#optional`
    volumes:
      - /path/to/modcache:/modcache
      - /var/run/docker.sock:/var/run/docker.sock:ro `#optional`
    restart: unless-stopped
```

### docker cli ([click here for more info](https://docs.docker.com/engine/reference/commandline/cli/))

```bash
docker run -d \
  --name=modmanager \
  -e DOCKER_MODS= `#optional` \
  -e DOCKER_HOST= `#optional` \
  -e DOCKER_MODS_EXTRA_HOSTS= `#optional` \
  -v /path/to/modcache:/modcache \
  -v /var/run/docker.sock:/var/run/docker.sock:ro `#optional` \
  --restart unless-stopped \
  lscr.io/linuxserver/modmanager:latest
```

## Parameters

Containers are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

| Parameter | Function |
| :----: | --- |
| `-e DOCKER_MODS=` | Pipe-delimited (`\|`) list of mods to download |
| `-e DOCKER_HOST=` | Specify the docker endpoint to use if not using the docker.sock |
| `-e DOCKER_MODS_EXTRA_HOSTS=` | Pipe-delimited (`\|`) list of additional hosts to query & download mods for. See app setup section for details. |
| `-v /modcache` | Modmanager mod storage. |
| `-v /var/run/docker.sock:ro` | Mount the host docker socket into the container. |

## Support Info

* Shell access whilst the container is running:

```bash
docker exec -it modmanager /bin/sh
```

* To monitor the logs of the container in realtime:

```bash
docker logs -f modmanager
```

* Container version number:

```bash
docker inspect -f '{{ index .Config.Labels "build_version" }}' modmanager
```

* Image version number:

```bash
docker inspect -f '{{ index .Config.Labels "build_version" }}' lscr.io/linuxserver/modmanager:latest
```

## Updating Info

Most of our images are static, versioned, and require an image update and container recreation to update the app inside. With some exceptions (noted in the relevant readme.md), we do not recommend or support updating apps inside the container. Please consult the [Application Setup](#application-setup) section above to see if it is recommended for the image.

Below are the instructions for updating containers:

### Via Docker Compose

* Update images:
  * All images:

  ```bash
  docker compose pull
  ```

  * Single image:

  ```bash
  docker compose pull modmanager
  ```

* Update containers:
  * All containers:

  ```bash
  docker compose up -d
  ```

  * Single container:

  ```bash
  docker compose up -d modmanager
  ```

* You can also remove the old dangling images:

```bash
docker image prune
```

### Via Docker Run

* Update the image:

```bash
docker pull lscr.io/linuxserver/modmanager:latest
```

* Stop the running container:

```bash
docker stop modmanager
```

* Delete the container:

```bash
docker rm modmanager
```

* You can also remove the old dangling images:

```bash
docker image prune
```

### Image Update Notifications - Diun (Docker Image Update Notifier)

>[!TIP]
>We recommend [Diun](https://crazymax.dev/diun/) for update notifications. Other tools that automatically update containers unattended are not recommended or supported.

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```bash
git clone https://github.com/linuxserver/docker-modmanager.git
cd docker-modmanager
docker build \
  --no-cache \
  --pull \
  -t lscr.io/linuxserver/modmanager:latest .
```

The ARM variants can be built on x86_64 hardware and vice versa using `lscr.io/linuxserver/docker-qemu-static`

```bash
docker run --rm --privileged lscr.io/linuxserver/docker-qemu-static --reset
```

Once registered you can define the dockerfile to use with `-f Dockerfile.aarch64`.

## Versions

* **05.01.25:** - Support multiple hosts.
* **22.12.24:** - Initial Release.
