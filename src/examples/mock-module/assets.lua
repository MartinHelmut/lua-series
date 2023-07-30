local path = require("path")

local Assets = {}

function Assets:get_path()
	local user_home = path.user_home()
	return user_home .. path.DIR_SEP .. "assets"
end

return Assets
