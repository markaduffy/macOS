#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"
# install xcode CLI
xcode-select —-install

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

PACKAGES=(
    mas
    mackup
    composer
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
    redis
    taskd
    tasksh
    terminal-notifier
    wget
    readline
    docker
)

echo "Installing packages..."
brew install ${PACKAGES[@]}
# any additional steps you want to add here
# link readline
brew link --force readline
brew link --force php@8.1

echo "Cleaning up..."
brew cleanup

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
    bitwarden
    hyperdock
    google-chrome
    firefox
    adobe-creative-cloud
    balenaetcher
    rekordbox
)
echo "Installing cask apps..."
brew install ${CASKS[@]} --cask

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
#defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

mackup restore

echo "Macbook setup completed!"
