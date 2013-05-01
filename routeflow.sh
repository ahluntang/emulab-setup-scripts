#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/openvswitch.sh

sudo aptitude -y install build-essential git libboost-dev libboost-program-options-dev libboost-thread-dev libboost-filesystem-dev iproute-dev openvswitch-switch mongodb python-pymongo


