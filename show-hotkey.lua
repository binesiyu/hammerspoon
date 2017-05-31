function showavailableHotkey()
    if not hotkeytext then
        local hotkey_list=hs.hotkey.getHotkeys()
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local localMainRes = mainScreen:absoluteToLocal(mainRes)
        local hkbgrect = hs.geometry.rect(mainScreen:localToAbsolute(localMainRes.w/5,localMainRes.h/5,localMainRes.w/5*3,localMainRes.h/5*3))
        hotkeybg = hs.drawing.rectangle(hkbgrect)
        -- hotkeybg:setStroke(false)
        if not hotkey_tips_bg then hotkey_tips_bg = "light" end
        if hotkey_tips_bg == "light" then
            hotkeybg:setFillColor({red=238/255,blue=238/255,green=238/255,alpha=0.95})
        elseif hotkey_tips_bg == "dark" then
            hotkeybg:setFillColor({red=0,blue=0,green=0,alpha=0.95})
        end
        hotkeybg:setRoundedRectRadii(10,10)
        hotkeybg:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeybg:behavior(hs.drawing.windowBehaviors.stationary)
        local hktextrect = hs.geometry.rect(hkbgrect.x+40,hkbgrect.y+30,hkbgrect.w-80,hkbgrect.h-60)
        hotkeytext = hs.drawing.text(hktextrect,"")
        hotkeytext:setLevel(hs.drawing.windowLevels.modalPanel)
        hotkeytext:behavior(hs.drawing.windowBehaviors.stationary)
        hotkeytext:setClickCallback(nil,function() hotkeytext:delete() hotkeytext=nil hotkeybg:delete() hotkeybg=nil end)
        hotkey_filtered = {}
        for i=1,#hotkey_list do
            if hotkey_list[i].idx ~= hotkey_list[i].msg then
                table.insert(hotkey_filtered,hotkey_list[i])
            end
        end
        local availablelen = 70
        local hkstr = ''
        for i=2,#hotkey_filtered,2 do
            local tmpstr = hotkey_filtered[i-1].msg .. hotkey_filtered[i].msg
            if string.len(tmpstr)<= availablelen then
                local tofilllen = availablelen-string.len(hotkey_filtered[i-1].msg)
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. string.format('%'..tofilllen..'s',hotkey_filtered[i].msg) .. '\n'
            else
                hkstr = hkstr .. hotkey_filtered[i-1].msg .. '\n' .. hotkey_filtered[i].msg .. '\n'
            end
        end
        if math.fmod(#hotkey_filtered,2) == 1 then hkstr = hkstr .. hotkey_filtered[#hotkey_filtered].msg end
        local hkstr_styled = hs.styledtext.new(hkstr, {font={name="Courier-Bold",size=16}, color=dodgerblue, paragraphStyle={lineSpacing=12.0,lineBreak='truncateMiddle'}, shadow={offset={h=0,w=0},blurRadius=0.5,color=darkblue}})
        hotkeytext:setStyledText(hkstr_styled)
        hotkeybg:show()
        hotkeytext:show()
    else
      hideHotKey()
    end
end

function hideHotKey()
    if hotkeytext then
        hotkeytext:delete()
        hotkeytext=nil
        hotkeybg:delete()
        hotkeybg=nil
    end
end

hs.hotkey.bind({"cmd", "shift", "ctrl"}, "space", "Toggle Hotkeys Cheatsheet", function() showavailableHotkey() end)
