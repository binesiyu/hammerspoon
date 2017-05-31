require "modalbase"

viewM = modalbase.create("alt", "V",'Enter View Mode',"viewM")


function moveMouseBy(offsetx,offsety)
    local currentpos = hs.mouse.getRelativePosition()
    local newpos = hs.geometry.point(currentpos.x+offsetx,currentpos.y+offsety)
    hs.mouse.setRelativePosition(newpos)
end

function clickWithMouse(opts)
    local currentpos = hs.mouse.getRelativePosition()
    if opts == 'left' then
        hs.eventtap.leftClick(currentpos)
    elseif opts == 'right' then
        hs.eventtap.rightClick(currentpos)
    end
end

viewM:bind('', 'H', 'Scroll Leftward', function() hs.eventtap.scrollWheel({1,0},{},"line") end, nil, function() hs.eventtap.scrollWheel({1,0},{},"line") end)
viewM:bind('', 'L', 'Scroll Rightward', function() hs.eventtap.scrollWheel({-1,0},{},"line") end, nil, function() hs.eventtap.scrollWheel({-1,0},{},"line") end)
viewM:bind('', 'J', 'Scroll Downward', function() hs.eventtap.scrollWheel({0,-1},{},"line") end, nil, function() hs.eventtap.scrollWheel({0,-1},{},"line") end)
viewM:bind('', 'K', 'Scroll Upward', function() hs.eventtap.scrollWheel({0,1},{},"line") end, nil, function() hs.eventtap.scrollWheel({0,1},{},"line") end)
viewM:bind('ctrl', 'H', 'Move Mouse Leftward by 50px', function() moveMouseBy(-50,0) end, nil, function() moveMouseBy(-50,0) end)
viewM:bind('ctrl', 'L', 'Move Mouse Rightward by 50px', function() moveMouseBy(50,0) end, nil, function() moveMouseBy(50,0) end)
viewM:bind('ctrl', 'K', 'Move Mouse Upward by 50px', function() moveMouseBy(0,-50) end, nil, function() moveMouseBy(0,-50) end)
viewM:bind('ctrl', 'J', 'Move Mouse Downward by 50px', function() moveMouseBy(0,50) end, nil, function() moveMouseBy(0,50) end)
viewM:bind('shift', 'H', 'Move Mouse Leftward by 10px', function() moveMouseBy(-10,0) end, nil, function() moveMouseBy(-10,0) end)
viewM:bind('shift', 'L', 'Move Mouse Rightward by 10px', function() moveMouseBy(10,0) end, nil, function() moveMouseBy(10,0) end)
viewM:bind('shift', 'K', 'Move Mouse Upward by 10px', function() moveMouseBy(0,-10) end, nil, function() moveMouseBy(0,-10) end)
viewM:bind('shift', 'J', 'Move Mouse Downward by 10px', function() moveMouseBy(0,10) end, nil, function() moveMouseBy(0,10) end)
viewM:bind({'ctrl','shift'}, 'H', 'Move Mouse Leftward by 1px', function() moveMouseBy(-1,0) end, nil, function() moveMouseBy(-1,0) end)
viewM:bind({'ctrl','shift'}, 'L', 'Move Mouse Rightward by 1px', function() moveMouseBy(1,0) end, nil, function() moveMouseBy(1,0) end)
viewM:bind({'ctrl','shift'}, 'K', 'Move Mouse Upward by 1px', function() moveMouseBy(0,-1) end, nil, function() moveMouseBy(0,-1) end)
viewM:bind({'ctrl','shift'}, 'J', 'Move Mouse Downward by 1px', function() moveMouseBy(0,1) end, nil, function() moveMouseBy(0,1) end)
viewM:bind('', ',', 'Left Mouse Click', function() clickWithMouse('left') end, nil, nil)
viewM:bind('', '.', 'Right Mouse Click', function() clickWithMouse('right') end, nil, nil)

