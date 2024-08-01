local function greet(str)
    if type(str) ~= "string" then
        error("Function 'greet' expects a string as argument.")
    end
    return "Hello, " .. str
end

print(greet(1))
