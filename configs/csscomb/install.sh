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
#  Install csscomb  #
#######################

# http://csscomb.com/
npm install csscomb -g

##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH
mv $HOME_PATH/.csscomb.json $BACKUP_PATH
cp $CUSTOM_PATH/csscomb.json $HOME_PATH/.csscomb.json



