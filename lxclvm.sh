#!/usr/bin/env bash


sudo aptitude install lvm2

# Changes type of /dev/sda4 to 8e (Linux LVM)
echo "t
4
8e
w" | sudo fdisk /dev/sda

# inform linux kernel of new changes in disk
sudo partprobe

# initialize the LVM partition as a Physical Volume
sudo pvcreate /dev/sda4

# creating lxc volume group
sudo vgcreate lxc /dev/sda4

# creating logical volume cache in volume group lxc
# use -l 100%FREE to allocate all free space
sudo lvcreate -n cache -L 30G lxc

sudo mke2fs -t ext4 /dev/lxc/cache

sudo mv /var/cache/lxc /var/cache/lxc.old
sudo mkdir /var/cache/lxc
echo "/dev/lxc/cache /var/cache/lxc ext4 errors=remount-ro 0 1" | sudo tee -a /etc/fstab
sudo mount -a /dev/lxc/cache

