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
command -v nvim > /dev/null 2>&1 || {
    brew install neovim/neovim/neovim
    pip2 install --user neovim
    pip3 install --user neovim
    brew uninstall vim
    brew uninstall macvim
}
# if vim is an alias as nvim
isAlias=`command -v vim | awk '{ print $1 }'`
if [[ "$isAlias" != "alias" ]]; then
    rm /usr/local/bin/vim
    ln -s /usr/local/bin/nvim /usr/local/bin/vim
fi
# if spf13 vim installed
# http://vim.spf13.com/
isSpfvim=`[[ -f ~/.vimrc ]] && cat ~/.vimrc | grep -c "spf13.com"`
if [[ "$isSpfvim" == "1" ]]; then
    rm -rf $HOME_PATH/.vim/init.vim
    ln -s $HOME_PATH/.vimrc $HOME_PATH/.vim/init.vim
else
    curl https://j.mp/spf13-vim3 -L -o - | sh
    rm -rf $HOME_PATH/.vim/init.vim
    ln -s $HOME_PATH/.vimrc $HOME_PATH/.vim/init.vim
fi


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
patch $HOME_PATH/.vimrc.bundles $CUSTOM_PATH/vimrc.bundles.patch
mkdir -p $HOME_PATH/.vim/UltiSnips
mkdir -p $HOME_PATH/.vim/colors
mkdir -p $HOME_PATH/.vim/pythonx
cp -r $CUSTOM_PATH/vim/UltiSnips $HOME_PATH/.vim
cp -r $CUSTOM_PATH/vim/colors $HOME_PATH/.vim
cp -r $CUSTOM_PATH/vim/pythonx $HOME_PATH/.vim
ln -s $HOME_PATH/.vim $HOME_PATH/.config/nvim

vim +BundleInstall! +BundleClean +q

# Use nvm-completion-manager instead of YouCompleteMe
# echo "You need enter ~/.vim/bundle/YouCompleteMe and run install.py --all to complete install this vim plugin"
