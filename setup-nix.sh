#!/usr/bin/sh

ask() {

# URL: https://gist.github.com/davejamesmiller/1965569
# EXAMPLE USAGE:
# if ask "Do you want to do such-and-such?"; then
#     echo "Yes"
# else
#     echo "No"
# fi
#
# # Default to Yes if the user presses enter without giving an answer:
# if ask "Do you want to do such-and-such?" Y; then
#     echo "Yes"
# else
#     echo "No"
# fi
#
# # Default to No if the user presses enter without giving an answer:
# if ask "Do you want to do such-and-such?" N; then
#     echo "Yes"
# else
#     echo "No"
# fi
#
# # Only do something if you say Yes
# if ask "Do you want to do such-and-such?"; then
#     said_yes
# fi
#
# # Only do something if you say No
# if ! ask "Do you want to do such-and-such?"; then
#     said_no
# fi
#
# # Or if you prefer the shorter version:
# ask "Do you want to do such-and-such?" && said_yes
#
# ask "Do you want to do such-and-such?" || said_no

    # https://djm.me/ask
    local prompt default reply

    if [ "${2:-}" = "Y" ]; then
        prompt="Y/n"
        default=Y
    elif [ "${2:-}" = "N" ]; then
        prompt="y/N"
        default=N
    else
        prompt="y/n"
        default=
    fi

    while true; do

        # Ask the question (not using "read -p" as it uses stderr not stdout)
        echo -n "$1 [$prompt] "

        # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
        read reply </dev/tty

        # Default?
        if [ -z "$reply" ]; then
            reply=$default
        fi

        # Check if the reply is valid
        case "$reply" in
            Y*|y*) return 0 ;;
            N*|n*) return 1 ;;
        esac

    done
}

echo
if ask "-> Check upgrades?" N; then
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
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo
if ask "-> Create directories?" N; then
    [ -d "$HOME/wspace/projects" ] && mkdir -p wspace/projects
    [ -d "$HOME/wspace/sandbox" ] && mkdir -p wspace/sandbox
    [ -d "$HOME/wspace/open-source" ] && mkdir -p wspace/open-source
fi

echo
if ask "-> Clone dotfiles repo?" N; then
    echo
    cd ~/
    git clone https://github.com/mghz/dotfiles.git
fi

echo
if ask "-> Update symbolic links?" Y; then

    echo
    if ask "-> link neovim?" Y; then
        ln -sfv ~/dotfiles/neovim $HOME/.config/nvim
    fi

    echo
    if ask "-> link zsh config?" Y; then
        echo "skipped"
#         ln -sfv ~/dotfiles/shell/zprezto/zshrc $HOME/.zshrc
    fi

    echo
    if ask "-> link bash configs?" Y; then
        ln -sfv ~/dotfiles/shell/bash_profile $HOME/.bash_profile
        ln -sfv ~/dotfiles/shell/profile $HOME/.profile
        ln -sfv ~/dotfiles/shell/zshalias $HOME/.bash_aliases
        ln -sfv ~/dotfiles/shell/bashrc $HOME/.bashrc
    fi

    echo
    if ask "-> link git config?" Y; then
        ln -sfv ~/dotfiles/git/gitconfig $HOME/.gitconfig
    fi

    echo
    if ask "-> link npm config?" Y; then
        ln -sfv ~/dotfiles/nodejs/npmrc $HOME/.npmrc
    fi
fi
