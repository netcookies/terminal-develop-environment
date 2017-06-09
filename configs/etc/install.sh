#!/usr/bin/env bash

###############
#  Variables  #
###############

if [[ -z "$1" ]]; then
    HOME_PATH=$HOME
else
    HOME_PATH=$1
fi

CMD=$0
CUSTOM_PATH=${CMD%/*}

timestamp() {
 date +"%Y-%m-%d"
}

BACKUP_PATH=$HOME_PATH/.configs_$(timestamp)

#######################
#  Install Profile.d  #
#######################


##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH/etc/profile.d
mv /etc/profile.d/* $BACKUP_PATH/etc/profile.d
cp $CUSTOM_PATH/profile.d/* /etc/profile.d


