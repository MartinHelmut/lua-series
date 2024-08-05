local lu = require "luaunit"

local function log(text) print(text) end

local TestGlobal = {}

function TestGlobal:setUp()
	self.backupPrint = _G.print
end

function TestGlobal.test1()
	local hasBeenCalled = false
	_G.print = function () hasBeenCalled = true end
	log("Hello World")
	lu.assertTrue(hasBeenCalled)
end

function TestGlobal:tearDown()
	_G.print = self.backupPrint
end

return TestGlobal
