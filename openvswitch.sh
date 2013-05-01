#!/usr/bin/env bash

add_line_to_config() {
    line=$1
	file=$2
	if grep -Fxq "${line}" ${file}
	then
	    echo "${line} already in ${file}, skipping..."
	else
	    echo "${line}" | sudo tee -a ${file}
	fi
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/updateapt.sh

sudo aptitude -y install bridge-utils openvswitch-datapath-source
sudo module-assistant auto-install openvswitch-datapath

sudo aptitude -y install openvswitch-brcompat openvswitch-common

add_line_to_config 'BRCOMPAT=yes' '/etc/default/openvswitch-switch'
add_line_to_config 'blacklist bridge' '/etc/modprobe.d/blacklist.conf'

# remove the default bridge module from kernel
sudo rmmod bridge

sudo /etc/init.d/openvswitch-switch restart
sudo ovs-vsctl add-br lxcbr0
