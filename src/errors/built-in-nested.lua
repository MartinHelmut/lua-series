local function will_error()
    local non_table = 1
    return non_table[1]
end

local function parent_function()
    will_error()
end

parent_function()
