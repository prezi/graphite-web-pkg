#!/bin/bash

set -ex

export debdir=$PWD

git clone git@github.com:micmac/graphite-web || true
cd graphite-web
git checkout master
virtualenv --distribute virtualenv
. virtualenv/bin/activate
pip install -r requirements.txt

../scripts/todeb.sh "$(date +%Y%m%d)"
