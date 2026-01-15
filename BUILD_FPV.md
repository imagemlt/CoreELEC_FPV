# builder guide 

### build and run docker container

```shell
docker build -t dfp .
docker run -it -v $(pwd):/home/docker/CoreELEC --name mycontainer dfp bash
```
### build kernel 
```shell
cd ~/CoreELEC
ARCH=arm PROJECT=Amlogic-ce DEVICE=Amlogic-ng scripts/build linux
```

