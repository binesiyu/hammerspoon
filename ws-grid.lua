-- No Animation
hs.window.animationDuration = 0

-- Hotkeys
local opt = {"alt"}
local optcmd = {"alt", "cmd"}
local shftopt = {"shift", "alt"}
local shftcmd = {"shift", "cmd"}

hs.grid.MARGINX = 0
hs.grid.MARGINY = 0
hs.grid.GRIDWIDTH = 12
hs.grid.GRIDHEIGHT = 12

-- Grid Helper Function
local gridset = function(x, y, w, h)
  return function()
    cur_window = hs.window.focusedWindow()
    hs.grid.set(
      cur_window,
      {x=x, y=y, w=w, h=h},
      cur_window:screen()
    )
  end
end

-- Full Bindings
hs.hotkey.bind(shftopt, "'", gridset(0,0,12,12))
hs.hotkey.bind(shftcmd, "'", gridset(1,1,10,10))

-- Half Bindings
hs.hotkey.bind(opt, 'h', gridset(0,0,6,12))
hs.hotkey.bind(opt, 'k', gridset(0,0,12,6))
hs.hotkey.bind(opt, 'j', gridset(0,6,12,6))
hs.hotkey.bind(opt, 'l', gridset(6,0,6,12))

-- Third Bindings
hs.hotkey.bind(opt, '1', gridset(0,0,4,12))
hs.hotkey.bind(opt, '2', gridset(4,0,4,12))
hs.hotkey.bind(opt, '3', gridset(8,0,4,12))

-- Quarter Bindings
hs.hotkey.bind(optcmd, '1', gridset(0,0,6,6))
hs.hotkey.bind(optcmd, '2', gridset(6,0,6,6))
hs.hotkey.bind(optcmd, '3', gridset(6,6,6,6))
hs.hotkey.bind(optcmd, '4', gridset(0,6,6,6))

hs.hotkey.bind(optcmd, 'h', gridset(0,0,3,12))
hs.hotkey.bind(optcmd, 'j', gridset(3,0,3,12))
hs.hotkey.bind(optcmd, 'k', gridset(6,0,3,12))
hs.hotkey.bind(optcmd, 'l', gridset(9,0,3,12))
