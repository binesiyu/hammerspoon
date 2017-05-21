-- Define window layouts
--   Format reminder:
--     {"App name", "Window name", "Display Name", "unitrect", "framerect", "fullframerect"},
local internal_display = {
    {"Mail",              nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Microsoft Outlook", nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Evernote",          nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"iTerm",             nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_laptop, hs.layout.maximized, nil, nil},
    {"IntelliJ IDEA",     nil,          display_laptop, hs.layout.maximized, nil, nil},
}

local desk_display = {
    {"Mail",              nil,          display_desk_left, hs.layout.right50, nil, nil},
    {"Microsoft Outlook", nil,          display_desk_left, hs.layout.maximized, nil, nil},
    {"Calendar",          nil,          display_desk_left, hs.layout.left50, nil, nil},
    {"Jabber",            nil,          display_desk_left, hs.layout.maximized, nil, nil},
    {"Evernote",          nil,          display_desk_right, hs.layout.maximized, nil, nil},
    {"iTerm",             nil,          display_desk_right, hs.layout.maximized, nil, nil},
    {"Google Chrome",     nil,          display_desk_right, hs.layout.maximized, nil, nil},
    {"IntelliJ IDEA",     nil,          display_desk_right, hs.layout.maximized, nil, nil},
}

function notify(text)
    -- hs.notify.new({title="Hammerspoon", informativeText=text}):send()
    hs.alert(text)
end

local lastNumberOfScreens = #hs.screen.allScreens()
function screenWatcher()
    print(table.show(hs.screen.allScreens(), "allScreens"))
    newNumberOfScreens = #hs.screen.allScreens()

    -- FIXME: This is awful if we swap primary screen to the external display. all the windows swap around, pointlessly.
    -- if lastNumberOfScreens ~= newNumberOfScreens then
        if newNumberOfScreens == 1 then
            notify("Screens changed to Internal Display")
            hs.layout.apply(internal_display)
        elseif newNumberOfScreens == 2 then
            notify("Screens changed to Desk Display")
            hs.layout.apply(desk_display)
        end
    -- end

    lastNumberOfScreens = newNumberOfScreens
end
hs.screen.watcher.new(screenWatcher):start()
hs.hotkey.bind(ctrlaltcmd, 'S', screenWatcher)