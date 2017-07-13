-- app
local    applist = {
        {shortcut = '1',appname = 'MacVim'},
        {shortcut = '2',appname = 'iTerm'},
        {shortcut = '3',appname = 'player3'},
        {shortcut = '4',appname = 'Cocos Studio 2'},
        {shortcut = '5',appname = 'Terminal'},
        {shortcut = 'c',appname = 'Google Chrome'},
        {shortcut = 'f',appname = 'Finder'},
        {shortcut = 't',appname = '钉钉'},
    }

function switch_window_inapp(app)
    local focused = app:focusedWindow()
    if focused then
      local windows = nil
      windows = app:allWindows()
      if #windows <= 1 then
        return
      end
      
      local to_focus
      
      windows = hs.fnutils.filter(windows, hs.window.isStandard)
      windows = hs.fnutils.filter(windows, hs.window.isVisible)

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
      if to_focus then
        to_focus:focus()
      end
    end
end
  
for i = 1, #applist do
    hs.hotkey.bind('alt', applist[i].shortcut,  function()
        local appname = applist[i].appname
        local appruning = hs.application.get(appname)
        if appruning then
            --已经是最前面的，切后到同一个程序的不同窗口
            if appruning:isFrontmost() then
              --appruning:hide()
              switch_window_inapp(appruning)
            elseif appruning:isHidden() then
              appruning:unhide()
              --激活应用的窗口
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