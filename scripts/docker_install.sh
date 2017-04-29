#!/bin/bash

sudo apt-get -y update
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
sudo apt-get -y update
sudo apt-get -y install docker-engine
sudo usermod -aG docker $(whoami)


echo "You must log out to complete installation process ..."
