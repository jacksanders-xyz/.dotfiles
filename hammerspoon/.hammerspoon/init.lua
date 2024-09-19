    -- {'g', 'Google Chrome.app'},
    -- {'g', 'qutebrowser.app'},
appMappings = {
    {'g', 'Google Chrome.app'},
	{'c', 'iTerm.app'},
	{'r', 'Slack.app'},
	{'&', 'Microsoft Outlook.app'},
	{'=', 'Spotify.app'},
    -- {'*', 'Cisco Webex Meetings.app'},
}

local log = hs.logger.new("hammerspoon", "debug")

function launch(name)
    log.i("launch something", name)
	hs.application.launchOrFocus(name)
end

for i, km in ipairs(appMappings) do
	hs.hotkey.bind({"alt"}, km[1], function() launch(km[2]) end)
end
