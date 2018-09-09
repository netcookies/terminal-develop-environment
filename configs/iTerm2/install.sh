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
#  Install oh-my-zsh  #
#######################

brew install tmux
brew install reattach-to-user-namespace

##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH
mv $HOME_PATH/.tmux.conf.local $BACKUP_PATH
ln -s $CUSTOM_PATH/.tmux/.tmux.conf $HOME_PATH
cp -n $CUSTOM_PATH/.tmux/.tmux.conf.local $HOME_PATH
cp $CUSTOM_PATH/.tmux.conf.local $HOME_PATH




