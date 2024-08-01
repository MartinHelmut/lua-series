local function greet(str)
    if type(str) ~= "string" then
        error("Function 'greet' expects a string as argument.", 2)
    end
    return "Hello, " .. str
end

local status, result = pcall(greet, 1)

if status then
    print(result)
else
    print("Error calling greet:\n", result)
end
