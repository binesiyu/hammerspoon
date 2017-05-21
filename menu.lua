local menuTable = {
    { title = "Re-arrange Space        ⌃⌥⌘r", fn = rearrangeSpace },
    { title = "Re-arrange App", fn = rearrangeCurrentApp },
    { title = "2 Tiled Vertically", fn = verticalTile2 },
    { title = "3 Tiled Vertically", fn = verticalTile3 },
    -- { title = "-" },
}

local menubar = hs.menubar.new()
if menubar then
    menubar:setTitle("b")
    menubar:setMenu(menuTable)
end