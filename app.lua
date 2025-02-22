-- app
local hs = _G.hs
-- local log = require'hs.logger'.new('app','info')

-- defaults write com.p5sys.jump.mac.viewer ApplePressAndHoldEnabled -bool true
local remoteApp = "com.p5sys.jump.mac.viewer"
local    applist = {
        {shortcut = 'v',appname = 'MacVim',unmini = false,checkRemote = true},
        {shortcut = '1',appname = {'MacVim','com.neovide.neovide','com.jetbrains.rider','com.microsoft.VSCode',},unmini = false,checkRemote = true},
        {shortcut = '2',appname = 'iTerm',checkRemote = true},
        {shortcut = '3',appname = {'player3','com.p5sys.jump.mac.viewer','Unity'},unmini = false},
        {shortcut = '5',appname = 'Cocos Studio 2'},
        {shortcut = '4',appname = 'Terminal'},
        {shortcut = 'c',appname = 'Google Chrome',checkRemote = true},
        {shortcut = 'f',appname = 'Finder',checkRemote = true},
        {shortcut = 't',appname = '钉钉'},
        {shortcut = 'r',appname = remoteApp,checkRemote = true},
        -- {shortcut = '3',appname = remoteApp,checkRemote = true},
        {shortcut = 'x',appname = 'Xcode',checkRemote = true},
        {shortcut = 'a',appname = 'Android Studio',checkRemote = true},
        {shortcut = 'q',appname = 'QQ'},
        {shortcut = 'w',appname = 'WPS Office'},--word
        {shortcut = 'e',appname = 'WPS Officl',checkRemote = true},--excel
        --{shortcut = 'd',appname = 'PDF Expert'},--pdf
        {shortcut = 's',appname = 'com.torusknot.SourceTreeNotMAS',unmini = false,checkRemote = true},--sorcetree
        {shortcut = 'z',appname = 'ZeroBraneStudio'},--ZeroBraneStudio
    }

local function filter_window(windows)
    -- windows = hs.fnutils.filter(windows, hs.window.isStandard)
    windows = hs.fnutils.filter(windows, hs.window.isVisible)
    return windows
end

local function switch_window_inapp(focused,windows)
    local to_focus
    if focused then
        if #windows <= 1 then
            return
        end

        -- we need to sort the table just because it's sorted randomly every time
        table.sort(windows, function(w1, w2)
            return w1:id() > w2:id()
        end)
        local size = #windows
        -- if no -> no action will be perfomed
        if size > 1 then
            local last_index = hs.fnutils.indexOf(windows, focused)
            if last_index then
                local focus_index = 1
                if last_index < size then
                    focus_index = last_index + 1
                end
                to_focus = windows[focus_index]
            end
        end
    elseif #windows > 0 then
        to_focus = windows[1]
    end

    if to_focus then
        to_focus:focus()
    end
end

local function unminimal_window_inapp(app)
      local windows = app:allWindows()
      for _,v in pairs(windows) do
        if v:isMinimized() then
          v:unminimize()
          break
        end
      end
end

local function focusApp(appname,isunminimal)
    local appruning = hs.application.get(appname)

    if appruning then
        --已经是最前面的，切后到同一个程序的不同窗口
        if appruning:isFrontmost() then
            --appruning:hide()
            if isunminimal then
                unminimal_window_inapp(appruning)
            end
            local focused = appruning:focusedWindow()
            local windows = appruning:allWindows()
            windows = filter_window(windows)
            switch_window_inapp(focused,windows)
        elseif appruning:isHidden() then
            --激活应用的窗口
            appruning:unhide()
            if isunminimal then
                unminimal_window_inapp(appruning)
            end
        else
            appruning:activate()
            if isunminimal then
                unminimal_window_inapp(appruning)
            end
        end
    else
        hs.application.launchOrFocus(appname)
    end
end

local function focusAppMul(appname,isunminimal)
    local focused
    local windowsAll = {}
    for _,name in ipairs(appname) do
        local appruning = {hs.application.find(name,true,true)}
        if appruning then
            for _,app in ipairs(appruning) do
                if app:isFrontmost() then
                    focused = app:focusedWindow()
                end

                if app:isRunning() then
                    local windows = app:allWindows()
                    windows = filter_window(windows)
                    windowsAll = hs.fnutils.concat(windowsAll,windows)
                end
            end
        end
    end

    if #windowsAll > 0 then
        switch_window_inapp(focused,windowsAll)
    else
        focusApp(appname[1],isunminimal)
    end
end

local function factory_app(appData)
    local appname = appData.appname
    local isunminimal = true
    if appData.unmini ~= nil then
        isunminimal = appData.unmini
    end

    if type(appname) == 'table' then
        return function()
            focusAppMul(appname,isunminimal)
        end
    end
    return function()
        focusApp(appname,isunminimal)
    end
end

local remoteAppKey = {}
for i = 1, #applist do
    local appData = applist[i]
    local hotkey = hs.hotkey.bind('alt', appData.shortcut,factory_app(appData))
    if appData.checkRemote then
        -- hs.alert.show("checkremote " .. appData.shortcut)
        table.insert(remoteAppKey,hotkey)
    end
end


local remoteKeyEnable = true
local function disableKey()
    if not remoteKeyEnable then
        return
    end
    remoteKeyEnable = false
    -- hs.alert.show("disableKey ")
    for _,hotkey in ipairs(remoteAppKey) do
        hotkey:disable()
    end
end

local function enableKey()
    if remoteKeyEnable then
        return
    end
    remoteKeyEnable = true
    -- hs.alert.show("enablekey ")
    for _,hotkey in ipairs(remoteAppKey) do
        hotkey:enable()
    end
end

local function focusRemoteApp(w)
    if w:isStandard() then
        enableKey(w)
    else
        disableKey(w)
    end
end

local function unfocusRemoteApp(w)
    if w:isStandard() then
        -- disableKey(w)
    else
        enableKey(w)
    end
end

-- hs.window.filter.new(false):setAppFilter("Jump Desktop",{})
hs.window.filter.new(function(w)
    -- hs.alert.show(w:application().name)
    if w:application():name() ~= "Jump Desktop" then return false end
    -- if w:isStandard() then return false end
    return true
end)
:subscribe(hs.window.filter.windowFocused, focusRemoteApp)
:subscribe(hs.window.filter.windowUnfocused, unfocusRemoteApp)
-- Toggle an application between being frontmost app and hidden
-- local function toggle_application(_app)
--     local app = hs.appfinder.appFromName(_app)
--     if not app then
--         hs.application.launchOrFocus(_app)
--     end
--     local mainwin = app:mainWindow()
--     if mainwin then
--         if mainwin == hs.window.focusedWindow() then
--             mainwin:application():hide()
--         else
--             mainwin:application():activate(true)
--             mainwin:application():unhide()
--             mainwin:focus()
--         end
--     end
-- end
