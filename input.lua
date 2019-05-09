-- 希望默认是英文输入状态, 需要的时候才切换到输入法进行中文输入.
--[[InputMethod = {
    'baidu-pinyin': 'com.baidu.inputmethod.BaiduIM.pinyin',
    'baidu-wubi': 'com.baidu.inputmethod.BaiduIM.wubi',
    'sogou-pinyin': 'com.sogou.inputmethod.sogou.pinyin',
    'qq-wubi': 'com.tencent.inputmethod.QQInput.QQWubi',
    'squirrel-rime': 'com.googlecode.rimeime.inputmethod.Squirrel.Rime',
    'squirrel-rime-upstream': 'im.rime.inputmethod.Squirrel.Rime',
    'osx-pinyin': 'com.apple.inputmethod.SCIM.ITABC',
    'osx-wubi': 'com.apple.inputmethod.SCIM.WBX',
    'qingg': 'com.aodaren.inputmethod.Qingg',
    'loginput': 'com.logcg.inputmethod.LogInputMac.LogInputMacSP',
    'loginput2': 'com.logcg.inputmethod.LogInputMac2.LogInputMac2SP',
    'general': 'GENERAL'
}
--]]

local hs = _G.hs
local keycodes = hs.keycodes

local function changeInput(input)
    if keycodes.currentSourceID() ~= input then
        keycodes.currentSourceID(input)
    end
end

local function Chinese()
   changeInput("com.baidu.inputmethod.BaiduIM.wubi")
   -- hs.alert.show("中文")
end

local function English()
   changeInput("com.apple.keylayout.US")
   -- hs.alert.show("英文")
end

local function set_app_input_method(app_name, set_input_method_function, event)
   event = event or hs.window.filter.windowFocused

   hs.window.filter.new(app_name)
      :subscribe(event, function()
                    set_input_method_function()
                end)
end



set_app_input_method('Hammerspoon', English, hs.window.filter.windowCreated)
set_app_input_method('Spotlight', English, hs.window.filter.windowCreated)
set_app_input_method('Alfred 3', English, hs.window.filter.windowCreated)
set_app_input_method('VimR', English)
set_app_input_method('MacVim', English)
set_app_input_method('iTerm2', English)
set_app_input_method('Google Chrome', English)
set_app_input_method('微信', Chinese)
set_app_input_method('钉钉', Chinese)


-- hs.keycodes.inputSourceChanged(
--    function()
--       if string.find(hs.keycodes.currentSourceID(), "com.apple.keylayout.US") then
--          -- hs.alert.show("英文" .. hs.keycodes.currentSourceID())
--          hs.alert.show("英文")
--       else
--          hs.alert.show("中文")
--       end
--    end
-- )



-- -- -- 如果不知道当前的应用的名字和输入法SourceID, 可以用下面的函数查看:
-- hs.hotkey.bind({"cmd","ctrl","alt"}, ".", function()
-- 		  hs.alert.show("App path:        "
-- 				..hs.window.focusedWindow():application():path()
-- 				.."\n"
-- 				.."App name:      "
-- 				..hs.window.focusedWindow():application():name()
-- 				.."\n"
-- 				.."IM source id:  "
-- 				..hs.keycodes.currentSourceID())
-- end)
