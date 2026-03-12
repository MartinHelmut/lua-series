-- Example script file
local GameData = require "GameData"

local data = GameData.new("Dwarves", 7)
print(type(data)) -- "userdata"

print(data.amount .. " " .. data.name)

data.name = "Gnomes"
print(data.amount .. " " .. data.name)
