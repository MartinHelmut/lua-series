local lu = require("luaunit")

local TestAssets = {}

function TestAssets:setUp()
	self.actualRequire = _G.require

	_G.require = function (modname)
		if modname == "path" then
			return {
				user_home = function () return "" end,
				DIR_SEP = "/"
			}
		else
			return self.actualRequire(modname)
		end
	end
end

function TestAssets:test1()
	local assets = require("examples/mock-module/assets")
	lu.assertEquals(assets.get_path(), "/assets")
end

function TestAssets:tearDown()
	_G.require = self.actualRequire
end

return TestAssets
