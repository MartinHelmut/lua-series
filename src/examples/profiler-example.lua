local profiler = require "profiler"

profiler:begin_session()

local function test_fn()
	local scope = profiler:scope("test scope")
	print(42)
	scope:close()
end

local function factorial(n)
	if (n == 0) then
		return 1
	else
		local _ <close> = profiler:scope("test scope")
		return n * factorial(n - 1)
	end
end

factorial(2)
test_fn()

profiler:end_session()

return factorial
