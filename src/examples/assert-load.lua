local function readConfig(path)
	local config = {}
	assert(loadfile(path, "t", config))()
	return config
end

local config = readConfig("src/examples/config.lua")
print(config.speed, config.jumpHeight)
