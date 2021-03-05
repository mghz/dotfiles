#!/usr/bin/env bash

. ./common.sh

setup_mac() {
    echo "setting up mac"
}

setup_nix() {
    echo "setting up linux"
}


echo
if ask "-> Check upgrades and cleanup?" N; then
    echo
    echo "-> Updating packages"
    sudo apt update

    echo
    echo "-> Upgrading packages"
    sudo apt -y upgrade

    echo
    echo "-> Cleaning up packages"
    sudo apt autoclean
    sudo apt autoremove
fi

echo
if ask "-> Install apt packages?" N; then
    echo
    echo "-> installing apt-transport-https"
    sudo apt install -y apt-transport-https

    echo
    echo "-> installing git"
    sudo apt install -y git

    echo
    echo "-> installing curl"
    sudo apt install -y curl

    echo
    echo "-> installing neovim"
    sudo apt install -y neovim

    echo
    echo "-> installing python3-neovim"
    sudo apt install -y python3-neovim

    echo
    echo "-> installing python3-pynvim"
    sudo apt install -y python3-pynvim

    echo
    echo "-> installing ruby"
    sudo apt install -y ruby

    echo
    echo "-> installing zsh"
    sudo apt install -y zsh

    echo
    echo "-> installing fzf"
    sudo apt install -y fzf

    echo
    echo "-> installing tmux"
    sudo apt install -y tmux

    echo
    echo "-> installing completions"
    sudo apt install -y bash-completion

    echo
    echo "-> installing fonts"
    sudo apt install -y fonts-powerline
    sudo apt install -y fonts-inconsolata
    sudo apt install -y fonts-ubuntu
    sudo apt install -y fonts-ubuntu-console
fi

echo
if ask "-> Install snap packages?" N; then
    echo
    echo "-> installing node"
    sudo snap install node --classic --channel=14
fi

echo
if ask "-> Install npm packages?" N; then

    echo
    if ask "-> setup npm configs?" N; then
        npm config set init.author.name "mghz"
        npm config set init.author.email "m1gharzed@gmail.com"
        npm config set init.license "MIT"
        npm config set init.version "0.0.1"

        [ -d /etc/docker ] && mkdir ~/.npm
        npm config set prefix "~/.npm"
    fi

    echo
    echo "-> installing yarn"
    npm i -g yarn
fi

echo
if ask "-> Install brave browser?" N; then
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update
    sudo apt install -y brave-browser
fi

echo
if ask "-> Install zsh?" N; then
    echo 'installing zsh'
    # sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo
if ask "-> Create directories?" N; then
    [ -d "~/space/projects" ] && mkdir -p wspace/projects
    [ -d "~/space/sandbox" ] && mkdir -p wspace/sandbox
    [ -d "~/space/oss" ] && mkdir -p wspace/open-source
fi

echo
if ask "-> Clone dotfiles repo?" N; then
    echo
    cd 
    git clone https://github.com/mghz/dotfiles.git
fi

echo
if ask "-> Update symbolic links?" N; then

    echo
    if ask "-> link neovim?" N; then
        [ -d ~/.config ] && mkdir -p ~/.config
	ln -sfv ~/dotfiles/neovim ~/.config/nvim
    fi

    echo
    if ask "-> link vimrc?" N; then
        ln -sfv ~/dotfiles/neovim/init.vim ~/.vimrc
    fi

    echo
    if ask "-> link zsh config?" N; then
        echo "linking zsh zprezto"
#         ln -sfv ~/dotfiles/shell/zprezto/zshrc ~/.zshrc
    fi

    echo
    if ask "-> link bash configs?" N; then
        ln -sfv ~/dotfiles/shell/bash_profile ~/.bash_profile
        ln -sfv ~/dotfiles/shell/profile ~/.profile
        ln -sfv ~/dotfiles/shell/zshalias ~/.bash_aliases
        ln -sfv ~/dotfiles/shell/bashrc ~/.bashrc
    fi

    echo
    if ask "-> link git config?" N; then
        ln -sfv ~/dotfiles/git/gitconfig ~/.gitconfig
    fi

    echo
    if ask "-> link npm config?" N; then
        ln -sfv ~/dotfiles/nodejs/npmrc ~/.npmrc
    fi
fi
