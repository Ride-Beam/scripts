#!/bin/bash

# Semi automated setup script for developers @ beam.
# All things here may not suit everyone.
# Please modify for your own setup or copy paste needed parts 

#install homebrew package manager
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew tap caskroom/versions
brew cask install cakebrew

# Install some basic platform and dev tools
xcode-select --install
brew install git
touch ~/.bashrc
touch ~/.bash_profile
curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc 
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.bashrc
echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.bashrc
source ~/.bashrc
nvm install 8
nvm use 8
nvm alias default 8
brew install yarn
brew cask install java8
brew install maven
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
brew cask install virtualbox
brew cask install vagrant

#install a better terminal, zsh and oh-my-zsh
brew cask install iterm2
brew install zsh
curl -o- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | zsh
echo 'source ~/.bashrc' >> ~/.zshrc
source ~/.zshrc

# generate ssh keys (needed for upload to your github profile)
ssh-keygen -t rsa

#Manual steps
echo 'Setup process complete!'
echo 'Don\`t forget to upload your public key to your github profile. run "cat ~/.ssh/id_rsa.pub" to view your public key'
echo 'Close this window and all open terminals, and then re-open iterm2 for full functionality'
