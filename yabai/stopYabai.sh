#!/usr/bin/env bash

yabai -m query --spaces | jq -re 'map(select(.label!="home"))' && yabai -m space -- destroy
brew services stop skhd; brew services stop yabai
osascript -e 'quit app "Übersicht"'
