#!/bin/bash

osascript <<EOD
to clickClassName(theClassName, elementnum)
    tell application "Google Chrome" to (tabs of window 1 whose URL contains "youtube")
    set youtubeTabs to item 1 of the result
    tell application "Google Chrome"
        execute youtubeTabs javascript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();"
    end tell
end clickClassName

clickClassName("ytp-play-button ytp-button", 0)
return
EOD

# osascript <<EOD
# to clickClassName2(theClassName, elementnum)
#     tell application "Brave Browser"
#             tell window 1 to set current tab to tab 1 whose URL contains "youtube"
#             do JavaScript "document.getElementsByClassName('" & theClassName & "')[" & elementnum & "].click();" in document 1
#     end tell
# end clickClassName2

# clickClassName2("ytp-play-button ytp-button", 0)
# return
# EOD

