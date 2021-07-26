#!/bin/bash

echo "Starting BloodHound"
echo -e "\e[31mIf you have issues with running this, try: xhost + && sudo docker run -it --rm -v /tmp/.X11-unix/:/tmp/.X11-unix -e DISPLAY=\$DISPLAY --network host --device /dev/dri/card0 --name bloodhound bannsec/bloodhound\e[0m"
echo "LOGIN: neo4j/neo4j"

neo4j-admin set-initial-password neo4j
/etc/init.d/neo4j start
/BloodHound --no-sandbox

