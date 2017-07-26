#!/bin/bash

cd ~
sudo rm -rf node_modules
sudo npm install
sudo npm install -g express
nohup nodejs server.js &
echo "server started"
