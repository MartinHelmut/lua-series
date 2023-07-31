local path = require("path")

local Assets = {}

function Assets:getPath()
	local user_home = path.user_home()
	return user_home .. path.DIR_SEP .. "assets"
end

return Assets
