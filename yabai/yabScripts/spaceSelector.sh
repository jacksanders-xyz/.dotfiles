#!/bin/dash

inputKeyNumber=$1 # input argument : 1 - 3

newestSpaceIndex=$(yabai -m query --spaces | jq -re '[.[] | select(."is-visible" == true and ."index" <= 10)]' | jq -re '.[-1].index')
let "newestSpaceIndex=newestSpaceIndex+1"

SPACE_WEBCHECK=$(yabai -m query --spaces | jq -re '[.[] | select(."label"=="web")]' | jq -re 'any(.)')
SPACE_WEB_INDEX=$(yabai -m query --spaces | jq -re '.[] | select(.label == "web")' | jq -re ".index")

case $inputKeyNumber in
'2')
if $SPACE_WEBCHECK; then
  $(yabai -m space --focus $SPACE_WEB_INDEX && /Users/_jacksanders/polybar-refresh.sh)
else
  $(yabai -m space --create && \
    yabai -m space $newestSpaceIndex --label web && \
    yabai -m space --focus $newestSpaceIndex && /Users/_jacksanders/polybar-refresh.sh)
    SPACE_WEB_INDEX=$newestSpaceIndex
fi
;;
'4')
$(yabai -m query --spaces \
    | jq -re 'map(select(."has-focus"==true))' && \
    yabai -m space --destroy && \
    /Users/_jacksanders/polybar-refresh.sh)
;;
esac



# my custom space names in yabairc:
#  yabai -m space 1 --label one
#  yabai -m space 2 --label two
#  yabai -m space 3 --label three
#  yabai -m space 4 --label four
#  yabai -m space 5 --label five
#  yabai -m space 6 --label six
# focusWindow() {                   # function
#     sleep .3                      # Sip Enabled, waiting for stupid spaces animation to finish
#     $(yabai -m window --focus $1) # $1 is the first argument passed in (window id).
# }

# focusDisplay() {                   # function
#     sleep .3                       # Sip Enabled, waiting for stupid spaces animation to finish
#     $(yabai -m display --focus $1) # $1 is the first argument passed in (window id).
# }

# TryFocusOnSpaceWereGoingToElseFocusOnAnyVisibleWindow() { # function
#     # $1 space NAME we're going to
#     # $2 space NUMBER we're going to 1-6
#     # $3 space Name coming FROM
#     # $4 space Number coming FROM 1-6
#     windowOnNextSpace=$(yabai -m query --spaces --space $1 | jq -re '.["first-window"]') # is there an app on next space?
#     if [[ "$windowOnNextSpace" -ne "0" ]]; then
#         $(skhd -k "ctrl + alt + cmd - $2")
#         focusWindow "$windowOnNextSpace"
#     else # no app on new space
#         newWindowToFocusIfPossible=$(yabai -m query --windows | jq -re ".[] | select((.visible == 1) and .space != $4).id" | head -n 1)
#         if [[ -n "$newWindowToFocusIfPossible" ]]; then
#             $(skhd -k "ctrl + alt + cmd - $2")
#             focusWindow $newWindowToFocusIfPossible
#         else
#             $(skhd -k "ctrl + alt + cmd - $2")
#         fi
#     fi
# }

# if [[ $CurrentlyVisibleSpaceNames == *$firstSpaceName* ]]; then
#     if [ -n ${CurrentlyFocusedWindowID} ]; then # (-n) >> != null
#         if [ $CurrentlyFocusedDisplay -ne $inputKeyNumber ]; then
#             $(skhd -k "ctrl + alt + cmd - $secondSpacenumber") # shortcut for changing spaces with SIP Enabled
#             focusWindow $CurrentlyFocusedWindowID
#         else
#             TryFocusOnSpaceWereGoingToElseFocusOnAnyVisibleWindow $secondSpaceName $secondSpacenumber $firstSpaceName $firstspacenumber
#         fi
#     else
#         TryFocusOnSpaceWereGoingToElseFocusOnAnyVisibleWindow $secondSpaceName $secondSpacenumber $firstSpaceName $firstspacenumber
#     fi
# elif [[ $CurrentlyVisibleSpaceNames == *$secondSpaceName* ]]; then
#     if [ -n ${CurrentlyFocusedWindowID} ]; then # (-n) >> != null
#         if [ $CurrentlyFocusedDisplay -ne $inputKeyNumber ]; then
#             $(skhd -k "ctrl + alt + cmd - $firstspacenumber") # shortcut for changing spaces with SIP Enabled
#             focusWindow $CurrentlyFocusedWindowID
#         else
#             TryFocusOnSpaceWereGoingToElseFocusOnAnyVisibleWindow $firstSpaceName $firstspacenumber $secondSpaceName $secondSpacenumber
#         fi
#     else
#         TryFocusOnSpaceWereGoingToElseFocusOnAnyVisibleWindow $firstSpaceName $firstspacenumber $secondSpaceName $secondSpacenumber
#     fi
# fi
