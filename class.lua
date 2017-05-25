Person = {name="testname"}
Person.__index = Person

--
function Person:talk(words)
  print("[" .. self.name .. "] say:" .. words)
end

--构造函数
function Person:create(name)
  local p = {}
  setmetatable(p,Person)
  p.name = name
  return p
end

local pa = Person:create("A")
local pb = Person:create("B")
pa:talk("I'am A")
pb:talk("I'am B")


local pc={}
setmetatable(pc,Person)
--pc.name="c"
pc:talk("I'am C")