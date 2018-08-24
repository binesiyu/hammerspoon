-- require traverses directories in your ~/.hammerspoon folder, with directory levels separated by dots
local spaces = require('hs._asm.undocumented.spaces')

local cache = {
  mousePosition = nil
}

-- grabs screen with active window, unless it's Finder's desktop
-- then we use mouse position
local function activeScreen()
  local mousePoint = hs.geometry.point(hs.mouse.getAbsolutePosition())
  local activeWindow = hs.window.focusedWindow()

  if activeWindow and activeWindow:role() ~= 'AXScrollArea' then
    return activeWindow:screen()
  else
    return hs.fnutils.find(hs.screen.allScreens(), function(screen)
        return mousePoint:inside(screen:frame())
      end)
  end
end

local function focusScreen(screen)
  local frame = screen:frame()

  -- if mouse is already on the given screen we can safely return
  if hs.geometry(hs.mouse.getAbsolutePosition()):inside(frame) then return false end

  -- "hide" cursor in the lower right side of screen
  -- it's invisible while we are changing spaces
  local mousePosition = {
    x = frame.x + frame.w - 1,
    y = frame.y + frame.h - 1
  }

  -- hs.mouse.setAbsolutePosition doesn't work for gaining proper screen focus
  -- moving the mouse pointer with cliclick (available on homebrew) works
  os.execute(template([[ /usr/local/bin/cliclick m:={X},{Y} ]], { X = mousePosition.x, Y = mousePosition.y }))
  hs.timer.usleep(1000)

  return true
end

local function activeSpaceIndex(screenSpaces)
  return hs.fnutils.indexOf(screenSpaces, spaces.activeSpace()) or 1
end

local function screenSpaces(currentScreen)
  currentScreen = currentScreen or activeScreen()
  return spaces.layout()[currentScreen:spacesUUID()]
end

local function spaceInDirection(direction)
  local screenSpaces = screenSpaces()
  local activeIdx = activeSpaceIndex(screenSpaces)
  local targetIdx = direction == 'west' and activeIdx - 1 or activeIdx + 1

  return screenSpaces[targetIdx]
end

local function moveToSpaceInDirection(win, direction)
  local clickPoint = win:zoomButtonRect()
  local sleepTime = 1000
  local targetSpace = spaceInDirection(direction)

  -- check if all conditions are ok to move the window
  local shouldMoveWindow = hs.fnutils.every({
      clickPoint ~= nil,
      targetSpace ~= nil,
      not cache.movingWindowToSpace
    }, function(test) return test end)

  if not shouldMoveWindow then return end

  cache.movingWindowToSpace = true

  cache.mousePosition = cache.mousePosition or hs.mouse.getAbsolutePosition()

  clickPoint.x = clickPoint.x + clickPoint.w + 5
  clickPoint.y = clickPoint.y + clickPoint.h / 2

  -- fix for Chrome UI
  if win:application():title() == 'Google Chrome' then
    clickPoint.y = clickPoint.y - clickPoint.h
  end

  -- focus screen before switching window
  focusScreen(win:screen())

  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseDown, clickPoint):post()
  hs.timer.usleep(sleepTime)

  hs.eventtap.keyStroke({ 'ctrl' }, direction == 'east' and 'right' or 'left')

  hs.timer.waitUntil(
    function()
      return spaces.activeSpace() == targetSpace
    end,
    function()
      hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftMouseUp, clickPoint):post()

      -- resetting mouse after small timeout is needed for focusing screen to work properly
      hs.mouse.setAbsolutePosition(cache.mousePosition)
      cache.mousePosition = nil

      -- reset cache
      cache.movingWindowToSpace = false

    end,
    0.01 -- check every 1/100 of a second
  )
end

hs.fnutils.each({
    { key = 'left', direction = 'west' },
    { key = 'right', direction = 'east' }
  }, function(object)
    hs.hotkey.bind({"ctrl", "shift"}, object.key, nil, function() moveToSpaceInDirection(hs.window.frontmostWindow(), object.direction) end)
  end)