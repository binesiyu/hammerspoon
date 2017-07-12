local focus_screen = function(screen)
  local screen_frame = screen:fullFrame()
  local center_point = hs.geometry.rectMidPoint(screen_frame)
  hs.mouse.setAbsolutePosition(center_point)
  if timer and timer:running() then
    timer:fire()
  end
  local rect = hs.drawing.rectangle(screen_frame)
  if rect then
    rect:setFill(false)
    rect:setStroke(true)
    rect:setStrokeColor(hs.drawing.color.red)
    rect:setStrokeWidth(4)
    rect:show()
    timer = hs.timer.doAfter(1, function()
      rect:delete()
      timer = nil
    end)
  end
end

-- thanks to @oskarols
-- github.com/oskarols/dotfiles/blob/master/hammerspoon/

local window_cycle = function(backward)
  return function()
    local focused = hs.window.focusedWindow()
    local to_focus
    local windows = hs.window.visibleWindows()
    windows = hs.fnutils.filter(windows, hs.window.isStandard)
    windows = hs.fnutils.filter(windows, hs.window.isVisible)
    if focused then
      -- we need to sort the table just because it's sorted randomly every time
      table.sort(windows, function(w1, w2)
        return w1:id() > w2:id()
      end)
      local size = #windows
      -- if no -> no action will be perfomed
      if size > 1 then
        local last_index = hs.fnutils.indexOf(windows, focused)
        if last_index then
          -- todo: replace with fmod?
          if backward then
            if last_index > 1 then
              focus_index = last_index - 1
            else
              focus_index = size
            end
          else
            if last_index < size then
              focus_index = last_index + 1
            else
              focus_index = 1
            end
          end
          to_focus = windows[focus_index]
        end
      end
      if to_focus then
        to_focus:focus()
        --focus_screen(to_focus:screen())
      end
    end
    if not focused or not to_focus then
      -- todo: focus next display
    end
  end
end

--在同一个就用内
local window_cycle_app = function(backward)
  return function()
    local focused = hs.window.focusedWindow()
    if focused then
      local windows = nil
      local app = focused:application()
      if app then
        windows = app:allWindows()
      else
        windows = hs.window.visibleWindows()
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
          -- todo: replace with fmod?
          if backward then
            if last_index > 1 then
              focus_index = last_index - 1
            else
              focus_index = size
            end
          else
            if last_index < size then
              focus_index = last_index + 1
            else
              focus_index = 1
            end
          end
          to_focus = windows[focus_index]
        end
      end
      if to_focus then
        to_focus:focus()
        --focus_screen(to_focus:screen())
      end
    end
    if not focused or not to_focus then
      -- todo: focus next display
    end
  end
end
hs.hotkey.setLogLevel(5)
-- focus 'next' window
--hs.hotkey.bind("ctrl", "tab", window_cycle(true))
hs.hotkey.bind("alt", "`", window_cycle_app(true))
-- focus 'previous' window
--hs.hotkey.bind({"ctrl", "shift"}, "tab", window_cycle(false))
hs.hotkey.bind({"alt", "shift"}, "`", window_cycle_app(false))

--local logger = hs.logger.new('window-cycle')
local function window_last()
    local windows = hs.window.orderedWindows()
      windows = hs.fnutils.filter(windows, hs.window.isStandard)
      windows = hs.fnutils.filter(windows, hs.window.isVisible)
      --logger.df("windows frame: %d", #windows)
    if #windows >=2 then
      local to_focus = windows[2]
      if to_focus then
        to_focus:focus()
        --focus_screen(to_focus:screen())
      end
    end
end
hs.hotkey.bind("alt", "tab", window_last)
-- vim: sw=2 ts=2 expandtab