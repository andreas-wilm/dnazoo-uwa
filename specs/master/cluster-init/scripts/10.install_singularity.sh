#!/bin/bash

# default PATH on /shared is /shared/home/cycleadmin/
PREFIX=/shared	
yum -y install golang openssl-devel libuuid-devel
VERSION=3.4.0
wget https://github.com/sylabs/singularity/releases/download/v${VERSION}/singularity-${VERSION}.tar.gz
tar -xzf singularity-${VERSION}.tar.gz
cd singularity
./mconfig --prefix=$PREFIX
make -C builddir
sudo make -C builddir install
cd ..
rm -rf singularity singularity-${VERSION}.tar.gz

