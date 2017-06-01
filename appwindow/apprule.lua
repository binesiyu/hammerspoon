local E = require('hs.application.watcher')   -- appwindows events
local A = require('appwindow/appactions')               -- appwindows actions
------------------
--  appwindows  --
------------------
-- Each app name points to a list of rules, which are event/action pairs.
-- See hs.application.watcher for events, and appactions.lua for actions.
local apprules = {
  rules = {
    Finder              = {{evt = E.activated,    act = A.toFront}},
    ['Google Chrome']   = {{evt = E.launched,     act = A.maximize}},
    --['Google Chrome']   = {{evt = E.activated,     act = A.debug}},
  },
}

return apprules