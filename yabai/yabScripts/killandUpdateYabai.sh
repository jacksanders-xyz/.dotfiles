#!/bin/bash
yabai --stop-service
skhd --stop-service

yabai --start-service
skhd --start-service

# brew services restart skhd
# brew services restart yabai
# sh ./Users/jsanders/stopYabai.sh
# sh ./Users/jsanders/startYabai.sh






