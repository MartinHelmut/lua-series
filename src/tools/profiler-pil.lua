-- Example from "Programming in Lua"
-- https://www.lua.org/pil/23.3.html
local Counters = {}
local Names = {}

local function hook()
	local f = debug.getinfo(2, "f").func
	if Counters[f] == nil then -- first time `f' is called?
		Counters[f] = 1
		Names[f] = debug.getinfo(2, "Sn")
	else -- only increment the counter
		Counters[f] = Counters[f] + 1
	end
end

local function getname(func)
	local n = Names[func]
	if n.what == "C" then
		return n.name
	end
	local loc = string.format("[%s]:%s", n.short_src, n.linedefined)
	if n.namewhat ~= "" then
		return string.format("%s (%s)", loc, n.name)
	else
		return string.format("%s", loc)
	end
end

local f = assert(loadfile(arg[1]))
debug.sethook(hook, "c") -- turn on the hook
f()                      -- run the main program
debug.sethook()          -- turn off the hook

for func, count in pairs(Counters) do
	print(getname(func), count)
end
