-- app
local    applist = {
        {shortcut = '1',appname = 'MacVim'},
        {shortcut = '2',appname = 'iTerm'},
        {shortcut = '3',appname = 'player3'},
        {shortcut = 'c',appname = 'Google Chrome'},
    }

for i = 1, #applist do
    hs.hotkey.bind('alt', applist[i].shortcut,  function()
        local appname = applist[i].appname
        local appruning = hs.application.get(appname)
        if appruning then
            if appruning:isFrontmost() then
              appruning:hide()
            else
              appruning:activate()
            end
        else
            hs.application.launchOrFocus(applist[i].appname)
        end
    end)
end

-- Toggle an application between being frontmost app and hidden
function toggle_application(_app)
    local app = hs.appfinder.appFromName(_app)
    if not app then
        hs.application.launchOrFocus(_app)
    end
    local mainwin = app:mainWindow()
    if mainwin then
        if mainwin == hs.window.focusedWindow() then
            mainwin:application():hide()
        else
            mainwin:application():activate(true)
            mainwin:application():unhide()
            mainwin:focus()
        end
    end
end