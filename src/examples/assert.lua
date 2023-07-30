-- Basic test wrapper
function test(fn)
	local status, err = pcall(fn)
	if not status then
		print(err)
	end
end

-- Testing some code
local factorial = require("examples/factorial")

test(function ()
	assert( factorial(1) == 1, "Factor of 1 should be 1")
end)

test(function ()
	assert(factorial(4) == 24, "Factor of 4 should be 24")
end)

print("All tests run")
