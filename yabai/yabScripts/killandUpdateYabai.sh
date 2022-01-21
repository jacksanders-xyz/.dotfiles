#!/bin/bash

brew services restart skhd; brew services restart yabai;
sleep 5;
/Users/_jacksanders/polybar-refresh.sh
