local function work(str)
    if type(str) ~= "string" then
        error({
            message = "Function 'work' needs a string.",
            status = 42
        }, 2)
    end
    return "Doing some work: " .. str
end

local status, err = pcall(work, 1)

if not status then
    print(err.message)
end
