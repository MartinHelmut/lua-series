local Runner = {
	has_errors = false
}

function Runner:test(fn)
	local status, err = pcall(fn)
	if not status then
		self.has_errors = true
		print(err)
	end
end

function Runner:evaluate()
	if self.has_errors then
		print("Test suite exited with errors")
		os.exit(1)
	else
		print("All tests successful")
	end
end

return Runner
