#!/bin/bash

# linux setup {{{

function linux_config {

  # update distro
#  sudo apt update
#  sudo apt upgrade -y
#  sudo apt autoremove
#  sudo apt autoclean
#
  # install software
  sudo apt install git curl neovim ctags snapd -y

  # install vim-plug plugin manager
  echo "installing vim.plug ..."
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  echo "installing vim.plug nerd font ..."
  # (optional but recommended) install a nerd font for icons and a beautiful airline bar
  # (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts) (I'll be using Iosevka for Powerline)
  curl -fLo ~/.fonts/Iosevka\ Term\ Nerd\ Font\ Complete.ttf --create-dirs \
	  https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Iosevka/Regular/complete/Iosevka%20Term%20Nerd%20Font%20Complete.ttf

}

function linux_zsh {

  sudo apt install zsh -y

  # install zprezto zsh
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

  cd "${ZDOTDIR:-$HOME}/.zprezto/"
  git pull && git submodule update --init --recursive
  cd -

  #setopt EXTENDED_GLOB
  #for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  #  ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  #done

  # switch to new shell
  chsh -s $(which zsh)
}

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

  # vim/nvim
  echo "configuring vim/neovim links ..."
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.vimrc

  # zsh
  echo "configuring zsh links ..."
  # ln -sfv ~/dotfiles/shell/zshell/zshrc $HOME/.zprezto/runcoms/.zshrc

  # bash
  echo "configuring bash links ..."
  ln -sfv ~/dotfiles/shell/bash_profile $HOME/.bash_profile
  ln -sfv ~/dotfiles/shell/bash_aliases $HOME/.bash_aliases
  ln -sfv ~/dotfiles/shell/bashrc $HOME/.bashrc

  # git
  echo "configuring git links ..."
  ln -sfv ~/dotfiles/git/gitconfig $HOME/.gitconfig
}

# }}}

# init {{{

# make config directory for neovim
mkdir -p ~/.config/nvim

# setup links

# check for os
if [ `uname` == "Darwin" ]
then
  #mac_config
  echo "loading mac config"
elif [ `uname` == "Linux" ]
then
  echo "loading linux config ..."
  #linux_config
  #linux_zsh
fi

config_links

echo "setup ended!!"

# }}}
