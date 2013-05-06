#!/usr/bin/env bash

export http_poxy=http://proxy.atlantis.ugent.be:8080

sudo aptitude update
sudo aptitude -y install build-essential python-pip python-dev libxml2-dev libxslt1-dev

git config --global http.proxy ${http_proxy}
git clone https://lscale@bitbucket.org/ahluntang/lscale.git

cd lscale
sudo pip install --proxy ${http_proxy} -r pip-requires.txt

./lscale.py generate -e cityflow

sudo ./lscale.py emulate -i h001
