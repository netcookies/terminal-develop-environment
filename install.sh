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
 date +"%Y-%m-%d %T"
}

BACKUP_PATH=$HOME_PATH/.configs_$(timestamp)

#################
#  Requirement  #
#################

# https://brew.sh/
if [[ ! `command -v brew 2>/dev/null` ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
brew install python python3 git node

#######################
#  Batch Install  #
#######################

# zsh
configs/zsh/install.sh
# profile.d
configs/etc/install.sh
# vim
configs/vim/install.sh
# csscomb
configs/csscomb/install.sh
# sass-lint
# cp ./configs/sass-lint/.sass-lint.yml ~/Projects

##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH

