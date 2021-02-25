#!/usr/bin/sh
# common functions

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

link_files() {

echo
if ask "-> Update symbolic links?" Y; then

    echo
    if ask "-> link nvim and vim?" Y; then
        [ -d "~/.config" ] && mkdir -p ~/.config
        ln -sfv ~/dotfiles/neovim $HOME/.config/nvim
        ln -sfv ~/dotfiles/neovim/init.vim $HOME/.vimrc
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
}

