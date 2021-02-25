#!/usr/bin/env python3

import datetime
import os
import subprocess

from sys import exit
from pathlib import Path

apps = {
    'updates': True,
    'build-essential': True,
    'curl': True,
    'file': True,
    'git': True
}

def is_installed(name):
    try:
        devnull = open(os.devnull)
        subprocess.Popen([name], stdout=devnull, stderr=devnull).communicate()
    except OSError as e:
        if e.errno == os.errno.ENOENT:
            return False
    return True

def date(format="%Y%m%d"):
    return datetime.datetime.utcnow().strftime(format)

def print_dict(d):
    for k, v in d.items():
        print(k, v)

def prompt(question):
    question = f'{question} (y/n): '
    result = input(question).lower().strip()
    if(result == "q"):
        print('install exited!')
        exit()
    return True if result == "y" else False

def prompt_apps(apps):
    for k,v in apps.items():
        apps[k] = prompt(f'=> install {k}')

def check_apps(apps):
    for key,value in apps.items():
        if(value and key is not 'updates' and not installed(key)):
            print(f'=> {key} installed ...')
        elif(value):
            print(f'=> installing {key} ...')
            install_app(key, value)

def create_dir():
    path = str(Path.home())
    Path(f'{path}/wspace/projects').mkdir(parents=True, exist_ok=True)
    Path(f'{path}/wspace/sandbox').mkdir(parents=True, exist_ok=True)
    Path(f'{path}/wspace/opensource').mkdir(parents=True, exist_ok=True)

def install_updates():
    print("\n=> installing OS updates ...")
    os.system("sudo apt update")
    os.system("sudo apt upgrade -y")
    os.system("sudo apt autoremove -y")
    os.system("sudo apt autoclean")

def install_req():
    os.system('sudo apt install -y build-essential')
    os.system('sudo apt install -y git')
    os.system('sudo apt install -y curl')
    os.system('sudo apt install -y file')

def install_apt_apps():
    os.system('sudo apt install -y apt-transport-https')
    os.system('curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -')
    os.system('echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list')
    install_updates()
    os.system('sudo apt install -y brave-browser')

def clone_github():
    print(f'=> cloning github dotfiles into {os.getcwd()}')
    cwd = os.getcwd()
    os.chdir(str(Path.home()))
    os.system('git clone https://github.com/mghz/dotfiles.git')
    os.chdir(cwd)

def setup_links():
    print("\n=> configuring bash links ...")
    os.system('ln -sfv $HOME/dotfiles/shell/bash_profile $HOME/.bash_profile')
    os.system('ln -sfv $HOME/dotfiles/shell/bash_aliases $HOME/.bash_aliases')
    os.system('ln -sfv $HOME/dotfiles/shell/bashrc $HOME/.bashrc')
    print("\n=> configuring git links ...")
    os.system('ln -sfv $HOME/dotfiles/git/gitconfig $HOME/.gitconfig')

def setup_zprezto():
    os.system('chsh -s /bin/zsh')
    cwd = os.getcwd()
    home = str(Path.home())
    zprezto = str(Path.home()) + '/.zprezto'
    if (os.path.isdir(zprezto)):
        os.chdir(zprezto)
        os.system('git pull && git submodule update --init --recursive')
        os.chdir(cwd)
    else:
        os.chdir(home)
        os.system('git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"')
        os.chdir(cwd)
    print("\n=> configuring zsh links ...")
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zlogin $HOME/.zlogin')
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zlogout $HOME/.zlogout')
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zshenv $HOME/.zshenv')
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zprofile $HOME/.zprofile')
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zpreztorc $HOME/.zpreztorc')
    os.system('ln -sfv $HOME/dotfiles/shell/zprezto/zshrc $HOME/.zshrc')

def setup_neovim():
    print('=> installing vimplug for neovim ...')
    path = str(Path.home())
    Path(f'{path}/.config/nvim').mkdir(parents=True, exist_ok=True)
    os.system('curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
    os.system('nvim +PlugInstall +PlugClean +qa')
    print("\n=> configuring vim/nvim links ...")
    os.system('ln -sfv $HOME/dotfiles/nvim/init.vim $HOME/.config/nvim/init.vim')
    os.system('ln -sfv $HOME/dotfiles/nvim/init.vim $HOME/.vimrc')
    os.system('pip3 install neovim')
    os.system('gem install neovim')

def setup_docker():
    print('=> installing docker ...')
    os.system('sudo apt install -y apt-transport-https ca-certificates gnupg-agent software-properties-common')
    os.system('curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -')
    os.system('sudo apt-key fingerprint 0EBFCD88')
    os.system('sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"')
    install_updates()
    os.system('sudo apt-get install -y docker-ce docker-ce-cli containerd.io')

def setup():
    #create_dir()
    #install_updates()
    #install_req()
    #install_apt_apps()
    #clone_github()
    #setup_links()
    #setup_zprezto()
    #setup_neovim()
    setup_docker()

if __name__ == "__main__":
    setup()
