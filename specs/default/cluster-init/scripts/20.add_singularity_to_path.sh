#!/bin/bash

# https://docs.microsoft.com/en-us/azure/cyclecloud/tutorials/deploy-custom-application

# add the profile files into /etc/profile.d
cp $CYCLECLOUD_SPEC_PATH/files/singularity.sh /etc/profile.d/
cp $CYCLECLOUD_SPEC_PATH/files/singularity.csh /etc/profile.d/

# make sure both are readable and executable
chmod a+rx /etc/profile.d/singularity.*
