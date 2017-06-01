-- Application actions defined for modules/appwindows.lua
local log = require'hs.logger'.new('appaction','info')

local function hasNoMainWindow(appObject) 
  return function()
    return appObject:mainWindow() == nil end
  end
    
-- set the main window to fullscreen
local function fullscreen(appName, eventType, appObject)
  hs.timer.waitWhile(hasNoMainWindow(appObject), function()
            appObject:mainWindow():setFullScreen(true)
          end)
end

-- maximize the main window
local function maximize(appName, eventType, appObject)
  hs.timer.waitWhile(hasNoMainWindow(appObject), function()
            appObject:mainWindow():maximize()
          end)
end

-- bring the application windows to the front฀勡
local function bringToFront(appName, eventType, appObject)
  appObject:selectMenuItem({'Window', 'Bring All to Front'})
end

-- activate (focus) the appȀ
local function activate(appName, eventType, appObject)
  appObject:activate()
end

-- table for converting events to strings when debugging
local DEBUG = {
  [0] = 'launching',
  [1] = 'launched',
  [2] = 'terminated',
  [3] = 'hidden',
  [4] = 'unhidden',
  [5] = 'activated',
  [6] = 'deactivated',
}
-- print some debugging information about the app and events
local function appdebug(appName, eventType, appObject)
  log.i(
            'appName:', appName,
            ', bundleID:', appObject:bundleID(),
            ', eventType:', DEBUG[eventType]
          )
end
          
local actions = {
  fullscreen = fullscreen,
  maximize = maximize,
  toFront = bringToFront,
  activate = activate,
  debug = appdebug,
}

return actions
