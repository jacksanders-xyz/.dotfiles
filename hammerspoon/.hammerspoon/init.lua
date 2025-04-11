appMappings = {
    {'g', 'Google Chrome.app'},
    {'c', 'iTerm.app'},
    {'r', 'Slack.app'},
    {'&', 'Microsoft Outlook.app'},
    {'=', 'Spotify.app'},
    {'*', 'Microsoft Teams.app'}
}

local log = hs.logger.new("hammerspoon", "debug")

function launch(name)
    log.i("launch something", name)
    hs.application.launchOrFocus(name)
end

for i, km in ipairs(appMappings) do
    hs.hotkey.bind({"alt"}, km[1], function() launch(km[2]) end)
end

-- Bind Alt-O to move the mouse exactly to the bottom-right corner
hs.hotkey.bind({"alt"}, "o", function()
    local currentScreen = hs.mouse.getCurrentScreen()
    local screenFrame = currentScreen:frame()
    -- Calculate the exact bottom-right pixel that's visible
    local pos = {
        x = screenFrame.x + screenFrame.w - 1,
        y = screenFrame.y + screenFrame.h - 1
    }
    hs.mouse.setAbsolutePosition(pos)
end)
