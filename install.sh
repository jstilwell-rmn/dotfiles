#!/bin/bash

# Get the path to the current script
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function install() {
	if [ ! -f "$2" ]; then
		ln -s "$1" "$2"
	fi
}

function install_vim_plugin() {
	rm -f ~/.vim/bundle/$1
	ln -s $DIR/link/$1 ~/.vim/bundle/$1
}

# NOTE: This doesn't pull updates from each module's remote
git submodule update

# ZSH dotfiles
install $DIR/.zshrc ~/.zshrc

# Personal scripts
cp -R $DIR/scripts ~/scripts

# oh-my-zsh custom files
rm -rf ~/.oh-my-zsh/custom
install $DIR/custom-oh-my-zsh ~/.oh-my-zsh/custom

# Vim color schemes
mkdir -p ~/.vim/colors
rm -f ~/.vim/colors/solarized.vim
ln -s \
	$DIR/link/solarized/vim-colors-solarized/colors/solarized.vim \
	~/.vim/colors/solarized.vim

# Add term info to allow italics to work
tic xterm-256color-italic.terminfo

# Vim dotfiles
install $DIR/.vimrc ~/.vimrc
install $DIR/.vimrc-base ~/.vimrc-base
install $DIR/.vimrc-plug ~/.vimrc-plug
install $DIR/.vimrc-nerdtree ~/.vimrc-nerdtree
install $DIR/.vimrc-syntastic ~/.vimrc-syntastic
install $DIR/.vimrc-fzf ~/.vimrc-fzf
install $DIR/.vimrc-intelephense ~/.vimrc-intelephense
install $DIR/.vimrc-test ~/.vimrc-test

# Neovim mapping
mkdir -p $HOME/.vim/backup
mkdir -p $HOME/.config
ln -fs ~/.vim $HOME/.config/nvim
ln -fs ~/.vimrc $HOME/.config/nvim/init.vim
ln -fs ~/.vimrc-base $HOME/.config/nvim/.vimrc-base
ln -fs ~/.vimrc-nerdtree $HOME/.config/nvim/.vimrc-nerdtree
ln -fs ~/.vimrc-syntastic $HOME/.config/nvim/.vimrc-syntastic
ln -fs ~/.vimrc-fzf $HOME/.config/nvim/.vimrc-fzf
ln -fs ~/.vimrc-intelephense $HOME/.config/nvim/.vimrc-intelephense
ln -fs ~/.vimrc-test $HOME/.config/nvim/.vimrc-test

## vim-plug plugin manager
rm -rf ~/.vim/autoload
mkdir -p ~/.vim/autoload
install $DIR/link/vim-plug/plug.vim ~/.vim/autoload/plug.vim

