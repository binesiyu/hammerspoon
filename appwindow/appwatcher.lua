-- module: Application window actions
-- App/window actions are defined in appactions.lua
local A = require('appwindow/appactions')
local apprules = require('appwindow/apprule')
--local log = require'hs.logger'.new('appwatcher','info')

local watcher = nil

-- appwatcher callback
local function watch(appName, eventType, appObject)
  -- see config.appwindows for rule configuration
  if apprules.rules[appName] then
    for _,rule in ipairs(apprules.rules[appName]) do
      -- if the current event matches one of our rules for this app,
      -- take the action defined by the rule.
      if rule.evt == eventType and type(rule.act) == 'function' then
          rule.act(appName,eventType,appObject)
      end
    end
  end
end

watcher = hs.application.watcher.new(watch)
watcher:start()
