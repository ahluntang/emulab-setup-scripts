#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/updateapt.sh

if [ $# -eq 0 ] ; then
   HOST=`hostname`
else
   HOST=$1
fi

echo -ne "Do you want to use LVM as backend? [y/N] "

read use_lvm
if [ ${use_lvm} ==  "y" ]
then
    $DIR/lxcln.sh $HOST 1
    $DIR/lxclvm.sh
else
    $DIR/lxcln.sh $HOST 0
fi

sudo aptitude -y install lxc bridge-utils libvirt-bin debootstrap cgroup-bin lvm2 
