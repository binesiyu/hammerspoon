function moveWindowOneSpace(direction)
   _mouseOrigin = hs.mouse.getAbsolutePosition()
   local win = hs.window.focusedWindow()
   _clickPoint = win:zoomButtonRect()

   _clickPoint.x = _clickPoint.x + _clickPoint.w + 5
   _clickPoint.y = _clickPoint.y + (_clickPoint.h / 2)

   local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, _clickPoint)
   mouseClickEvent:post()

   hs.timer.usleep(150000)

   local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true)
   nextSpaceDownEvent:post()
end

function moveWindowOneSpaceEnd(direction)
   local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false)
   nextSpaceUpEvent:post()
   hs.timer.usleep(150000)
   local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, _clickPoint)
   mouseReleaseEvent:post()
   
   hs.timer.usleep(250000)
   local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, _clickPoint)
   mouseClickEvent:post()

   hs.timer.usleep(100)
   mouseReleaseEvent:post()
      
   hs.timer.usleep(100)
   hs.mouse.setAbsolutePosition(_mouseOrigin)
end

hk1 = hs.hotkey.bind({"ctrl","shift"}, "right",
   function() moveWindowOneSpace("right") end,
   function() moveWindowOneSpaceEnd("right") end)
hk2 = hs.hotkey.bind({"ctrl","shift"}, "left",
   function() moveWindowOneSpace("left") end,
   function() moveWindowOneSpaceEnd("left") end)

--[[
function moveWindowOneSpace(direction)
   local mouseOrigin = mouse.getAbsolutePosition()
   local win = hs.window.focusedWindow()
   local clickPoint = win:zoomButtonRect()

   clickPoint.x = clickPoint.x + clickPoint.w + 5
   clickPoint.y = clickPoint.y + (clickPoint.h / 2)

   local mouseClickEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmousedown, clickPoint)
   mouseClickEvent:post()
   hs.timer.usleep(150000)

   local nextSpaceDownEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true)
   nextSpaceDownEvent:post()
   hs.timer.usleep(150000)

   local nextSpaceUpEvent = hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false)
   nextSpaceUpEvent:post()
   hs.timer.usleep(150000)

   local mouseReleaseEvent = hs.eventtap.event.newMouseEvent(hs.eventtap.event.types.leftmouseup, clickPoint)
   mouseReleaseEvent:post()
   hs.timer.usleep(150000)

   mouse.setAbsolutePosition(mouseOrigin)
end


hk1 = hs.hotkey.bind({"ctrl","shift"}, "right",
             function() moveWindowOneSpace("right") end)
hk2 = hs.hotkey.bind({"ctrl","shift"}, "left",
             function() moveWindowOneSpace("left") end)
--]]
