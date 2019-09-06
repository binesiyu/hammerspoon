-- -----------------------------------------------------------------------
--           ** HammerSpoon Config File ❤️ **           --
-- -----------------------------------------------------------------------

-- require "mob-debug"

-- -----------------------------------------------------------------------
--                         ** Something Global **                       --
-- -----------------------------------------------------------------------
hs.hotkey.alertDuration=0
hs.hints.showTitleThresh = 0
hs.window.animationDuration = 0

-- -----------------------------------------------------------------------
--                            ** Requires **                            --
-- -----------------------------------------------------------------------
require "color"
--require "show-hotkey"

require "ws"

require "app"
require "ctrl-esc"

-- require "space"
-- require "space_plugin"

--require "input"
--require "vim"
-- require "window-cycle"

local module_list = {
    --"modes/viewM",
}

for i=1,#module_list do
    require(module_list[i])
end

--require "appwindow/appwatcher"
-- -----------------------------------------------------------------------
--                            ** For Debug **                           --
-- -----------------------------------------------------------------------
--require "hs-reload"

hs.alert.show("Hammerspoon, at your service.",1)
