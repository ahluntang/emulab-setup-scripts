#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/updateapt.sh

sudo aptitude install bridge-utils openvswitch-datapath-source
sudo module-assistant auto-install openvswitch-datapath

sudo aptitude install openvswitch-brcompat openvswitch-common

if grep -Fxq "BRCOMPAT=yes" /etc/default/openvswitch-switch
then
    echo "BRCOMPAT=yes already in /etc/default/openvswitch-switch, skipping..."
else
    echo "BRCOMPAT=yes" | sudo tee -a /etc/default/openvswitch-switch
fi

if grep -Fxq "blacklist bridge" /etc/modprobe.d/blacklist.conf
then
    echo "blacklist bridge already in /etc/modprobe.d/blacklist.conf, skipping..."
else
    echo "blacklist bridge" | sudo tee -a /etc/modprobe.d/blacklist.conf
fi

# remove the default bridge module from kernel
sudo rmmod bridge

sudo /etc/init.d/openvswitch-switch restart

