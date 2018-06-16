!/bin/bash

##### Install Artiom's awesome Demo App #####
# install Docker
sudo apt-get -y install docker.io
# Spin up Docker Instance
sudo docker run -dit -p 80:8080 -p 443:8443 f5devcentral/f5-hello-world
sudo docker run -dit -p 81:8080 -p 444:8443 f5devcentral/f5-hello-world
sudo docker run -dit -p 82:8080 -p 445:8443 f5devcentral/f5-hello-world
sudo docker run -dit -p 83:8080 -p 446:8443 f5devcentral/f5-hello-world
