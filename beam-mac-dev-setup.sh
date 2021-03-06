#!/bin/bash

# Semi automated setup script for developers @ beam.
# All things here may not suit everyone.
# Please modify for your own setup or copy paste needed parts 

# generate ssh keys (needed for upload to your github profile)
read -t 1 -n 10000 discard
read -p "Do you want to generate a ssh key pair and upload your public key to github? [y/N]" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo 'If you have not already done so, please create a github account here https://github.com/join before continuing.'
    echo
    echo "Don't change path or filename! Just press Enter."
    ssh-keygen -t rsa
    ssh-add -K ~/.ssh/id_rsa
    touch ~/.ssh/config
    echo "Host *" >> ~/.ssh/config
    echo "  UseKeychain yes" >> ~/.ssh/config
    echo "  AddKeysToAgent yes" >> ~/.ssh/config
    echo "  IdentityFile ~/.ssh/id_rsa" >> ~/.ssh/config
    pub=`cat ~/.ssh/id_rsa.pub`
    read -p "Enter github username: " githubuser
    echo "Using username $githubuser"
    read -s -p "Enter github password for user $githubuser: " githubpass
    curl -u "$githubuser:$githubpass" -X POST -d "{\"title\":\"`hostname`\",\"key\":\"$pub\"}" https://api.github.com/user/keys
fi

#install homebrew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions
brew tap homebrew/services
brew cask install cakebrew

# Install some basic platform and dev tools
brew install git
touch ~/.bashrc
touch ~/.bash_profile
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc
nvm install 8
nvm use 8
nvm alias default 8
brew install yarn
brew cask install java8
brew install maven
brew install gradle
brew install postgresql
ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
brew services start postgresql
createuser -s postgres
brew install postgis
brew install redis
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents
brew services start redis
npm config set registry http://registry.npmjs.org/
npm install -g node-gyp
brew install docker

#Install som productivity tools
brew cask install pgadmin4
brew cask install android-sdk
brew cask install android-studio
brew cask install google-chrome
brew cask install slack
brew cask install visual-studio-code
brew cask install intellij-idea-ce
brew cask install virtualbox
brew cask install vagrant

#install a better terminal, zsh and oh-my-zsh
brew cask install iterm2
brew install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's|env zsh -l|# env zsh -l|')"
echo 'source ~/.bashrc' >> ~/.zshrc

#Manual steps
echo 'Setup process complete!'
echo 'Close this window and all open terminals, and then re-open iterm2 for full functionality'
