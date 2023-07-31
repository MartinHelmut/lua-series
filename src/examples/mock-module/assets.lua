local path = require("path")

local Assets = {}

function Assets:getPath()
	local userHome = path.user_home()
	return userHome .. path.DIR_SEP .. "assets"
end

return Assets
