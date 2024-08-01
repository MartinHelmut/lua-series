local function greet(str)
    if type(str) ~= "string" then
        error("Function 'greet' expects a string as argument.", 2)
    end
    return "Hello, " .. str
end

local function handle_error(err)
    if err == "<unknown>" then
        return "Unknown error!"
    end
    return err
end

local status, result = xpcall(greet, handle_error, 1)

if not status then
    print("Error calling greet:\n", result)
end
