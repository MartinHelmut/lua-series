local Runner = {
	hasErrors = false
}

function Runner:test(fn)
	local status, result = pcall(fn)
	if not status then
		self.hasErrors = true
		print(result)
	end
end

function Runner:evaluate()
	if self.hasErrors then
		print("Test suite exited with errors")
		os.exit(1)
	else
		print("All tests successful")
	end
end

return Runner
