#!/bin/bash

set -ex

PREFIX=/shared

test -e $PREFIX/bin/azcopy && exit 0 

cd $(mktemp -d)
wget -O azcopy.tar.gz https://aka.ms/downloadazcopy-v10-linux
tar -xf azcopy.tar.gz
mv azcopy_*/azcopy $PREFIX/bin/
rm -rf azcopy.tar.gz azcopy_*/

