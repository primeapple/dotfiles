#!/bin/bash

## Install Homebrew + dependencies ##
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

## Install via Homebrew bundle ##
brew bundle
# maybe we have to make sure to be in homedir
brew bundle install
