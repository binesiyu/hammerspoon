-- 主要用来实现vim回到
local hs = _G.hs
local function vimnormal()
   local win = hs.window.frontmostWindow()
   if win ==nil then
      return
   end
   hs.alert.show("MacVim normal")
   local app = win:application()
   if app:bundleID()=="org.vim.MacVim" then
   end
end

local function viminsert()
   local win = hs.window.frontmostWindow()
   if win ==nil then
      return
   end
   hs.alert.show("MacVim insert")
   local app = win:application()
   if app:bundleID()=="org.vim.MacVim" then
   end
end
 --可以在外部通过 open -g "hammerspoon://vimnormal" 执行这个函数
hs.urlevent.bind("vimnormal", function() vimnormal() end)
 --可以在外部通过 open -g "hammerspoon://viminsert" 执行这个函数
hs.urlevent.bind("viminsert", function() viminsert() end)
