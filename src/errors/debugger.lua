local dbg = require "debugger"

-- Breakpoint
dbg()

local function run(levels)
    for _, level in ipairs(levels) do
        local result = level()
        -- Assert usage
        dbg(result.success ~= true)
        if result.success == false then
            print("You lose!")
            return
        end
    end

    print("Winner!")
end

local function level1()
    local message = "Level 1"
    print(message)
    return { success = true, points = 10 }
end

local function level2()
    local message = "Level 2"
    print(message)
    return { success = false, points = 20 }
end

print(run({ level1, level2 }))
