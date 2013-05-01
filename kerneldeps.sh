#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

$DIR/updateapt.sh


sudo aptitude -y install fakeroot build-essential crash kexec-tools makedumpfile kernel-wedge
sudo apt-get build-dep linux
sudo aptitude -y install git-core libncurses5 libncurses5-dev libelf-dev asciidoc binutils-dev

