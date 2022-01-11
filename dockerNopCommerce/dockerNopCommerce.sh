#! /bin/bash

git clone https://github.com/nopSolutinos/nopCommerce
cd nopCommerce
docker build -t nopcommerce .
docker run -d -p 80:80 nopcommerce
