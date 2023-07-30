local lu = require("luaunit")
local factorial = require("examples/factorial")

local TestFactorial = {}

function TestFactorial:test1()
	lu.assertEquals(factorial(0), 1)
end

function TestFactorial:test2()
	lu.assertEquals(factorial(1), 1)
end

function TestFactorial:test3()
	lu.assertEquals(factorial(4), 24)
end

return TestFactorial
