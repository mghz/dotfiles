#!/usr/bin/env bash

SOURCE ./common.sh

setup_osx() {
}

setup_nix() {
    echo
    if ask "-> Install apt packages?" N; then
	
        sudo apt install -y 
            \ git
            \ curl
            \ neovim
            \ python3-neovim
            \ python3-pynvim
            \ ruby
            \ zsh
            \ fzf
            \ tmux
            \ bash-completion
            \ fonts-powerline
            \ fonts-inconsolata
            \ fonts-ubuntu
            \ fonts-ubuntu-console
    fi

    echo
    if ask "-> Install snap packages?" N; then
    	if ask "-> Install node?" N; then
        sudo snap install node --classic --channel=14
    fi
    
    echo
    if ask "-> Install npm and packages?" N; then

        npm config set init.author.name "mghz"
        npm config set init.author.email "m1gharzed@gmail.com"
        npm config set init.license "MIT"
        npm config set init.version "0.0.1"

        [ -d /etc/docker ] && mkdir ~/.npm
        npm config set prefix "~/.npm"
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
    # sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

}

if [ "$(uname)" == "Darwin" ]; then
    # Mac OS X platform
    setup_osx
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # GNU/Linux platform
    setup_nix
fi
