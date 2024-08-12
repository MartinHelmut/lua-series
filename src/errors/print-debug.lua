local function caller(fn)
	-- Some code ...
	local value = fn()
	print("Problem at:",
        debug.getinfo(fn).source
        .. ":" ..
        debug.getinfo(fn).linedefined)
    return value
end

local function callback()
    return "Great value!"
end

print(caller(callback))
