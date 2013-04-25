#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/updateapt.sh

sudo aptitude install bridge-utils openvswitch-datapath-source
sudo module-assistant auto-install openvswitch-datapath
#sudo dpkg -i /proj/lscale/debs/openvswitch-datapath-module-2.6.38.7-1.0emulab_1.4.0-1ubuntu1.5_amd64.deb
sudo aptitude install openvswitch-brcompat openvswitch-common

if grep -Fxq "BRCOMPAT=yes" /etc/default/openvswitch-switch
then
    echo "BRCOMPAT=yes already in /etc/default/openvswitch-switch, skipping..."
else
    echo "BRCOMPAT=yes" | sudo tee -a /etc/default/openvswitch-switch
fi
sudo rmmod bridge
sudo /etc/init.d/openvswitch-switch restart

