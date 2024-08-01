local function greet(str)
    if type(str) ~= "string" then
        error("Function 'greet' expects a string as argument.", 2)
    end
    return "Hello, " .. str
end

print(greet(1))
