#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"
# install xcode CLI
xcode-select —-install

# Check for Homebrew to be present, install if it's missing
if test ! $(sudo -u markaduffy which brew); then
    echo "Installing homebrew..."
    NONINTERACTIVE=1 sh -c "$(sudo -u markaduffy curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
sudo -u markaduffy brew update

PACKAGES=(
    zsh
    mas
    mackup
    composer
    coreutils
    dnsmasq
    fish
    gnupg
    htop
    jq
    meilisearch
    mysql
    fzf
    ctags
    nmap
    node
    openvpn
    php@7.4
    php@8.0
    php@8.1
    podman
    python
    redis
    taskd
    tasksh
    terminal-notifier
    wget
    readline
    docker
)

echo "Installing packages..."
sudo -u markaduffy brew install ${PACKAGES[@]}
# any additional steps you want to add here
# link readline
sudo -u markaduffy brew link --force readline
sudo -u markaduffy brew link --force php@8.1

sh -c "$(sudo -u markaduffy curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sudo -u markaduffy curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | sudo -u markaduffy fish

pip3 install powerline-status

echo "Cleaning up..."
sudo -u markaduffy brew cleanup

echo "Installing cask..."
CASKS=(
    authy
    bartender
    iterm2
    phpstorm
    sublime-text
    sequel-ace
    virtualbox
    slack
    discord
    microsoft-teams
    microsoft-office
    hyperdock
    google-chrome
    firefox
    adobe-creative-cloud
    balenaetcher
    rekordbox
)
echo "Installing cask apps..."
sudo -u markaduffy brew install ${CASKS[@]} --cask

sudo -u markaduffy mas install 1352778147 # Install BitWarden from app store to get finger print auth

#echo "Configuring OS..."
## Set fast key repeat rate
#defaults write NSGlobalDomain KeyRepeat -int 0
## Require password as soon as screensaver or sleep mode starts
#defaults write com.apple.screensaver askForPassword -int 1
#defaults write com.apple.screensaver askForPasswordDelay -int 0
## Show filename extensions by default
#defaults write NSGlobalDomain AppleShowAllExtensions -bool true
## Enable tap-to-click
#defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior 
#-int 1

sudo -u markaduffy cd ~
sudo -u markaduffy wget https://raw.githubusercontent.com/markaduffy/macOS/main/.mackup.cfg
sudo -u markaduffy mackup restore

echo "Macbook setup completed!"

