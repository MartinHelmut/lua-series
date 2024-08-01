local tr = require("examples/test-runner")
local factorial = require("examples/factorial")

tr:test(function ()
	assert(factorial(1) == 1, "Factor of 1 should be 1")
end)

tr:test(function ()
	assert(factorial(4) == 24, "Factor of 4 should be 24")
end)

tr:evaluate()
