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

-- Toggle state: false means dock/menu is not revealed; true means it is.
local dockRevealed = false

hs.hotkey.bind({"alt"}, "a", function()
    local currentScreen = hs.mouse.getCurrentScreen()
    local frame = currentScreen:frame()

    if not dockRevealed then
        -- First toggle: move to top center (with a slight offset)
        local pos = {
            x = frame.x + (frame.w / 2) - 350,  -- center horizontally
            y = frame.y - 25              -- 25 pixels above the frame’s top edge (to trigger the dock/menu)
        }
        hs.mouse.setAbsolutePosition(pos)
        hs.eventtap.leftClick(pos)  -- click to reveal the dock/menu
        dockRevealed = true
    else
        -- Second toggle: move the mouse to the bottom-right and click
        local newPos = {
            x = frame.x + frame.w - 1,    -- right edge of the screen
            y = frame.y + frame.h - 1     -- bottom edge of the screen
        }
        hs.mouse.setAbsolutePosition(newPos)
        hs.eventtap.rightClick(newPos)
        hs.eventtap.rightClick(newPos)
        dockRevealed = false
    end
end)
