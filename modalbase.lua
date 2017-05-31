local log = require'hs.logger'.new('modalbase','info')

modalbase = hs.hotkey.modal
modalbase.__index = modalbase

function modal_stat(color,alpha)
    if not modal_tray then
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local localMainRes = mainScreen:absoluteToLocal(mainRes)
        modal_tray = hs.canvas.new(mainScreen:localToAbsolute({x=localMainRes.w-40,y=localMainRes.h-40,w=40,h=40}))
        modal_tray[1] = {action="fill",type="circle",fillColor=white}
        modal_tray[1].fillColor.alpha=0.7
        modal_tray[2] = {action="fill",type="circle",fillColor=white,radius="40%"}
        modal_tray:level(hs.canvas.windowLevels.status)
        modal_tray:clickActivating(false)
        modal_tray:behavior(hs.canvas.windowBehaviors.canJoinAllSpaces + hs.canvas.windowBehaviors.stationary)
        modal_tray._default.trackMouseDown = true
    end
    modal_tray:show()
    modal_tray[2].fillColor = color
    modal_tray[2].fillColor.alpha = alpha
end

function modalbase:enterOther()
end

function modalbase:entered()
  
    if self.exitothers then
      exit_others()
    end
    
    if self.id then
      table.insert(activeModals, self)
    end
    
    local color = self.color or royalblue
    modal_stat(color,0.7)
    
    self._active = true
    self:enterOther()
    hideHotKey()
 
end

function modalbase:exitOther()
end

function modalbase:exited()
    if modal_tray then
      modal_tray:hide()
    end
    
    self._active = false
    
    if self.id then
      for i=1,#activeModals do
        if activeModals[i].id == self.id then
            table.remove(activeModals, i)
        end
      end
    end
    
    self:exitOther()
    hideHotKey()
end

modal_list = {}
activeModals = {}

function exit_others(excepts)
    local function isInExcepts(value,tbl)
        for i=1,#tbl do
           if tbl[i] == value then
               return true
           end
        end
        return false
    end
    if excepts == nil then excepts = {} end
    for i = 1, #activeModals do
        if activeModals[i]._active and not isInExcepts(activeModals[i]._id, excepts) then
            activeModals[i]:exit()
        end
    end
end

function modalbase.create(mods, key, message,id)
  local m = setmetatable({keys = {}}, modalbase)
  if (key) then
    m.k = hs.hotkey.bind(mods, key, message, function() m:enter() end)
  end
  --exit others modal when enter this modal
  m.exitothers = true
  
  if id then
    m._id = _id
    table.insert(modal_list, m)
  end
  
  -- add default keybind
  m:bind('', 'escape', function() m:exit() end)
  m:bind('', 'Q', function() m:exit() end)
  m:bind('', 'tab', function() showavailableHotkey() end)
  
  log.d('Created modalbase hotkey')
  return m
end


