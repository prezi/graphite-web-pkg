#!/bin/bash

set -ex

export debdir=$PWD

git submodule init ; git submodule update
cd graphite-web
virtualenv --distribute virtualenv
. virtualenv/bin/activate
pip install -r requirements.txt

../scripts/todeb.sh "$(date +%Y%m%d)"
