#!/bin/bash

openssl genrsa -out server.key 4096
sudo mv server.key /opt/bitnami/apache2/conf/server.key
