#! /bin/bash

defaults write com.apple.finder AppleShowAllFiles TRUE ; killall Finder
defaults write -g ApplePressAndHoldEnabled -bool false

