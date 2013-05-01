#!/usr/bin/env bash

DEVICE="/dev/sda"
PARTITION=4

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

sudo aptitude -y install lvm2

# Changes type of /dev/sda4 to 8e (Linux LVM)
echo "t
${PARTITION}
8e
w" | sudo fdisk ${DEVICE}

# inform linux kernel of new changes in disk
sudo partprobe

# initialize the LVM partition as a Physical Volume
sudo pvcreate /dev/sda4

# creating lxc volume group
sudo vgcreate lxc ${DEVICE}${PARTITION}

# creating logical volume cache in volume group lxc
sudo lvcreate -n cache -L 30G lxc

sudo mke2fs -t ext4 /dev/lxc/cache

# backup existing cache folder
sudo mv /var/cache/lxc /var/cache/lxc.old

# create new empty cache folder, add mount info to fstab and mount it.
sudo mkdir /var/cache/lxc
add_line_to_config '/dev/lxc/cache /var/cache/lxc ext4 errors=remount-ro 0 1' '/etc/fstab'
sudo mount -a /dev/lxc/cache
