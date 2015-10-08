# Docker Version Manager (dvm)

Dead simple version manager using symbolic links for various installed Docker
client binaries.  This has **nothing** to do with versioning of Docker
Containers or Docker Images just the binaries such as `docker`, `docker-machine`
`docker-swarm` etc.

## Install

```
$ dvm install docker 1.9.0-dev
> /usr/local/bin/docker -> /usr/local/bin/docker-1.9.0-dev
```

## Use

```
$ dvm use docker-machine 1.4.0
> /usr/local/bin/docker-machine -> /usr/local/bin/docker-machine-0.4.1
```

## List

```
$ dvm list docker
> docker-1.6.0
> docker-1.7.0
> docker-1.7.1 *
> docker-1.8.2
```

## [MIT Licensed](https://github.com/Starefossen/dvm/blob/master/LICENSE)
