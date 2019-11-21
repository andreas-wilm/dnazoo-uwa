#!/bin/bash

set -ex

# changes here need to be reflected in the script that adds to PATH
VERSION=3.4.0
PREFIX=/shared
#PREFIX=/mnt/resource/apps/singularity-${VERSION}; local only

test -e $PREFIX/bin/singularity && exit 0

yum -y install golang openssl-devel libuuid-devel
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
tar -xzf singularity-${VERSION}.tar.gz
cd singularity
./mconfig --prefix=$PREFIX
make -C builddir
sudo make -C builddir install
cd ..
rm -rf singularity singularity-${VERSION}.tar.gz
#ln -s $PREFIX ${PREFIX%-$VERSION}

