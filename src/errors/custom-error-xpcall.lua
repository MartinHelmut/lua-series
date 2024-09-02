local function work(str)
    if type(str) ~= "string" then
        error({
            message = "Function 'work' needs a string.",
            status = 42
        }, 2)
    end
    return "Doing some work: " .. str
end

local function handle_error(err)
    if err.status == 42 then
        -- Any special handling
    end
    return err.message .. "\n" .. debug.traceback()
end

local status, err = xpcall(work, handle_error, 1)

if not status then
    print(err)
end
