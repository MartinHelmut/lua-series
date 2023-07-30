local lu = require("luaunit")
local Logger = require("examples/logger")

local TestLogger = {}

function TestLogger:setUp()
	-- define the fname to use for logging
	self.fname = "mytmplog.log"
	-- make sure the file does not already exists
	os.remove(self.fname)
end

function TestLogger:testLoggerCreatesFile()
	Logger.setup(self.fname)
	Logger.log("Hello?")
	-- make sure that our log file was created
	f = io.open(self.fname, "r")
	lu.assertNotNil(f)
	f:close()
end

function TestLogger:tearDown()
	-- cleanup our log file after all tests
	os.remove(self.fname)
end

return TestLogger
