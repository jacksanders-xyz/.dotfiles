#!/bin/bash

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

