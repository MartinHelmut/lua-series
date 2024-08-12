local function work(str)
    if type(str) ~= "string" then
        error({
            message = "Function 'work' needs a string.",
            status = 42
        }, 2)
    end
    return "Doing some work: " .. str
end

work(1)
