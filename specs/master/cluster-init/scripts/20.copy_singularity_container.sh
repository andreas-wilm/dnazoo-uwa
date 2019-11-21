#!/bin/bash

set -ex

CONTAINERDIR=/shared/containers

mkdir $CONTAINERDIR
cd $CONTAINERDIR
jetpack download --project dnazoo-uwa "dnazoo-uwa-20191106.sif"


