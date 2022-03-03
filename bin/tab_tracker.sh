#!/bin/bash
osascript <<EOD
on setActiveTabIndex(searchString)
	tell application "Google Chrome"
    set i to 0
    repeat with t in tabs of front window
    set i to i + 1
    if title of t contains searchString then
        set active tab index of front window to i
        return
    end if
end repeat
end tell
end setActiveTabIndex

on run
setActiveTabIndex("Youtube")
return
end run
EOD


echo "Google Chrome is now open in Kiosk Mode"
