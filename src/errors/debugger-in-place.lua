local dbg = require "debugger"
local error = dbg.error
local pcall = dbg.call

local function greet(str)
	if type(str) ~= "string" then
		error("Function 'greet' expects a string as argument.")
	end
	return "Hello, " .. str
end

if pcall(greet, 1) then
	print("No errors")
else
	print("Error calling greet!")
end
