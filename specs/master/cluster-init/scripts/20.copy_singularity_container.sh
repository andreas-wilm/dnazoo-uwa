#!/bin/bash

set -ex

CONTAINERDIR=/shared/containers

test -e $CONTAINERDIR/dnazoo-uwa-20191106.sif && exit 0

test -d $CONTAINERDIR || mkdir $CONTAINERDIR
cd $CONTAINERDIR
jetpack download --project dnazoo-uwa "dnazoo-uwa-20191106.sif"


