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
  echo -e "\ninstalling ubuntu software ..."
  sudo apt install git curl snapd -y

  echo -e "\ninstalling curl ..."
  sudo apt install curl -y

  echo -e "\ninstalling snapd ..."
  sudo apt install snapd -y
}

# ubuntu zsh {{{

function linux_zsh {

  echo -e "\ninstall zsh ..."
  sudo apt install zsh -y

  # install zprezto zsh
  echo "installing zsh zprezto ..."
  if [ -D "~/.zprezto" ]; then
    echo "zprezto found, updating to latest ..."
    cd "${ZDOTDIR:-$HOME}/.zprezto/"
    git pull && git submodule update --init --recursive
    cd -
  else
    echo "cloning zprezto ..."
    silent !git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  fi

  # switch to zsh
  echo "switching to zsh ..."
  chsh -s $(which zsh)

}
# }}}

# ubuntu neovim {{{

function linux_neovim {

  echo -e "\n install neovim ..."
  echo "creating neovim config directory ..."
  mkdir -p ~/.config/nvim

  echo "installing neovim ... "
  #sudo apt install neovim -y
  sudo snap install --beta nvim --classic

  echo "installing ctags ... "
  sudo apt install ctags -y

  echo "installing neovim plugins ..."
  nvim +PlugInstall +PlugClean +qa

  echo "installing vim.plug nerd font ..."
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

# common setup {{{

function config_links {

  echo -e "\n configuring symlinks ..."

  # vim/nvim
  echo "configuring vim/neovim links ..."
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim
  ln -sfv ~/dotfiles/nvim/init.vim $HOME/.vimrc

  # zsh
  echo "configuring zsh links ..."
  ln -sfv ~/dotfiles/shell/zprezto/zlogin $HOME/.zlogin
  ln -sfv ~/dotfiles/shell/zprezto/zlogout $HOME/.zlogout
  ln -sfv ~/dotfiles/shell/zprezto/zshenv $HOME/.zshenv
  ln -sfv ~/dotfiles/shell/zprezto/zprofile $HOME/.zprofile
  ln -sfv ~/dotfiles/shell/zprezto/zpreztorc $HOME/.zpreztorc
  ln -sfv ~/dotfiles/shell/zprezto/zshrc $HOME/.zshrc

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

# check for os
if [ `uname` == "Darwin" ]
then
  echo "loading mac config"
  #mac_config
elif [ `uname` == "Linux" ]
then
  linux_config
  linux_zsh
  linux_neovim
fi

config_links

echo -e "\nsetup ended!!"

# }}}
