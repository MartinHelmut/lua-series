-- Some inspiration from: https://github.com/2dengine/profile.lua
-- To-be-closed information: https://lwn.net/Articles/826134/

local internal_functions = {}

local Profile = {
    file = "profile.json",
    output = "",
}

function Profile:new(file)
    local obj = {
        file = file or self.file
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function Profile:write_header()
    self.output = '{"otherData": {},"traceEvents":[{}'
end

function Profile:write_footer()
    local file_handle = io.open(self.file, "w")
    if file_handle then
        file_handle:write(self.output .. "]}")
        self.output = ""
        io.close(file_handle)
    end
end

function Profile:write_item(name, start_time, end_time)
    local json = [[
    ,{
        "cat": "function",
        "dur": %f,
        "name": "%s",
        "ph": "X",
        "pid": 0,
        "tid": 0,
        "ts": %f
    }
    ]]
    self.output = self.output .. string.format(json, end_time, name, start_time)
end

local Instrumentator = {
    -- Clock milliseconds to nanoseconds
    clock = function () return os.clock() * 1000000 end,
    profile = nil,
    tail_calls = 0,
    function_stack = {},
    scope_stack = {},
}

function Instrumentator:create_hook()
    return function (event, _line, info)
        info = info or debug.getinfo(2)
        local func = info.func

        -- Ignore internal functions in trace
        if internal_functions[func] or info.what ~= "Lua" then
            return
        end

        local _, stack_depth = debug.traceback():gsub("\n", "\n")
        if info.istailcall == true then
            stack_depth = stack_depth - 1
        end

        if event == "tail call" then
            self.tail_calls = self.tail_calls + 1

            if not self.function_stack[func] then
                self.function_stack[func] = {}
            end

            self.function_stack[func][stack_depth + self.tail_calls] = self.clock()
        end

        if event == "call" then
            if not self.function_stack[func] then
                self.function_stack[func] = {}
            end

            self.function_stack[func][stack_depth] = self.clock()
        end

        if event == "return" then
            if not self.function_stack[func] then
                return
            end

            local function _write(id, depth)
                local name = info.name or string.format("%s(%s:%s)", id, info.short_src, info.linedefined)
                local start_time = self.function_stack[func][depth]
                local end_time = self.clock() - start_time
                self.profile:write_item(name, start_time, end_time)
                self.function_stack[func][depth] = nil
            end

            if info.istailcall == true then
                for i = self.tail_calls, 1, -1 do
                    _write("tail_call", stack_depth + i)
                end
                self.tail_calls = 0
            end

            _write("unknown", stack_depth)

            -- Cleanup
            if next(self.function_stack[func]) == nil then
                self.function_stack[func] = nil
            end
        end
    end
end

function Instrumentator:begin_session(file)
    if self.profile then
        error(string.format(
            "Instrumentor:begin_session('%s'), but another session '%s' is already open.",
            file or "", self.profile.file), 2)
    end

    self.profile = Profile:new(file)
    self.profile:write_header()

    debug.sethook(self:create_hook(), "cr")
end

function Instrumentator:scope(name)
    self.scope_stack[name] = self.clock()

    local function __close()
        if not self.scope_stack[name] then
            return
        end

        local info = debug.getinfo(2)
        local scope_name = string.format("%s(%s:%s)", name, info.short_src, info.linedefined)
        local start_time = self.scope_stack[name]
        local end_time = self.clock() - start_time
        self.profile:write_item(scope_name, start_time, end_time)

        self.scope_stack[name] = nil
    end

    local closable = { close = __close }
    setmetatable(closable, { __close = __close })
    internal_functions[__close] = true

    return closable
end

function Instrumentator:end_session()
    debug.sethook()
    self.profile:write_footer()
    self.profile = nil;
end

local function collect_function(from, into)
    for _, v in pairs(from) do
        if type(v) == "function" then
            into[v] = true
        end
    end
end

internal_functions[collect_function] = true
collect_function(Instrumentator, internal_functions)
collect_function(Profile, internal_functions)

return Instrumentator
