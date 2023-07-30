TestFactorial = require("examples/factorial-test")
TestRound = require("examples/round-test")
TestLogger = require("examples/logger-test")

TestMockExported = require("examples/mock-exported-test")
TestMockGlobal = require("examples/mock-global-test")

local lu = require("luaunit")
os.exit(lu.LuaUnit.run())
