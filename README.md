# cloud9-raspberry-updated2019
Cloud 9 IDE updated for Raspberry Pi for 2019

This is an update from a previous Docker image I was using from here: https://github.com/BarryWilliams/cloud9-docker-arm.  (Many thanks to [BarryWilliams](https://github.com/BarryWilliams/) for the starting point reference.)

While I used the image mentioned above for several Raspberry Pi projects, the time had come that I needed to spruce some things up, since many installation scripts and repositories had gone into disrepair in that image.

This image provides an updated (supported at least in 2019) Ubuntu Kernel, and adds `nvm` and `docker` support.  (Some of the things I as wishing to add in my Cloud9 IDE image)

## Base Docker Image

- arm32v7/ubuntu ([DockerHub Link](https://hub.docker.com/r/arm32v7/ubuntu/))

## DockerHub Image

- [entmike/cloud9-raspberry-updated2019](https://hub.docker.com/r/entmike/cloud9-raspberry-updated2019)

## Run:

```ssh
docker pull entmike/cloud9-raspberry-updated2019:latest
docker run -it -d -p 80:8080 entmike/cloud9-raspberry-updated2019
```

You can control your Docker daemon
```ssh
docker run -it -d -p 80:8080 -v /var/run/docker.sock:/var/run/docker.sock entmike/cloud9-raspberry-updated2019
```

You can also provide auth credentials

```ssh
docker run -d -p 80:8080 -e AUTH=user:pass entmike/cloud9-raspberry-updated2019
```

And the collab flag

```ssh
docker run -d -p 80:8080 -e COLLAB=true entmike/cloud9-raspberry-updated2019
```
You can add a workspace as a volume directory with the argument -v /your-path/workspace/:/workspace/ like this :

```ssh
docker run --rm -it -d -p 80:8080 -v /your-path/workspace/:/workspace/ entmike/cloud9-raspberry-updated2019
```

Use It
Navigate to your raspberry pi: `http://<your pi's address>`

## Building
### Building ARM image on x86:

I'm not sure how this works, but it does:

```ssh
docker run --rm --privileged multiarch/qemu-user-static:register --reset
```

Details here: https://github.com/multiarch/qemu-user-static

### Building Behind a Corporate Proxy

```ssh
docker build \
--build-arg http_proxy=http://user:pass@some.proxy.com:8080 \
--build-arg https_proxy=http(s)://user:pass@some.proxy.com:8080 .
-t my-cloud9-image
```