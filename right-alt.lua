--Switch between windows WITHIN Application with right alt 
--[[
hs.hotkey.bind({"alt"},80,function()
	if hs.application.frontmostApplication():allWindows()[2]==nil then
		--hs.alert.show("ctrl+tab")
		hs.eventtap.event.newKeyEvent({"ctrl"}, "tab", true):post()
		hs.eventtap.event.newKeyEvent({}, "tab", false):post()
		hs.timer.usleep(100000)
		hs.eventtap.event.newKeyEvent({}, "cmd", false):post()
	else
		--hs.alert.show("cmd+`")
		hs.eventtap.event.newKeyEvent({"cmd"}, "`", true):post()
		hs.eventtap.event.newKeyEvent({}, "`", false):post()
		hs.timer.usleep(100000)
		hs.eventtap.event.newKeyEvent({}, "cmd", false):post()
	end
end)

--Switch between windows WITHIN Application with right alt (Reverse Direction)
hs.hotkey.bind({"shift","alt"},80,function()
	hs.eventtap.event.newKeyEvent({"ctrl", "shift"}, "tab", true):post()
	hs.eventtap.event.newKeyEvent({}, "tab", false):post()
	hs.timer.usleep(100000)
	hs.eventtap.event.newKeyEvent({}, "cmd", false):post()

end)
--]]

---[[
hs.hotkey.bind("alt", "tab", function()
	hs.window.switcher.nextWindow()
end)

hs.hotkey.bind({"alt", "shift"}, "tab", function()
	hs.window.switcher.previousWindow()
end)
--]]