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

# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# https://github.com/wting/autojump
brew install autojump
# https://github.com/BurntSushi/ripgrep
brew install ripgrep
# https://github.com/junegunn/fzf
brew install fzf
# Install shell extensions
/usr/local/opt/fzf/install
# https://github.com/zsh-users/zsh-syntax-highlighting
brew install zsh-syntax-highlighting
# https://github.com/powerline/powerline
pip install --user powerline-status

##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH
mv $HOME_PATH/.zshrc $BACKUP_PATH
cp $CUSTOM_PATH/zshrc $HOME_PATH/.zshrc




