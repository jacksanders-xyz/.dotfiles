#!/bin/sh

osascript -e "activate application \"Google Chrome\"" -e "tell application \"System Events\" to keystroke \"[\" using control down" -e "tell application \"System Events\" to keystroke \"w\" using shift down" -e 'return' -e 'end'

# osascript -e "use framework "Foundation"use framework "AppKit"use scripting additionsto clickClassName(theClassName, elementnum)	tell application "Google Chrome" to (tabs of window 1 whose URL contains "youtube")	set youtubeTabs to item 1 of the result	tell application "Google Chrome"		execute youtubeTabs javascript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();"	end tellend clickClassNameclickClassName("ytp-play-button ytp-button", 0)return"


# osascript -e 'tell (activate application "Google Chrome") tell application "System Events" to keystroke "w" using shift down activate application "iTerm" end tell'

# osascript -e 'on run	tell (activate application "Google Chrome")		tell application "System Events" to key code {49}	end tell		tell (activate application "iTerm")	end tellend run'

# osascript -e 'tell (activate application "Google Chrome")	tell application "System Events" to key code {49}end telltell (activate application "iTerm")end tell'
# osascript -e 'tell (activate application "Google Chrome")	tell application "System Events" to key code {49}end tell'
# osascript -e "tell application \"iTerm2\"" -e "activate" -e "end tell"

# osascript -e 'tell (activate application "Google Chrome")	tell application "System Events" to key code {49}	activate application "iTerm"end tell'

# osascript -e 'activate application "Google Chrome"tell application "System Events" to key code {49}activate application "iTerm"end'
# osascript -e "tell application \"iTunes\"" -e "activate" -e "end tell"


# osascript -e "activate application \"Google Chrome\"" -e "tell application \"System Events\" to key code {49}" -e 'activate application "iTerm"' -e 'end'
# osascript -e "tell application \"Google Chrome\"" -e "activate" -e "end tell"

# osascript -e 'activate application "Google Chrome" tell application "System Events" to key code {49} activate application "iTerm" end'

# osascript -e 'activate application "Google Chrome" tell application "System Events" to key code {49} activate application "iTerm" end'
# osascript -e 'activate application "Google Chrome" tell application "System Events" to key code {49} activate application "iTerm2" end'
# osascript -e 'activate application "iTerm2" tell application "System Events" to key code {4, 14, 37, 37, 31, 47} end'
