TestFactorial = require("examples/factorial-test")
TestRound = require("examples/round-test")
TestLogger = require("examples/logger-test")

local lu = require("luaunit")
os.exit(lu.LuaUnit.run())
