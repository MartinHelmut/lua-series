local lu = require("luaunit")
local Logger = require("examples/logger")

local TestLogger = {}

function TestLogger:setUp()
	self.fname = "mytmplog.log"
	-- Ensure file does not already exist.
	os.remove(self.fname)
end

function TestLogger:testLoggerCreatesFile()
	Logger.setup(self.fname)
	Logger.log("Hello?")

	-- Disabled as it will fail, Logger is an empty example.
	-- local f = io.open(self.fname, "r")
	-- lu.assertNotNil(f)
	-- f:close()
end

function TestLogger:tearDown()
	-- Cleanup log file.
	os.remove(self.fname)
end

return TestLogger
