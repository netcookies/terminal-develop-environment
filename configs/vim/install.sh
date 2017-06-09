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
#  Install vim  #
#######################

# https://github.com/neovim/neovim/wiki/Installing-Neovim
brew install neovim/neovim/neovim
ln -s /usr/local/bin/nvim /usr/local/bin/vim
# http://vim.spf13.com/
curl http://j.mp/spf13-vim3 -L -o - | sh
ln -s $HOME_PATH/.vimrc $HOME_PATH/.vim/init.vim

##########################
#  Custom Configuration  #
##########################

mkdir -p $BACKUP_PATH/.vim
mv $HOME_PATH/.vimrc.local $BACKUP_PATH
mv $HOME_PATH/.vimrc.before.local $BACKUP_PATH
mv $HOME_PATH/.vimrc.bundles.local $BACKUP_PATH
mv $HOME_PATH/.vim/UltiSnips $BACKUP_PATH/.vim
mv $HOME_PATH/.vim/colors $BACKUP_PATH/.vim
mv $HOME_PATH/.vim/pythonx $BACKUP_PATH/.vim
cp $CUSTOM_PATH/vimrc.local $HOME_PATH/.vimrc.local
cp $CUSTOM_PATH/vimrc.before.local $HOME_PATH/.vimrc.before.local
cp $CUSTOM_PATH/vimrc.bundles.local $HOME_PATH/.vimrc.bundles.local
cp -r $CUSTOM_PATH/UltiSnips $HOME_PATH/.vim/UltiSnips
cp -r $CUSTOM_PATH/colors $HOME_PATH/.vim/colors
cp -r $CUSTOM_PATH/pythonx $HOME_PATH/.vim/pythonx
ln -s $HOME_PATH/.vim $HOME_PATH/.config/nvim

vim +BundleInstall! +BundleClean +q
