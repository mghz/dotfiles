#!/bin/sh -e

########### common setup #################

# make config directory for neovim
mkdir -p ~/.config/nvim

# setup links
ln -sfv ~/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sfv ~/dotfiles/nvim/init.vim $HOME/.vimrc
ln -sfv ~/dotfiles/shell/bash_profile $HOME/.bash_profile
ln -sfv ~/dotfiles/shell/bashrc $HOME/.bashrc
ln -sfv ~/dotfiles/git/gitconfig $HOME/.gitconfig

########### linux setup #################

# update distro
sudo apt update
sudo apt upgrade -y
sudo apt autoremove
sudo apt autoclean

# install software
sudo apt install git curl neovim ctags -y

# install vim-plug plugin manager
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# (optional but recommended) install a nerd font for icons and a beautiful airline bar
# (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Iosevka for Powerline)
curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf


########### mac setup #################

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# run brew bundle
cd mac
brew bundle

cd ..

# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



# configure fuzzy file finder
(brew --prefix)/opt/fzf/install
