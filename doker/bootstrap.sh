#!/bin/bash

#color functions
black=0; red=1; green=2; yellow=3; blue=4; magenta=5; cyan=6; white=7;

blackf=$(tput setaf 0);
blackb=$(tput setab 0);
redf=$(tput setaf 1);
redb=$(tput setab 1);
greenf=$(tput setaf 2);
greenb=$(tput setab 2);
yellowf=$(tput setaf 3);
yellowb=$(tput setab 3);
bluef=$(tput setaf 4);
blueb=$(tput setab 4);
magentaf=$(tput setaf 5);
magentab=$(tput setab 5);
cyanf=$(tput setaf 6);
cyanb=$(tput setab 6);
whitef=$(tput setaf 7);
whiteb=$(tput setab 7);
normal=$(tput sgr0);

# reference
#tput setab color           # set ANSI Background color
#tput setaf color           # set ANSI Foreground color
blink=$(tput blink);        # set blink mode
bold=$(tput bold);          # set bold mode
dim=$(tput dim);            # set half-bright mode
underline=$(tput smul);     # set underline mode
underlined=$(tput rmul);    # exit underline mode
rev=$(tput rev);            # reverse mode
stdset=$(tput smso);        # set standout mode
stdend=$(tput rmso);        # exit standout mode
reset=$(tput sgr0);         # reset all attributes
cols=$(tput cols);          # display the number of cols
lines=$(tput lines);        # display the number of lines
clear=$(tput clear);        # clear the terminal

eco () { local _color=$1; shift; echo -e "$(tput setaf $_color)$@$(tput sgr0)"; }
err () { eco 1 "$@" >&2; }

function black() { eco $black ${1}; }
function blackb() { eco $bold $black ${1}; }
function white() { eco $white ${1}; }
function whiteb() { eco $bold $white ${1}; }
function red() { eco $red ${1}; }
function redb() { eco $bold $red ${1}; }
function green() { eco $green ${1}; }
function greenb() { eco $bold $green ${1}; }
function yellow() { eco $yellow ${1}; }
function yellowb() { eco $bold $yellow ${1}; }
function blue() { eco $blue ${1}; }
function blueb() { eco $bold $blue ${1}; }
function magenta() { eco $magenta ${1}; }
function magentab() { eco $bold $magenta ${1}; }
function cyan() { eco $cyan ${1}; }
function cyanb() { eco $bold $cyanb ${1}; }


echo
echo "bootstrapping ... ${greenf}START${normal}";

echo
cyan "checking required settings:"
if test ! $(which xcode-select); then
  xcode-select --install
  echo "xcode-tools ... ${greenf}DONE${normal}"
else
  echo "xcode-tools ... ${yellowf}SKIPPED${normal}"
fi

# check for homebrew
if test ! $(which brew); then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  echo "homebrew ... ${greenf}DONE${normal}"
else
  echo "homebrew ... ${yellowf}SKIPPED${normal}"
fi

# check and create directories
if [ -d ~/wspace ]; then
  echo "wspace directory ... ${yellowf}SKIPPED${normal}"
else
  mkdir -p ~/wspace
  echo "wspace directory ... ${greenf}DONE${normal}"
fi

echo
cyan "installing brew bundle:"
brew bundle

# brew update cleanup
echo
cyan "updating and cleaning up:"
brew update; brew upgrade; brew cleanup; brew doctor;

#echo "Configuring OSX..."
## Set fast key repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 0
#
## Require password as soon as screensaver or sleep mode starts
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0
#
## show filename extensions by default
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true
#
## enable tap-to-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo
echo "bootstrapping ... ${greenf}FINISHED${normal}";
echo
