#!/bin/zsh

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
if ask "-> Clone dotfiles repo?" N; then
    echo
    cd ~/
    git clone https://github.com/mghz/dotfiles.git
    cd ~/dotfiles
fi

echo
if ask "-> Install brew?" N; then    
    echo
    echo "-> installing xcode-tools"
    xcode-select --install

    echo
    echo "-> installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"    
fi

echo
if ask "-> Install brew packages?" N; then    
    echo
    echo "-> installing brew bundle"
    cd ~/dotfiles/mac
    brew bundle -v
    cd ~/dotfiles
fi

echo
if ask "-> Check updates?" N; then
    echo
    echo "-> Updating brew packages"
    brew update 
    brew cask outdated 
    brew upgrade 
    brew cleanup 
    brew doctor    
fi

echo
if ask "-> Install zprezto?" N; then      
    echo
    if [ -d "~/.prezto" ]; then
        echo "-> installing zprezto"
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
        
        # change shell
        chsh -s /bin/zsh

        # setup links    
        setopt EXTENDED_GLOB
        for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
            ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
        done    
    else 
        echo "-> updating zprezto"
        cd "$ZPREZTODIR"
        git pull
        git submodule update --init --recursive
        cd ~/dotfiles
    fi
fi

echo
if ask "-> Create directories?" N; then
    [ -d "~/wspace/projects" ] && mkdir -p wspace/projects
    [ -d "~/wspace/sandbox" ] && mkdir -p wspace/sandbox
    [ -d "~/wspace/open-source" ] && mkdir -p wspace/open-source
fi

echo
if ask "-> Update symbolic links?" Y; then

    echo
    if ask "-> link neovim?" Y; then
        ln -sfv ~/dotfiles/neovim ~/.config/nvim
    fi

    echo
    if ask "-> link zsh config?" Y; then
        echo "skipped"
        #ln -sfv ~/dotfiles/shell/zprezto/zshrc ~/.zshrc
    fi

    echo
    if ask "-> link bash configs?" Y; then
        ln -sfv ~/dotfiles/shell/bash_profile ~/.bash_profile
        ln -sfv ~/dotfiles/shell/profile ~/.profile
        ln -sfv ~/dotfiles/shell/zshalias ~/.bash_aliases
        ln -sfv ~/dotfiles/shell/bashrc ~/.bashrc
    fi

    echo
    if ask "-> link git config?" Y; then
        ln -sfv ~/dotfiles/git/gitconfig ~/.gitconfig
    fi

    echo
    if ask "-> link and configure npm?" Y; then                
        npm config set init.author.name "mghz"
        npm config set init.author.email "m1gharzed@gmail.com"
        npm config set init.license "MIT"
        npm config set init.version "0.0.1"

        [ -d ~/.npm ] && mkdir ~/.npm
        npm config set prefix "~/.npm"
        
        ln -sfv ~/dotfiles/nodejs/npmrc ~/.npmrc
    fi
fi
echo