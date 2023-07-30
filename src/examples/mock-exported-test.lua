local lu = require("luaunit")

-- Representing a module to require. Example:
-- local someModule = require("some-module")
local someModule = { fn = function () return false end }

TestSomeModule = {}

function TestSomeModule:setUp()
	-- Backup the function that will be mocked
	self.backupFn = someModule.fn

	-- Mock function for tests
	someModule.fn = function () return true end
end

function TestSomeModule:test1()
	lu.assertTrue(someModule.fn())
end

function TestSomeModule:tearDown()
	-- Restore mocked function
	someModule.fn = self.backupFn
end

return TestSomeModule
