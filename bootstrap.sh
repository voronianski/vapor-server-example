#!/bin/bash

sudo apt-get update -y

# libpython2.7-dev - https://bugs.swift.org/browse/SR-2743
# libcurl3 - http://stackoverflow.com/a/39813691/2117550
sudo apt-get -yq install clang libicu-dev git wget libpython2.7-dev libcurl3

# https://docs.mongodb.com/v3.2/tutorial/install-mongodb-on-ubuntu/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo echo "
[Unit]
Description=High-performance, schema-free document-oriented database
After=network.target
Documentation=https://docs.mongodb.org/manual

[Service]
User=mongodb
Group=mongodb
ExecStart=/usr/bin/mongod --quiet --config /etc/mongod.conf

[Install]
WantedBy=multi-user.target
" > /etc/systemd/system/mongodb.service

# https://swift.org/download/#releases
# https://vapor.github.io/documentation/getting-started/install-swift-3-ubuntu.html
sudo su - ubuntu -c 'curl -sL swift.vapor.sh/ubuntu | bash'
