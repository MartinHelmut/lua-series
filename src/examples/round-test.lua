local lu = require("luaunit")
local round = require("examples/round")

local TestRound = {}

function TestRound.test1()
	lu.assertEquals(round(3.44), 3)
end

function TestRound.test2()
	lu.assertEquals(round(3.44, 1), 3.4)
end

return TestRound
