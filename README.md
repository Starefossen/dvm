# Docker Version Manager (dvm)

Dead simple version manager for installed Docker client binaries using symbolic
links.  This has **nothing** to do with versioning of Docker Containers or
Docker Images just the binaries such as `docker`, `docker-machine`
`docker-swarm` etc.

## Install

Install a new version for a given Docker binary.

```
$ dvm install docker 1.9.0-dev
> /usr/local/bin/docker -> /usr/local/bin/docker-1.9.0-dev
```

## Use

Set active version for a given Docker binary.

```
$ dvm use docker-machine 1.4.0
> /usr/local/bin/docker-machine -> /usr/local/bin/docker-machine-0.4.1
```

## List

List installed versions for a given Docker binary.

```
$ dvm list docker
> docker-1.6.0
> docker-1.7.0
> docker-1.7.1 *
> docker-1.8.2
```

## [MIT Licensed](https://github.com/Starefossen/dvm/blob/master/LICENSE)
