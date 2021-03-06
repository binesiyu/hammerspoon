local hs = _G.hs
local send_escape = false
local last_mods = {}

local control_key_handler = function()
  send_escape = false
end

local control_key_timer = hs.timer.delayed.new(0.15, control_key_handler)

local control_handler = function(evt)
  local new_mods = evt:getFlags()
  if last_mods["shift"] == new_mods["shift"] then
    return false
  end
  if not last_mods["shift"] then
    last_mods = new_mods
    send_escape = true
    control_key_timer:start()
  else
    if send_escape then
      hs.eventtap.keyStroke({'ctrl'}, 'Space')
    end
    last_mods = new_mods
    control_key_timer:stop()
  end
  return false
end

local control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
control_tap:start()

local other_handler = function()
  send_escape = false
  return false
end

local other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
other_tap:start()
