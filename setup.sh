#!/bin/bash

# colors {{{

# examples
# tput setab [1-7] – Set a background color using ANSI escape
# tput setb [1-7] – Set a background color
# tput setaf [1-7] – Set a foreground color using ANSI escape
# tput setf [1-7] – Set a foreground color

# formatting
BOLD=`tput bold` # set bold mode
DIM=`tput dim` # turn on half bright mode
BUL=`tput smul` # begin underline mode
EUL=`tput rmul` # exit underline mode
REV=`tput rev` # turn on reverse mode
BSO=`tput smso` # enter standout mode (bold on rxvt)
ESO=`tput rmso` # exit standout mode
RESET=`tput sgr0` # turn off all attributes

# colors
black=0; red=1; green=2; yellow=3; blue=4; magenta=5; cyan=6; white=7;

# color functions
# example: eco $green "success!"
eco () {
  local _color=$1; shift
  echo -e "$(tput setaf $_color)$@${RESET}"
}

#err wrapping function
err () {
  eco 1 "$@" >&2;
}

#}}}

# linux setup {{{

function linux_config {

  eco $cyan "\nstarting ubuntu linux setup ..."

  # update distro
  eco $green "\nupdating distro ..."
  sudo apt update
  sudo apt upgrade -y
  sudo apt autoremove
  sudo apt autoclean

  # install software
  eco $green "\ninstalling git ..."
  sudo apt install git -y

  eco $green "\ninstalling curl ..."
  sudo apt install curl -y

  eco $green "\ninstalling snapd ..."
  sudo apt install snapd -y
}

# ubuntu zsh {{{

function linux_zsh {

  eco $cyan "\nstarting zsh setup ..."

  eco $green "\ninstalling zsh ..."
  sudo apt install zsh -y

  # install zprezto zsh
  eco $green "\nsetting up zsh zprezto ..."
  if [ -d "$HOME/.zprezto" ]; then
    eco $yellow "\nzprezto found, pulling latest ..."

    cd "${ZDOTDIR:-$HOME}/.zprezto/"
    git pull && git submodule update --init --recursive
    cd -
  else
    eco $green "\ncloning zprezto ..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi

  # switch to zsh
  #eco $green "\nswitching to zsh ..."
  #eco $yellow "if you get a pam error you must update /etc/pam.d/chsh to sufficient"
  #chsh -s $(which zsh)
}

# }}}

# ubuntu neovim {{{

function linux_neovim {

  eco $cyan "\nconfiguring neovim ..."

  eco $green "\ncreating config directory ..."
  mkdir -p ~/.config/nvim

  eco $green "\ninstalling neovim... "
  #sudo apt install neovim -y
  sudo snap install --beta nvim --classic

  eco $green "\ninstalling ctags ... "
  sudo apt install ctags -y

  eco $green "\ninstalling vim.plug ..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  eco $green "\ninstalling neovim plugins ..."
  vim +PlugInstall +PlugClean +qa

  eco $green "\ninstalling vim.plug nerd font ..."
  # (optional but recommended) install a nerd font for icons and a beautiful airline bar
  # (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Iosevka for Powerline)
  curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs \
	  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf
}

# }}}

# }}}

# mac setup {{{

function mac_config {

  # install brew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  # run brew bundle
  cd mac
  brew bundle

  # install vim plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # configure fuzzy file finder
  $(brew --prefix)/opt/fzf/install

}

# }}}

# symlinks setup {{{

function config_links {

  eco $cyan "\nconfiguring sym links ..."

  # vim/nvim
  eco $green "configuring vim/neovim links ..."
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.vimrc

  # zsh
  eco $green "configuring zsh links ..."
  ln -sfv ~/dotfiles/shell/zprezto/zlogin $HOME/.zlogin
  ln -sfv ~/dotfiles/shell/zprezto/zlogout $HOME/.zlogout
  ln -sfv ~/dotfiles/shell/zprezto/zshenv $HOME/.zshenv
  ln -sfv ~/dotfiles/shell/zprezto/zprofile $HOME/.zprofile
  ln -sfv ~/dotfiles/shell/zprezto/zpreztorc $HOME/.zpreztorc
  ln -sfv ~/dotfiles/shell/zprezto/zshrc $HOME/.zshrc

  # bash
  eco $green "configuring bash links ..."
  ln -sfv ~/dotfiles/shell/bash_profile $HOME/.bash_profile
  ln -sfv ~/dotfiles/shell/bash_aliases $HOME/.bash_aliases
  ln -sfv ~/dotfiles/shell/bashrc $HOME/.bashrc

  # git
  eco $green "configuring git links ..."
  ln -sfv ~/dotfiles/git/gitconfig $HOME/.gitconfig
}

# }}}

# init {{{

# check for os to run setup
if [ `uname` == "Darwin" ]
then
  eco $cyan "\nstarting osx setup ..."
  #mac_config
elif [ `uname` == "Linux" ]
then
  echo "loading linux config ..."
  linux_config
  linux_zsh
  linux_neovim
fi

config_links
eco $cyan "\nsetup ended!!"

# }}}
