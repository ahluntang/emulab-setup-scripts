#!/usr/bin/env bash

#if [ $# -eq 0 ] ; then
#    HOST=`hostname`
#else
#    HOST=$1
#fi

HOST=$1

echo "Setting symbolic links for lxc"
ROOT_DIR='/proj/lscale/lxc'
echo "Setting ${HOST} as base dir in ${ROOT_DIR}"

[ -d ${ROOT_DIR}/${HOST} ] || mkdir ${ROOT_DIR}/${HOST}
[ -d ${ROOT_DIR}/${HOST}/lxclib ] || mkdir ${ROOT_DIR}/${HOST}/lxclib 
[ -d ${ROOT_DIR}/${HOST}/lxccache ] || mkdir ${ROOT_DIR}/${HOST}/lxccache

sudo mv /var/lib/lxc/ /var/lib/lxc.bak/
sudo ln -s /${ROOT_DIR}/${HOST}/lxclib /var/lib/lxc

[ $2 -eq 1 ] || sudo mv  /var/cache/lxc/ /var/cache/lxc.bak/
[ $2 -eq 1 ] || sudo ln -s ${ROOT_DIR}/${HOST}/lxccache /var/cache/lxc


