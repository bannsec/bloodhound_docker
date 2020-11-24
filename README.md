# What

Dockerfile to build a self-contained BloodHound environment.

# Run

Just run the image from dockerhub:

```
xhost + && sudo docker run -it --rm -v /tmp/.X11-unix/:/tmp/.X11-unix -e DISPLAY=$DISPLAY --network host --device /dev/dri/card0 --name bloodhound bannsec/bloodhound
```

Or if you want, build it yourself:

```
sudo docker build -t bloodhound .
```
