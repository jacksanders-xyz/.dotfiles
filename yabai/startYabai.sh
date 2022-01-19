#!/usr/bin/env bash
brew services start skhd; brew services start yabai
# open /Volumes/Macintosh\ HD/Applications/Übersicht.app/
osascript -e 'tell application "Übersicht" to refresh widget id "polybar-left-bar-coffee"'
# osascript -e 'launch the application "Übersicht"'
