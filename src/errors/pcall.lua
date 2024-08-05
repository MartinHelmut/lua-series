local inspect = require "inspect"

local function call_hook(event)
    local s = debug.getinfo(2)
    print(event, ":", inspect(s))
end

debug.sethook(call_hook, "cr")

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
    -- Optioanlly print a stack trace:
    -- print(debug.traceback())
end
