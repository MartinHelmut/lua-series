local function greet(str)
    if type(str) ~= "string" then
        error("Function 'greet' expects a string as argument.", 2)
    end
    return "Hello, " .. str
end

local function handle_error(err)
    -- Call inside error handler:
    return err .. "\n" .. debug.traceback()
end

local status, err = xpcall(greet, handle_error, 1)

if not status then
    print(err)
end
